From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/6] Documentation/git-tools: retire manually-maintained list
Date: Tue, 28 Jul 2015 16:06:15 -0400
Message-ID: <1438113975-4915-7-git-send-email-sunshine@sunshineco.com>
References: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 22:07:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB9P-0001aN-By
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbbG1UGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:06:55 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33061 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbbG1UGv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:06:51 -0400
Received: by igbpg9 with SMTP id pg9so152724562igb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cWIeL0x/0wf1KdqIofyw7pk8SXnH9yJ+VPFDqGGr2t4=;
        b=vE4K+ihrb3ExrtEIAV7WB43l+6Cgx2qX1h1DkBFq+thYAgjwc73Qh2TawUGPyZPSZQ
         QvGz5uy15hTXStDI+3bf8ftNJVIzt/EP/83T6oAef0DEuR+EHRr32VOjqVhcQ91ePlJN
         rdegOcBfGxGyMEpT5HLgaTTXOj7iN0PhnAl9xZjr1RdX3RhXZj8GvId70We3cqjGnfcG
         jX236Wl3Qejt4wyI11qwJn4MN13x33H1TXrj5xtTPQ0TyT2zR94VG6NfUFW78A7q1WSX
         gEERqZOfax4RqiHT5UG53uoq4GmGtYRlN/Rn/4nDCKL6Q76LYSAsPqVPF7duZT6Etvge
         QTGw==
X-Received: by 10.50.138.232 with SMTP id qt8mr10386685igb.21.1438114010367;
        Tue, 28 Jul 2015 13:06:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id r16sm15195896ioe.19.2015.07.28.13.06.49
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 13:06:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.490.g8c70279
In-Reply-To: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274833>

When Git was young, people looking for third-party Git-related tools
came to the Git project itself to find them, so it made sense to
maintain a list of tools here. These days, however, search engines fill
that role much more efficiently, so retire the manually-maintained
list.

The list of front-ends and tools on the Git wiki rates perhaps a distant
second to search engines, and may still have value, so retain a
reference to it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

New in v2. This is plopped at the end of the series, rather than being
incorporated into it more fully, so that it can be dropped easily in
case it is decided that there is still some merit to having a manually-
maintained list.

 Documentation/git-tools.txt | 88 ++++-----------------------------------------
 1 file changed, 7 insertions(+), 81 deletions(-)

diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 48a3595..2f4ff50 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -1,84 +1,10 @@
-A short Git tools survey
-========================
+Git Tools
+=========
 
+When Git was young, people looking for third-party Git-related tools came
+to the Git project itself to find them, thus a list of such tools was
+maintained here. These days, however, search engines fill that role much
+more efficiently, so this manually-maintained list has been retired.
 
-Introduction
-------------
-
-Apart from Git contrib/ area there are some others third-party tools
-you may want to look at.
-This document presents a brief summary of each tool and the corresponding
-link.
-For a more comprehensive list, see:
+See also the `contrib/` area, and the Git wiki:
 http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
-
-
-Alternative/Augmentative Porcelains
------------------------------------
-
-- *StGit* (http://www.procode.org/stgit/)
-+
-Stacked Git provides a quilt-like patch management functionality in the
-Git environment. You can easily manage your patches in the scope of Git
-until they get merged upstream.
-
-
-History Viewers
----------------
-
-- *gitk* (shipped with git-core)
-+
-gitk is a simple Tk GUI for browsing history of Git repositories easily.
-
-
-- *gitview*  (contrib/)
-+
-gitview is a GTK based repository browser for Git
-
-
-- *gitweb* (shipped with git-core)
-+
-Gitweb provides full-fledged web interface for Git repositories.
-
-
-- *qgit* (http://digilander.libero.it/mcostalba/)
-+
-QGit is a git/StGit GUI viewer built on Qt/C++. QGit could be used
-to browse history and directory tree, view annotated files, commit
-changes cherry picking single files or applying patches.
-Currently it is the fastest and most feature rich among the Git
-viewers and commit tools.
-
-- *tig* (http://jonas.nitro.dk/tig/)
-+
-tig by Jonas Fonseca is a simple Git repository browser
-written using ncurses. Basically, it just acts as a front-end
-for git-log and git-show/git-diff. Additionally, you can also
-use it as a pager for Git commands.
-
-
-Foreign SCM interface
----------------------
-
-- *git-svn* (shipped with git-core)
-+
-git-svn is a simple conduit for changesets between a single Subversion
-branch and Git.
-
-
-- *hg-to-git* (contrib/)
-+
-hg-to-git converts a Mercurial repository into a Git one, and
-preserves the full branch history in the process. hg-to-git can
-also be used in an incremental way to keep the Git repository
-in sync with the master Mercurial repository.
-
-
-Others
-------
-
-- *git.el* (contrib/)
-+
-This is an Emacs interface for Git. The user interface is modelled on
-pcl-cvs. It has been developed on Emacs 21 and will probably need some
-tweaking to work on XEmacs.
-- 
2.5.0.rc3.490.g8c70279
