From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 2/2] Restructure documentation for git-merge-base.
Date: Fri, 15 Apr 2011 10:38:55 +0200
Message-ID: <4DA8041F.3090502@lyx.org>
References: <4DA47A4D.80909@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 10:40:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAea0-0000El-Nu
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 10:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab1DOIkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 04:40:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43717 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab1DOIjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 04:39:53 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so684433ewy.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 01:39:53 -0700 (PDT)
Received: by 10.213.25.202 with SMTP id a10mr302115ebc.99.1302856792898;
        Fri, 15 Apr 2011 01:39:52 -0700 (PDT)
Received: from [192.168.1.2] (i229113.upc-i.chello.nl [62.195.229.113])
        by mx.google.com with ESMTPS id x54sm1769522eeh.19.2011.04.15.01.39.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 01:39:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4DA47A4D.80909@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171597>

From: Jonathan Nieder <jrnieder@gmail.com>

Restructure the text of git-merge-base to better explain more clearly
the different modes of operation.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>

---
 Documentation/git-merge-base.txt |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index a9f677b..ca5ed31 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -23,23 +23,21 @@ that does not have any better common ancestor is a 'best common
 ancestor', i.e. a 'merge base'.  Note that there can be more than one
 merge base for a pair of commits.

-Unless `--octopus` is given, among the two commits to compute the merge
-base from, one is specified by the first commit argument on the command
-line; the other commit is a (possibly hypothetical) commit that is a merge
-across all the remaining commits on the command line.  As the most common
-special case, specifying only two commits on the command line means
-computing the merge base between the given two commits.
+OPERATION MODE
+--------------
+
+As the most common special case, specifying only two commits on the
+command line means computing the merge base between the given two commits.
+
+More generally, among the two commits to compute the merge base from,
+one is specified by the first commit argument on the command line;
+the other commit is a (possibly hypothetical) commit that is a merge
+across all the remaining commits on the command line.

 As a consequence, the 'merge base' is not necessarily contained in each of the
 commit arguments if more than two commits are specified. This is different
 from linkgit:git-show-branch[1] when used with the `--merge-base` option.

-OPTIONS
--------
--a::
---all::
-	Output all merge bases for the commits, instead of just one.
-
 --octopus::
 	Compute the best common ancestors of all supplied commits,
 	in preparation for an n-way merge.  This mimics the behavior
@@ -52,6 +50,12 @@ OPTIONS
 	from any other.  This mimics the behavior of 'git show-branch
 	--independent'.

+OPTIONS
+-------
+-a::
+--all::
+	Output all merge bases for the commits, instead of just one.
+
 DISCUSSION
 ----------

-- 
1.7.3.1.msysgit.0
