From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] docs: minor grammar fixes to git-status
Date: Thu, 26 May 2011 22:31:11 -0400
Message-ID: <20110527023111.GA25362@sigill.intra.peff.net>
References: <30543.1305828072@plover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 04:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPmqS-0002u7-Lz
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 04:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab1E0CbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 22:31:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59473
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab1E0CbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 22:31:14 -0400
Received: (qmail 20662 invoked by uid 107); 27 May 2011 02:31:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 22:31:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 22:31:11 -0400
Content-Disposition: inline
In-Reply-To: <30543.1305828072@plover.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174595>


Signed-off-by: Jeff King <peff@peff.net>
---
Noticed these while working on 2/4.

 Documentation/git-status.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 00b699f..7702727 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -78,18 +78,19 @@ OUTPUT
 The output from this command is designed to be used as a commit
 template comment, and all the output lines are prefixed with '#'.
 The default, long format, is designed to be human readable,
-verbose and descriptive.  They are subject to change in any time.
+verbose and descriptive.  Its contents and format are subject to change
+at any time.
 
 The paths mentioned in the output, unlike many other git commands, are
 made relative to the current directory if you are working in a
 subdirectory (this is on purpose, to help cutting and pasting). See
 the status.relativePaths config option below.
 
-In short-format, the status of each path is shown as
+In the short-format, the status of each path is shown as
 
 	XY PATH1 -> PATH2
 
-where `PATH1` is the path in the `HEAD`, and ` -> PATH2` part is
+where `PATH1` is the path in the `HEAD`, and the ` -> PATH2` part is
 shown only when `PATH1` corresponds to a different path in the
 index/worktree (i.e. the file is renamed). The 'XY' is a two-letter
 status code.
-- 
1.7.4.5.26.g0c6a2
