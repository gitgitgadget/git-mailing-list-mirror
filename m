Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CD51FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbcIAIwm (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:52:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:50183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbcIAIwD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:52:03 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LwF9u-1b26J01ORS-0181wk; Thu, 01 Sep 2016 10:51:56
 +0200
Date:   Thu, 1 Sep 2016 10:51:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/34] sequencer (rebase -i): write the 'done' file
In-Reply-To: <1472668771.4265.74.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609011046420.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>  <516d2aaf8837c8675141cf9c330c18c44765b69d.1472633606.git.johannes.schindelin@gmx.de> <1472668771.4265.74.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-760690558-1472719916=:129229"
X-Provags-ID: V03:K0:4uLz4Ew269119c9MPhjxDOZqdElvkKDJPxPqGDG4nN2r/3YaEjV
 scUxPv3TAPKocKlBRufu1xQjhnpwyFNMxrfc2SNThUhJuDavcpRzrtUCAxnu7FFF9RYDipM
 bqDwq8pwsSUQxfC+e3Jv2VbcsDe0SlZ38ZVhqjE4EVjZiRjFEWBiaWFT7SAS6QZpIZ3gaVR
 PtA+DXfBpUvR/SBWRhovg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A33H1GmIVBs=:WrpBNxwmPBbOkoGDH9YyvE
 NmqoaoR/BD7TQAeWQXD2XiXh+iIeOYH/9Wuq1oTG5DSzbl3KtFydC1pWMDOaHMptOgR1ea9p6
 uobglxHyMiGp2ewcqqC2Vvae5Oi+OZM07qw7+Ug2kahv7ySrF4SRxAqxN0eruC+HhvYxCt+XM
 aM/ZFUVWYaoOuy5JtKSKb6wa2bwzHyKu3ie4DavwTlyAn2n1epoMQDPyHIKqsYMq2c17dK2ZG
 7v+N/r+Mt/VkyYQEH+wghgjGkpJYucsFeQTvuEmLYDcuAaxJIgpzHzvC4ndh58XZHAKOSKk2w
 IRJ5Pqk6qX1RM0bVDvK1vQ3UexchLIGrLdhhfOJaJ4RC6BalY/Id4BYbtHDu7eMT2v/N2ZsMg
 8RbeNYuOG2OmA21PCrHCZWWe2LKF2oH3gAHrP+5A5q+0F8E0TmNO7cJa2CFWov6kFuGgWajFH
 NxHAqIp5LCTs1j6nc/JCY80LDV7671P2LzrRpy/FV4wfuWtuQMpmDVIFllu9ngaDV26Pa+iZj
 dCOflaDjwLb2e0h04L2M9Vr3JKERFpd5x/49LqcDqdmqKfI1Rv2Fm8ZjJErP1/3zPFDnhZuoB
 VfD3/UmaxPiewmELuH6Xsf65816+vdzdGXBgZJrA10nVw08yzlKJ7Ln5wOxycWZ0+II6c/vEq
 a/n8NdN9YfwN5wVr1hixoooF2LeAccPCeNFz9OCLYHJU4e1DH2fqwx1RcG1yA9Tjqg21sLgIw
 tNi9tRqUgVMWtIhc3MqbqLzT5otWWuwyBZO5EC3FYPfOJK03yU9UQAY5XB0JwAecLdYMbId4k
 y79O2Tz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-760690558-1472719916=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Wed, 31 Aug 2016, Dennis Kaarsemaker wrote:

> On wo, 2016-08-31 at 10:54 +0200, Johannes Schindelin wrote:
> > In the interactive rebase, commands that were successfully processed ar=
e
> > not simply discarded, but appended to the 'done' file instead. This is
> > used e.g. to display the current state to the user in the output of
> > `git status` or the progress.
>=20
> Wouldn't it make more sense to have this patch before the ones that
> implement the actual rebase commands?

I waffled about the order so many times that I don't know anymore. The
thing is, while the sequencer is taught incrementally to understand all of
the rebase -i functionality, rebase -i itself is not touched, on purpose.

In the case of the "done" file, my thoughts were: the commands do not need
this file *at all*. In fact, if we did not write the "done" file at all,
the only two types of test failures in the test suite would be 1) git
status' output and 2) the prompt testing for the progress.

So you see, functionally, the "done" file is only relevant to the progress
part of the patch series.

As such, I'd rather keep this patch in the current place, just before
introducing the progress.

> Hmm, and after reading more of this series, I think the same applies to
> some other patches too, e.g. 08/34 and 14/34, so I'm probably missing
> something. So before I make a fool of myself and suggest that the
> implementation of the actual commands should come at the end, maybe you
> could tell me what I'm missing :)=C2=A0

No, no, don't hesitate to suggest reorderings. I am really thankful for
the discussion we are having, so that the outcome is better than what I
have right now. If the outcome would be the very same patches, but with
more confidence, it would still be better than what I have right now ;-)

Ciao,
Dscho
--8323329-760690558-1472719916=:129229--
