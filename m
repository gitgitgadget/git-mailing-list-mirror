From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH v2 1/2] Documentation: remove --prune from pack-refs examples
Date: Thu, 18 Jul 2013 09:53:25 -0700
Message-ID: <0A7070DB-118A-44B2-A554-246459D0CEF3@JonathonMah.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 18:53:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzrSf-0000tN-HP
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 18:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474Ab3GRQxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 12:53:46 -0400
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:27666 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932379Ab3GRQxp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 12:53:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvMTAIYc6FEyiIWrPGdsb2JhbAANTYtLuisDAQEBATiDGoFjGhOsFpI+kyRuA4koozQ
Received: from c-50-136-133-171.hsd1.ca.comcast.net (HELO [192.168.120.50]) ([50.136.133.171])
  by ipmail04.adl6.internode.on.net with ESMTP; 19 Jul 2013 02:23:30 +0930
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230701>

The option has been the default for a while, and doesn't otherwise
appear in the page.

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
Forgot sign-off in v1. Also, I was unsure whether to rewrap the lines (and if so, to how many columns); erred on the side of minimal changes.

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
