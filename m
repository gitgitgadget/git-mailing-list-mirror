From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v5 2/4] submodule: Document module_clone arguments in comments
Date: Sun, 26 Jan 2014 12:45:14 -0800
Message-ID: <9d4a3470ef426ea8f93db33ad0e2f11f668a6d26.1390768736.git.wking@tremily.us>
References: <20140117023746.GJ7078@odin.tremily.us>
 <cover.1390768736.git.wking@tremily.us>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 26 21:46:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7Wax-0002Yc-J0
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 21:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbaAZUqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 15:46:13 -0500
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:57858
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753194AbaAZUqK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 15:46:10 -0500
Received: from omta23.westchester.pa.mail.comcast.net ([76.96.62.74])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id Jk071n0031c6gX853km9TZ; Sun, 26 Jan 2014 20:46:09 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta23.westchester.pa.mail.comcast.net with comcast
	id Jkm71n00B152l3L3jkm7Jy; Sun, 26 Jan 2014 20:46:09 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id CD476F1C339;
	Sun, 26 Jan 2014 12:46:06 -0800 (PST)
Received: (nullmailer pid 2841 invoked by uid 1000);
	Sun, 26 Jan 2014 20:45:23 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <cover.1390768736.git.wking@tremily.us>
In-Reply-To: <cover.1390768736.git.wking@tremily.us>
References: <cover.1390768736.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1390769169;
	bh=yMFoLETQNPjbVy2QY7ZQJvwAo4aM4Hfp1i2VXxsXEqo=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=Rc26ZkT9UTAn9PcHS7p/B5cZ9BCDdirhZHkSrFzyD6S+3HidBKVDJiBct6AYI0BKM
	 KPvfSudYpBPL41aa8x5m1sw2AKCH60P7KjVEyei2JeIPlrXr12TKuYXhIfGNTD5Hdp
	 s46lNeX3jgDBX3tQo+Dw29Ve5NcLiA2Ma5lD1rTeVOzFx7gjEfp8nWnpzRq5yphPuV
	 cZPgyyYYNrL62VaTg6WOlESYaN35ViVnO1v2fneFJKImJKI8WG9/ZUwD2QQoa2C8J/
	 atXvloLINgSU9Qsg0hqeeCO+zAjzXCJq5SRz6+qKXTmPBUQkW91SkqY74KXtfD77II
	 9brZyUgI2N9iQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241113>

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 git-submodule.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5e8776c..68dcbe1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,6 +241,12 @@ module_name()
 #
 # Clone a submodule
 #
+# $1 = submodule path
+# $2 = submodule name
+# $3 = URL to clone
+# $4 = reference repository to reuse (empty for independent)
+# $5 = depth argument for shallow clones (empty for deep)
+#
 # Prior to calling, cmd_update checks that a possibly existing
 # path is not a git repository.
 # Likewise, cmd_add checks that path does not exist at all,
-- 
1.8.5.2.8.g0f6c0d1
