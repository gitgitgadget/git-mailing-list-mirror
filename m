Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8F8C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 11:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5109020721
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Bz/vGjez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfKULNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:13:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:40101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKULNA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 06:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574334771;
        bh=R7E4UTM2HYvM6b+WnQcttMYEtZTbsEM5Q7JDIKhufEs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Bz/vGjezyZjRNVG4A3/4JWmFW55n05bFQMgAgNcouTydnehNKCGU4FGH5czSd7kuQ
         XoOH/UTjhj+ZcqWxoBOIU5j+wXPDm7E0fmSvHD81hA3Og32AlrCD9WFgpzv7hFTWq8
         i1yVei5e+M3gmWuq0TUx2vMEIm3W6w3upf+7FDog=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV63q-1iNCY12T02-00S7wx; Thu, 21
 Nov 2019 12:12:51 +0100
Date:   Thu, 21 Nov 2019 12:12:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce`
 cask
In-Reply-To: <20191120225439.GA18277@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1911211209190.31080@tvgsbejvaqbjf.bet>
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com> <pull.400.v3.git.1571789978.gitgitgadget@gmail.com> <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com> <20191118221804.GA23183@szeder.dev>
 <nycvar.QRO.7.76.6.1911192155140.15956@tvgsbejvaqbjf.bet> <xmqqk17ve45s.fsf@gitster-ct.c.googlers.com> <20191120225439.GA18277@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-817254985-1574334774=:31080"
X-Provags-ID: V03:K1:ENhHttsBkInLvSP26lWYrKb3JT0OmGaQB4D8g9UV95MFqCjF54v
 fn0ifG4iXXJE55aEw/rv0ItecfAKrjXjzIVd+u/aUgPtd27TldP8WswEJ1Tbds5PscUFP35
 S/w6Im8fbvxmehe7mLACALI4wJUGGWV3SbudRxtydQEWhNR/Hpt1mbz8H5IY2lp7mblms0K
 mcU9fZGfXEmGj4x015Mww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U8zjaa5QiSE=:fTP3upwdOaCdedcLmhBcYH
 M7fuVFdDEVVNz/EBfxF+byCGIiuyhzs7+wvOC6o/FXpIDzI+XzkwFyA5fZuHJfzOf76UUfZU0
 F3+QcaoZjoPb7OJRipE9XyJWXvKHZku/93K0bfEMhKeDZDaW1ULRTanZMTGExmLcXGsSTyiOx
 0jqN6KWcpqUL9C/J2jfghO5LL2WWNOlSTApRzWjVlhl0bx48K46Y7P6PwBQWSL7vQJNv3K0b+
 95i3KKkYmdGV+VNLDCB7p+Zv1DSJNirRgDvkeP8O1CRinNPthjyjdyD4Y9H5ETFxFZC61Jb9P
 hBCR5UiENCeUs5Ioip+OTVhqa0KbVpOdVldhJBo6n3w1m4uMIfSPxTbvPhdgzVJ+PopD2dthj
 xN0eN/114eNS9Sj+T0lqArLruGsd8Y5h4SdFcDeNSuOVz0zahDVFImvYYPD/A/tH9FZNUwy2N
 E0W/3RjsoAD+SS3LblFN+cc5tj+GpWjX0GAC1xNHf++zE8VEcOrIBkWZsZ5QnE/AxNuJg0MpP
 wHI1q1nXvRguATxQBRNQt63wkBuVmmnvIlj2Ylh4UPyVWq6XwViekc4xKcKxPWw9PW2eIzbBP
 GFdn7wAk6MdgUaNpcY9Qs9P1Bx9HItEk0WwDY8gqYfvIMFNRUpLm0nElNps3rSaLXVvgLtcgy
 M0Hn+KGQDZI2UCFr8UyrGmwN6pNc3FLAOIlKYa4VZ+Km2e90zyAhbE0lz8jnh8sC0ENI7DtRA
 xtUM8b7Cle0GDG81wgA5jHsG2C0rQSx6bO2WpMH8BWKORVvEkJpNwxdIP+cA8bML60tbbbkRu
 oCal20r9AKjurLq+YCNiEoCzj136NLdhmRXsRHh6sdypt8whTg/bnxPxgOZh+vw1+E7Cns7Xh
 Gmjdij4V/0T6U32GlByxIS83C2uGuT1Dy+NzlRP+vPP6pTS39cf4JjqRh4wHl4LptLe715J5C
 EHJqCIIg9bnkhE/yyidwRUZgL33S1VuyahNZaKvBLIhknRjN3JyN9BEP23gkxArcdIrcKbC9r
 S/wQVBTn2vvLj8V56DoaqFx53iN48WOkzZfCidu0Z6UMs52yCPGTzmb71TfdILC6R8VixDsSC
 8XRKW4LmB/kPd25NqBM9B0GEFqLSWPyPIjLOtFWrCvxb6UpdolWdcCaDvly75fE0Uyqtm2wKI
 0bmSfx7vq5yRVWfi2BhpMnFkm8rZlywjnJT8yZmZtuAidVAiitutvQ3EZDzcr/TyZ7c0dqpF1
 qGlIO5lqzURPmo3eeZ/8OlSYvRJJOvJ3u1McB6zV8FqMZgRyePlAmoxnUZcI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-817254985-1574334774=:31080
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 20 Nov 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Nov 20, 2019 at 10:18:39AM +0900, Junio C Hamano wrote:
> > Subject: ci(osx): update homebrew-cask repository with less noise
> >
> > The OSX CI build procedure updates the homebrew-cask repository
> > before attempting to install perforce again, after seeing an
> > installation failure.  This involves a "git pull" that by default
> > computes and outputs diffstat, which would only grow as the time
> > goes by and the repository cast in stone in the CI build image
> > becomes more and more stale relative to the upstream repository in
> > the outside world.
>
> Minor clarification: I, too, thought that the CI build images are cast
> in stone, but the Travis CI build images are definitely not (don't
> know about Azure Pipelines),

Judging from
https://github.com/microsoft/azure-pipelines-image-generation/commits/mast=
er/images/macos/macos-10.14-Readme.md
it looks like they are updated weekly, although I have to admit that I do
not know whether the Homebrew packages are updated as regularly (I would
wager they are). The latest update to Homebrew itself came in 21 days ago:
https://github.com/microsoft/azure-pipelines-image-generation/commit/866b3=
68747a064f22ecfb7061e9034e3e21c63d4#diff-fb7f82d5a779a32aabccaad5bb9ab35c

Ciao,
Johannes

--8323328-817254985-1574334774=:31080--
