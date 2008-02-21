From: Len Brown <lenb@kernel.org>
Subject: git-send-email getting filtered as spam by vger.kernel.org
Date: Thu, 21 Feb 2008 04:29:58 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200802210429.58353.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 13:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSANa-0007dy-HS
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 13:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbYBUMRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 07:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYBUMRn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 07:17:43 -0500
Received: from hera.kernel.org ([140.211.167.34]:38413 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbYBUMRe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 07:17:34 -0500
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m1LCHMrb010041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 21 Feb 2008 12:17:23 GMT
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.7/5909/Thu Feb 21 10:17:26 2008 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74612>

git-send-email is getting filtered by vger.kernel.org

git --version
git version 1.5.4.2.184.gb23b

Example rejected message below.
sent this way:

git-send-email --from "Len Brown <lenb@kernel.org>" --compose --to linux-acpi@vger.kernel.org  --smtp-server 192.168.0.6 --suppress-from --no-chain-reply-to patch-release

and then tried again with --chain-reply-to, but it also has not survived vger.kernel.org.

when it prompts "Message-ID to be used as In-Reply-To for the first email?"
I simply hit return, b/c I have no idea how to answer that question.

This has worked for me many times in the past, but seems to have broken recently.
I don't know if it was a change in git, or a change on vger.kernel.org.

clues?

thanks,
-Len

----------  Forwarded Message  ----------

Subject: Fw: TABOO linux-acpi@vger.kernel.org: global taboo header: m/<>/ global taboo header: m/<>/
Date: Thursday 21 February 2008 03:56
From: David Miller <davem@davemloft.net>
To: lenb@kernel.org
Cc: len.brown@intel.com


All of your postings to the mailing list bounced because of those "<>"
things in your headers.  We block that because it is a pattern
frequently used by spammers to cover up their Received headers.

...

Thanks.


-------------------------------------------------------
>From lenb@kernel.org Thu Feb 21 03:46:40 2008
Received: from mga09.intel.com ([134.134.136.24]:62635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755925AbYBUIqc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Feb 2008 03:46:32 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP; 21 Feb 2008 00:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.25,385,1199692800"; 
   d="scan'208";a="300482149"
Received: from unknown (HELO localhost.localdomain) ([10.127.56.36])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2008 00:44:45 -0800
From:   Len Brown <lenb@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 14/26] ACPI: thinkpad-acpi: make the video output feature optional
Date:   Thu, 21 Feb 2008 03:45:16 -0500
Message-Id: <d7c1d17dfed996e84212fc1ce617b2586dd70ec2.1203581638.git.len.brown@intel.com>
X-Mailer: git-send-email 1.5.4.2.184.gb23b
In-Reply-To: <>
References: <>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203581637.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203581637.git.len.brown@intel.com>
Organization: Intel Open Source Technology Center
Return-Path: <lenb@kernel.org>
X-Envelope-To: <"|/opt/Majordomo/wrapper resend -l linux-acpi -f x-linux-acpi -h vger.kernel.org linux-acpi-outgoing"> (uid 400)
X-Orcpt: rfc822;linux-acpi@vger.kernel.org
Original-Recipient: rfc822;linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The video output port control feature is not very useful on many ThinkPads
(especially when a X server is running), and lately userspace is getting
better and better at it, so it makes sense to allow users to stripe out the
thinkpad-acpi video feature from their kernels and save at least 2KB.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig         |   17 +++++++++++++++++
 drivers/misc/thinkpad_acpi.c |   20 +++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 1abc95c..982e27b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -258,6 +258,23 @@ config THINKPAD_ACPI_BAY
 
          If you are not sure, say Y here.
 
+config THINKPAD_ACPI_VIDEO
+       bool "Video output control support"
+       depends on THINKPAD_ACPI
+       default y
+       ---help---
+         Allows the thinkpad_acpi driver to provide an interface to control
+         the various video output ports.
+
+         This feature often won't work well, depending on ThinkPad model,
+         display state, video output devices in use, whether there is a X
+         server running, phase of the moon, and the current mood of
+         Schroedinger's cat.  If you can use X.org's RandR to control
+         your ThinkPad's video output ports instead of this feature,
+         don't think twice: do it and say N here to save some memory.
+
+         If you are not sure, say Y here.
+
 config THINKPAD_ACPI_HOTKEY_POLL
        bool "Suport NVRAM polling for hot keys"
        depends on THINKPAD_ACPI
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 02f9465..4ea3866 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -301,6 +301,13 @@ TPACPI_HANDLE(hkey, ec, "\\_SB.HKEY",      /* 600e/x, 770e, 770x */
           "HKEY",              /* all others */
           );                   /* 570 */
 
+TPACPI_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",  /* 570 */
+          "\\_SB.PCI0.AGP0.VID0",      /* 600e/x, 770x */
+          "\\_SB.PCI0.VID0",   /* 770e */
+          "\\_SB.PCI0.VID",    /* A21e, G4x, R50e, X30, X40 */
+          "\\_SB.PCI0.AGP.VID",        /* all others */
+          );                           /* R30, R31 */
+
 
 /*************************************************************************
  * ACPI helpers
@@ -2680,6 +2687,8 @@ static struct ibm_struct wan_driver_data = {
  * Video subdriver
  */
 
+#ifdef CONFIG_THINKPAD_ACPI_VIDEO
+
 enum video_access_mode {
        TPACPI_VIDEO_NONE = 0,
        TPACPI_VIDEO_570,       /* 570 */
@@ -2707,13 +2716,6 @@ static int video_orig_autosw;
 static int video_autosw_get(void);
 static int video_autosw_set(int enable);
 
-TPACPI_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",  /* 570 */
-          "\\_SB.PCI0.AGP0.VID0",      /* 600e/x, 770x */
-          "\\_SB.PCI0.VID0",   /* 770e */
-          "\\_SB.PCI0.VID",    /* A21e, G4x, R50e, X30, X40 */
-          "\\_SB.PCI0.AGP.VID",        /* all others */
-          );                           /* R30, R31 */
-
 TPACPI_HANDLE(vid2, root, "\\_SB.PCI0.AGPB.VID");      /* G41 */
 
 static int __init video_init(struct ibm_init_struct *iibm)
@@ -3023,6 +3025,8 @@ static struct ibm_struct video_driver_data = {
        .exit = video_exit,
 };
 
+#endif /* CONFIG_THINKPAD_ACPI_VIDEO */
+
 /*************************************************************************
  * Light (thinklight) subdriver
  */
@@ -5807,10 +5811,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
                .init = wan_init,
                .data = &wan_driver_data,
        },
+#ifdef CONFIG_THINKPAD_ACPI_VIDEO
        {
                .init = video_init,
                .data = &video_driver_data,
        },
+#endif
        {
                .init = light_init,
                .data = &light_driver_data,
-- 
1.5.4.2.184.gb23b
