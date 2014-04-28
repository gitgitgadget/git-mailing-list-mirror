From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 02/12] MINGW: compat/bswap.h: include stdint.h
Date: Mon, 28 Apr 2014 17:51:27 +0400
Message-ID: <1398693097-24651-3-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:51:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WelyP-0003WG-58
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbaD1Nvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:51:49 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56101 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaD1Nvs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:51:48 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyC-0004qo-DH; Mon, 28 Apr 2014 17:51:44 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247328>

bswap.h uses uint32_t type which might not be defined.
This patch adds direct include so bswap.h can be safely included.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/bswap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index 120c6c1..d170447 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -5,6 +5,8 @@
  * operation.
  */
 
+#include <stdint.h>
+
 /*
  * Default version that the compiler ought to optimize properly with
  * constant values.
-- 
1.9.1
