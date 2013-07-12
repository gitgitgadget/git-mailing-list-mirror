From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] .mailmap: Map email addresses to names
Date: Fri, 12 Jul 2013 19:29:19 +0200
Message-ID: <1373650159-29203-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:29:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh9x-000476-TU
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138Ab3GLR3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 13:29:30 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:53309 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964904Ab3GLR32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:29:28 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so8354083wgg.8
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=EjqjYvDfe6oJJtDprw97/5TXt0kLNmAdXmgd14VLWuQ=;
        b=NDSBUJG1CUyfIedAbWhR3zgHJHINxAFSIRh61mzA6IuJH+pBADIEp/o/XlU7t8mnIQ
         ATh3VvXvIE9YecqhPm8tVRecgI6VOGjJZ7oxZbmH0c13nERzjS7oCKLcY5Y1nIcZHW1H
         5JDKLjEwml0uedWelzHPqftVu06SW9W3Zxpp6yrMqjLiSDLxUAWRcWFa6npY6IxZ2Xgo
         RbN7DB41CRWEIFbExhyDM2H2AilQwp/jwwKkp41X2HUer0J/Af1r9cHjzk2wsykdQYon
         MBkTaqqvpyuTvyvz3zHo999d7FovHsAmWNIrOY34FVMKAD7OaJTHNrikms4et+0sg636
         jV7w==
X-Received: by 10.180.126.10 with SMTP id mu10mr2202435wib.64.1373650166506;
        Fri, 12 Jul 2013 10:29:26 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id s19sm4658090wik.11.2013.07.12.10.29.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:29:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.790.g9192b0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230221>

The same kind of cleanup as sent earlier today
(2e2ae79df4fabea0157c5eb527b5396eb89185a1 locally here)

I asked all the people before, whether
they like their lines added. Many had
requests to change the order of the mail address.

When having this patch applied, you'll notice the
bug as described here
http://marc.info/?l=3Dgit&m=3D137364524514927&w=3D2
http://www.mail-archive.com/git@vger.kernel.org/msg31964.html
("Bug in .mailmap handling?", for example look for Knut Franke)

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 1179767..1d6ba17 100644
--- a/.mailmap
+++ b/.mailmap
@@ -7,6 +7,7 @@
=20
 Alejandro R. Sede=C3=B1o <asedeno@MIT.EDU> <asedeno@mit.edu>
 Alexander Gavrilov <angavrilov@gmail.com>
+Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.ru>
 Alex Benn=C3=A9e <kernel-hacker@bennee.com>
 Alex Riesen <raa.lkml@gmail.com> <fork0@t-online.de>
 Alex Riesen <raa.lkml@gmail.com> <raa@limbo.localdomain>
@@ -18,12 +19,15 @@ anonymous <linux@horizon.com>
 anonymous <linux@horizon.net>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
 Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
+Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
+Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
 Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
 Dana L. How <danahow@gmail.com>
 Dana L. How <how@deathvalley.cswitch.com>
 Daniel Barkalow <barkalow@iabervon.org>
 Dan Johnson <computerdruid@gmail.com>
+David Brown <git@davidb.org> <davidb@quicinc.com>
 David D. Kilzer <ddkilzer@kilzer.net>
 David K=C3=A5gedal <davidk@lysator.liu.se>
 David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
@@ -31,7 +35,10 @@ David S. Miller <davem@davemloft.net>
 Deskin Miller <deskinm@umich.edu>
 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
 Eric S. Raymond <esr@thyrsus.com>
+Eric Blake <eblake@redhat.com> <ebb9@byu.net>
+Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
+Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel.n=
tnu.no>
 Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.achl=
eitner2.6.31@gmail.com>
 Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
 Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
@@ -47,19 +54,25 @@ H. Peter Anvin <hpa@zytor.com> <hpa@tazenda.sc.orio=
nmulti.com>
 H. Peter Anvin <hpa@zytor.com> <hpa@trantor.hos.anvin.org>
 =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
 Jakub Nar=C4=99bski <jnareb@gmail.com>
+Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
+Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
 J. Bruce Fields <bfields@citi.umich.edu> <bfields@fieldses.org>
 J. Bruce Fields <bfields@citi.umich.edu> <bfields@pig.linuxdev.us.dell=
=2Ecom>
 J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>
 Jeff King <peff@peff.net> <peff@github.com>
+Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@=
gmx.de>
 Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
 Johannes Sixt <j6t@kdbg.org> <J.Sixt@eudaptics.com>
 Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
