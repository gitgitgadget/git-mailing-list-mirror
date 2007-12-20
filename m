From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Mention git-shell's "cvs" substitution in the RelNotes
Date: Thu, 20 Dec 2007 12:50:34 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712201248030.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <7vhciers0o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 12:51:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5JvY-0002c3-Br
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 12:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbXLTLuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 06:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbXLTLuh
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 06:50:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:38423 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752043AbXLTLug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 06:50:36 -0500
Received: (qmail invoked by alias); 20 Dec 2007 11:50:34 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp056) with SMTP; 20 Dec 2007 12:50:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BpYwo8QkBvdifkgK/aHeSUjkuRBdGtjGYnCPeXt
	iexUEJX2CrGYSQ
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vhciers0o.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68993>


git shell became much more powerful for existing CVS setups.  Tis is a 
benefit that we should not hide from those people who only read release 
notes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes-1.5.4.txt
index cd79124..fb521c3 100644
--- a/Documentation/RelNotes-1.5.4.txt
+++ b/Documentation/RelNotes-1.5.4.txt
@@ -175,7 +175,9 @@ Updates since v1.5.3
 
  * "git remote" learned "rm" subcommand.
 
- * "git cvsserver" can be run via "git shell".
+ * "git cvsserver" can be run via "git shell".  Also, "cvs" is
+   recognized as a synonym for "git cvsserver", so that CVS users
+   can be switched to git just by changing their login shell.
 
  * "git cvsserver" acts more like receive-pack by running post-receive
    and post-update hooks.
