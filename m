From: Andrew Pimlott <andrew@pimlott.net>
Subject: [PATCH] lib-rebase: document exec_ in FAKE_LINES
Date: Mon,  1 Jul 2013 09:20:35 -0700
Message-ID: <1372695636-10768-1-git-send-email-andrew@pimlott.net>
Cc: Andrew Pimlott <andrew@pimlott.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 01 18:21:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utgqn-0002b5-QD
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab3GAQVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 12:21:09 -0400
Received: from pimlott.net ([72.249.23.100]:52919 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741Ab3GAQVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 12:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Message-Id:Date:Subject:Cc:To:From; bh=TYwfWuGabBJiC0nB6gB41sYwUNYajmh8+mXJnu3MJaI=;
	b=fOm8rNHR1KLytPgXjZNz9O492YQRzN2+x5Gsv4cQ7Ode3OLMSivcS+s/ETCFzDHnESTOdceDR2YcRBA4zwMIXe7OB/tc1FPAvhnZaRsFCUksBlceRv8S0VPDU5zULcFVSUVZlA2IwDkZLypI93Edz1YC1SA+5YLDHuhyuvC12p8=;
Received: from c-71-198-212-229.hsd1.ca.comcast.net ([71.198.212.229] helo=oinkpad.pimlott.net)
	by fugue.pimlott.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1Utgqg-0004Gj-De; Mon, 01 Jul 2013 09:21:06 -0700
Received: from andrew by oinkpad.pimlott.net with local (Exim 4.80)
	(envelope-from <andrew@pimlott.net>)
	id 1Utgqa-0002oK-1D; Mon, 01 Jul 2013 16:21:00 +0000
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229305>


Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
---
 t/lib-rebase.sh |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index cfd3409..7f119e2 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -17,6 +17,8 @@
 #       ("squash", "fixup", "edit", or "reword") and the SHA1 taken
 #       from the specified line.
 #
+#   "exec_cmd_with_args" -- add an "exec cmd with args" line.
+#
 #   "#" -- Add a comment line.
 #
 #   ">" -- Add a blank line.
-- 
1.7.10.4
