From: nelsonjesus.benitez@mpt.es
Subject: [PATCH] 1.7.10 RelNotes: mention git is now able to authenticate
Date: Thu, 05 Apr 2012 16:38:50 +0200
Message-ID: <20120405163850.17615pnlhulqxsw0@correo.seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 19:08:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFqAB-0000ut-M1
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 19:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab2DERHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 13:07:54 -0400
Received: from luthien1.mpt.es ([213.9.211.102]:58760 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811Ab2DERHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 13:07:53 -0400
X-Greylist: delayed 8930 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Apr 2012 13:07:53 EDT
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id 9D4F3B728C;
	Thu,  5 Apr 2012 16:38:54 +0200 (CEST)
Received: from localhost (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id CC4B0203905;
	Thu,  5 Apr 2012 16:38:50 +0200 (CEST)
Received: from 87.218.15.55 ([87.218.15.55]) by correo.seap.minhap.es
 (Horde Framework) with HTTP; Thu, 05 Apr 2012 16:38:50 +0200
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.3.9)
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 9D4F3B728C.1EDA9
X-map-MapScanner-From: nelsonjesus.benitez@mpt.es
X-map-MailScanner-Watermark: 1334241535.38382@OXVa009GuimsOJYDqKgyUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194789>

Mention http transport is now able to go through proxies
that require authentication, that was added in commit
dd6139971a18e25a5089c0f96dc80e454683ef0b
---
Hi Juno, I send you this patch to 'next' so you consider adding
to 1.7.10 RelNotes the proxy authentication feature, so I can
link at this when git proxy auth is asked on forums, you are free
to re-word it as you want. thank you.

  Documentation/RelNotes/1.7.10.txt |    4 ++++
  1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/RelNotes/1.7.10.txt  
b/Documentation/RelNotes/1.7.10.txt
index fed9c73..9967c04 100644
--- a/Documentation/RelNotes/1.7.10.txt
+++ b/Documentation/RelNotes/1.7.10.txt
@@ -143,6 +143,10 @@ UI, Workflows & Features
     external tool to perform a directory diff of two Git revisions
     in one go, unlike "difftool" that compares one file at a time.

+ * HTTP transport has learnt to go through proxies that require
+   authentication, be sure to have username and password provided
+   in the proxy url stored at http.proxy config option.
+
  Foreign Interface

   * Improved handling of views, labels and branches in "git-p4" (in contrib).
-- 
1.6.3.3
