From: daly@axiom-developer.org
Subject: builtin-add.c patch
Date: Wed, 10 Dec 2008 06:38:32 -0600
Message-ID: <200812101238.mBACcWQk023480@axiom-developer.org>
Cc: daly@axiom-developer.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 14:41:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAPJC-0002PP-N7
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 14:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbYLJNje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 08:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYLJNje
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 08:39:34 -0500
Received: from vs338.rosehosting.com ([209.135.140.38]:36990 "EHLO
	axiom-developer.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbYLJNjd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 08:39:33 -0500
X-Greylist: delayed 3659 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Dec 2008 08:39:33 EST
Received: from axiom-developer.org (lincoln.rosehosting.com [127.0.0.1])
	by axiom-developer.org (8.12.8/8.12.8) with ESMTP id mBACcXug023486;
	Wed, 10 Dec 2008 06:38:33 -0600
Received: (from daly@localhost)
	by axiom-developer.org (8.12.8/8.12.8/Submit) id mBACcWQk023480;
	Wed, 10 Dec 2008 06:38:32 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102685>

A trivial patch to fix a typo -- Tim Daly


diff --git a/builtin-add.c b/builtin-add.c
index ea4e771..5f2e68b 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -23,7 +23,7 @@ static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 	int num_unmatched = 0, i;
 
 	/*
-	 * Since we are walking the index as if we are warlking the directory,
+	 * Since we are walking the index as if we are walking the directory,
 	 * we have to mark the matched pathspec as seen; otherwise we will
 	 * mistakenly think that the user gave a pathspec that did not match
 	 * anything.
