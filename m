From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 1/4] doc/clone: Remove the '--bare -l -s' example
Date: Sat, 22 Jun 2013 10:46:24 -0400
Message-ID: <fb9dc74892299d30e4b313353fddf663cc28b212.1371911897.git.wking@tremily.us>
References: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
 <cover.1371911897.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 16:46:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqP5Y-0003fn-1l
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 16:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758216Ab3FVOqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 10:46:48 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:61184 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368Ab3FVOqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 10:46:47 -0400
Received: from odin.tremily.us ([unknown] [72.68.80.60])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MOS00KKAUDJOHB0@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 22 Jun 2013 09:46:32 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 6B301A3D878; Sat,
 22 Jun 2013 10:46:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371912391; bh=ceNVmvuzVRCedJx9DusLhcdIH3bQdH77T03bYAZF+4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=LEmAbd7jdh3trjIZPDb3dt/7GGp2+H0m5YcXa0R1sEL0RBLbnc8Xl+sfjCQTMDSaQ
 lW7qEkEdj0LsP1VwJoo8+j68Xep+oxSR2YlGTFN3UecoIGTTbOSSXk80oLCTR1Z+oz
 828Q5OKu49S/10hHRBcpaQV/maBpMc8D5v5YLnp4=
X-Mailer: git-send-email 1.8.1.5
In-reply-to: <cover.1371911897.git.wking@tremily.us>
In-reply-to: <cover.1371911897.git.wking@tremily.us>
References: <cover.1371911897.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228713>

From: "W. Trevor King" <wking@tremily.us>

There are other examples in git-clone.txt demonstrating both '--bare'
and '-l -s'.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-clone.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 5c16e31..cec6fc1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -271,13 +271,6 @@ $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
 ------------
 
 
-* Create a repository on the kernel.org machine that borrows from Linus:
-+
-------------
-$ git clone --bare -l -s /pub/scm/.../torvalds/linux-2.6.git \
-    /pub/scm/.../me/subsys-2.6.git
-------------
-
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.8.3
