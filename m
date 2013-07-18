From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH 1/2] Documentation: remove --prune from pack-refs examples
Date: Thu, 18 Jul 2013 00:11:58 -0700
Message-ID: <19D1767A-4C36-4A89-A9BB-9FED33289CD9@JonathonMah.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 09:12:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UziO4-0003F4-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 09:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758334Ab3GRHMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 03:12:14 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:62186 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755026Ab3GRHMO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 03:12:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Au4WADqT51EyiIWrPGdsb2JhbAANTYtKuicDAQEBATiDGYFjGhOsFZJEkw5uA4knozQ
Received: from c-50-136-133-171.hsd1.ca.comcast.net (HELO [192.168.120.50]) ([50.136.133.171])
  by ipmail07.adl2.internode.on.net with ESMTP; 18 Jul 2013 16:41:59 +0930
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230678>

The option has been the default for a while, and doesn't otherwise
appear in the page.
---
 Documentation/git-pack-refs.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index f131677..154081f 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -33,8 +33,8 @@ Subsequent updates to branches always create new files under
 `$GIT_DIR/refs` directory hierarchy.
 
 A recommended practice to deal with a repository with too many
-refs is to pack its refs with `--all --prune` once, and
-occasionally run `git pack-refs --prune`.  Tags are by
+refs is to pack its refs with `--all` once, and
+occasionally run `git pack-refs`.  Tags are by
 definition stationary and are not expected to change.  Branch
 heads will be packed with the initial `pack-refs --all`, but
 only the currently active branch heads will become unpacked,
-- 
1.8.3.3.754.g9c3c367




Jonathon Mah
me@JonathonMah.com
