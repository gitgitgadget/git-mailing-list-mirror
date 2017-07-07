Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4E2202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 15:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdGGPYZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 11:24:25 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35716 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbdGGPYY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 11:24:24 -0400
Received: by mail-pf0-f171.google.com with SMTP id c73so18728237pfk.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=sTlG3aaMOFXshMLMoyEFT4kT6hG3k3XR1J6NKMcLBzw=;
        b=aOVbgu6ctBv0XQNJjzGSpKYMGFuCY8sBf6Hw5WXTj5u4J7dyaoBI2SbdmdOcp6CgIh
         2A5dZ0O+CvPBO7T2RJlp2OHPKFUFREyVugP76ieHWVpfD3RrLe3vzwV4k4/Ps63ugi6A
         lHMaKC0Lds+kntTgZbHseVDQmhP7vLCs2WwSpOkqpxawjbtjmGScOnkYq0Udq5SrfnWJ
         Hjw42ZRJ9dZReBqY+Qbyr/XOxqv0j3New3zOtOJpXCcIKYjpaUTGARvOTR2dHMcmmydR
         kV966Ct86+QcrOU74w7YDZ7izRz/A4OD6qWY70jG7Ejh2Bx1F00ZMvb1AdYbqmhY+PeU
         sYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=sTlG3aaMOFXshMLMoyEFT4kT6hG3k3XR1J6NKMcLBzw=;
        b=t0wsyt9X4jPjjKyPCiq0f0pVKOgHqmXS+GdE0rbvz0L5XJ5ejj1NDpysYtg/WYxrEz
         7XnvAcmyZQ87nbjhll4TytspNJtW3GCvZMcw6w3RE/XjUxNR4Juli3WHa2D1pJEI/XMF
         gTA812W2r4J+Z30cHHMHr2vBV3xlfez3zoPfvXreu2KEsfup+k9Q6jNoiCKLZ0k5iq0p
         5w0pzf2kwM+RdoEbW/xNFtHEdicEgBYXrjmL/y/shWAhXiHocgDpbLAiJaCtOutTeUPm
         kV75nDXG2nqmQprojytGqOh3scTSZydmxgWNp4keCKeHfyV6RgthX91OOIWa230CvSGP
         UpLA==
X-Gm-Message-State: AIVw113rD2wXAru9aZAfx9CFKGxHFIU4vGOdpwxd60s+DKu1omf0cx0Z
        g7amZ0Iw8vAAt/KznqU=
X-Received: by 10.99.121.133 with SMTP id u127mr2067496pgc.31.1499441063387;
        Fri, 07 Jul 2017 08:24:23 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id 83sm9453513pfa.113.2017.07.07.08.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 08:24:23 -0700 (PDT)
Message-ID: <1499441062.6829.1.camel@gmail.com>
Subject: Re: [PATCH] hooks: replace irrelevant hook sample
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 07 Jul 2017 20:54:22 +0530
In-Reply-To: <xmqqwp7kcmoi.fsf@gitster.mtv.corp.google.com>
References: <20170702112728.15757-1-kaarticsivaraam91196@gmail.com>
         <20170705165114.20662-1-kaarticsivaraam91196@gmail.com>
         <xmqqr2xuhde1.fsf@gitster.mtv.corp.google.com>
         <1499428393.1849.3.camel@gmail.com>
         <xmqqwp7kcmoi.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-07-07 at 08:05 -0700, Junio C Hamano wrote:
> That is because I wear multiple hats, because I try to help in
> different ways, and because open source is not a battle to see whose
> idea is more right, but is a cooperative process to find a better
> solution together.
> 
Thanks for helping and being kind!

> As a fellow contributor, I do not think that removing the hint that
> is commented out, which is meant to be helpful to users while in
> their editor and which will be removed after the editor finishes
> anyway, is a useful enough example to keep the now otherwise useless
> sample hook.  But as the maintainer, I can see that you are still
> making sincere efforts to come up with a useful example and improve
> the end-user experience, and more importantly, I haven't heard from
> other people what they think---the only thing I have are different
> opinions from two people.  That is why I am not deciding and telling
> you to go find another area to hack in.
> 
> At the same time, I found that your implementation of the idea, i.e.
> removal of the commented-out hint, can be improved.  With an
> improved implementation of the proposed solution, it may have a
> better chance to be supported by others on the list, and equally
> importantly, if it turns out that other people do support what this
> patch tries to do, i.e. keep the sample hook alive by replacing the
> now useless examples with this one, we would have a better
> implementation of it.  And that is something I can help with, while
> I, the maintainer, is waiting.
> 
So, I'll improve it and of course wait for any replies. BTW, thanks for
clearing off the little confusion I had. I'm not used to these
multiple-hat replies from single person. Thanks for exposing me to it.

> Oh, by the way, what the maintainer is waiting for is not just "me
> too"s; this is not exactly a "having more people wins" democracy.
Got it.

-- 
Quote: “The most valuable person on any team is the person who makes
everyone else on the team more valuable”

Regards,
Kaartic
