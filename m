From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Document ls-files -t as obsolete.
Date: Wed, 14 Apr 2010 15:45:04 +0200
Message-ID: <1271252704-21739-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 14 15:55:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O233o-0004Ca-3s
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 15:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab0DNNzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 09:55:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38773 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab0DNNzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 09:55:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o3EDeDOo022216
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Apr 2010 15:40:13 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1O22tv-0003T7-BN; Wed, 14 Apr 2010 15:45:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1O22tv-0005fC-8t; Wed, 14 Apr 2010 15:45:07 +0200
X-Mailer: git-send-email 1.7.0.3.299.gb22d9.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Apr 2010 15:40:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o3EDeDOo022216
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1271857214.423@eWIuOAwSH2MJEt2xwtd96A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144874>

The behavior of "git ls-files -t" is very misleading (see
http://thread.gmane.org/gmane.comp.version-control.git/126516 and
http://thread.gmane.org/gmane.comp.version-control.git/144394/focus=144397
for examples of mislead users) and badly documented, hence we point the
users to superior alternatives.

The feature is marked as "obsolete" but not "scheduled for removal" since
it's a plumbing command, scripts might use it, and Git testsuite already
uses it to test the state of the index.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-ls-files.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3521637..7b86bb5 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -106,6 +106,11 @@ OPTIONS
 	with `-s` or `-u` options does not make any sense.
 
 -t::
+	This feature is deprecated. Authors of scripts should use
+	linkgit:git-status[1] `--porcelain`, and users can look at
+	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
+	`--name-status` for alternatives.
+
 	Identify the file status with the following tags (followed by
 	a space) at the start of each line:
 	H::	cached
-- 
1.7.0.3.299.gb22d9.dirty
