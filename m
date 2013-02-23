From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2] Documentation/githooks: Explain pre-rebase parameters
Date: Sat, 23 Feb 2013 10:27:39 -0500
Message-ID: <c8b19dc074a81b009399ff1011102737761658ec.1361633106.git.wking@tremily.us>
References: <20130220163621.GI14102@odin.tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 16:28:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9H1R-0000lX-6G
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 16:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759048Ab3BWP14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 10:27:56 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:51800 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758864Ab3BWP1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 10:27:55 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIO00IVOIY8WN00@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 23 Feb 2013 09:27:45 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 5269A8C0092; Sat,
 23 Feb 2013 10:27:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361633264; bh=hbvq9OIZGnDrfngFxZvOgZ43TgXHOwRxG3x7yPVArV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QFXKsfjrJfR/QrEfJxHs8Uwp8h9XWcs+ctTUE20xPyrLyznLFarSv+PBC4C+tsKGF
 l/vkAV/SIJTvVxYTG4Gfdrb6nA/XKn2jI7tM3yJbu7wp77+l+kbGbpia7bWgm1YJLI
 Ll1lZJym5z5xQWRuBiDET9B3unolkwa9Fe1B8p+4=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <20130220163621.GI14102@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216899>

From: "W. Trevor King" <wking@tremily.us>

Descriptions borrowed from templates/hooks--pre-rebase.sample.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
Changes from v1:
* Replaced "empty" with "missing" for second parameter.

 Documentation/githooks.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..dfd5959 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -140,9 +140,10 @@ the outcome of 'git commit'.
 pre-rebase
 ~~~~~~~~~~
 
-This hook is called by 'git rebase' and can be used to prevent a branch
-from getting rebased.
-
+This hook is called by 'git rebase' and can be used to prevent a
+branch from getting rebased.  The hook takes two parameters: the
+upstream the series was forked from and the branch being rebased.  The
+second parameter will be missing when rebasing the current branch.
 
 post-checkout
 ~~~~~~~~~~~~~
-- 
1.8.2.rc0.16.g20a599e
