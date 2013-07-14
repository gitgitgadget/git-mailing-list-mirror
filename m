From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] .mailmap: Combine more (email, name) to individual persons
Date: Sun, 14 Jul 2013 12:14:59 +0200
Message-ID: <1373796899-23378-2-git-send-email-stefanbeller@googlemail.com>
References: <1373796899-23378-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 14 12:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyJL2-0000A3-Tl
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 12:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab3GNKPZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 06:15:25 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:35391 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab3GNKPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 06:15:00 -0400
Received: by mail-wg0-f54.google.com with SMTP id n11so9184077wgh.21
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EaOucch8Rfq03lXLDxj9yjf3/fDCOeCLXTXZHAXIaoA=;
        b=tYtOi8miwSoVaeuLkv/cMsZBAq/q0HnJ/P6euM9pVIuWaHL3D5OzsUaHWvLVaa4Trg
         QmawoytCSX1jxL0iTKRMOz0n4w4mLkpF+3usf10txnzoWR+javSBjTztWq1joi1Nrfbl
         qexwOcn1RonfPky7+eUpKHqy4t7BBPuaSpHiuFoYaeC9IlRHzUoYPJ7apU+7WU+NyW96
         scGSwhDhCHVr33KXhf7UGsJRWGvTBW18LqmLwAUFY0MrxL6NeoxpwsgCXdt9Vz01OT8j
         CWuRsrlhJfwqZxCOIPldSpZM2Z3r21ZVThYBbeGwHOkfE/vb4DX2aG47UBpxc08RGPeZ
         HtHA==
X-Received: by 10.180.37.133 with SMTP id y5mr5985212wij.30.1373796899082;
        Sun, 14 Jul 2013 03:14:59 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z6sm13553311wiv.11.2013.07.14.03.14.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 03:14:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53.dirty
In-Reply-To: <1373796899-23378-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230362>

I got more responses from people regarding the .mailmap file.
All added persons gave permission to add them to the .mailmap file.

It's mostly email mappings again. However we also have Nick Stokoe,
who contributed as Nick Woolley. He changed his name, but kept the emai=
l.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 22d3d70..9430d14 100644
--- a/.mailmap
+++ b/.mailmap
@@ -17,6 +17,7 @@ Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.=
ru>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
+Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
 Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
@@ -24,6 +25,8 @@ Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.co=
m>
 Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
 Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
+Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
+Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com>
 Dana L. How <how@deathvalley.cswitch.com>
@@ -44,8 +47,11 @@ Florian Achleitner <florian.achleitner.2.6.31@gmail.=
com> <florian.achleitner2.6.
 Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
 Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
 Frank Lichtenheld <frank@lichtenheld.de> <flichtenheld@astaro.com>
-Fredrik Kuivinen <freku045@student.liu.se>
+Fredrik Kuivinen <frekui@gmail.com> <freku045@student.liu.se>
 Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com>
+Garry Dolley <gdolley@ucla.edu> <gdolley@arpnetworks.com>
+Greg Price <price@mit.edu> <price@MIT.EDU>
+Greg Price <price@mit.edu> <price@ksplice.com>
 H. Merijn Brand <h.m.brand@xs4all.nl> H.Merijn Brand <h.m.brand@xs4all=
=2Enl>
 H. Peter Anvin <hpa@zytor.com> <hpa@bonde.sc.orionmulti.com>
 H. Peter Anvin <hpa@zytor.com> <hpa@smyrno.hos.anvin.org>
@@ -62,6 +68,7 @@ Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.=
edu>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
 Jeff King <peff@peff.net> <peff@github.com>
 Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
+Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@=
gmx.de>
 Johannes Sixt <j6t@kdbg.org> <J.Sixt@eudaptics.com>
@@ -95,6 +102,7 @@ Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.r=
u>
 Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
 Lars Doelle <lars.doelle@on-line ! de>
 Lars Doelle <lars.doelle@on-line.de>
+Lars Noschinski <lars@public.noschinski.de> <lars.noschinski@rwth-aach=
en.de>
 Li Hong <leehong@pku.edu.cn>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@evo.osdl.org>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@g5.osdl.org>
@@ -112,6 +120,7 @@ Martin Langhoff <martin@laptop.org> <martin@catalys=
t.net.nz>
 Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gm=
ail.com>
 Matt Draisey <matt@draisey.ca> <mattdraisey@sympatico.ca>
 Matt Kraai <kraai@ftbfs.org> <matt.kraai@amo.abbott.com>
+Matt McCutchen <matt@mattmccutchen.net> <hashproduct@gmail.com>
 Matthias Kestenholz <matthias@spinlock.ch> <mk@spinlock.ch>
 Matthias Urlichs <matthias@urlichs.de> <smurf@kiste.(none)>
 Matthias Urlichs <matthias@urlichs.de> <smurf@smurf.noris.de>
@@ -120,6 +129,7 @@ Michael J Gruber <git@drmicha.warpmail.net> <michae=
ljgruber+gmane@fastmail.fm>
 Michael W. Olson <mwolson@gnu.org>
 Michael Witten <mfwitten@gmail.com> <mfwitten@MIT.EDU>
 Michael Witten <mfwitten@gmail.com> <mfwitten@mit.edu>
+Michal Rokos <michal.rokos@nextsoft.cz> <rokos@nextsoft.cz>
 Michele Ballabio <barra_cuda@katamail.com>
 Miklos Vajna <vmiklos@frugalware.org> <vmiklos@suse.cz>
 Namhyung Kim <namhyung@gmail.com> <namhyung.kim@lge.com>
