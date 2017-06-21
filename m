Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD8C20401
	for <e@80x24.org>; Wed, 21 Jun 2017 22:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbdFUWeN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 18:34:13 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34052 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdFUWeM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 18:34:12 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so30250907pge.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DqAlTf66HmViWZjsRQVyVVCq2+mtqALoLN7hWCCW7BE=;
        b=GNF9eoeIspmXjBPhWIiarVdwQWaQlzKAZBUngr4H+1hrX5Udt9lpx49ARKkevEwtds
         6TSRs2JCQEWkRc3l/C9JSw8+Y8I8IK543wNJpr1XXHH3AYan8uInCBVBy6d2YqTwM+dQ
         Jo8zhEDrsEr/Qvyo4iSQtPDm0cqmyWeJ6RWmdYSMZIkoG53O5MnjSP6NC4t7yDgSXCgm
         voxlWH6jK7Qo8Mezu5NOy4A5Wzm1I+w1VOmnLvqBpvsF29ITsRGjUZ0Qq9nhfF0MZ1KG
         3PoZy1OsdmERKH6GUD6VIy8taAP0aO+a1k7GT1T31b7H0A8ha3DADVGjmb+4O8Uj4LJF
         +P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DqAlTf66HmViWZjsRQVyVVCq2+mtqALoLN7hWCCW7BE=;
        b=QLQxxh6MHyeash29RY+dJjVTATExTk8t6MFicJoPYEDfMNPpoUAzrfciqcCPmENb+w
         E0aeyflNO1ba2dGL9Fn9188Qxxod5han3PnIlGqYUGA68vPZzfiQBu0UpBpnEa7wO/6s
         MWAAnW8pP0F9j/HYFPnQ1QLTkYVxFAwq7h+uXsV0XxBHs7gPYFv1AzNOmMDCoXMklUQh
         MuU27CiJX+Sp784SLfgIOVhkINfvq+Vml9kUb4sSGwOzMotu+gZfmKk171gRKc9s0mKg
         9rCoy3EU6rB1YjFOkTlcRmerTQDQcV17Tn97ZGrsk4OiUJX96xjJ/xjuqrJ+VugLqVnk
         C9xw==
X-Gm-Message-State: AKS2vOwEqSB84yXbCbA7+7dHVP8qJ8pITqc8OKSXwSwpxohDScUwpJP5
        qLUbvVvUlvz+XQ==
X-Received: by 10.98.48.5 with SMTP id w5mr38269041pfw.44.1498084451655;
        Wed, 21 Jun 2017 15:34:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id g10sm33675444pgr.18.2017.06.21.15.34.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 15:34:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Chris Packham <judge.packham@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 (resend)] Tweak help auto-correct phrasing.
References: <3164ca01-9b54-3c9b-96d8-182c9fbbceb9@xiplink.com>
        <20170621135738.27948-1-marcnarc@xiplink.com>
Date:   Wed, 21 Jun 2017 15:34:10 -0700
In-Reply-To: <20170621135738.27948-1-marcnarc@xiplink.com> (Marc Branchaud's
        message of "Wed, 21 Jun 2017 09:57:38 -0400")
Message-ID: <xmqqd19xm0m5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

> When auto-correct is enabled, an invalid git command prints a warning and
> a continuation message, which differs depending on whether or not
> help.autoCorrect is positive or negative.
>
> With help.autoCorrect = 15:
>
>    WARNING: You called a Git command named 'lgo', which does not exist.
>    Continuing under the assumption that you meant 'log'
>    in 1.5 seconds automatically...
>
> With help.autoCorrect < 0:
>
>    WARNING: You called a Git command named 'lgo', which does not exist.
>    Continuing under the assumption that you meant 'log'
>
> The continuation message's phrasing is awkward.  This commit cleans it up.
> As a bonus, we now use full-sentence strings which make translation easier.
>
> With help.autoCorrect = 15:
>
>    WARNING: You called a Git command named 'lgo', which does not exist.
>    Continuing in 1.5 seconds, assuming that you meant 'log'.
>
> With help.autoCorrect < 0:
>
>    WARNING: You called a Git command named 'lgo', which does not exist.
>    Continuing under the assumption that you meant 'log'.
>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>
> So here's the patch again.

Thanks.  Will queue and wait for people to yell at us when this
breaks their setup (which I highly doubt would happen ;-).

>  help.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/help.c b/help.c
> index f637fc800..69966c174 100644
> --- a/help.c
> +++ b/help.c
> @@ -356,12 +356,18 @@ const char *help_unknown_cmd(const char *cmd)
>  		clean_cmdnames(&main_cmds);
>  		fprintf_ln(stderr,
>  			   _("WARNING: You called a Git command named '%s', "
> -			     "which does not exist.\n"
> -			     "Continuing under the assumption that you meant '%s'"),
> -			cmd, assumed);
> -		if (autocorrect > 0) {
> -			fprintf_ln(stderr, _("in %0.1f seconds automatically..."),
> -				(float)autocorrect/10.0);
> +			     "which does not exist."),
> +			   cmd);
> +		if (autocorrect < 0)
> +			fprintf_ln(stderr,
> +				   _("Continuing under the assumption that "
> +				     "you meant '%s'."),
> +				   assumed);
> +		else {
> +			fprintf_ln(stderr,
> +				   _("Continuing in %0.1f seconds, "
> +				     "assuming that you meant '%s'."),
> +				   (float)autocorrect/10.0, assumed);
>  			sleep_millisec(autocorrect * 100);
>  		}
>  		return assumed;
