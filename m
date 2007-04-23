From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Documentation/git-reset.txt: suggest git commit --amend in example.
Date: Mon, 23 Apr 2007 12:17:25 +0000
Message-ID: <20070423121725.24485.qmail@3bf9b110a1d717.315fe32.mid.smarden.org>
References: <20070423120629.23521.qmail@b1f8866d714ca2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfxTh-0001AE-HN
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 14:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbXDWMRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 08:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbXDWMRF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 08:17:05 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:50235 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754107AbXDWMRE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 08:17:04 -0400
Received: (qmail 24486 invoked by uid 1000); 23 Apr 2007 12:17:25 -0000
Mail-Followup-To: git@vger.kernel.org, 420112@bugs.debian.org
Content-Disposition: inline
In-Reply-To: <20070423120629.23521.qmail@b1f8866d714ca2.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45319>

Please see http://bugs.debian.org/420112

In example 'Undo a commit and redo', refer to 'git commit --amend', as
this is the easier alternative.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-reset.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 5b55cda..19c5b9b 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -67,6 +67,8 @@ message, or both.  Leaves working tree as it was before "reset".
 <3> "reset" copies the old head to .git/ORIG_HEAD; redo the
 commit by starting with its log message.  If you do not need to
 edit the message further, you can give -C option instead.
++
+See also the --amend option to gitlink:git-commit[1].
 
 Undo commits permanently::
 +
-- 
1.5.1.2
