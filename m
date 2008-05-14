From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] Documentation/git-prune.txt: document unpacked logic
Date: Wed, 14 May 2008 19:22:18 -0400
Message-ID: <20080514232218.GA2991@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 01:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwQJh-0001Fq-Lo
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 01:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbYENXWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 19:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbYENXWf
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 19:22:35 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:40706 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbYENXWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 19:22:34 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4ENMIES004572;
	Wed, 14 May 2008 19:22:18 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82159>

Clarifies the git-prune man page, documenting that it only
prunes unpacked objects.

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---

	One of these days I'll get it right... :-)
	Splitting up previous git-repack patch, and trying to format
	properly.  Trying the simple one first...

 Documentation/git-prune.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index f92bb8c..3178bc4 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -18,12 +18,15 @@ git-prune. See the section "NOTES", below.
 
 This runs `git-fsck --unreachable` using all the refs
 available in `$GIT_DIR/refs`, optionally with additional set of
-objects specified on the command line, and prunes all
+objects specified on the command line, and prunes all unpacked
 objects unreachable from any of these head objects from the object database.
 In addition, it
 prunes the unpacked objects that are also found in packs by
 running `git prune-packed`.
 
+Note that unreachable, packed objects will remain.  If this is
+not desired, see linkgit:git-repack[1].
+
 OPTIONS
 -------
 
-- 
1.5.4.4
