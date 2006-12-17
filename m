X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] Documentation: new option -P for git-svnimport
Date: Mon, 18 Dec 2006 01:50:12 +1100
Message-ID: <45855924.1050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 14:50:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
X-Enigmail-Version: 0.94.1.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34693>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvxLX-00047y-OV for gcvg-git@gmane.org; Sun, 17 Dec
 2006 15:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752744AbWLQOud (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 09:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752745AbWLQOud
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 09:50:33 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:60893 "EHLO
 pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S1752744AbWLQOuc (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 09:50:32 -0500
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95]
 helo=[192.168.64.35]) by pecan.exetel.com.au with esmtp (Exim 4.63)
 (envelope-from <qtonthat@gmail.com>) id 1GvxLR-00027l-SE for
 git@vger.kernel.org; Mon, 18 Dec 2006 01:50:30 +1100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Documentation: new option -P for git-svnimport.

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 Documentation/git-svnimport.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index b1b87c2..df604e1 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
 		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
 		[ -I <ignorefile_name> ] [ -A <author_file> ]
+		[ -P <path_from_trunk> ]
 		<SVN_repository_URL> [ <path> ]
 
 
@@ -107,6 +108,14 @@ repository without -A.
 	Formerly, this option controlled how many revisions to pull,
 	due to SVN memory leaks. (These have been worked around.)
 
+-P <path_from_trunk>::
+	Partial import of the SVN tree.
+
+	By default, the whole tree on the SVN trunk (/trunk) is imported.
+	'-P my/proj' will import starting only from '/trunk/my/proj'.
+	This option is useful when you want to import one project from a
+	svn repo which hosts multiple projects under the same trunk.
+
 -v::
 	Verbosity: let 'svnimport' report what it is doing.
 
-- 
1.4.4.1.GIT
