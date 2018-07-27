Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2FF91F597
	for <e@80x24.org>; Fri, 27 Jul 2018 15:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbeG0RM2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 13:12:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:52219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbeG0RM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 13:12:28 -0400
Received: from [192.168.0.129] ([37.201.193.59]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ma2Lr-1fPbnw0WNz-00LjC6; Fri, 27
 Jul 2018 17:49:47 +0200
Date:   Fri, 27 Jul 2018 17:49:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     knu@idaemons.org, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script
 properly
In-Reply-To: <xmqqbmatrixc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807271749290.10478@tvgsbejvaqbjf.bet>
References: <86a7qwpt9g.knu@iDaemons.org> <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com> <CAPig+cQWA+sE3iH89kQGWgS+0HQDK-V5++S0+F6_dpfOCfXxDg@mail.gmail.com> <xmqqpnzlla1p.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807261347040.71@tvgsbejvaqbjf.bet>
 <xmqqbmatrixc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1L0xopHafNFbtKDufxb+DyTnxCX0VXLS6CshhHnSkxbj831J7oS
 R6kIA558kFsE2ZdEWaRTGLl5ZPnIAGG6F1jG7IsOMOLjgaSs5CMJCCCByypOgf/Ajvj1JAb
 t3lQMXSzO93aSkzFzLd6soPTuDi/60d/FCAQuF3stV9IcyvM+hGn2ve3OcuCD9skxkqdsEx
 kJs3S6Rhk5xeAhCiPDy6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wKNP5A0UYLU=:6/G7kmqzyo8YwA4XpAbyJc
 HE60+mUjn1dTnO3IQnrQntISmo6TUl1ieFHmbI96SWux/LFE3iw0pKlRVyPxIjmk7Sg99NUJ7
 OB6ufoM3M9C7VjJN/cdrDKQxg0YuF3Xsop6z4AoGeIDGRPSwWPBzKcaDswf42AiB9RkcwS50u
 jiwIc1ThbUt/aT/RzA66cwvcMebbYrb80Y61Z1YbMqEbK0aEgqVebmdGMhOjgWQiudtHHrgWd
 +9wBqrwiVBzu5U29qg2rZZA/0n88woHvFgLFkOiNCj+lWZp7UE0OKGwesGpTmJQpkx/Wag3dU
 +DKa4wb2El5sW8O1gmyQApwx6Tw/kAb3b4Qp5gXyYkWcyavhqUJZw/cdLTYgdj6v4cjb+mvsh
 nbNHtk0CYC8HqWiHswFri/jBO5U4H32w3sAfJEI9T32eLFGpKCiWiyCJ4RdiFBc1Jf4ksmQ4M
 OIMuNSUCuDktm5jjowRNUAUgmFsuEWNeQDawLtwIgqJH5Yq4P8lYtPL1Yp13XikuudXI9kdtZ
 y6wpyL7S4zoPgjXrP9fCNeKKNKsawhnZKHpxoz8uIDH5r63N8WjG3b+WqRTINKfrOgnkPHD6j
 a4ObiajCl8ToKTasmTRSM+dGKX1BjVUeA1iVNLbg7kY2/6wuNS82wrxXKG68oqAKdNqXGX4AD
 MYSWiZd2Ek4kelCJOGwndzS+2Ujpd3aFOMOf4Wr5yoGbWyf3dPxqZbeUfkGBRbEItDE/4z4PC
 G/WcMqpNqGc4bsZBLIpINFQRE+lkF7NTeGrCZeEevM+AaRjSNPQziiOdwNlPN47zwnnj7nFmB
 pPBKig3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi Junio,
> >
> > On Tue, 17 Jul 2018, Junio C Hamano wrote:
> >
> >> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> >> index 2d189da2f1..b0cef509ab 100755
> >> --- a/t/t3404-rebase-interactive.sh
> >> +++ b/t/t3404-rebase-interactive.sh
> >> @@ -81,11 +81,13 @@ test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "ed
> >
> > You missed a very long line here.
> >
> >>  	set_fake_editor &&
> >>  	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
> >>  	test -f .git/rebase-merge/author-script &&
> >
> > Why do we need this, if we already have an `eval` later on?
> 
> You are commenting on a wrong version.  Comment on the original.

Sorry, no time. Take this review, or leave it.

Ciao,
Dscho
