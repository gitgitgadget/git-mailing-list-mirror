From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Documentation/git-rebase.txt: Add --strategy to synopsys
Date: Sat,  1 Mar 2008 12:39:52 +0100
Message-ID: <1204371592-17329-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 01 12:37:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVQ1c-0004yx-0N
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 12:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761681AbYCALgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 06:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761733AbYCALgb
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 06:36:31 -0500
Received: from vuizook.err.no ([194.24.252.247]:43971 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761463AbYCALga (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 06:36:30 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVQ0n-0004YD-4t; Sat, 01 Mar 2008 12:36:24 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVQ4G-0004Vv-JQ; Sat, 01 Mar 2008 12:39:52 +0100
X-Mailer: git-send-email 1.5.4.3.345.ged697.dirty
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75659>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 Documentation/git-rebase.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c11c645..4b10304 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
+	[-s <strategy> | --strategy=<strategy>]
 	[-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
 	[--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
-- 
1.5.4.3.345.ged697.dirty

