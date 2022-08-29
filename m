Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA2EECAAD5
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 16:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiH2Q53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiH2Q5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 12:57:20 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD59A96B
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 09:57:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id cr9so6580555qtb.13
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=+SYOAC6lt9nbWLE996FE2p/PEHylCQeMIN1ZZTJSJxA=;
        b=KhkwIlu76gPzEtZHSnWivNr1BJZHF3otGIRR9we1EhBAEDVVTy9/lNNroC0cIBLXVe
         /g7igB77AW7GrFjGFdQqZ1wfiaNPf5jz7Ypct5FNU8dqdN4KTZZJoGFpKNH5CgOcK2h1
         SllftE2vlrGXC8aEdBMbffmJwjUjrgxutzgz+pq2YBhor6cXdXuzypx43EcuB+sVoHbF
         nDibWTXgbGdxR3q2ncCMVGbiT4+wthqO9xDDtXU05+8EivlRVJ7RzDBKsK5FmViXfsiP
         MHA7yMNv8sdeNl+67VrB1GcKk0oODCMdV0uaPo1Fna3U4dyGaKdu+X3FZGGDVgnCqAHt
         +Ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=+SYOAC6lt9nbWLE996FE2p/PEHylCQeMIN1ZZTJSJxA=;
        b=m3UWOWSaC2kFyFKlKqc7k4UkivtgcACpAcdwQ3FZAXF7d4oH7AFIyZhg6htw9l7Uxf
         vyIVurVRbI7hrHNVvA/YGszuK0DU+gxaBb7SIHnsKQCAsB1czSElQT2zV+oDCA9R4X/o
         Rk2s36CIiR4N4JuSKIH3Geb3tD/oSV+MvqErNI2pjpDCieAjS1Fw1X1LtDgkaUM3H3r/
         WVoTN2pZ4jVIH5Bf8bRzq0POPqFhrLUP7VbvpFoVaCGlBdTYa0ggXLqFmKY7JamBhQKt
         4q64R3pwJpyoxYeee5fRAt+53mWnB3K3aI0hoGN7BnjL9Ue7HBfqTebTmDL4yJYvSsfg
         Mwfg==
X-Gm-Message-State: ACgBeo3F7Bji9vN5XtcG5511eN3FwZf1ltPs7+lr5TkyCCKxVf+Lcjd2
        8rloOmU33W/vbpz+BNxwdh+UL+92AuGMklcU
X-Google-Smtp-Source: AA6agR7xJ/XkLXWaelMsaMVTPU1RTqd3zLr7dViAlbJU2D2F9pTgPxPJNsEshVt3uxZEPihvCYXCzw==
X-Received: by 2002:a05:622a:387:b0:345:432:578a with SMTP id j7-20020a05622a038700b003450432578amr8895703qtx.588.1661792237561;
        Mon, 29 Aug 2022 09:57:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ez5-20020a05622a4c8500b00342fb07944fsm5431751qtb.82.2022.08.29.09.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:57:17 -0700 (PDT)
Date:   Mon, 29 Aug 2022 12:57:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>
Subject: Git in Outreachy? (December 2022)
Message-ID: <Ywzv7Dl6n+LcY//n@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Christian and I both got emails from the Outreachy organizers asking if
we are interested in participating again this year. Last year we
submitted projects, but ultimately did not select anybody from the
program.

I think it would be good to participate in this year's December cohort.
September 9th is the initial community application deadline.

If we're interested, the project submission deadline is September 23rd
By then, we'd need:

  - Volunteers to act as mentors
  - Updates to our applicant materials on git.github.io (project ideas,
    as well as potential microprojects).

If folks are interested, I'd be more than happy to answer any questions
about participating, and overall logistics of the program.

Thanks,
Taylor
