Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57EF2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbcGMTKr (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 15:10:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:53514 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbcGMTKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 15:10:46 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MNw0t-1bTj5A3LzP-007QSI; Wed, 13 Jul 2016 21:10:31
 +0200
Date:	Wed, 13 Jul 2016 21:10:29 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <xmqqlh1534qk.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607132105091.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox> <20160712140427.GB613@sigill.intra.peff.net> <alpine.DEB.2.20.1607131329510.6426@virtualbox> <xmqqlh1534qk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NUs6tmi6mr1yfXOj/fyPyV/gApD0w0q2VUZ4m98LhrS8Yp6hbSi
 GWHD5fYNOcOXzQcD0Dyq82W4l6cfMBtrQmLK6BsmMOytAM8I37sAfQtfoJrPd1zdAUFdqp0
 KB0en0v7LiTKMuZ3NPwiVLo4cOIF41Rt3A7higCnBqrGH0YbYbL6OmTsJ/ix2uiaphGbirs
 EyBdNl9xq0RoFagxcOA3A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WtfGSoMt05s=:BL87fAq0As2Bw7Aj+ZNSP7
 N1ap4Tx5VcQwzjahib+0tOZMM2/j07Cj7/tM4WTj1pCNs/SmEySIeYCf4I8xBMwJ+mvCf48Z6
 /YvCq8+iGmwyUYEfxKNJX8KpP51OBoc0eB8TsgKhkiwaE3fbKyoXJqrVURExXmDB/rOMDDwMP
 XuxvwLORYlam65VDEBiCfnyW3OHT8F5Xg0CRJXdYs8/u8DWz0p1kDkLhdZ2X+yfLJ0EYzzJ48
 xKRZMJQtRA9cD8JhnsoGW+cVh1R5KarHPPBi52MmxGJrpciXd93owZXNcuVWe9jTfBr+xJag/
 2M5ZVNHRYqV2PoRXtjhzswdp+OqCXqjC+QfeFiwKEOTIV0pOYFv91moIzhwMFyGl7awWDhniv
 pwioMsRmQqIvD0cbiJGUAmyzmlACLNeZX18afJ7AF/2IABSaO6KRCTqb4z5W3rTanuP7iIbaW
 4BSehWWvfLoHgsOxgrEA/bbpiwVR/ud7DzkbCdPWdnX8vJ5Twhm8tPxjhbBKJZoniWq9hCRC7
 +kuOrUuOkbnjxBLfNHuGyDJrsZYRjAvcB6yMOI51+MSsWXaBwuJdaAhAerdeXQt9BAoEz9HOE
 2eMmb3J6GMKorckP/LZhLK/DGJyjx76XkEFsnkzXcVeGyj7C7bSziW7zfOc8QoV4vuRDBLQeO
 JPG1njwThSzwA/hiaGq23p3aNBsPGn/MlJG1fAU8NdOJbHguJ0tq4C1/7H6ldexTOD0dm+tDt
 DbABaD7O+Wb5pYXRW/Sw0KGzgU6LmN91WuS1V22KIiDKoGcR3SYOanO0M2P49c0pBWZ/zQyVR
 u8Xcbw3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This was just a quick fix, intended to allow me to release Git for Windows
> > v2.9.1 in a timely manner (which is now delayed for other reasons).
> > ...
> >> You'll need to adjust check_show as I did in my earlier patch.
> >
> > Makes sense!
> 
> Hmph, so what is your preferred approach?  You'll do your own v2.9.1
> that is different from others at t0006?

I may do a Git for Windows v2.9.1 that is different from Git v2.9.1 in
t0006, yes. Git for Windows still has tons of patches on top of Git
because I seem to be unable to drain the patch queue as fast as I want, so
I do not believe it is a big deal.

> I was hoping to hear from you sooner and do v2.9.2 with your t0006
> workaround with lazy-prereq changes from Peff (i.e. "Makes sense!"
> above), so that you do not have to do two releases in a row
> (i.e. skipping v2.9.1 saying "Git for Windows skipped that one
> because it was not quite right; this release fixes the issue" in
> your v2.9.2 announcement).

I am sorry that you expected me to be more available. It is a pretty crazy
week already (and trying to get a Git for Windows v2.9.1 out of the door
after dropping everything else on Tuesday morning added quite a bit to the
load), so I am at times unable to even read the Git mailing list.

As I am more concerned with Jeff Hostetler's patch now (the "very verbose
porcelain status"; I merged the Pull Request after seeing no comments on
his mail, but then Peff provided some good feedback, so now I am not quite
certain how to go about it: revert, or wait if the 2nd iteration is
acceptable and take that), so I am not immediately releasing any version,
anyway.

Ciao,
Dscho
