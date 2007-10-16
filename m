From: Michael Witten <mfwitten@mit.edu>
Subject: [PATCH 2/3] git-cvsexportcommit.perl tmpdir removed
Date: Tue, 16 Oct 2007 04:08:13 -0400
Message-ID: <1192522094-4988-2-git-send-email-mfwitten@mit.edu>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu>
Cc: Michael Witten <mfwitten@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 11:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhjAW-0002RG-Lx
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337AbXJPJ4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757367AbXJPJ43
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:56:29 -0400
Received: from WITTEN.MIT.EDU ([18.239.2.43]:51356 "EHLO witten.mit.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757001AbXJPJ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:56:28 -0400
Received: by witten.mit.edu (Postfix, from userid 501)
	id 922ED262128; Tue, 16 Oct 2007 04:08:14 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.207.g6d7480-dirty
In-Reply-To: <1192522094-4988-1-git-send-email-mfwitten@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61134>

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
    This is perhaps a duplicate of another patch sent in,
    but it applies to the tabified version.
    
 git-cvsexportcommit.perl |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index b330c3d..869c8b5 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -30,9 +30,6 @@ if ($opt_d) {
 		@cvs = ('cvs');
 }
 
-# setup a tempdir
-our ($tmpdir, $tmpdirname) = tempdir('git-cvsapplycommit-XXXXXX', TMPDIR => 1, CLEANUP => 1);
-
 # resolve target commit
 my $commit;
 $commit = pop @ARGV;
-- 
1.5.3.4.207.g6d7480-dirty
