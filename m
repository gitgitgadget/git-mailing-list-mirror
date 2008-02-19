From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Improve "git svn" docs
Date: Tue, 19 Feb 2008 14:59:34 +0100
Message-ID: <873arp6nvg.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 15:08:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRT8b-00028t-Hp
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 15:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYBSOHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2008 09:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbYBSOHZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 09:07:25 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:47514 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbYBSOHY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2008 09:07:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 5C099200A1DE
	for <git@vger.kernel.org>; Tue, 19 Feb 2008 15:07:23 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 11352-01-5; Tue, 19 Feb 2008 15:07:22 +0100 (CET)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E39F1200A1E6;
	Tue, 19 Feb 2008 15:07:22 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id B34457B4078; Tue, 19 Feb 2008 15:07:31 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74409>


---
 Documentation/git-svn.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

I've had this lying around for a long time, but since I think it's an
improvement, although minor, I thought I'd send it in.

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 340f1be..e10f647 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -114,10 +114,12 @@ and have no uncommitted changes.
 	last fetched commit from the upstream SVN.
=20
 'dcommit'::
-	Commit each diff from a specified head directly to the SVN
-	repository, and then rebase or reset (depending on whether or
-	not there is a diff between SVN and head).  This will create
-	a revision in SVN for each commit in git.
+	Commit to the Subversion repository all commits in a branch
+	that are not yet in Subversion.  If no branch name is given,
+	HEAD is used.
+=09
+	After committing, the branch is rebased or reset (depending on
+	whether or not there is a diff between SVN and the branch).
 	It is recommended that you run git-svn fetch and rebase (not
 	pull or merge) your commits against the latest changes in the
 	SVN repository.
--=20
1.5.4.2.148.g410dc


--=20
David K=C3=A5gedal
