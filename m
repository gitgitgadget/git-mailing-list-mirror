From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-am.sh: Remove option -n from tail
Date: Tue, 16 Oct 2007 19:57:15 +0300
Message-ID: <1192553837-18302-2-git-send-email-jari.aalto@cante.net>
References: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihptv-0000vb-Fm
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760286AbXJPRIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760225AbXJPRIE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:08:04 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:52567 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724AbXJPRID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:08:03 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 4341961A19
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 19:57:20 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A018EF409AF; Tue, 16 Oct 2007 19:57:20 +0300
Received: from cante.cante.net (a81-197-175-198.elisa-laajakaista.fi [81.197.175.198])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 354D31C6550
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 19:57:19 +0300 (EEST)
Received: from jaalto by cante.cante.net with local (Exim 4.68)
	(envelope-from <jaalto@cante.cante.net>)
	id 1IhpjJ-0004li-CT; Tue, 16 Oct 2007 16:57:17 +0000
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jaalto@cante.cante.net
X-SA-Exim-Scanned: No (on cante.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61220>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-am.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b02ae6a..09a991c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -2,6 +2,8 @@
 #
 # Copyright (c) 2005, 2006 Junio C Hamano
 
+TAIL="tail"
+
 USAGE='[--signoff] [--dotest=<dir>] [--keep] [--utf8 | --no-utf8]
   [--3way] [--interactive] [--binary]
   [--whitespace=<option>] [-C<n>] [-p<n>]
@@ -321,7 +323,7 @@ do
 		LAST_SIGNED_OFF_BY=`
 		    sed -ne '/^Signed-off-by: /p' \
 		    "$dotest/msg-clean" |
-		    tail -n 1
+		    $TAIL 1
 		`
 		ADD_SIGNOFF=`
 		    test "$LAST_SIGNED_OFF_BY" = "$SIGNOFF" || {
-- 
1.5.3.2.81.g17ed
