From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] command-list: mention git-credential-* helpers
Date: Wed, 8 Aug 2012 14:34:49 -0400
Message-ID: <20120808183449.GD24574@sigill.intra.peff.net>
References: <20120808183132.GA24550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 20:35:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzB5x-0001ko-BD
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 20:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843Ab2HHSe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 14:34:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57548 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab2HHSez (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 14:34:55 -0400
Received: (qmail 9628 invoked by uid 107); 8 Aug 2012 18:35:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 14:35:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 14:34:49 -0400
Content-Disposition: inline
In-Reply-To: <20120808183132.GA24550@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203113>

These commands were never added to the command-list. Adding
them makes "make check-docs" run without complaint.
While we're at it, let's capitalize the first letter of
their one-line summaries to match the rest of the git
manpages.

The credential-cache--daemon command is somewhat special. It
is already ignored by check-docs because it contains a "--",
marking it as a non-interesting implementation detail. It
is, in fact, documented, but since the documentation
basically just redirects you to a more appropriate command
anyway, let's explicitly omit it so it is not mentioned in
git(1).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-credential-cache--daemon.txt | 2 +-
 Documentation/git-credential-cache.txt         | 2 +-
 Documentation/git-credential-store.txt         | 2 +-
 command-list.txt                               | 2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-credential-cache--daemon.txt b/Documentation/git-credential-cache--daemon.txt
index 11edc5a..d15db42 100644
--- a/Documentation/git-credential-cache--daemon.txt
+++ b/Documentation/git-credential-cache--daemon.txt
@@ -3,7 +3,7 @@ git-credential-cache--daemon(1)
 
 NAME
 ----
-git-credential-cache--daemon - temporarily store user credentials in memory
+git-credential-cache--daemon - Temporarily store user credentials in memory
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index f3d09c5..eeff5fa 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -3,7 +3,7 @@ git-credential-cache(1)
 
 NAME
 ----
-git-credential-cache - helper to temporarily store passwords in memory
+git-credential-cache - Helper to temporarily store passwords in memory
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 3109346..b27c03c 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -3,7 +3,7 @@ git-credential-store(1)
 
 NAME
 ----
-git-credential-store - helper to store credentials on disk
+git-credential-store - Helper to store credentials on disk
 
 SYNOPSIS
 --------
diff --git a/command-list.txt b/command-list.txt
index 1da8f0d..7e8cfec 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -26,6 +26,8 @@ git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
 git-credential                          purehelpers
+git-credential-cache                    purehelpers
+git-credential-store                    purehelpers
 git-cvsexportcommit                     foreignscminterface
 git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
-- 
1.7.12.rc2.2.g584e0d9
