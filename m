Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523AFC4332F
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350967AbhLFQGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:06:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:51869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444643AbhLFQDA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638806368;
        bh=wk3RgKneV86RF8+7sSsklV+0x3TUbYikTl2AWzKXkN4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i4yKrULolDI6VmcbkmFXqizjDsEaZ1m8719wBuzo7GP+vLMV727f51slwL6i/Z+En
         Lm3Ttgp5tAjU488XfHVe2xau20pGWakR69SMQt4KIApde7NJaC1qYr+Ng92h7Dg+Jn
         kWDgOPy8yoBpYju7u/BFLv7Un3kAmdWA/v9BN3C4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnakR-1mBY3m3P5Z-00jd8d; Mon, 06
 Dec 2021 16:59:27 +0100
Date:   Mon, 6 Dec 2021 16:59:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Slavica_=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/2] Use the built-in implementation of the interactive
 add command by default
In-Reply-To: <2ffbab1a-d5b2-fee5-806b-4e81eb759e11@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112061659010.27797@tvgsbejvaqbjf.bet>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com> <2ffbab1a-d5b2-fee5-806b-4e81eb759e11@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1493341414-1638806368=:27797"
X-Provags-ID: V03:K1:nmjt2PKrRzZv4DyNw7Oy9CbPVk9MLCyTpUyzFI4Pa6EW5xjajvG
 FVir0nhQwwB1TvNTZn1gdtAyS8r/mA5DwO+JY5bMPpGOuBkXulHBbfqsf2XhzEMgzOL7xTX
 5OwxozRVKCHPu6pJt8UlWhVfsQreJwlOAKjSmupNPtH/BxGRICBOvwPHjTE78hhcN6Ipy5u
 gAVRHAzROa9x0W75wHNwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0qSJlCfC/VI=:S5khhqs9AtRnLxjZf7eQgP
 xmBtDmN/PLJlXnNT52ImH1L+bahgkwuYASc+4s4ZYg2DM4SvolgVov5QzeNi1HdBRzBs4B1W0
 PVu61HdjlNfWTxcqH2ZF6I+caMMrycqTS83+pD/SptoCZ6aLCt1ww7kxDOLmxfS+zvMX9TMFq
 keEy9TZOE8JyrB13veeULunawvaJtMb3fOm+3BQJ/HRGdCeEF0XNvWthj6N9PIZxfBuUKz7Ut
 sQXIlRVgmhaTnzTdu3wCB7sFF5BIY8nyMb+8Sq7nVYlN6/SBZ287WLvQlo7a59muk0KeCDVNt
 H9wPmeGOW4GjMEjaKO+WHRIS+5mmE9/jAutaoO22Mr513X1RBxjgzchUjcY6h2l72LbePP/Nu
 1yqq+i21ag8kM09cTUrJy6BUISPa+22yI/RNh1mS7Li9Uxu1YX/0kRkWPrETdajg1WDn6yFsv
 ZzEHvpBLEpQkdFM8LX+OsmElFPU48WF9mnAqL89eB9xwTynPkoVty5gQIrMJbGfidjZ8g0bC0
 dszV591pHRDWT8br8p6oLTjo5icNerPR7KSJ9k9AN9e6UXQt5w1470O6mUM780Uf2EvxN0PUc
 RFS3jmdoz3sABbKdLBiDHQrlCkTsNqL2JI+hfI2n2wP1GhL95VM32n5nj64mBLcIPnacIB6Co
 tzKqM0IT2OY9uDBUz7Z6i5OIJPn94N4XTu5mo5kSbPuH3VhSTKydUm2vF0RnmxlPEGXWPgcVK
 LBzNKE9gaT/RpBzDfsvQA/QWX4MPCnem8WqqyyT8cY0UxfxxFMWJqiRIP8b7GoWe8zgTm9wjV
 MXL5sByxZd7/cfD1zk9UvNHcnJBXmHpbnXJl3KKlRcEFCin4PslW5ph2GereBbyFNlaHs5/IS
 TAceyHsNbVn6poqWDmn8arxJnrS8SrWFGhdt88lpXLEozv5dcrum44H44tN+DHskJEzNk6Vot
 2Yjeclz2X4hBnA6+4U+IrprBG29iDoCmkaWqyFg4RGCUdMwEPqUYnjoh/Z469VQ5n8MiUL/wE
 is7g6jE3DyUNu511TZyU/AyAweoN9+Jgq2oCndG9j6bUHEI91W+mrlEwZeVMx9LNXu6EHlrsu
 +byYJwZjalLbLk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1493341414-1638806368=:27797
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Fri, 3 Dec 2021, Philippe Blain wrote:

> Le 2021-11-30 =C3=A0 09:14, Johannes Schindelin via GitGitGadget a =C3=
=A9crit=C2=A0:
> > Over two years ago, Slavica =C4=90uki=C4=87 participated in the Outrea=
chy project,
> > starting to implement a built-in version of the interactive git add co=
mmand.
> > A little over a year ago, Git turned on that mode whenever users were
> > running with feature.experimental =3D true.
> >
> > It is time to declare this implementation robust, to use it by default=
, and
> > to start deprecating the scripted implementation.
> >
> > Johannes Schindelin (2):
> >    t2016: require the PERL prereq only when necessary
> >    add -i: default to the built-in implementation
> >
> >   Documentation/config/add.txt |  6 +++---
> >   builtin/add.c                | 15 +++++--------
> >   ci/run-build-and-tests.sh    |  2 +-
> >   t/README                     |  2 +-
> >   t/t2016-checkout-patch.sh    | 42 +++++++++++++++++++---------------=
--
> >   5 files changed, 32 insertions(+), 35 deletions(-)
>
> I just noticed that 'INSTALL' mentions that Perl is needed for 'git add
> interactive'
> et al, so maybe we would want to tweak the wording a bit in there when s=
witch
> the default
> to the C version ?

Not yet. Only once we remove `git-add--interactive.perl`.

Thanks,
Dscho

--8323328-1493341414-1638806368=:27797--
