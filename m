From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 1/2] config: correct core.loosecompression documentation
Date: Mon, 19 Nov 2007 10:58:50 -0600
Message-ID: <1195491531-2701-1-git-send-email-bdowning@lavos.net>
References: <alpine.LFD.0.99999.0711191139240.19105@xanadu.home>
Cc: Nicolas Pitre <nico@cam.org>,
	Jonas Juselius <jonas.juselius@chem.uit.no>,
	git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuA62-0000xe-NV
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbXKSRH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbXKSRHZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:07:25 -0500
Received: from mxsf04.insightbb.com ([74.128.0.74]:38046 "EHLO
	mxsf04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbXKSRHY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 12:07:24 -0500
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="119310242"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf04.insightbb.com with ESMTP; 19 Nov 2007 12:07:23 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAIJRQUdKhvkY/2dsb2JhbACBWA
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="162316093"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 19 Nov 2007 12:07:23 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 0C93A309F21; Mon, 19 Nov 2007 11:07:22 -0600 (CST)
X-Original-To: bdowning@lavos.net
Received: from silvara.lavos.net (silvara.lavos.net [10.4.0.20])
	by mail.lavos.net (Postfix) with SMTP id 6A161309F20;
	Mon, 19 Nov 2007 10:58:48 -0600 (CST)
Received: (nullmailer pid 2758 invoked by uid 1000);
	Mon, 19 Nov 2007 16:58:51 -0000
X-Mailer: git-send-email 1.5.3.5.1824.g5f389
In-Reply-To: <alpine.LFD.0.99999.0711191139240.19105@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65471>

* core.loosecompression stated that the default was "0 (best speed)",
  when in fact 0 is "no compression", and the default is Z_BEST_SPEED,
  which is 1.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7ee97df..9565652 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -232,7 +232,7 @@ core.loosecompression::
 	are not in a pack file. -1 is the zlib default. 0 means no
 	compression, and 1..9 are various speed/size tradeoffs, 9 being
 	slowest.  If not set,  defaults to core.compression.  If that is
-	not set,  defaults to 0 (best speed).
+	not set,  defaults to 1 (best speed).
 
 core.packedGitWindowSize::
 	Number of bytes of a pack file to map into memory in a
-- 
1.5.3.5.1824.g5f389
