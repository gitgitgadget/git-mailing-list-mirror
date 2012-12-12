From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] .mailmap: match up some obvious names/emails
Date: Wed, 12 Dec 2012 06:36:35 -0500
Message-ID: <20121212113634.GA18803@sigill.intra.peff.net>
References: <20121212113036.GB19625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Cheng Renquan <crquan@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	=?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Kevin Leung <kevinlsk@gmail.com>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
	Mark Rada <marada@uwaterloo.ca>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 12:36:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TikcT-0008Fk-5J
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 12:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab2LLLgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 06:36:40 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42799 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985Ab2LLLgj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 06:36:39 -0500
Received: (qmail 23192 invoked by uid 107); 12 Dec 2012 11:37:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 06:37:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 06:36:35 -0500
Content-Disposition: inline
In-Reply-To: <20121212113036.GB19625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211341>

This patch updates git's .mailmap in cases where multiple
names are matched to a single email. The "master" name for
each email was chosen by:

  1. If the only difference is in the presence or absence
     of accented characters, the accented form is chosen
     (under the assumption that it is the natural spelling,
     and accents are sometimes stripped in email).

  2. Otherwise, the most commonly used name is chosen.

  3. If all names are equally common, the most recently used name is
     chosen.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm cc-ing all involved authors. If you object or want to normalize you=
r
name in some other way, please let me know.

 .mailmap | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.mailmap b/.mailmap
index bcf4f87..69301bd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -9,7 +9,9 @@ Chris Shoemaker <c.shoemaker@cox.net>
 Alexander Gavrilov <angavrilov@gmail.com>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
 Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
+Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
+Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com>
 Dana L. How <how@deathvalley.cswitch.com>
 Daniel Barkalow <barkalow@iabervon.org>
@@ -18,13 +20,16 @@ Horst H. von Brand <vonbrand@inf.utfsm.cl>
 David S. Miller <davem@davemloft.net>
 Deskin Miller <deskinm@umich.edu>
 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
+Eric S. Raymond <esr@thyrsus.com>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
 Fredrik Kuivinen <freku045@student.liu.se>
+Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com>
 H. Peter Anvin <hpa@bonde.sc.orionmulti.com>
 H. Peter Anvin <hpa@tazenda.sc.orionmulti.com>
 H. Peter Anvin <hpa@trantor.hos.anvin.org>
 Horst H. von Brand <vonbrand@inf.utfsm.cl>
 =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
+Jakub Nar=C4=99bski <jnareb@gmail.com>
 Jay Soffian <jaysoffian+git@gmail.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
@@ -41,11 +46,14 @@ Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
 Junio C Hamano <gitster@pobox.com> <junio@kernel.org>
 Junio C Hamano <gitster@pobox.com> <junkio@cox.net>
 Karl Hasselstr=C3=B6m <kha@treskal.com>
+Kevin Leung <kevinlsk@gmail.com>
 Kent Engstrom <kent@lysator.liu.se>
 Lars Doelle <lars.doelle@on-line ! de>
 Lars Doelle <lars.doelle@on-line.de>
 Li Hong <leehong@pku.edu.cn>
 Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
+Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
+Mark Rada <marada@uwaterloo.ca>
 Martin Langhoff <martin@laptop.org>
 Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gm=
ail.com>
 Michael Coleman <tutufan@gmail.com>
@@ -63,11 +71,13 @@ Steven Grimm <koreth@midwinter.com>
 Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
 Robert Fitzsimons <robfitz@273k.net>
+Robert Zeh <robert.a.zeh@gmail.com>
 Sam Vilain <sam@vilain.net>
 Santi B=C3=A9jar <sbejar@gmail.com>
 Sean Estabrooks <seanlkml@sympatico.ca>
 Shawn O. Pearce <spearce@spearce.org>
 Steven Grimm <koreth@midwinter.com>
+Tay Ray Chuan <rctay89@gmail.com>
 Theodore Ts'o <tytso@mit.edu>
 Thomas Rast <trast@inf.ethz.ch> <trast@student.ethz.ch>
 Tony Luck <tony.luck@intel.com>
--=20
1.8.0.2.4.g59402aa
