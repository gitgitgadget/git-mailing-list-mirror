Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ABCC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 08:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhLMIDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 03:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhLMIDd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 03:03:33 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECB0C06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 00:03:33 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e128so17546141iof.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 00:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4ZHH+ScIKVmiRuJCKAaRpqRHp2kKNIXRDIS+eTLIYB8=;
        b=AjMlRA3IRdFoQqQw6fhERLXHKmfKi20F4cFWizVpmdpzISUjK0KVZwKY8sjGeFJTU1
         6dh1umU6bJ7ltF0Op6vivY5ZKY5FmawxC8ToALOfblFGdw4J+bhcD3vGtYaLYF6nWvmP
         9uagzp8sQ687DkTXp/IOjV89bzHO9Dj408Z6sKCDu7/Bwbqyx6arhLgcKxohyYTaROJ2
         2w7R5Sn1diRet8yOpZ0hE+h5tCoRkPxI/KKDOctcEGM3Cq1dxRPMC18YPQdJSx9bRq5X
         UAx6gKMDg/1hospPyVv00fWA7hXuXs7WtwEBR08Smc4aRmjpZZ/Z3hxvg96Mcug722hc
         JcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4ZHH+ScIKVmiRuJCKAaRpqRHp2kKNIXRDIS+eTLIYB8=;
        b=aDpoh7YnC1zwHmEXxc1f9LinlCr9lwtmjTX0xYVvrkJ6yji41cug5IbvW2sx+tMexW
         8+Z01gAEOgOBRCcOuX8YKlA0DuEViYeu+IkJIxwFa7llcLI6nwc3YfECsOPl7vS3B4Is
         zxixDqoPECznEQ4DKVgVTH8g26bep8ba/lj1jXk3aelz8EaW8SCbj84i9f1Ub/j43YOq
         e3VqkPwuYlaWs4zY0IpG6AZQUZ1dib/Osv4Gsc4sPAL1hy8PsS7p/ZvxfpcQtgoS2UZl
         FYsH6VN6pY3i3cHAtJxr7sw/4ONJzTsk85X5ADNyEk+fSupFqSdd+SdzMk6a7UcXv1Dt
         Muzg==
X-Gm-Message-State: AOAM533yVWgYW6ivy3z1I1N3B4cejMo2iTmFtIRrC2E8EfFhsG2WbWXL
        P4R9Y8jkmziAJgAl2IL5TW2JxvskOvYQjlTGNU4=
X-Google-Smtp-Source: ABdhPJwzp8Dwbyv3vp/fgMEM/liCtDWHC4uKJhH6KftKDVTKmmr1DZqDYrblpQeF1t6TJ4/AViPki7P7GTKkJ8sJ0q8=
X-Received: by 2002:a6b:6815:: with SMTP id d21mr33171252ioc.206.1639382612663;
 Mon, 13 Dec 2021 00:03:32 -0800 (PST)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 13 Dec 2021 09:03:27 +0100
Message-ID: <CAGr--=JiCv3XTrxP=foy+FrxbiYeMf=11eG_6kGBFmBr+P-=Jw@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     bandi.rao999@gmail.com
Cc:     Johannes.Schindelin@gmx.de, bagasdotme@gmail.com, davvid@gmail.com,
        git@vger.kernel.org, me@yadavpratyush.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


First of all just a BIG +1 to this issue. I'm on windows and opening
git-gui sometimes literally hurts my eyes. I even noticed I've started
squinting a little before opening it, then I move it to my side
monitor and open my IDE (which ofc is dark theme) on my main.

> Here is the preview I said: https://pasteboard.co/rwUBvWbX6m66.png .
> The checkbox needs some tinkering.
> Looking forward to any suggestions.

I would really appreciate it if you could help me make my git-gui look
like this. What do I need to do, exactly?


Best regards,
Birger
