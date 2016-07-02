Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70221FE4E
	for <e@80x24.org>; Sat,  2 Jul 2016 06:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbcGBGwv (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 02:52:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:51221 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbcGBGwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 02:52:50 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MegbQ-1azOcW3oyW-00OHUp; Sat, 02 Jul 2016 08:52:37
 +0200
Date:	Sat, 2 Jul 2016 08:52:34 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	"dmh@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] add an extra level of indirection to main()
In-Reply-To: <20160701223809.GA32545@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607020851060.12947@virtualbox>
References: <20160701055532.GA4488@sigill.intra.peff.net> <20160701055858.GA4593@sigill.intra.peff.net> <alpine.DEB.2.20.1607010953440.12947@virtualbox> <20160701081919.GA21076@sigill.intra.peff.net> <alpine.DEB.2.20.1607011449380.12947@virtualbox>
 <20160701223809.GA32545@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-404450175-1467442357=:12947"
X-Provags-ID: V03:K0:dOw2BbHX3WxHRTLkR8ITKOMXDoXQJHElbs0qkSn6Qpeyo5WtbVi
 GiALawGGprexfcoOgyR9N3ZdPmNV4JnIHjnKclsULxb8289zuRHenzPG0vdtktMM9eEYHZL
 YfyG/41syWu0cTK1pUJHGFRD8hmoy3h67enHwz+aUNDn12DtqvaEXaorw4V+4fZiIHi6qFk
 SCH1ZaYApXhrBlHV7bgsw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:vD4Qx2qBiBA=:xe+//kqHpPQKyPrArQ+91L
 JprzoSOOpkTgaPx+FncLarmv1hu7ZrkIgUwRLcCLbleSvRFKGZ8N/1TopgC6IO/6+FlUYXne1
 xUKI3QSvwzGgCfhkBGTskIb/lvUjj9NqNhp6iBl++7FUM0xOVmBLYwJzbeQ5Go7yJSfHYQmCV
 UaAniJ3JeCvAa4Y3JFQCXfn9myeMT35PawuWsOT0GKRnYmDf2wb8ruBeJmkLe4LOEBI5FyWsF
 7sSkFXBUpSlPxY9+zP/E/KaoxVUsA6JBp5mE+yEDKW3ziMzNXPxhtw6/+ppleG2vDBOndF1uk
 wRfxaYWu9l57G1BS2J/huyXVHTEeIlKNUt/3DjT4PuKlgJhd7LOg4iu5pM4+bmqJdTqpity0n
 87DhJTojpmp1Mc/GLSqDWro2cRStmDPakfZwpzDB/8JnE9eE93iMTSNO2cPryKvGNZNIFWoVo
 WOw4fRwhV66N8Y0gH0W+QZT0YMWgIVnWdtllW/h8Y3ZqAf5dhxygw/8WkwRLIZIISAulOqL/R
 0AX92FxnhybUEer5Xla6N4DqsP12jO6eJzdxcSljk0JcuzXWpwlZCUbTjdOGr/xGnB8VsZlFH
 UyL/phG5npllkoueou6NgK35ztkNCmBaE778GVDAYE7pRjgWWSZWhaf8Q7e4SX3M43XIrhocl
 LHK9LtxDACCafTMKnY1IXLIfDL+nEOZpZK4VUvQufVoTHUVRjB/E7mWPnzSmPk7/631mRkuSX
 EFfmo/WLzAB9XXPcG5KobJo7BDpp08+I+jIHi2EBmDV43r0rxgZS7qe5UfZS1NdklJpf8CRkD
 7S4/b8a
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-404450175-1467442357=:12947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,

On Fri, 1 Jul 2016, Jeff King wrote:

> On Fri, Jul 01, 2016 at 03:39:03PM +0200, Johannes Schindelin wrote:
>=20
> > > The description was sufficiently long that I didn't want to try
> > > repeating it, and opted for a reference instead. If you're planning t=
o
> > > fix mingw_main(), I'd be happy to do that as a preparatory patch, and
> > > then just skip this trickery entirely. :)
> >=20
> > Deal:
> >=20
> > =C2=BD/5 is in 5c54dff5c54e68a1101d8fe37aefc6158fddd7f2 and the fixup f=
or 1/5
> > is in 7b74f7aabb56b428c74f5983c066dc9ea8fe5116 in the 'common-main' bra=
nch
> > on https://github.com/dscho/git.
>=20
> Hrm. I didn't find 5c54dff5c when I fetched from dscho/git. However,
> having seen 7b74f7aa, the one that comes on top, I actually think that's
> what we really want anyway. It's really my first patch that makes your
> cleanup safe to do.

The reason is obvious: I forgot to push :-( Hopefully you did not
duplicate all my work to move my patch in front of the branch, to make it
a preparatory patch.

It is pushed now.

Sorry!
Dscho
--8323329-404450175-1467442357=:12947--