@@ -129,14 +139,19 @@ Nanako Shiraishi <nanako3@lavabit.com>
 Nelson Elhage <nelhage@mit.edu> <nelhage@MIT.EDU>
 Nelson Elhage <nelhage@mit.edu> <nelhage@ksplice.com>
 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
+Nick Stokoe <nick@noodlefactory.co.uk> Nick Woolley <nick@noodlefactor=
y.co.uk>
+Nick Stokoe <nick@noodlefactory.co.uk> Nick Woolley <nickwoolley@yahoo=
=2Eco.uk>
 Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nicolas=
=2Emorey@free.fr>
 Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nmorey@=
kalray.eu>
+Nicolas Sebrecht <nicolas.s.dev@gmx.fr> <ni.s@laposte.net>
 Paolo Bonzini <bonzini@gnu.org> <paolo.bonzini@lu.unisi.ch>
 Pascal Obry <pascal@obry.net> <pascal.obry@gmail.com>
 Pascal Obry <pascal@obry.net> <pascal.obry@wanadoo.fr>
 Pat Notz <patnotz@gmail.com> <pknotz@sandia.gov>
 Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(none)>
 Paul Mackerras <paulus@samba.org> <paulus@pogo.(none)>
+Peter Baumann <waste.manager@gmx.de> <Peter.B.Baumann@stud.informatik.=
uni-erlangen.de>
+Peter Baumann <waste.manager@gmx.de> <siprbaum@stud.informatik.uni-erl=
angen.de>
 Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolv=
es.pp.se>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
@@ -149,17 +164,24 @@ Ralf Thielow <ralf.thielow@gmail.com> <ralf.thiel=
ow@googlemail.com>
 Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
 Robert Fitzsimons <robfitz@273k.net>
+Robert Shearman <robertshearman@gmail.com> <rob@codeweavers.com>
 Robert Zeh <robert.a.zeh@gmail.com>
 Robin Rosenberg <robin.rosenberg@dewire.com> <robin.rosenberg.lists@de=
wire.com>
+Ryan Anderson <ryan@michonline.com> <rda@google.com>
 Salikh Zakirov <salikh.zakirov@gmail.com> <Salikh.Zakirov@Intel.com>
 Sam Vilain <sam@vilain.net> <sam.vilain@catalyst.net.nz>
 Santi B=C3=A9jar <santi@agolina.net> <sbejar@gmail.com>
 Sean Estabrooks <seanlkml@sympatico.ca>
 Sebastian Schuberth <sschuberth@gmail.com> <sschuberth@visageimaging.c=
om>
+Seth Falcon <seth@userprimary.net> <sfalcon@fhcrc.org>
 Shawn O. Pearce <spearce@spearce.org>
+Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@atlas-elektronik.c=
om>
+Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@googlemail.com>
 Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
 Stephen Boyd <bebarino@gmail.com> <sboyd@codeaurora.org>
 Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
+Steven Walter <stevenrwalter@gmail.com> <swalter@lexmark.com>
+Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.=
com>
 Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.b=
e>
 Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
 Tay Ray Chuan <rctay89@gmail.com>
@@ -170,19 +192,25 @@ Thomas Rast <trast@inf.ethz.ch> <trast@student.et=
hz.ch>
 Timo Hirvonen <tihirvon@gmail.com> <tihirvon@ee.oulu.fi>
 Toby Allsopp <Toby.Allsopp@navman.co.nz> <toby.allsopp@navman.co.nz>
 Tom Grennan <tmgrennan@gmail.com> <tgrennan@redback.com>
+Tommi Virtanen <tv@debian.org> <tv@eagain.net>
+Tommi Virtanen <tv@debian.org> <tv@inoi.fi>
+Tommy Thorn <tommy-git@thorn.ws> <tt1729@yahoo.com>
 Tony Luck <tony.luck@intel.com>
+Tor Arne Vestb=C3=B8 <torarnv@gmail.com> <tavestbo@trolltech.com>
 Trent Piepho <tpiepho@gmail.com> <tpiepho@freescale.com>
 Trent Piepho <tpiepho@gmail.com> <xyzzy@speakeasy.org>
-Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
-Uwe Kleine-K=C3=B6nig <Uwe_Zeisberger@digi.com>
-Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.de>
-Uwe Kleine-K=C3=B6nig <uzeisberger@io.fsforth.de>
-Uwe Kleine-K=C3=B6nig <zeisberg@informatik.uni-freiburg.de>
-Ville Skytt=C3=A4 <scop@xemacs.org>
+Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <Uwe.Kleine-Koe=
nig@digi.com>
+Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <ukleinek@infor=
matik.uni-freiburg.de>
+Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <uzeisberger@io=
=2Efsforth.de>
+Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <zeisberg@infor=
matik.uni-freiburg.de>
+Ville Skytt=C3=A4 <ville.skytta@iki.fi> <scop@xemacs.org>
 Vitaly "_Vi" Shukela <public_vi@tut.by>
 W. Trevor King <wking@tremily.us> <wking@drexel.edu>
 William Pursell <bill.pursell@gmail.com>
+YONETANI Tomokazu <y0n3t4n1@gmail.com> <qhwt+git@les.ath.cx>
+YONETANI Tomokazu <y0n3t4n1@gmail.com> <y0netan1@dragonflybsd.org>
 YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
+# the two anonymous contributors are different persons:
 anonymous <linux@horizon.com>
 anonymous <linux@horizon.net>
 =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
--=20
1.8.3.2.804.g0da7a53.dirty
