From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 13/16] contrib/examples: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:51 -0800
Message-ID: <1361665254-42866-14-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
 <1361665254-42866-7-git-send-email-davvid@gmail.com>
 <1361665254-42866-8-git-send-email-davvid@gmail.com>
 <1361665254-42866-9-git-send-email-davvid@gmail.com>
 <1361665254-42866-10-git-send-email-davvid@gmail.com>
 <1361665254-42866-11-git-send-email-davvid@gmail.com>
 <1361665254-42866-12-git-send-email-davvid@gmail.com>
 <1361665254-42866-13-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLp-000269-Mx
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759377Ab3BXAVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:34 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:35392 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758190Ab3BXAV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:27 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so1056965pbb.13
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4DTMdilluy9dDG0BaBbTphiG+bH2pLuIUfqhMGhts6k=;
        b=on+wBci5QgTmTSND1rMATlzqeVeCPiv0F0o24nBb0wdWZdaCUlCvl165ceJAnK6D5i
         8WkG/+/a78pkUbJ6VMz5Zvx/TbufDYA8WdVe5AkRF+AmIB+MxZwLygDHGOXk9dG8GIN8
         zN3+9FBiwSih8AaGq+rjG7tpinWAlzdzd4BR+2Zj38dQduVEvJaIzm/IoiHLbdrgEcra
         d4BfpC9iKWregdwZ4D8I022NH6DEgiGHNzGypGG9dr5hOjILbry6AVQEwSP/JlwXEY9T
         GVJC3INKE1ciEy4neAYGajQBNjYgVbAOIM/7RN918Pi3BBMVNXjWLEN2z+U3Ezw9Zbrj
         SvNg==
X-Received: by 10.66.81.199 with SMTP id c7mr11588109pay.39.1361665286886;
        Sat, 23 Feb 2013 16:21:26 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:26 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-13-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216945>

Use a lowercase "usage:" string for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/examples/git-remote.perl    | 2 +-
 contrib/examples/git-svnimport.perl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-remote.perl b/contrib/examples/git-remote.perl
index b17952a..b549a3c 100755
--- a/contrib/examples/git-remote.perl
+++ b/contrib/examples/git-remote.perl
@@ -347,7 +347,7 @@ sub rm_remote {
 }
 
 sub add_usage {
-	print STDERR "Usage: git remote add [-f] [-t track]* [-m master] <name> <url>\n";
+	print STDERR "usage: git remote add [-f] [-t track]* [-m master] <name> <url>\n";
 	exit(1);
 }
 
diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git-svnimport.perl
index b09ff8f..c414f0d 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -36,7 +36,7 @@ our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
 
 sub usage() {
 	print STDERR <<END;
-Usage: ${\basename $0}     # fetch/update GIT from SVN
+usage: ${\basename $0}     # fetch/update GIT from SVN
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev] [-R repack_each_revs]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-- 
1.8.2.rc0.247.g811e0c0
