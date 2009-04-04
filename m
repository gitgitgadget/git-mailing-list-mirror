From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] doc/git-pack-refs: fix two grammar issues
Date: Sat, 4 Apr 2009 12:35:22 +0200
Message-ID: <200904041235.23310.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 12:38:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq3Gz-0005TD-1y
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 12:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbZDDKfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 06:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZDDKfa
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 06:35:30 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:35844 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbZDDKfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 06:35:30 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5D0D1F9F67DC;
	Sat,  4 Apr 2009 12:35:25 +0200 (CEST)
Received: from [89.59.94.8] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lq3Dh-0002NH-00; Sat, 04 Apr 2009 12:35:25 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19nFuZ4d1fb4WPlMVrFEHrLQWsphI3/2AjD6vwg
	3EnHmGX+xo2nu7R3+dw2xluJ03w7JBkbumrMND1/tEnyWmFHWr
	mfcZDghnQtDPBh4td0eQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115581>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-pack-refs.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index a5244d3..1ee99c2 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -26,7 +26,7 @@ problem by stashing the refs in a single file,
 traditional `$GIT_DIR/refs` hierarchy, it is looked up in this
 file and used if found.
 
-Subsequent updates to branches always creates new file under
+Subsequent updates to branches always create new files under
 `$GIT_DIR/refs` hierarchy.
 
 A recommended practice to deal with a repository with too many
@@ -35,7 +35,7 @@ occasionally run `git pack-refs \--prune`.  Tags are by
 definition stationary and are not expected to change.  Branch
 heads will be packed with the initial `pack-refs --all`, but
 only the currently active branch heads will become unpacked,
-and next `pack-refs` (without `--all`) will leave them
+and the next `pack-refs` (without `--all`) will leave them
 unpacked.
 
 
-- 
1.6.2.1.428.g41b20c
