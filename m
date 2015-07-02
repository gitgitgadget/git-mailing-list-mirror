From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] Documentation/branch: document -M and -D in terms of --force
Date: Thu,  2 Jul 2015 16:07:21 +0200
Message-ID: <1435846041-19488-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1435846041-19488-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 02 16:09:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAfB3-0004n6-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 16:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbbGBOI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 10:08:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46323 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbbGBOHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 10:07:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t62E7WPh004200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2015 16:07:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t62E7Yee009964;
	Thu, 2 Jul 2015 16:07:34 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZAf9K-0005ym-8l; Thu, 02 Jul 2015 16:07:34 +0200
X-Mailer: git-send-email 2.5.0.rc0.7.ge1edd74.dirty
In-Reply-To: <1435846041-19488-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 Jul 2015 16:07:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t62E7WPh004200
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436450857.24608@Kp8xsx2Nnbas9RyCWOoK6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273231>

Now that we have proper documentation for --force's interaction with -d
and -m, we can avoid duplication and consider -M and -D as convenience
aliases for -m --force and -d --force.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I'm not 100% sure it's a good idea (too many levels of indirections in
a documentation can make it painful), so if people don't like this
patch, I won't fight for it. The important is PATCH 1/2.

 Documentation/git-branch.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b2e7963..a67138a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -81,7 +81,7 @@ OPTIONS
 	`--track` or `--set-upstream`.
 
 -D::
-	Delete a branch irrespective of its merged status.
+	Shortcut for `--delete --force`.
 
 -l::
 --create-reflog::
@@ -105,7 +105,7 @@ OPTIONS
 	Move/rename a branch and the corresponding reflog.
 
 -M::
-	Move/rename a branch even if the new branch name already exists.
+	Shortcut for `--move --force`.
 
 --color[=<when>]::
 	Color branches to highlight current, local, and
-- 
2.5.0.rc0.7.ge1edd74.dirty
