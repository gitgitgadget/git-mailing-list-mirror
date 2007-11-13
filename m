From: David Reiss <dreiss@facebook.com>
Subject: Trivial patch to git-svn
Date: Tue, 13 Nov 2007 13:56:47 -0800
Message-ID: <473A1D9F.4030103@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 23:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is41Z-0007qq-VC
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 23:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794AbXKMWOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 17:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbXKMWOI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 17:14:08 -0500
Received: from fw-sf2p.facebook.com ([204.15.23.140]:28821 "EHLO
	sf2pmxf02.TheFacebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756606AbXKMWOH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2007 17:14:07 -0500
X-Greylist: delayed 976 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2007 17:14:07 EST
Received: from [192.168.98.131] ([69.63.176.115]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Nov 2007 13:57:57 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20071008)
X-OriginalArrivalTime: 13 Nov 2007 21:57:58.0106 (UTC) FILETIME=[407263A0:01C82640]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64893>

 From d9f93dc1c503c5f42b27485b2c35b38e8c9bca44 Mon Sep 17 00:00:00 2001
From: David Reiss <dreiss@dreiss-vmware.(none)>
Date: Tue, 13 Nov 2007 13:47:26 -0800
Subject: [PATCH] Fix a typo and add a comma in an error message in git-svn

Signed-off-by: David Reiss <dreiss@facebook.com>
---
  git-svn.perl |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e3e00fd..981cdd6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -391,7 +391,7 @@ sub cmd_set_tree {
  sub cmd_dcommit {
  	my $head = shift;
  	git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
-		'Cannot dcommit with a dirty index.  Commit your changes first'
+		'Cannot dcommit with a dirty index.  Commit your changes first, '
  		. "or stash them with `git stash'.\n";
  	$head ||= 'HEAD';
  	my @refs;
-- 
1.5.3.4
