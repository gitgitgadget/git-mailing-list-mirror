Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCAA320196
	for <e@80x24.org>; Thu, 14 Jul 2016 12:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbcGNMfx (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 08:35:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:52664 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbcGNMfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 08:35:52 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MEKZg-1bd8L00klU-00FTgh; Thu, 14 Jul 2016 14:35:34
 +0200
Date:	Thu, 14 Jul 2016 14:35:31 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t1308: do not get fooled by symbolic links to the source
 tree
In-Reply-To: <57514BA8.7020207@web.de>
Message-ID: <alpine.DEB.2.20.1607141435030.6426@virtualbox>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com> <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de> <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com> <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com> <20160602213920.GA13356@sigill.intra.peff.net>
 <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com> <57511E44.1090708@kdbg.org> <20160603061023.GA7687@sigill.intra.peff.net> <57512980.1070200@kdbg.org> <57514BA8.7020207@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1881508000-1468499734=:6426"
X-Provags-ID: V03:K0:/ynOM8jyxBj8+aQlnmKDdahknpuoGATsrntgdRzTyMUCBWgGddA
 EyROYGh2wqtRgTG0XlthR9R+LAq5mxat/66yA/USX/V/1WlLgMpazHtzKk22fVWobp9H33V
 yWVuSZd4icnqYPR8Mqw7MD5+uyIzak2mj52RcTWQbTJZjTe3T6SZ+fzChG+szq0yg/5qaFP
 yWBfeOdB0SI6AVtmPvmhg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:FwzRuK9CfMw=:K5N5tFIahC69a4S8vQipYp
 QTOR6SPacdq8gfY8KALI6OfPuJN3d678Uif6TaTOb1jawAXAcMm+wZAOSBoT3xYyTXL8f9FdY
 szDUHkvab5kvmN+W32Lnemn3guPMKv/VnixP6JRZixKilO5Otb3asg/5VRcxChjUva9yIZUEK
 x6YmQ+xDDd0rX4bVQUzW7HHvtACZ/SyGHSVtNrhpuQyA85+rIZK6mB/9N0pyxv98P3Xq2nF66
 NmILigTUe16QatXZtQ9rwwY/Lxcx+lNWqk/NRokTwg8gbR7iSnNEmLcvkQp7y89PptFtUxrHo
 zOpGjOWuIqTrqKMs6IhNCwhxWM7StmSncp8DxJTet+NEFoisVSAgZfZctqBi8LPnMiCeRrwyx
 qxehKWP3l8krvG5I7yyJ+CYB4WO4kfsrfwGnH4c3RbaJ0a2I5wOegReZWnm5AR5RsZT5yC1Ta
 q9srLgDsvATWB590vUOwzVVfgvJb7IZvLEdqoX/B1YRokrrrEZAADUTVE7ASTBLNoZdpwt/hc
 MVnwMcsy8vJdU1TtGH6DFZrZnW1cVDc3EARFZtbe65UJhJJ/oyRG84w/7cX4ZUndI3V0500K3
 D16bbHB0ygrlWFjg5fBafLJe0Vx8THksW84aGQSqeCuOIY4P/o65nsJgb3wpoySwZMTGJ1JOR
 PlJqOdT5mmAOlNYwde4zi0ERrwQn9ndK94Snpz/dcYq2+mygqWYzmjqnu9HliNFvEq0Oo8Rzf
 IgXq0LMwUDY9lUDv0qGleNCpdHuRPXP7RwJhBm5O5GqK1Zbon5svKR9JXuAEeSjT9nJPT3Sny
 wGzuP3A
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1881508000-1468499734=:6426
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 3 Jun 2016, Torsten B=C3=B6gershausen wrote:

> On 06/03/2016 08:53 AM, Johannes Sixt wrote:
> > Am 03.06.2016 um 08:10 schrieb Jeff King:
> > > On Fri, Jun 03, 2016 at 08:05:56AM +0200, Johannes Sixt wrote:
> > >
> > > > > -    name=3D$(pwd)/.gitconfig
> > > > > +    name=3D$HOME/.gitconfig
> > > >
> > > > I haven't tested this, yet, but my guess is that this breaks on Win=
dows:
> > > > test-config will produce C:/foo style path, but the updated test wo=
uld
> > > > expect /c/foo style path. Dscho, do you have an idea how to fix thi=
s?
> > >
> > > Hmm. This should come directly from expand_user_path("~/.gitconfig")
> > > which prepends the literal contents of the $HOME variable. It does go
> > > through convert_slashes() afterwards, but I don't see any other
> > > massaging (but I won't be surprised when you tell me there is some th=
at
> > > happens behind the scenes).
> >
> > Yes, it happens behind the scenes: /c/foo absolute paths are a conventi=
on
> > used by the POSIX emulation layer (MSYS). When bash (an MSYS program) r=
uns a
> > non-MSYS program such as git or test-config, it converts the /c/foo pat=
hs in
> > the environment (and argument list) to c:/foo style because the non-MSY=
S
> > programs do not understand the MSYS convention.
> >
> > -- Hannes
> Compiling pu didn't succed:
> unix_stream_connect is missing in read_cache.c
>=20
> (And many more in index-heloer.c)
>=20
> (I thought that the index-helper is only compiled on systems,
>   which are known to have unix-sockets and other stuff ?)
>=20
> After patching that out,  t1308 fails:
> -name=3D/c/
> +name=3Dc:/

This issue was not resolved, and now this commit is on `master`...

Ciao,
Dscho
--8323329-1881508000-1468499734=:6426--
