Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CEC51F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfBFSqL (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:46:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37279 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBFSqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:46:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id c8so1965988wrs.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OPiJZGePz8MpF4ow2ohSqQtEI0YGYmAtCmJPdEg0UgE=;
        b=GpBIn4P9XpRSIlE0kZs6Fpc2f271c13XMQMLljav7qBObXYUOZM+Ig9N0LzypBIPu3
         Gkws14pnfIe+F2moWJXuOHl0o8XYhwjuKEIgeL7Ccxf6RzYWpePi6PBrZ2JnngOzKHsS
         Paje4BHJrcOHm9OLSQfkhZV7m/DtLxoGr3wJresL2kjpflT1n4GmvmC9+9MQimPIfZPe
         UsAmVTD5aAsRVGAud272RZPzDZ5z8mObr1Z3P4S0Kie9A1wNUQmXtI//d46V6W6wnDCG
         qIWSH4bKtAQFMKxIdMvgc+jvhDUg4tHfLTu6FR/wksRiUhjEZRlVEWoyly+XtKJrbqyX
         WaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OPiJZGePz8MpF4ow2ohSqQtEI0YGYmAtCmJPdEg0UgE=;
        b=H36EBJ8iR7Q8LB3uvLdkAOIrWYh4/ik2kPfKU6iYw2BX4w2h8cFXOrxtDjfrDwxMIS
         1/FUdE5FwLZW4FCa5WzhAUXJXld+LPRr2S7/S1N/NTd5lpxSdT6zPURZBk4iT3yqoEVF
         JPXnMGfBYqZ/PUFZpyG8q3eWs636790QJiWRaOkb+nXwFdkkVhPtzASbMbsjSzeVC7gb
         vwxKku91xn2y3ga2+xIbOqQbGuNJe4DXlkkz+OcoPIsY02NPUw8cMmersaX8slZTEP2b
         1rBedU8ekL8B3V2X+ZpHefb5giv3g88Np+UMsToV8u3zbjDmw/Vw2OisxRKGkXDWd6C7
         6CKQ==
X-Gm-Message-State: AHQUAuaRun3m7++H6VRRTdtfaJ9nzHLDGlaWWUv/pgLDdJxkmb13mwlj
        FdYagM1k8zU/3MI4okjuppo=
X-Google-Smtp-Source: AHgI3IZDUaxCf96e0FLMetVOLV65gnR4XRoSzI1W/StEqE9wN4LHTHAzPXa+7E+ghP2RVfHv3n+m7w==
X-Received: by 2002:a5d:438a:: with SMTP id i10mr8897418wrq.111.1549478768828;
        Wed, 06 Feb 2019 10:46:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b15sm611152wrm.47.2019.02.06.10.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:46:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] git-submodule.txt: document default behavior without --branch
References: <cover.1549450636.git.liu.denton@gmail.com>
        <cf6e0d16ac0c0d521da98f5d9a53532b923a621c.1549450636.git.liu.denton@gmail.com>
Date:   Wed, 06 Feb 2019 10:46:07 -0800
In-Reply-To: <cf6e0d16ac0c0d521da98f5d9a53532b923a621c.1549450636.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 6 Feb 2019 02:59:52 -0800")
Message-ID: <xmqqftt0rc0g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This behavior is mentioned in gitmodules.txt but not in
> git-submodule.txt so we copy the information over so that it is not
> missed.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-submodule.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index ba3c4df550..9951c68744 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -261,7 +261,8 @@ OPTIONS
>  	The name of the branch is recorded as `submodule.<name>.branch` in
>  	`.gitmodules` for `update --remote`.  A special value of `.` is used to
>  	indicate that the name of the branch in the submodule should be the
> -	same name as the current branch in the current repository.
> +	same name as the current branch in the current repository.  If the
> +	option is not specified, it defaults to 'master'.

OK.  Thanks.

I read the whole page and there are a few other things I noticed,
which I'll write down here so that somebody else can think about
them (and that somebody else does not have to be you) as a tangent.

1. The description of "--branch <branch>" option here is missing the
   "<branch>", a mandatory argument to the option.  Options in the
   OPTIONS list like "--jobs <n>", "--repository <repo>" do show the
   argument, and the description for this option should be updated
   to match.

2. Some options are mentioned in the description of each subcommand
   it can appear (e.g. "sync --recursive"), while many others are
   not and shown only in the OPTIONS section (e.g. "--remote" which
   can be used only with "update" subcommand).

These may want to be cleaned up.  Actually it may not be a bad idea
to do #1 as part of this change (i.e. retitle it to "git-submodule:
"--branch <branch>" option defaults to 'master'" or something).

