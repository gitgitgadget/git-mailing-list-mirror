From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v6 2/4] string-list: document that string_list_insert() inserts unique strings
Date: Thu, 29 Mar 2012 09:21:22 +0200
Message-ID: <edd8579ebf2cf3bc91137b9fff1d090ea75bee56.1332968667.git.hvoigt@hvoigt.net>
References: <cover.1332968667.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	Zbigniew J??drzejewski-Szmek <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 09:22:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD9gQ-0002Ub-WE
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 09:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758607Ab2C2HWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 03:22:06 -0400
Received: from darksea.de ([83.133.111.250]:34915 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753971Ab2C2HWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 03:22:03 -0400
Received: (qmail 32082 invoked from network); 29 Mar 2012 09:22:00 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Mar 2012 09:22:00 +0200
X-Mailer: git-send-email 1.7.10.rc2.31.gd8c60
In-Reply-To: <cover.1332968667.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1332968667.git.hvoigt@hvoigt.net>
References: <cover.1332968667.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194239>

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/technical/api-string-list.txt |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index ce24eb9..5a0c14f 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -83,7 +83,9 @@ Functions
 
 	Insert a new element to the string_list. The returned pointer can be
 	handy if you want to write something to the `util` pointer of the
-	string_list_item containing the just added string.
+	string_list_item containing the just added string. If the given
+	string already exists the insertion will be skipped and the
+	pointer to the existing item returned.
 +
 Since this function uses xrealloc() (which die()s if it fails) if the
 list needs to grow, it is safe not to check the pointer. I.e. you may
-- 
1.7.10.rc2.31.gd8c60
