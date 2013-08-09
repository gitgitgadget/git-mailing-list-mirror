From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 1/2] .mailmap: fixup entries
Date: Fri,  9 Aug 2013 20:18:24 +0200
Message-ID: <1376072305-15255-2-git-send-email-stefanbeller@googlemail.com>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 09 20:18:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7rGm-00071X-DJ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 20:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758625Ab3HISS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 14:18:28 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:49819 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758614Ab3HISS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 14:18:26 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so2299131eek.12
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uWlZUEUyfoUuXcHzhofHcgHKgAC/9leuNGg46MYTUkQ=;
        b=IzHhfNCV5uwRwKWUaW5KsdDysFlJC8ZvGxsXwWudWecFVHHkRCaZIua81bUBnyEjmB
         +dbw1Z7LKq870YayUFmHb52k0AzhYfE2xaZ+bB54HOhZcrPAP5sfDihrAMFV9d6urMZO
         VOzc2x6xGls7rb0DQcTQCwTJt2/yPcYQNgNrKfR1wW3uf54OPAn8WIiCGIN9/cVtVyF4
         B8DEhkVQoY8sZ4SEwPA8gSYP1fG5uu2hjOOjPGuqqeBB36THp8jlm/NYoYCaDIMgKPXt
         DWQke005tR8oXaHBROSDKmHrWMsHVxf14q3P6dGqzj8Wf7gsFusMQubNLpofioIWBzz0
         iq4g==
X-Received: by 10.15.98.3 with SMTP id bi3mr14087622eeb.124.1376072304574;
        Fri, 09 Aug 2013 11:18:24 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id j2sm30826727eep.6.2013.08.09.11.18.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 11:18:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2
In-Reply-To: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232006>

This patch adds no new names, but fixes the mistakes I made in the prev=
ious
commits. (94b410bba8, f4f49e225, c07a6bc57, 2013-07-12, .mailmap: Map
email addresses to names).

These mistakes are double white spaces between name and surname,
different capitalization in email address, or just the email address se=
t
as name.

Also I forgot to include James Knight to the mailmap file.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index dfa2e65..840abf7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -14,6 +14,7 @@ Alex Riesen <raa.lkml@gmail.com> <raa@steel.home>
 Alex Vandiver <alex@chmrr.net> <alexmv@MIT.EDU>
 Alexander Gavrilov <angavrilov@gmail.com>
 Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.ru>
+Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezoff@gmail.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
@@ -31,6 +32,7 @@ Christian Stimming <stimming@tuhh.de> <chs@ckiste.goe=
theallee>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
+Dana L. How <danahow@gmail.com> Dana How
 Daniel Barkalow <barkalow@iabervon.org>
 David Brown <git@davidb.org> <davidb@quicinc.com>
 David D. Kilzer <ddkilzer@kilzer.net>
@@ -65,6 +67,7 @@ J. Bruce Fields <bfields@citi.umich.edu> <bfields@fie=
ldses.org>
 J. Bruce Fields <bfields@citi.umich.edu> <bfields@pig.linuxdev.us.dell=
=2Ecom>
 J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>
 Jakub Nar=C4=99bski <jnareb@gmail.com>
+James Y Knight <jknight@itasoftware.com> <foom@fuhm.net>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
@@ -92,8 +95,8 @@ Junio C Hamano <gitster@pobox.com> <junio@pobox.com>
 Junio C Hamano <gitster@pobox.com> <junio@twinsun.com>
 Junio C Hamano <gitster@pobox.com> <junkio@cox.net>
 Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
-Karl Wiberg <kha@treskal.com> Karl Hasselstr=C3=B6m <kha@treskal.com>
-Karl Wiberg <kha@treskal.com> Karl Hasselstr=C3=B6m <kha@yoghurt.hemma=
=2Etreskal.com>
+Karl Wiberg <kha@treskal.com> Karl  Hasselstr=C3=B6m
+Karl Wiberg <kha@treskal.com> <kha@yoghurt.hemma.treskal.com>
 Karsten Blees <blees@dcon.de> <karsten.blees@dcon.de>
 Karsten Blees <blees@dcon.de> <karsten.blees@gmail.com>
 Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
@@ -177,6 +180,7 @@ Robin Rosenberg <robin.rosenberg@dewire.com> <robin=
=2Erosenberg.lists@dewire.com>
 Ryan Anderson <ryan@michonline.com> <rda@google.com>
 Salikh Zakirov <salikh.zakirov@gmail.com> <Salikh.Zakirov@Intel.com>
 Sam Vilain <sam@vilain.net> <sam.vilain@catalyst.net.nz>
+Sam Vilain <sam@vilain.net> sam@vilain.net
 Santi B=C3=A9jar <santi@agolina.net> <sbejar@gmail.com>
 Sean Estabrooks <seanlkml@sympatico.ca>
 Sebastian Schuberth <sschuberth@gmail.com> <sschuberth@visageimaging.c=
om>
@@ -191,6 +195,7 @@ Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
 Stephen Boyd <bebarino@gmail.com> <sboyd@codeaurora.org>
 Steven Drake <sdrake@xnet.co.nz> <sdrake@ihug.co.nz>
 Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
+Steven Grimm <koreth@midwinter.com> koreth@midwinter.com
 Steven Walter <stevenrwalter@gmail.com> <swalter@lexmark.com>
 Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.=
com>
 Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.b=
e>
--=20
1.8.4.rc2
