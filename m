From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] .mailmap: Combine more (email, name) to individual persons
Date: Wed, 17 Jul 2013 22:16:31 +0200
Message-ID: <1374092191-29851-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 17 22:16:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzY9P-0004Fg-R6
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 22:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306Ab3GQUQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 16:16:36 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:43115 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab3GQUQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 16:16:34 -0400
Received: by mail-wi0-f175.google.com with SMTP id m6so5893125wiv.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 13:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2KMsSxCyDlMOH0970jxbRVpAoQn4rhywF5U/fQkHbgo=;
        b=E9oYnoXjsCisorkmh25OFt8Fr3yxlQc/3AS3oSujQQMBJU4Yc1NfpEY2MP51rxALa3
         nlQcl63WNAhz04wj2/VBgMPVKy1PPC+HeqvQnbTtvVLBh+4mw9grtxnu8I3nvTFWmdbK
         BcjBae3MfeDtoi+2t4K7aKetCRbvHjwjrU6vOr7Ew7VnXOnSrcy3bpMtG5PfKMHaxnI4
         0rIrc5dnBmj8xEV8CUrkJVKfYN2I7JfvLTgNLj1xoFIq3SBJn4cTB6u/SFyz+SlMjWI5
         Zwb3TCSWOWU7CQc3I1gr24w7Z9yEe2eDjhmApeQZE/zGAZp1S30tJCjF5cvnxxVGHR/3
         JbNQ==
X-Received: by 10.180.160.144 with SMTP id xk16mr16995095wib.62.1374092193696;
        Wed, 17 Jul 2013 13:16:33 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z6sm12050414wiv.11.2013.07.17.13.16.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 13:16:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.754.g9c3c367.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230647>

I got more responses from people regarding the .mailmap file.
All added persons gave permission to add them to the .mailmap file.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 9430d14..df8898f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -28,8 +28,7 @@ Chris Shoemaker <c.shoemaker@cox.net>
 Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
 Dan Johnson <computerdruid@gmail.com>
-Dana L. How <danahow@gmail.com>
-Dana L. How <how@deathvalley.cswitch.com>
+Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Daniel Barkalow <barkalow@iabervon.org>
 David Brown <git@davidb.org> <davidb@quicinc.com>
 David D. Kilzer <ddkilzer@kilzer.net>
@@ -52,6 +51,7 @@ Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmai=
l.com>
 Garry Dolley <gdolley@ucla.edu> <gdolley@arpnetworks.com>
 Greg Price <price@mit.edu> <price@MIT.EDU>
 Greg Price <price@mit.edu> <price@ksplice.com>
+Heiko Voigt <hvoigt@hvoigt.net> <git-list@hvoigt.net>
 H. Merijn Brand <h.m.brand@xs4all.nl> H.Merijn Brand <h.m.brand@xs4all=
=2Enl>
 H. Peter Anvin <hpa@zytor.com> <hpa@bonde.sc.orionmulti.com>
 H. Peter Anvin <hpa@zytor.com> <hpa@smyrno.hos.anvin.org>
@@ -74,7 +74,8 @@ Johannes Schindelin <Johannes.Schindelin@gmx.de> <joh=
annes.schindelin@gmx.de>
 Johannes Sixt <j6t@kdbg.org> <J.Sixt@eudaptics.com>
 Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
 Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
-Jon Loeliger <jdl@freescale.com>
+Jon Loeliger <jdl@jdl.com> <jdl@freescale.com>
+Jon Loeliger <jdl@jdl.com> <jdl@freescale.org>
 Jon Seymour <jon.seymour@gmail.com> <jon@blackcubes.dyndns.org>
 Jonathan Nieder <jrnieder@gmail.com> <jrnieder@uchicago.edu>
 Jonathan del Strother <jon.delStrother@bestbefore.tv> <maillist@steels=
kies.com>
@@ -175,10 +176,13 @@ Sean Estabrooks <seanlkml@sympatico.ca>
 Sebastian Schuberth <sschuberth@gmail.com> <sschuberth@visageimaging.c=
om>
 Seth Falcon <seth@userprimary.net> <sfalcon@fhcrc.org>
 Shawn O. Pearce <spearce@spearce.org>
+Simon Hausmann <hausmann@kde.org> <simon@lst.de>
+Simon Hausmann <hausmann@kde.org> <shausman@trolltech.com>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@atlas-elektronik.c=
om>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@googlemail.com>
 Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
 Stephen Boyd <bebarino@gmail.com> <sboyd@codeaurora.org>
+Steven Drake <sdrake@xnet.co.nz> <sdrake@ihug.co.nz>
 Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
 Steven Walter <stevenrwalter@gmail.com> <swalter@lexmark.com>
 Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.=
com>
--=20
1.8.3.3.754.g9c3c367.dirty
