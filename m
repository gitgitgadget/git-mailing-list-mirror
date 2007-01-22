From: Jeff King <peff@peff.net>
Subject: [PATCH] v1.5.0.txt: update description of git-gc
Date: Sun, 21 Jan 2007 22:26:55 -0500
Message-ID: <20070122032655.GA5223@coredump.intra.peff.net>
References: <7virezwzpz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 04:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8ppy-0006ZF-Rp
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 04:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbXAVD06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 22:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbXAVD06
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 22:26:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1417 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751890AbXAVD05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 22:26:57 -0500
Received: (qmail 23745 invoked from network); 21 Jan 2007 22:27:17 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 21 Jan 2007 22:27:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Jan 2007 22:26:55 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virezwzpz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37393>

It doesn't call git-prune, and it does call a lot of other things.

Signed-off-by: Jeff King <peff@peff.net>
---
On Sun, Jan 21, 2007 at 06:40:40PM -0800, Junio C Hamano wrote:
> [PATCH] git-gc: do not run prune mindlessly.

This updates the release notes to reflect this change (and fixes a few
other inaccuracies and omissions).

 v1.5.0.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/v1.5.0.txt b/v1.5.0.txt
index 1b8ecf0..8a2c9cc 100644
--- a/v1.5.0.txt
+++ b/v1.5.0.txt
@@ -191,8 +191,8 @@ Updates in v1.5.0 since v1.4.4 series
    unreachable, as there is a one-day grace period built-in.
 
  - There is a toplevel garbage collector script, 'git-gc', that
-   is an easy way to run 'git-repack -a -d', 'git-reflog gc',
-   and 'git-prune'.
+   runs periodic cleanup functions, including 'git-repack -a -d',
+   'git-reflog expire', 'git-pack-refs --prune', and 'git-rerere gc'.
 
 
 * Detached HEAD
-- 
1.5.0.rc1.gda86
