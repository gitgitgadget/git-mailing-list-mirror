From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.
Date: Fri, 16 Apr 2010 15:53:59 +0200
Message-ID: <87vdbi37yp.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 10:10:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5DyF-0006Ce-4E
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 10:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478Ab0DWIKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 04:10:34 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:42559 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756291Ab0DWIK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 04:10:29 -0400
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id D639319F33A4;
	Fri, 23 Apr 2010 10:10:27 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id 5HT3WYN4xrZO; Fri, 23 Apr 2010 10:10:26 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 474CF19F337E;
	Fri, 23 Apr 2010 10:10:26 +0200 (CEST)
Received: from steelpick.2x.cz (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id A0305FA003;
	Fri, 23 Apr 2010 10:10:22 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.71)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1O5Dxu-0007W5-6O; Fri, 23 Apr 2010 10:10:22 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145593>

Dear Junio,

this is a resend of relicensing patch for test suite library, which
was initially sent by Carl Worth. Since the time you sent me acks for
this patch collected by you, I collected 8 additional acks as is
documented at
https://git.wiki.kernel.org/index.php/Test-lib_reclicensing. There are
still three contributors missing: Bert Wesarg, Stephan Beyer and Bryan
Donlan. The contributions of first two are clearly not copyrightable.
I'm not sure about the copyrightability of Bryan Donlan's
contributions (git log -p --author='Bryan Donlan' t/test-lib.sh).

Carl told me that in your ack collection process you missed only three
acks. So I wonder whether you already did some analysis of which
contributions are copyrightable. If so, are the missing acks in the
list bellow?

Thanks
Michal

8<--------8<--------8<--------
This file has had no explicit license information noted in it, but
has clearly been created and modified according to the terms of GPLv2
as with the rest of the git code base.

The purpose of relicensing is to allow other GPLv3+ projects (in
particular, the notmuch project: http://notmuchmail.org) to use this
same test-suite structure and to contribute changes back as well.

Signed-off-by: Carl Worth <cworth@cworth.org>
Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
Acked-by: Alex Riesen <raa.lkml@gmail.com>
Acked-by: Brandon Casey <drafnel@gmail.com>
Acked-by: Clemens Buchacher <drizzd@aon.at>
Acked-by: David Reiss <dreiss@facebook.com>
Acked-by: Emil Sit <sit@emilsit.net>
Acked-by: Eric Wong <normalperson@yhbt.net>
Acked-by: Fredrik Kuivinen <frekui@gmail.com>
Acked-by: Gerrit Pape <pape@smarden.org>
Acked-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jakub Narebski <jnareb@gmail.com>
Acked-by: Jeff King <peff@peff.net>
Acked-by: Johan Herland <johan@herland.net>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Acked-by: Johannes Sixt <j6t@kdbg.org>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Josh Triplett <josh@joshtriplett.org>
Acked-by: Junio C Hamano <gitster@pobox.com>
Acked-by: Lea Wiemann <lewiemann@gmail.com>
Acked-by: Markus Heidelberg <markus.heidelberg@web.de>
Acked-by: Martin Waitz <tali@admingilde.org>
Acked-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Acked-by: Matthias Lederhofer <matled@gmx.net>
Acked-by: Michael J Gruber <git@drmicha.warpmail.net>
Acked-by: Michele Ballabio <barra_cuda@katamail.com>
Acked-by: Miklos Vajna <vmiklos@frugalware.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Acked-by: Pavel Roskin <proski@gnu.org>
Acked-by: Petr Baudis <pasky@ucw.cz>
Acked-by: Pierre Habouzit <madcoder@debian.org>
Acked-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
Acked-by: Stephen Boyd <bebarino@gmail.com>
Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
Acked-by: Thomas Rast <trast@student.ethz.ch>
---
 t/test-lib.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c582964..9234eb7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -2,6 +2,18 @@
 #
 # Copyright (c) 2005 Junio C Hamano
 #
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see http://www.gnu.org/licenses/ .
 
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
-- 
1.7.0.4
