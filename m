From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH] Same default as cvsimport when using --use-log-author
Date: Tue, 25 Mar 2008 19:20:15 +0100
Message-ID: <20080425234556.BB4BC545E@aristoteles.cuci.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:46:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpXcu-0004gI-C3
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 01:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762052AbYDYXp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 19:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761647AbYDYXp6
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 19:45:58 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:56101 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758435AbYDYXp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 19:45:57 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id BB4BC545E; Sat, 26 Apr 2008 01:45:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80355>

---
 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b151049..846e739 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2434,6 +2434,9 @@ sub make_log_entry {
 		} else {
 			($name, $email) = ($name_field, 'unknown');
 		}
+	        if (!defined $email) {
+		    $email = $name;
+	        }
 	}
 	if (defined $headrev && $self->use_svm_props) {
 		if ($self->rewrite_root) {
-- 
1.5.5.1.83.ge77a4.dirty
