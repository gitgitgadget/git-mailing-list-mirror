From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] gitignore: add .version as this is generated during a make
Date: Thu, 10 Jul 2014 15:48:04 -0700
Message-ID: <1405032485-26117-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 00:59:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5NJc-0007s0-3q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 00:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbaGJW7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 18:59:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:26820 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbaGJW7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 18:59:43 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 10 Jul 2014 15:54:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,640,1400050800"; 
   d="scan'208";a="541718337"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2014 15:48:06 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253228>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index e0710ad5b294..098dcdfe1ea7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,6 @@
 /*.d
 /*.o
+/.version
 /hwstamp_ctl
 /phc2sys
 /pmc
-- 
2.0.1.475.g9b8d714
