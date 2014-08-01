From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] doc: format-patch: don't use origin as a branch name
Date: Fri,  1 Aug 2014 20:20:26 +0100
Message-ID: <1406920826-4680-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDINT-0002N2-IS
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 21:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbaHATU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 15:20:28 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:55470 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932088AbaHATU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 15:20:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArgTAPnn21MCYJjrPGdsb2JhbABbgwwBAWIBRYInhQirHpk5h1sMfxcFAQEBATg2hGAjGIECChoTiEbJD49MNYQdBbQePC8
X-IPAS-Result: ArgTAPnn21MCYJjrPGdsb2JhbABbgwwBAWIBRYInhQirHpk5h1sMfxcFAQEBATg2hGAjGIECChoTiEbJD49MNYQdBbQePC8
X-IronPort-AV: E=Sophos;i="5.01,781,1400022000"; 
   d="scan'208";a="506465770"
Received: from host-2-96-152-235.as13285.net (HELO localhost) ([2.96.152.235])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 01 Aug 2014 20:20:25 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254652>

Historically (5 Nov 2005 v0.99.9-46-g28ffb89) the git-format-patch used
'origin' as the upstream branch name. This is now used to name the remote.
Use the more modern 'master' as the branch name.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

I noticed this while cross-checking details for updating the guide
Documentation/(git)everyday.txt
--
Philip

 Documentation/git-format-patch.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c0fd470..b0f041f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -523,25 +523,25 @@ $ git format-patch -k --stdout R1..R2 | git am -3 -k
 ------------
 
 * Extract all commits which are in the current branch but not in the
-origin branch:
+master branch:
 +
 ------------
-$ git format-patch origin
+$ git format-patch master
 ------------
 +
 For each commit a separate file is created in the current directory.
 
-* Extract all commits that lead to 'origin' since the inception of the
+* Extract all commits that lead to 'master' since the inception of the
 project:
 +
 ------------
-$ git format-patch --root origin
+$ git format-patch --root master
 ------------
 
 * The same as the previous one:
 +
 ------------
-$ git format-patch -M -B origin
+$ git format-patch -M -B master
 ------------
 +
 Additionally, it detects and handles renames and complete rewrites
-- 
1.9.4.msysgit.0
