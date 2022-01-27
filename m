Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5003CC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 15:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbiA0PBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbiA0PBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 10:01:04 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F243EC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:01:03 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id z15so1998257vkp.13
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tBdezwEhs/z1+6c5Xi71vBpKvpH2eW/7QW6G7Fr7iio=;
        b=nyLNrls//gfDXpLmVDMCkG4QMQm4b0p1C1SU9R10iICw+xgQWgr7s3tbke+jBRkvHY
         2ePE3A5+gMP2fTdio1rVXcxtp2XV8Of35P4k/D9UazAi+1pu8IVysGrr130cnvfm4ksL
         XiwBVyehPk7mUevTGadr0eAERMIxRqZyD1uyUzvFUXb9OUFaNtapOgjSs+DrIr4SuQhF
         7lQBNFwHR4bheY5Ut2w85csBtSSbA78uRwBZbfbBbmXuh1k6Gps14QpXVQ7lpXhB3ARn
         F0gsYhXYeXR1E+cvpKNv3a4YykwRgYoDUB8r7CV6Bc17IMY1uOrio03UE4uN28ykL9lL
         QLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tBdezwEhs/z1+6c5Xi71vBpKvpH2eW/7QW6G7Fr7iio=;
        b=m0NMzBC4Ehn9Wic7E9HJwmqCxOXjERi/8yl+fJDdiLM2rP+z8mk1ctc5SRtwol+mp3
         OSjX2a/5gnMo2sOYdhxtmd3wIutkqftPYKa9Djq4fWEOD1Uf8IHtGvz1VCep07E1Q/ta
         CDKD6EOz/9D7p8/IsOaqKwEVbmbV5ZScTydpQ3xGp4YpIi1n42E1deC7JUz5BGFjPO8t
         4Xrre6p73PeQgxe8b1vsZZpUBc69OrR1fe8jFReoaOi8+Y+hWUh4ajZqMBphsbRj1IIj
         ffnEZAtSu+Y1FpmR5MdYBtotnktyORolUG0m6DbSxafV/mDCkn2QHJfYYbEGUlFAvZ4G
         pIIw==
X-Gm-Message-State: AOAM533c5siMC/J0/HfCaGEWd41QE37heqOwC8nK83Kf3JVSlOWLeUsK
        +x7RQapPRDzxeEaC2KgDTDzUWo5SEf7b0uNGO4J9G6IFTrjqrg==
X-Google-Smtp-Source: ABdhPJzy4MmCe8+1owpmG3KK7OHTS9pcUl8S0dkoM6s5voe/ryfaJXliaYauv6yi2SwLm4vjDteKOiKf/fDbd7JtAYs=
X-Received: by 2002:a1f:258f:: with SMTP id l137mr1710333vkl.6.1643295662733;
 Thu, 27 Jan 2022 07:01:02 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
In-Reply-To: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 27 Jan 2022 23:00:51 +0800
Message-ID: <CAOLTT8QzaM70_jk4bOnBAHFaNjf6d_WSNp4h-qLWr2eJLdErBg@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Community <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all,

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=
=8827=E6=97=A5=E5=91=A8=E5=9B=9B 02:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi all,
>
> GSoC 2022 is approaching. The timeline has been released [1].
> Mentoring organizations should submit applications between
> February 7 and 21 at 1800 UTC. So, I thought I'll kick off
> the discussion about our plans for GSoC 2022.
>
> First, are we interested in participating in the 2022 round of
> GSoC?
>
> If we are interested in participating we need:
>
>    - Volunteers who are wiling to act as mentors. I would be
>      willing to be volunteer myself as a mentor for one student.
>
>    - Microprojects: I believe we could repurpose the Outreachy
>      microproject ideas[2] for GSoC too. If others have suggestions
>      for microproject ideas, please share them.
>
>    - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
>      but both were picked by GSoC students the previous year. So,
>      we would need new ones this year.
>
>      Taylor showed interest in a bitmap-related project during
>      the Outreachy application period [4]. Taylor, are you still
>      interested in mentoring a bitmap-related project? Would it
>      be possible for you to do so for the upcoming GSoC?
>
>

I've been busy preparing for some internships lately and may not have
enough time as a mentor to help this year's GSOC students, but I can
occasionally provide my review for interesting projects this year.

Thanks.
--
ZheNing Hu
