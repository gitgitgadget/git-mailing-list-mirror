From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] Mark files in t/t5100 as UTF-8
Date: Wed, 21 Oct 2009 13:35:16 +0200
Message-ID: <1256124916-26486-2-git-send-email-j6t@kdbg.org>
References: <1256124916-26486-1-git-send-email-j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 14:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0a5o-0001dy-Mr
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 14:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbZJUMOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 08:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbZJUMOy
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 08:14:54 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:42260 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbZJUMOx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 08:14:53 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1N0ZTg-0003wL-6r; Wed, 21 Oct 2009 13:35:40 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 19A4E6D9; Wed, 21 Oct 2009 13:35:40 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 05AF9FA46; Wed, 21 Oct 2009 13:35:39 +0200 (CEST)
X-Mailer: git-send-email 1.6.5.rc2.47.g49402
In-Reply-To: <1256124916-26486-1-git-send-email-j6t@kdbg.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130907>

This enables gitk to show the patch text with correct glyphs if the locale
is not UTF-8.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This is particularly interesting for users on Windows, because we
 do not have a usable UTF-8 locale.

 t/t5100/.gitattributes |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 t/t5100/.gitattributes

diff --git a/t/t5100/.gitattributes b/t/t5100/.gitattributes
new file mode 100644
index 0000000..feeebf2
--- /dev/null
+++ b/t/t5100/.gitattributes
@@ -0,0 +1,4 @@
+msg*	encoding=UTF-8
+info*	encoding=UTF-8
+rfc2047-info-*	encoding=UTF-8
+sample.mbox	encoding=UTF-8
-- 
1.6.5.1028.g985e.dirty
