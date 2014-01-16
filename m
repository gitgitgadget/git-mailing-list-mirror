From: Alexander Berntsen <alexander@plaimi.net>
Subject: [PATCH] .gitignore: Ignore editor backup and swap files
Date: Thu, 16 Jan 2014 22:19:24 +0100
Message-ID: <1389907164-13400-1-git-send-email-alexander@plaimi.net>
Cc: alexander@plaimi.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 16 22:27:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3uTM-0004zL-Rq
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 22:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbaAPV13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 16:27:29 -0500
Received: from 107.4.189.109.customer.cdi.no ([109.189.4.107]:53351 "EHLO
	mail.plaimi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbaAPV12 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 16:27:28 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2014 16:27:27 EST
Received: by mail.plaimi.net (Postfix) with ESMTPSA id DDFA240155;
	Thu, 16 Jan 2014 22:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=plaimi.net; s=leet;
	t=1389907138; bh=8HSmAHcGU8KLlA5shhzoYlyehIlxzmraKKadnN+TZHE=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=W+NRo+quYt1B8L7/o4JG9Y9rlc3ay0qkmRvKxGBVonI2glQeeVG2mMsmGuSV9AIjE
	 HvhjSHp+Brgoxc1DoqyIB+B9crC/ZWriQ88ATqeSsNHyrlFhSc3a1ow+nc0n1jfgdH
	 S9IPUhacFX6IrNZf15vlfzjjT0wKT2V4uWJhEOCE=
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240537>

Signed-off-by: Alexander Berntsen <alexander@plaimi.net>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index b5f9def..2905c21 100644
--- a/.gitignore
+++ b/.gitignore
@@ -240,3 +240,5 @@
 *.pdb
 /Debug/
 /Release/
+*~
+.*.swp
-- 
1.8.3.2
