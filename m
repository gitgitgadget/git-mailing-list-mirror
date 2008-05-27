From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Documentation/git-bundle.txt: fix synopsis
Date: Tue, 27 May 2008 08:51:22 +0000
Message-ID: <20080527085122.21426.qmail@49caa4ee44f169.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 10:52:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0uul-0006va-5n
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 10:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbYE0IvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 04:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756805AbYE0IvX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 04:51:23 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:43824 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755691AbYE0IvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 04:51:23 -0400
Received: (qmail 21427 invoked by uid 1000); 27 May 2008 08:51:22 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82994>

The <git-rev-list args> are mandatory to git bundle create, not
optional.  The usage output of git bundle is already right on this.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-bundle.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 505ac05..18330cd 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -9,7 +9,7 @@ git-bundle - Move objects and refs by archive
 SYNOPSIS
 --------
 [verse]
-'git-bundle' create <file> [git-rev-list args]
+'git-bundle' create <file> <git-rev-list args>
 'git-bundle' verify <file>
 'git-bundle' list-heads <file> [refname...]
 'git-bundle' unbundle <file> [refname...]
-- 
1.5.5.1
