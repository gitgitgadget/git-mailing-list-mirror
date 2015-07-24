From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 6/6] Documentation/git-tools: drop references to defunct tools
Date: Fri, 24 Jul 2015 00:00:57 -0400
Message-ID: <1437710457-38592-7-git-send-email-sunshine@sunshineco.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 06:01:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUB8-0004MA-RB
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbbGXEBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:01:43 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33224 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbbGXEBj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:01:39 -0400
Received: by igbpg9 with SMTP id pg9so26573814igb.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BE1PCtUpDV+NPicg3tZaNW6oFR1v8vE8pBRNvQQK1NY=;
        b=llSlFoZ+m8VEsCO9O0BN+gunL7ZSTRwKmwrMuYOPBsZ5xmPkmb/Ei/DQnIMr7ynvd7
         KSRKw5/FC02v/3o7INRUz+Ns6miQIxNW3ZorjuEp/SEjH7OF1ZwhX+InBy8d2WXwfodo
         vxaWFyWjyYYcpin49XV1aKP6WmaaEzFr6IQ5a3IxDbykM3SOUJLcnOOn5V9aEdLKzH9A
         oUxnIrr2QHE5queWk2TzQLAHsHu96EGZiVK5fykI5wAxsTB/pLLZblcWTQq/09nNt1yb
         gFQ9GOvy0D26m8Kkv4mvYKjyDeYyDVyvD17A0YbQNOkSJ6k356Bh+LsH7Fqo3+wOo1xh
         kOXA==
X-Received: by 10.50.79.169 with SMTP id k9mr2726121igx.63.1437710498820;
        Thu, 23 Jul 2015 21:01:38 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j2sm4370288ioo.43.2015.07.23.21.01.37
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:01:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.407.g68aafd0
In-Reply-To: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274540>

Cogito -- unmaintained since late 2006[1]
pg -- URL dead; web searches reveal no information
quilt2git -- URL dead; web searches reveal no information
(h)gct -- URL dead; no repository activity since 2007[2]

[1]: http://git.or.cz/cogito/
[2]: http://repo.or.cz/w/hgct.git

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Perhaps it would be better to drop all items, and retain only the link
to the Git wiki?

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
2.5.0.rc3.407.g68aafd0
