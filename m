From: Thomas Hochstein <thh@inter.net>
Subject: [PATCH] documentation fix: git difftool uses diff tools, not merge tools.
Date: Mon, 14 Nov 2011 23:55:52 +0100
Message-ID: <1321311352-8950-1-git-send-email-thh@inter.net>
Cc: Thomas Hochstein <thh@inter.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 00:07:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ5d5-0001qB-GS
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 00:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697Ab1KNXHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 18:07:51 -0500
Received: from weideland.szaf.org ([78.46.90.44]:35457 "EHLO
	weideland.szaf.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab1KNXHu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 18:07:50 -0500
X-Greylist: delayed 701 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Nov 2011 18:07:50 EST
Received: from p4fccecd1.dip.t-dialin.net ([79.204.236.209] helo=thangorodrim.ancalagon.de)
	by weideland.szaf.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <thh@ancalagon.de>)
	id 1RQ5Rg-0006l8-75; Mon, 14 Nov 2011 23:56:08 +0100
Received: from thh by thangorodrim.ancalagon.de with local (Exim 4.72)
	(envelope-from <thh@ancalagon.de>)
	id 1RQ5Rf-0002X4-DV; Mon, 14 Nov 2011 23:56:07 +0100
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185417>

Let the documentation for -t list valid *diff* tools,
not valid *merge* tools.

Signed-off-by: Thomas Hochstein <thh@inter.net>
---
 Documentation/git-difftool.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index a03515f..19d473c 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,7 +31,7 @@ OPTIONS
 -t <tool>::
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
-	Valid merge tools are:
+	Valid diff tools are:
 	araxis, bc3, diffuse, emerge, ecmerge, gvimdiff, kdiff3,
 	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and xxdiff.
 +
-- 
1.7.2.5
