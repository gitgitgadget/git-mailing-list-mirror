From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] git-add --all: documentation
Date: Sat, 19 Jul 2008 23:09:04 -0700
Message-ID: <1216534144-23826-4-git-send-email-gitster@pobox.com>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com>
 <1216534144-23826-2-git-send-email-gitster@pobox.com>
 <1216534144-23826-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 08:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKS7p-0004W9-GR
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 08:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYGTGJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 02:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYGTGJU
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 02:09:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbYGTGJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 02:09:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F6DC33D91
	for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:09:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AC59A33D90 for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:09:15
 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.4.570.g052e6
In-Reply-To: <1216534144-23826-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 62CEF252-5622-11DD-B442-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89162>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 3558905..2b6d6c8 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--update | -u] [--refresh] [--ignore-errors] [--]
+	  [--all | [--update | -u]] [--refresh] [--ignore-errors] [--]
 	  <filepattern>...
 
 DESCRIPTION
@@ -86,6 +86,12 @@ OPTIONS
 	command line. If no paths are specified, all tracked files in the
 	current directory and its subdirectories are updated.
 
+-A::
+--all::
+	Update files that git already knows about (same as '\--update')
+	and add all untracked files that are not ignored by '.gitignore'
+	mechanism.
+
 --refresh::
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
-- 
1.5.6.4.570.g052e6
