From: vamsi <vamsineelam@gmail.com>
Subject: How to merge the diff file in the git repositry
Date: Sun, 22 Apr 2012 18:38:52 -0700 (PDT)
Message-ID: <1335145132814-7490516.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 03:39:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SM8Fa-0001sk-H8
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 03:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088Ab2DWBiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 21:38:54 -0400
Received: from sam.nabble.com ([216.139.236.26]:48249 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062Ab2DWBix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 21:38:53 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <vamsineelam@gmail.com>)
	id 1SM8Eu-0000Q5-Rg
	for git@vger.kernel.org; Sun, 22 Apr 2012 18:38:52 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196093>

hii ,

i have a diff file.how to add these modifications to the git repositry



diff --git a/board/Maxim/maximasp_eek/board_init.S

b/board/Maxim/maximasp_eek/board_init.S

index ec57078..bd55877 100644

--- a/board/Maxim/maximasp_eek/board_init.S

+++ b/board/Maxim/maximasp_eek/board_init.S

@@ -13,7 +13,7 @@

#define ENABLE_DLL

 

#define GCR_SETUP      /* Modify GCR register */

-#define GCR_UBP                /* UCI bypass */

+#undef  GCR_UBP                /* UCI bypass */

#undef  GCR_PBEN       /* Enable pass bridge */

#undef  GCR_PBFB       /* Enable burst in pass bridge */

#undef  GCR_ADK                /* Use ADK bridge */

diff --git a/include/configs/maximasp-eek.h b/include/configs/maximasp-eek.h
index 897f4ab..c9e3965 100644

--- a/include/configs/maximasp-eek.h

+++ b/include/configs/maximasp-eek.h

@@ -23,13 +23,13 @@

#define __CONFIG_H

 

#define CONFIG_SYS_USE_DDR     /* Use DDR instead of PSRAM */

-#define CONFIG_SYS_SYNC_MEM    /* Synchronous memory */

+//#define CONFIG_SYS_SYNC_MEM  /* Synchronous memory */

 

/*

  * CPU Clock - 16x crystal (20 MHz -> 320 MHz, 24 MHz -> 384 MHz)

  */

-//#define CONFIG_SYS_CPU_CLOCK         384000000

-#define CONFIG_SYS_CPU_CLOCK           320000000

+#define CONFIG_SYS_CPU_CLOCK           384000000

+//#define CONFIG_SYS_CPU_CLOCK         320000000

 
/*

  * Physical Memory Map

regards

Git newbie

--
View this message in context: http://git.661346.n2.nabble.com/How-to-merge-the-diff-file-in-the-git-repositry-tp7490516p7490516.html
Sent from the git mailing list archive at Nabble.com.
