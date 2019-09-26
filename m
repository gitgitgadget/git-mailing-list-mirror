Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD641F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfIZVFn (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:05:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:40895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfIZVFn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569531935;
        bh=tTqGcevMNYLYAOl+Bi9kNd20goDnWEOMjPq1i7oAaoA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OQ2Z5XyYPMdAk4cdGvWpoGbeblwQnJz1864xO9sHD+LBrI/wj1mGQvd0ryvXyW2qN
         uTJKaLVUqtHTmsMlFvZ8PhX8lu3wId6wdIrUFMWp4q8gscg6uVckJcngxSYdlmezTs
         E9ZLXlEUt/lc9fnOb4Z+U6ZiR6ipY/Zz04eRVSUs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1i3sAl1VtU-010tLQ; Thu, 26
 Sep 2019 23:05:35 +0200
Date:   Thu, 26 Sep 2019 23:05:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] git gui: fix staging a second line to a 1-line
 file
In-Reply-To: <20190926184449.swkqutltmwpzde6s@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1909262303310.15067@tvgsbejvaqbjf.bet>
References: <pull.359.git.gitgitgadget@gmail.com> <02ec6c5bde2f15c51e946c6806d8231fb5abffe5.1569519804.git.gitgitgadget@gmail.com> <CAKPyHN1XJHtcdzhaaeACFfb9=7PxdyHvrdafwJxDwQjbW_hbcA@mail.gmail.com> <20190926184449.swkqutltmwpzde6s@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lxnHGaCdZJ5GZpUsbP8w6Kvu1FJPD6KoYm8BcC0CYZaLHoQ28aO
 oPM0Qt6dS+/Mx8nFvZZZr2WpzZeLAwxRklw7ujqtjpQb4SdyLXvVPmNUd9Dvh2AzcCRf1YY
 ePGqeyA+RouJiVqfKQslQ62r4uXDwlnWLiFXe3HYId59GYBa7d2SOD9z66ErS0nqTCcN1Jh
 aUYuLOMDjpgvJL+9e4evg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f6LC2gOk3uA=:f8LhlyiHEtmO2GBaPNmjWW
 g83SsUOMIqUgd1ozjoacXjg0c9reYUg2l7crT41mWDbJvZ9JZLqrXwK94P0Q54mdSKf8hCT5K
 jP+N4tIs+Vz6SMf8wuX7sUmmk8CMEm8scH12wEDizULj8t5Cb1ewS6OjIFC/iuvbTFD4otfqT
 qKOzr/DwPsptnGiSUTw7Ueq4SuJ4k7hzLag8wVqhFIN8z/TWJMQ9ZEgdFrS/BQqYHuzu6yITd
 07wPx9qQ/wp7ESOOt2UPGbiwR6+Y3P4E9/5f4BRe24+ZrEi1jU2s8mtHVJw9swM0YgB4ffqd5
 FFgNbxmIhcHLTycNCaAtBgT5Iat4OqNvAcpaf+6EGKTZExrbXXiMGFBMIWia2KzsT465hn9cA
 bUN4GhAyWPDFoVoG6dZrBwp8d3gJwRFjwwK588SAl81zI0Se144+WYCj4zZC2xqVGLcWzvG/8
 AqN+bwcV0ojHVWVlurdmpcwjjxWFjQIdBJaYBk1zMAwse7moetZJmeANrqoD8hYikwSCuVA7S
 JtkYA85TgcuAB1qdwEv3oieh2HapSimtsC2geiszxo7T4FjDYp4Xfqtfxj794Yu7qP6x2p5ci
 p8zNVWNfgSzGso6gDZLxwE4J+l5VAxtKqh57dRWSxD/nGwczr/NhbSMx86SFuD4QRSFucZic8
 bV1yeuGaGwuwx0g/rxYUhvKyiVNBlYhVQCXXMEKhjL9TOBPZeRIb0X0Pd/oeFHpL/YbZrDfeF
 9UyVTefDBrDvDTyhfSTtGorPqsIF2WSECOfpto1CsbtMfzARF44moVYNQG2aiXirL0Qt37RoO
 TipLse7rpSXCffmu6Uo1pw2944mdatlqnWAs9k22tjnfnsV8Z9hx2mqGuINDKRS2o+EuqMC2A
 V6fdJllbnNqa7NGqbi4rGESBN6J/ASYCuuq6r9JtKZMk3W9C+ejSC79cnHU9L8JRb7lUntU0m
 dUnzeSkRxN+fIs+4y8TbF66J3m1td5eF7QeHGDO1NXEmczkTFCqg4XMqXV+VpGRcC8UnshYAU
 qMvrmc9ydRHhYNgLFoqPwacYnNU25fDpIH60b0NXfuIoNCjN5Ld/5lD9ty3A/T/l1Y5oox2/5
 efxo+OGAr34GNGU+WrDDHoytK08VHmSm7D/JhpHfK7xpY4HaDaH1Se6yyyNpbhQtt3sB8ewzh
 G9CS08gnqMrHz3piK4/Oj7db9ZRwnRj/WKWYfHZD5URr6z4Se9mVimnjLujcUnnW/XHbEOYs4
 l5yxB2TiZL1ukIVb6snqvg0G3Sd3z+iRc0XaB9fleLN6dLVl4hUEHEEk6tXE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Fri, 27 Sep 2019, Pratyush Yadav wrote:

> On 26/09/19 08:25PM, Bert Wesarg wrote:
> > On Thu, Sep 26, 2019 at 7:43 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > When a 1-line file is augmented by a second line, and the user tries=
 to
> > > stage that single line via the "Stage Line" context menu item, we do=
 not
> > > want to see "apply: corrupt patch at line 5".
> > >
> > > The reason for this error was that the hunk header looks like this:
> > >
> > >         @@ -1 +1,2 @@
> > >
> > > but the existing code expects the original range always to contain a
> > > comma. This problem is easily fixed by cutting the string "1 +1,2"
> > > (that Git GUI formerly mistook for the starting line) at the space.
> > >
> > > This fixes https://github.com/git-for-windows/git/issues/515
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  lib/diff.tcl | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/diff.tcl b/lib/diff.tcl
> > > index 4cae10a4c7..68c4a6c736 100644
> > > --- a/lib/diff.tcl
> > > +++ b/lib/diff.tcl
> > > @@ -698,6 +698,7 @@ proc apply_range_or_line {x y} {
> > >                 set hh [$ui_diff get $i_l "$i_l + 1 lines"]
> > >                 set hh [lindex [split $hh ,] 0]
> > >                 set hln [lindex [split $hh -] 1]
> > > +               set hln [lindex [split $hln " "] 0]
> >
> > this is already in that master

Sorry, I thought I had rebased, but I obviously failed to do so.

Ciao,
Johannes
>
> Yes, this was recently merged in when I was pulling in some stuff that
> went directly into git.git's git-gui subtree, instead of making it into
> git-gui first (thread at [0] in case someone wants to find out more).
> This commit was one of those. Junio directly merged this commit into
> git/git-gui, along with some other stuff from Johannes in the commit
> 02a5f25d95 (Merge branch 'js/misc-git-gui-stuff' of ../git-gui) of
> git.git.
>
> [0] https://public-inbox.org/git/CAGr--=3DKXqFbivuXHPNecb3dBR_hx8QqWoR4p=
BGXy7uOiT+ESbg@mail.gmail.com/
>
> --
> Regards,
> Pratyush Yadav
>
