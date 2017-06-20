Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94AD20282
	for <e@80x24.org>; Tue, 20 Jun 2017 18:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbdFTSFV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 14:05:21 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35525 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdFTSFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 14:05:19 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so23061894pgc.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references
         :disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=UDpZSDG8XtyoSkamfE2F0DEiplHXfVNcQcs94FmQUKI=;
        b=crw/d+UpiXmpsy8878AB3sHa2R5DbAtwkyz0wqH5+00YN1/wOssarmtc1Fe75h5yH0
         ClCWY+ntSrSQz0WbHMdqVc3YIdlpR6TycjZDW8IerIGr4AszbyJIUsrc2O7L80Ov3eZt
         DOEY6KJ+FfParFHmf1EmutVekAQy3/JtniiG97cBntBmcZ2cWnd20GsGBHcY3KE/x0dV
         3XWq2vhI3aj16rKL0rUxWERcI2gEyw0BLFrqYrs0ZaG/kPAKfvwQ7pjgMgJkwvZ0v0Mw
         RcyrP+2tK/pfOarVRAosI8D5/6Tvc6AS+01v6AE+zCqy5A58/qfESMMitiWpovDPNgC+
         u2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=UDpZSDG8XtyoSkamfE2F0DEiplHXfVNcQcs94FmQUKI=;
        b=oin+7zRWQ61y/zDGNmoguC4rCQTHbtTZLYP4MS5JE3+yMFnIL3snV6hgfJjeNoFi7U
         K287Z399Yp/0UENuAJ9l4XLemMG+1dSAAfMDOIcR3cj4bUs6iLdqhPlmoSkRyVFo58py
         ovZbnF5rtBKSC7r1NcScOB7m1ix6PoKJk2EZ1k+cG2ybyfQml8Mny8KMdG9blhNplxPh
         gtHk3sL0+2KFHPe0gO75FPzzOTX+1S0ZKsLVhiDk+FQl9OzFaL7qbtJzdqX8oolMKqs7
         F9gTgpqU9vK0sx1qixx6zruxoFJ9UeI2AXqyL9/jOv08xpVJba7jPLTw9IyK0EuGoeRc
         hYSw==
X-Gm-Message-State: AKS2vOzlhR9hwwg36Sc+HG0mQaV6TiHGP+ql0IZeTcYpKeEKSD3jAWvG
        Ehnv1IWrCARzrw==
X-Received: by 10.99.107.66 with SMTP id g63mr20211839pgc.277.1497981918776;
        Tue, 20 Jun 2017 11:05:18 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id j27sm16122158pgn.63.2017.06.20.11.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 11:05:16 -0700 (PDT)
Message-ID: <1497981886.28187.6.camel@gmail.com>
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
Date:   Tue, 20 Jun 2017 23:34:46 +0530
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
Excuse me for bringing this up after a long time. What's the status of
this patch? Was it applied?

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
