Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC44C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 06:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJGGJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGGJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 02:09:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19185A8CF0
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 23:09:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z97so5624669ede.8
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=VgDJSNrLhQ5z5g8I5K1yjEWgDDUWNS6IPJcSWYjkKcQ=;
        b=JT12c1pjtwxkvICXjjrWUv4JCDOceAfmYOiaaKj+s1Je3oraOBoIg+3UOd0WKSyQ7w
         Cer4OSOEmBHcrlTl29XmpfO7jyjQR0JzmwE98YHHZmoRiRoXtGPnKw1hCv+3m+Di/Wan
         tv0/wqbTHBKMRyqMFwzB0qcxxc6piR0BNeJAIum4fn5/emGlslNdSarkdsuHG6mABqOf
         RoQjNioDlI70OUofHdMB95C17Y/BGnrMwHrIzSyhlP0ulOwcnZSQuWsqyMb7sDc44Teh
         3+cjxFaJ+NJIO0wzKDdOiG5SFmFoiv/67B0vacrsnRKBtryqAaK4vF7HapvQL3dSB84h
         l7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=VgDJSNrLhQ5z5g8I5K1yjEWgDDUWNS6IPJcSWYjkKcQ=;
        b=vK2Tla6FocPfsF2Vm47ANyERebe+wnK+oh8gXEBL8+5jKIowuzNW+r2c6yM4MLcG8M
         Hnpk8YPa6FHUFEWi1DGyqh9KkSd7uQAGHuaOXsg6wi8B0m4PEVJSA1XfWoCBgU+zT/5x
         KmvKWByFUrIQHjPiuHNPsBUn7C136kAko5FqTc5eaikbWK8Bej7I9btSA2GsFwDjKODL
         8IWAU23tD2nmEG4p9vdN2cOlKtKbQzHX/FBnMCGccxUPDWByZB9ABTm6OX7YAgnqrRhM
         5rndGAGydj0o8Hl8d6ayr/HD1odYFgWHvscbIEAoPohXzod6rdoopH4AwaYasqUUHBVC
         7z6w==
X-Gm-Message-State: ACrzQf1cOZvzNGN+u2Wd5L8+01IQhijfxKqW29DE5/lIcdc6+Be3145F
        AWgadIcPz0jA5+ezS0rgzNLU0A/+gAu9w5AWTxKQcWr0G7c=
X-Google-Smtp-Source: AMsMyM4Fv3stGpBFKuSIYeW6O/Jjc6NTy11GB7PUG5SkQuCuQWSqOqXJm/qwMuYCjYDaNTfUflQKhIP91XQzOdY/sGc=
X-Received: by 2002:a05:6402:368:b0:458:9b5e:fd35 with SMTP id
 s8-20020a056402036800b004589b5efd35mr3110498edw.141.1665122962470; Thu, 06
 Oct 2022 23:09:22 -0700 (PDT)
MIME-Version: 1.0
From:   ddady <ddady1@gmail.com>
Date:   Fri, 7 Oct 2022 09:09:11 +0300
Message-ID: <CAApTLm9DJW6zARsbJOCEcahkuLHA23tCF=rJ1Vy0J+kufBfTGA@mail.gmail.com>
Subject: A possibly mistake on the "Git Commands - Setup and Config page"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

If i'm not mistaken, the path of configuring Notepad++ as default text
editor 64 bit version is: "C:\ProgramFiles\Notepad++\notepad++.exe"

and not as in your page "C:\Program Files\Notepad\notepad.exe"

Link to the ref. page:
https://git-scm.com/book/en/v2/Appendix-C%3A-Git-Commands-Setup-and-Config

I hope I helped.

Best Regards,

David
