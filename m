Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F6C20282
	for <e@80x24.org>; Tue, 20 Jun 2017 18:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdFTSeA (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 14:34:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32821 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbdFTSeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 14:34:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id w12so25118334pfk.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references
         :disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=9T0dzGdQQNmGOK7x/e8ynwOWHHYxJjYYWEXJpqhwBGo=;
        b=iSZrjW1JBq/mLv+rSCb2VsOsT87tqWKJGspG5Wmd3JvBCmJzUsiL6VOp0up94bBID4
         cRfF0/AMVrJdwXs+/GZnpFWDS7V2XgZwLIuDqhgykJOX7KX1nkDmlHybgDR4TuxkifP1
         /PqnPh0t91NtrU7BlGJPvNJvnKDok13rNmZ2d1pGX1SCdy6YCu4s4Hws7E6ybVLayMtc
         Myw2TD0tB8E93kPE3jUf/z2flEf0KMb7iCncQEeP/9upai5Yz7xb8pSjRn4NXH1s4huv
         D0gpdTXindt5wSyKn3+4LdJR7c7Gg7hMr7YpQFzO9qLGSsGKWGrcG+Ykaw8RqFs//zsk
         XbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=9T0dzGdQQNmGOK7x/e8ynwOWHHYxJjYYWEXJpqhwBGo=;
        b=VTKEdyeXLPdtCVz8QkbTsivy+FBs6QgPo7eXNxqXLAQeP+7fs34cJpv37K6Aw0dDoQ
         mYExxvTBAoxYGTumenaHYIe01TgPxeWK5sSGHUyXK7tX/GmMMy9eY0RY4p4hnJBRwG81
         jR1P4p0GLrtkvPgJtunjSWLFSRRTPfWtTEVMi/PJPYG2xihfd7Ze5rVor2fFw+JR+isI
         051TsExqTJm4DFwER52jE88j9bP5i3n0MHR+IIQMORAkJgmuxXZ4La9H60ZXJLCALcbQ
         eNdX2yWJoaRdmX8Owz0GfkeHrR+QA7zXec/i/aBTv2DytwzJjWOKvNiPBKrbb3TCuaQ/
         IvTw==
X-Gm-Message-State: AKS2vOyRsiuEp1M/65PUrP2rPqkPh1MjV9ISZm5iEj4O0pCBR6NHX8jZ
        hrTFizU8q4m/hK8z7eAkAg==
X-Received: by 10.98.18.143 with SMTP id 15mr4005081pfs.163.1497983639419;
        Tue, 20 Jun 2017 11:33:59 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id n78sm30723882pfh.128.2017.06.20.11.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 11:33:58 -0700 (PDT)
Message-ID: <1497981610.28187.3.camel@gmail.com>
Subject: Re: [PATCHv2] Tweak help auto-correct phrasing.
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
Cc:     Chris Packham <judge.packham@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20161220140226.18456-1-marcnarc@xiplink.com>
References: <xmqqpoknmv7d.fsf@gitster.mtv.corp.google.com>
         <20161220140226.18456-1-marcnarc@xiplink.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 20 Jun 2017 23:30:10 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-12-20 at 09:02 -0500, Marc Branchaud wrote:
> When auto-correct is enabled, an invalid git command prints a warning
> and
> a continuation message, which differs depending on whether or not
> help.autoCorrect is positive or negative.
> 
> With help.autoCorrect = 15:
> 
>    WARNING: You called a Git command named 'lgo', which does not
> exist.
>    Continuing under the assumption that you meant 'log'
>    in 1.5 seconds automatically...
> 
> With help.autoCorrect < 0:
> 
>    WARNING: You called a Git command named 'lgo', which does not
> exist.
>    Continuing under the assumption that you meant 'log'
> 
> The continuation message's phrasing is awkward.  This commit cleans
> it up.
> As a bonus, we now use full-sentence strings which make translation
> easier.
> 
> With help.autoCorrect = 15:
> 
>    WARNING: You called a Git command named 'lgo', which does not
> exist.
>    Continuing in 1.5 seconds, assuming that you meant 'log'.
> 
> With help.autoCorrect < 0:
> 
>    WARNING: You called a Git command named 'lgo', which does not
> exist.
>    Continuing under the assumption that you meant 'log'.
> 
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
> 
> Writing the commit message was more work than the commit!  :)
> 
> 		M.
> 
>  help.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/help.c b/help.c
> index 53e2a67e00..fc56aa2d76 100644
> --- a/help.c
> +++ b/help.c
> @@ -381,12 +381,18 @@ const char *help_unknown_cmd(const char *cmd)
>  		clean_cmdnames(&main_cmds);
>  		fprintf_ln(stderr,
>  			   _("WARNING: You called a Git command
> named '%s', "
> -			     "which does not exist.\n"
> -			     "Continuing under the assumption that
> you meant '%s'"),
> -			cmd, assumed);
> -		if (autocorrect > 0) {
> -			fprintf_ln(stderr, _("in %0.1f seconds
> automatically..."),
> -				(float)autocorrect/10.0);
> +			     "which does not exist."),
> +			   cmd);
> +		if (autocorrect < 0)
> +			fprintf_ln(stderr,
> +				   _("Continuing under the
> assumption that "
> +				     "you meant '%s'."),
> +				   assumed);
> +		else {
> +			fprintf_ln(stderr,
> +				   _("Continuing in %0.1f seconds, "
> +				     "assuming that you meant
> '%s'."),
> +				   (float)autocorrect/10.0,
> assumed);
>  			sleep_millisec(autocorrect * 100);
>  		}
>  		return assumed;
Excuse me bringing this up after a long time. Was this patch applied?
What's it's status?

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

