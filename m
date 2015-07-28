From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/6] Documentation/git-tools: drop references to defunct tools
Date: Tue, 28 Jul 2015 16:06:14 -0400
Message-ID: <1438113975-4915-6-git-send-email-sunshine@sunshineco.com>
References: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 22:06:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB9O-0001aN-76
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbbG1UGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:06:51 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34758 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbG1UGt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:06:49 -0400
Received: by igk11 with SMTP id 11so122596370igk.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zo6CSwTd/t8nsR4B9WpICA2vMAGgHdj70Gv89VZFF1Y=;
        b=tWcdqeKVIZhHLU4gOL4Z9vaDviOYG18xfteR9oELIcijnDau3kdTgtQSvASEoH+cg9
         8ITDvg0U1y3IpzVSwl+0oVXP5+3H6TNC34EFnOWMNrt/n6ZPDZbAy+rytEyLuKnhPtJi
         40O69sA5Ao4c1NOyEEyLdVdOk/RP+WDILP2TAWQ+KXy8PiNLSjrTDINZmy6ziqN3PBza
         nGSNfNoiov8/sJGjKURjdT1+k1y14oQFflwC6tVqQiCpwifkFBzSvN4ckIH/sklYv1rd
         BwteHI59tuzoEO+1CsHjeQG7eLir46iHqrlWMq2CCX4Oqw4FeMttKTrspzweOOHA2VEL
         R2uw==
X-Received: by 10.107.10.161 with SMTP id 33mr57813018iok.155.1438114009290;
        Tue, 28 Jul 2015 13:06:49 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id r16sm15195896ioe.19.2015.07.28.13.06.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 13:06:48 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.490.g8c70279
In-Reply-To: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274831>

Cogito -- unmaintained since late 2006[1]
pg -- URL dead; web searches reveal no information
quilt2git -- URL dead; web searches reveal no information
(h)gct -- URL dead; no repository activity since 2007[2]

[1]: http://git.or.cz/cogito/
[2]: http://repo.or.cz/w/hgct.git

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

 Documentation/git-tools.txt | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index ab4aab9..48a3595 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -16,24 +16,6 @@ http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
 Alternative/Augmentative Porcelains
 -----------------------------------
 
-- *Cogito* (http://www.kernel.org/pub/software/scm/cogito/)
-+
-Cogito is a version control system layered on top of the Git tree history
-storage system. It aims at seamless user interface and ease of use,
-providing generally smoother user experience than the "raw" Core Git
-itself and indeed many other version control systems.
-+
-Cogito is no longer maintained as most of its functionality
-is now in core Git.
-
-
-- *pg* (http://www.spearce.org/category/projects/scm/pg/)
-+
-pg is a shell script wrapper around Git to help the user manage a set of
-patches to files. pg is somewhat like quilt or StGit, but it does have a
-slightly different feature set.
-
-
 - *StGit* (http://www.procode.org/stgit/)
 +
 Stacked Git provides a quilt-like patch management functionality in the
@@ -84,12 +66,6 @@ git-svn is a simple conduit for changesets between a single Subversion
 branch and Git.
 
 
-- *quilt2git / git2quilt* (http://home-tj.org/wiki/index.php/Misc)
-+
-These utilities convert patch series in a quilt repository and commit
-series in Git back and forth.
-
-
 - *hg-to-git* (contrib/)
 +
 hg-to-git converts a Mercurial repository into a Git one, and
@@ -101,13 +77,6 @@ in sync with the master Mercurial repository.
 Others
 ------
 
-- *(h)gct* (http://www.cyd.liu.se/users/~freku045/gct/)
-+
-Commit Tool or (h)gct is a GUI enabled commit tool for Git and
-Mercurial (hg). It allows the user to view diffs, select which files
-to committed (or ignored / reverted) write commit messages and
-perform the commit itself.
-
 - *git.el* (contrib/)
 +
 This is an Emacs interface for Git. The user interface is modelled on
-- 
2.5.0.rc3.490.g8c70279
