From: Kevin Geiss <kevin@desertsol.com>
Subject: [PATCH 1/1] git-cvsexportcommit.perl: Fix usage() output.
Date: Mon, 14 Nov 2005 09:45:05 -0700
Message-ID: <20051114164505.GF9131@raven.localdomain>
References: <20051114164047.GB9131@raven.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin.langhoff@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 17:47:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhSB-0008Fp-TL
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVKNQpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVKNQpH
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:45:07 -0500
Received: from 12-219-167-192.client.mchsi.com ([12.219.167.192]:57729 "EHLO
	desertsol.com") by vger.kernel.org with ESMTP id S1751186AbVKNQpG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:45:06 -0500
Received: from kevin by desertsol.com with local (Exim 4.50)
	id 1EbhS5-00088I-Kq; Mon, 14 Nov 2005 09:45:05 -0700
To: Kevin Geiss <kevin@desertsol.com>
Content-Disposition: inline
In-Reply-To: <20051114164047.GB9131@raven.localdomain>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11818>

---

 git-cvsexportcommit.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: e604d20cd75e71750e8316348c988ef0296b3ec5
224d4f4897ea47425aafc6d491f2a0762e683a4c
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 50b041c..5bce39c 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -4,6 +4,7 @@ use strict;
 use Getopt::Std;
 use File::Temp qw(tempdir);
 use Data::Dumper;
+use File::Basename qw(basename);
 
 unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
     die "GIT_DIR is not defined or is unreadable";
@@ -206,8 +207,7 @@ if ($opt_c) {
 }
 sub usage {
 	print STDERR <<END;
-Usage: GIT_DIR=/path/to/.gi ${\basename $0}      # fetch/update GIT from CVS
-       [-h] [-p] [ parent ] commit
+Usage: GIT_DIR=/path/to/.git ${\basename $0} [-h] [-p] [-v] [-c] [ parent ] commit
 END
 	exit(1);
 }
---
0.99.9.GIT