+Jonathan del Strother <jon.delStrother@bestbefore.tv> <maillist@steels=
kies.com>
 Jonathan Nieder <jrnieder@gmail.com> <jrnieder@uchicago.edu>
 Jon Loeliger <jdl@freescale.com>
-Jon Seymour <jon@blackcubes.dyndns.org>
+Jon Seymour <jon.seymour@gmail.com> <jon@blackcubes.dyndns.org>
+Josh Triplett <josh@joshtriplett.org> <josh@freedesktop.org>
+Josh Triplett <josh@joshtriplett.org> <josht@us.ibm.com>
 Junio C Hamano <gitster@pobox.com> <gitster@pobox.com>
 Junio C Hamano <gitster@pobox.com> <junio@hera.kernel.org>
 Junio C Hamano <gitster@pobox.com> <junio@kernel.org>
@@ -71,11 +84,14 @@ Karl Wiberg <kha@treskal.com> Karl Hasselstr=C3=B6m=
 <kha@treskal.com>
 Karl Wiberg <kha@treskal.com> Karl Hasselstr=C3=B6m <kha@yoghurt.hemma=
=2Etreskal.com>
 Kay Sievers <kay.sievers@vrfy.org> <kay@mam.(none)>
 Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
+Karsten Blees <blees@dcon.de> <karsten.blees@dcon.de>
+Karsten Blees <blees@dcon.de> <karsten.blees@gmail.com>
 Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
 Kent Engstrom <kent@lysator.liu.se>
 Kevin Leung <kevinlsk@gmail.com>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
+Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
 Lars Doelle <lars.doelle@on-line ! de>
 Lars Doelle <lars.doelle@on-line.de>
 Li Hong <leehong@pku.edu.cn>
@@ -85,11 +101,14 @@ Linus Torvalds <torvalds@linux-foundation.org> <to=
rvalds@osdl.org>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.o=
rg>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.o=
rg.(none)>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@woody.linux-f=
oundation.org>
-Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
+Lukas Sandstr=C3=B6m <luksan@gmail.com> <lukass@etek.chalmers.se>
+Matt Kraai <kraai@ftbfs.org> <matt.kraai@amo.abbott.com>
 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
+Mark Levedahl <mdl123@verizon.net> <mlevedahl@gmail.com>
 Mark Rada <marada@uwaterloo.ca>
 Martin Langhoff <martin@laptop.org> <martin@catalyst.net.nz>
 Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gm=
ail.com>
+Matt Draisey <matt@draisey.ca> <mattdraisey@sympatico.ca>
 Matthias Kestenholz <matthias@spinlock.ch> <mk@spinlock.ch>
 Matthias Urlichs <matthias@urlichs.de> <smurf@kiste.(none)>
 Matthias Urlichs <matthias@urlichs.de> <smurf@smurf.noris.de>
@@ -104,8 +123,11 @@ Namhyung Kim <namhyung@gmail.com> <namhyung@kernel=
=2Eorg>
 Namhyung Kim <namhyung@gmail.com> <namhyung.kim@lge.com>
 Nanako Shiraishi <nanako3@bluebottle.com>
 Nanako Shiraishi <nanako3@lavabit.com>
+Nelson Elhage <nelhage@mit.edu> <nelhage@ksplice.com>
+Nelson Elhage <nelhage@mit.edu> <nelhage@MIT.EDU>
 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
 <nico@fluxnic.net> <nico@cam.org>
+Paolo Bonzini <bonzini@gnu.org> <paolo.bonzini@lu.unisi.ch>
 Pascal Obry <pascal@obry.net> <pascal.obry@gmail.com>
 Pascal Obry <pascal@obry.net> <pascal.obry@wanadoo.fr>
 Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(none)>
@@ -114,6 +136,7 @@ Peter Krefting <peter@softwolves.pp.se> <peter@soft=
wolves.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolv=
es.pp.se>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
 Petr Baudis <pasky@ucw.cz> <xpasky@machine>
+Phil Hord <hordp@cisco.com> <phil.hord@gmail.com>
 Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
@@ -145,6 +168,7 @@ Uwe Kleine-K=C3=B6nig <uzeisberger@io.fsforth.de>
 Uwe Kleine-K=C3=B6nig <zeisberg@informatik.uni-freiburg.de>
 Ville Skytt=C3=A4 <scop@xemacs.org>
 Vitaly "_Vi" Shukela <public_vi@tut.by>
+W. Trevor King <wking@tremily.us> <wking@drexel.edu>
 William Pursell <bill.pursell@gmail.com>
 YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
=20
--=20
1.8.3.2.790.g9192b0b
