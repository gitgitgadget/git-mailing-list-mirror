From: bfields@fieldses.org
Subject: [PATCH] Documentation: remove master:origin example from pull-fetch-param.txt
Date: Sun, 31 Dec 2006 18:47:37 -0500
Message-ID: <1167608858532-git-send-email-bfields@fieldses.org>
References: <11676088584199-git-send-email-bfields@fieldses.org> <1167608858759-git-send-email-bfields@fieldses.org> <11676088582634-git-send-email-bfields@fieldses.org> <11676088581948-git-send-email-bfields@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 00:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1APA-0007zX-Ft
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 00:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbWLaXrn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 18:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbWLaXrm
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 18:47:42 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38256 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbWLaXrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 18:47:39 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1AOw-0002F2-JU; Sun, 31 Dec 2006 18:47:38 -0500
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.gac28
In-Reply-To: <11676088581948-git-send-email-bfields@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35711>

From: J. Bruce Fields <bfields@citi.umich.edu>

This is no longer a useful example.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/pull-fetch-param.txt |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index e852f41..8d4e950 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -39,10 +39,6 @@ checkout -b my-B remote-B`).  Run `git fetch` to keep track of
 the progress of the remote side, and when you see something new
 on the remote branch, merge it into your development branch with
 `git pull . remote-B`, while you are on `my-B` branch.
-The common `Pull: master:origin` mapping of a remote `master`
-branch to a local `origin` branch, which is then merged to a
-local development branch, again typically named `master`, is made
-when you run `git clone` for you to follow this pattern.
 +
 [NOTE]
 There is a difference between listing multiple <refspec>
-- 
1.5.0.rc0.gac28
