From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/2] lockfile: mark strings for translation
Date: Tue,  1 Mar 2016 18:04:09 +0100
Message-ID: <1456851850-24759-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1456690276-13914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Gregory.Mounie@grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 18:04:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aanj0-0004JQ-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbcCAREh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:04:37 -0500
Received: from mx2.imag.fr ([129.88.30.17]:33686 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbcCAREg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:04:36 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u21H4Aam015216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 1 Mar 2016 18:04:11 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u21H4C3Q018006;
	Tue, 1 Mar 2016 18:04:13 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456690276-13914-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Mar 2016 18:04:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u21H4Aam015216
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1457456654.63426@bcorO6ZhzL3YR2kR1jC4PA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288039>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 lockfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 80d056d..62583d1 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -149,13 +149,13 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
 	if (err == EEXIST) {
-		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
+		strbuf_addf(buf, _("Unable to create '%s.lock': %s.\n\n"
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
-		    "process is running and remove the file manually to continue.",
+		    "process is running and remove the file manually to continue."),
 			    absolute_path(path), strerror(err));
 	} else
-		strbuf_addf(buf, "Unable to create '%s.lock': %s",
+		strbuf_addf(buf, _("Unable to create '%s.lock': %s"),
 			    absolute_path(path), strerror(err));
 }
 
-- 
2.7.2.334.g35ed2ae.dirty
