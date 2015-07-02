From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] Documentation/branch: document -d --force and -m --force
Date: Thu,  2 Jul 2015 16:07:20 +0200
Message-ID: <1435846041-19488-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 02 16:09:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAfBA-0004qL-VI
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 16:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbbGBOIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 10:08:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46324 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735AbbGBOHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 10:07:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t62E7Tud004182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2015 16:07:29 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t62E7UdF009961;
	Thu, 2 Jul 2015 16:07:30 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZAf9G-0005wB-Ea; Thu, 02 Jul 2015 16:07:30 +0200
X-Mailer: git-send-email 2.5.0.rc0.7.ge1edd74.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 Jul 2015 16:07:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t62E7Tud004182
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436450852.22982@RAIu6Ij9XSrgH1+h+l2Ysg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273232>

The --force option was modified in 356e91f (branch: allow -f with -m and
-d, 2014-12-08), but the documentation was not updated.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-branch.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 359619b..b2e7963 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -95,6 +95,10 @@ OPTIONS
 --force::
 	Reset <branchname> to <startpoint> if <branchname> exists
 	already. Without `-f` 'git branch' refuses to change an existing branch.
+	In combination with `-d` (or `--delete`), allow deleting the
+	branch irrespective of its merged status. In combination with
+	`-m` (or `--move`), allow renaming the branch even if the new
+	branch name already exists.
 
 -m::
 --move::
-- 
2.5.0.rc0.7.ge1edd74.dirty
