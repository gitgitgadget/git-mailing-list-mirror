Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC3DC4332F
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiBXPsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbiBXPsA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:48:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B814757A
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645717639;
        bh=9UdGxRoqXENd3yW1INWGBv2ym8Q8lRv3W3i+ZKCSldE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QucY+2hfXJJtamH+nqpEH4U/C3o/hAC7rPlmIW/C6WAT0HHIxXEnMk325/aDCh9oI
         iSVgkMMEVXWMHZa8C8TQ7LWMuOINOyeniKoSlGz1IUcBIyxZsa4QmNqtQIQH3QJZJQ
         yRqCwbbV9M/U7jfUtiiWc0+0DkkCzRzzQ7xYUrFI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1oKq0m1JNH-011lWp; Thu, 24
 Feb 2022 16:47:19 +0100
Date:   Thu, 24 Feb 2022 16:47:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/30] Builtin FSMonitor Part 2
In-Reply-To: <xmqqpmnl8evc.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2202241646430.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com> <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet> <xmqqpmnl8evc.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cZ2SdHIPApdLWrqc0ywwz2QMw0q2g63fCIYOF8Pv7Fme8cxHpdM
 ZIp2WwMRo5/UMvq3tu3TR5Ca27HfRoQTUQi7eN/AsJPds6fykuqQ1r5KI/6SSKdffGekra+
 drKIV4Grwh6cmx55yzY8F6GtzLTSJ6VJA8xLBnqEqNsgMOewlb5f9YtS1CInVlrcTqlUrXE
 qnZT9ubfKSNaKIVlJVcLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3BSzyV6LNOU=:/ntF64iX/H9BE2DFXdq+Qi
 QzHVyeyVYavoKzDcUWj/mCC47P3VVxMvsiUxmDXoHGTSwndBtRRDpJZQj5IKYBKlha0gf27fT
 I1yMeFphKNJjpp0waBTFRn8Xeaf/7hUNlb5yL9DFCWgWIKRfvpN93s6lacWux6RvtJ7pCyY1f
 V65NSjnjS0C1dBid7b1xZeuoGFom0TpI7LFf0JteYbtX5C7/THVLDv9h/rqVTsHVM8F6mZulN
 DrBFxWd5rNq0IUpunDHNVFz6ABciVt95nFDAL5clqYDywTmV5abwXF7VsoK2wz7BysnDPssv8
 oohOAFHxVu/Lv+pO2OsL/ktS3yzmkSmN0DXkKkzaMLah5co0IimPurqTTR1/QZGXMflS51jtl
 HGNOqG7bnbWbNQ1je/Ehx8mQm4zG86SkYx/5uL0KP1WUb9cRerwBteEwZylfcaU/eNvnTwgFq
 O2RpNci7HaEPTzzRGQ9LmZC/Wafr4gcmlrq22GGcfnpIv02aMSgvhr+H3ashGRqkqXg8HIMp+
 l1lPhzroQDfIwoCImsCvPw5AGGGFzPuxWF+54RiiSqenluSKCOJRnDVqzW51bXjJ/wcwi62TA
 Kqu2PPjhoi+1X3ojL2xNL/YdcOaW1/GT/o7NtY/TOAP7ZzlPB4CxAOL6+fh3XZuxJ18tmEnJe
 3dYgjU/GGABh03QvFOTEbOd9ZYEtt4Z1LW358PJYB1kmlAtkC3gwW/p+1skD72hMTNK90qg2m
 jk0gmAKEKjp30r8H5qTwAAFZMVgAfTHBw3Avhl72okeq7AwlunFm0K+XyG6j1z9Oc1Lqi+ja2
 fnIy8TevDfOzlztDMNw5orYORC//DH5vY0GqF/9h0zrjx/yw2+vJ1ne484c7CLXiFrCN5ryCi
 dsysyEFfiwZy6kXDOHLvJqnKy9TLfB0Erzf+W10IOT4DdLrUJOF2ggosCC8/vFDlGA4hKex/U
 JU4QRL6t7I8XgdEsYj20x/YmUFkjUk51JRoPVY68Qx9phg2NsGS6A8kBCVOOeooAcvELmPTu4
 cVnmHpjiIKGa2ek3KWE/hc9IMCgoEFqWgGOLKjRHwHokB7IS5vmTFAs6rZ4aM78NZ4e/QYjIa
 2Ja6sM7/pGfKz4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 17 Feb 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> In this version I removed the core.useBuiltinFSMonitor config setting=
 and
> >> instead extended the existing core.fsmonitor.
> >
> > I am somewhat surprised that a reviewer suggested this, as it breaks t=
he
> > common paradigm we use to allow using several Git versions on the same
> > worktree.
>
> I do not think sharing the same repository with different versions
> of Git was considered as a possible source of problems during the
> review discussion.
>
> https://lore.kernel.org/git/74282d08-aaeb-0a1e-cad3-1de17d59b4d1@jeffhos=
tetler.com/
>
> I am not saying that we should not consider it; I am just stating
> the fact that there was nobody who raised as a potential issue
> during the discussion that lead to the cited message.

Just to make sure: I did not intend to insult anyone (and in hindsight I
wish that I had made that clearer).

Ciao,
Dscho
