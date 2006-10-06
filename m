From: Len Brown <len.brown@intel.com>
Subject: Re: git-send-email w/ headers
Date: Fri, 6 Oct 2006 00:41:56 -0400
Organization: Intel Open Source Technology Center
Message-ID: <200610060041.56807.len.brown@intel.com>
References: <200610041250.50272.len.brown@intel.com> <7viriy9w1q.fsf@assigned-by-dhcp.cox.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 06:39:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVhV6-0004A6-Kd
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 06:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWJFEjw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 00:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWJFEjw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 00:39:52 -0400
Received: from hera.kernel.org ([140.211.167.34]:51173 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750989AbWJFEjv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 00:39:51 -0400
Received: from lenb-laptop (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.7/8.13.7) with ESMTP id k964dJ4J029383
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Fri, 6 Oct 2006 04:39:45 GMT
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7viriy9w1q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.4/1999/Thu Oct  5 17:35:38 2006 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.3
X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28384>

On Thursday 05 October 2006 19:34, Junio C Hamano wrote:
> Len Brown <len.brown@intel.com> writes:
> 
> > git-send-email seems to strip out my custom headers.
> 
> It seems to not care about anything but a selected few.
> 
> Could you give this a try, please?

The good news is that the message received now includes the custom headers
from the original message.

But the Signed-off-by: line from the original message body
has now been swallowed up into the message header -- so my mailer doesn't display it.

thanks,
-Len

Original Message:
From 42f19e47f7e720cce936e4fdbaa979b6d4cf2f13 Mon Sep 17 00:00:00 2001
Message-Id: <42f19e47f7e720cce936e4fdbaa979b6d4cf2f13.1160108957.git.len.brown@intel.com>
From: Len Brown <len.brown@intel.com>
Date: Wed, 4 Oct 2006 01:11:12 -0400
Subject: [PATCH 1/14] test: create junk
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center

Signed-off-by: Len Brown <len.brown@intel.com>
---
 junk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/junk b/junk
new file mode 100644
index 0000000..9ecf3cf
--- /dev/null
+++ b/junk
@@ -0,0 +1 @@
+this
--
1.4.2.3.gabd6-dirty

Received Message:

Return-Path: <len.brown@intel.com>
 Received: from alnrmhc13.comcast.net (alnrmhc13.comcast.net [206.18.177.53])
        by hera.kernel.org (8.13.7/8.13.7) with ESMTP id k964RZPa026442
        for <lenb@kernel.org>; Fri, 6 Oct 2006 04:28:01 GMT
 Received: from localhost.localdomain (c-65-96-213-102.hsd1.ma.comcast.net[65.96.213.102])
          by comcast.net (alnrmhc13) with SMTP
          id <20061006042729b1300l5679e>; Fri, 6 Oct 2006 04:27:30 +0000
 From: Len Brown <len.brown@intel.com>
 To: lenb@kernel.org
 Cc: Len Brown <len.brown@intel.com>
 Subject: [PATCH 1/14] test: create junk
 Date: Fri,  6 Oct 2006 00:30:29 -0400
 Message-Id: <11601090432143-git-send-email-len.brown@intel.com>
 X-Mailer: git-send-email 1.4.2.3.gabd6-dirty
 In-Reply-To: <1160109042971-git-send-email-len.brown@intel.com>
 References: <1160109042971-git-send-email-len.brown@intel.com>
 Message-Id: <42f19e47f7e720cce936e4fdbaa979b6d4cf2f13.1160108957.git.len.brown@intel.com>
 Date: Wed, 4 Oct 2006 01:11:12 -0400
 Reply-To: Len Brown <lenb@kernel.org>
 Organization: Intel Open Source Technology Center
 Signed-off-by: Len Brown <len.brown@intel.com>
 X-Virus-Scanned: ClamAV 0.88.4/1999/Thu Oct  5 17:35:38 2006 on hera.kernel.org
 X-Virus-Status: Clean
 X-Spam-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,
        FORGED_RCVD_HELO,INVALID_DATE autolearn=no version=3.1.3
 X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on hera.kernel.org
 Status: R
 X-Status: NGC
 X-KMail-EncryptionState: 
 X-KMail-SignatureState: 
 X-KMail-MDN-Sent: 
 Content-Type: 
 
---
 junk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/junk b/junk
new file mode 100644
index 0000000..9ecf3cf
--- /dev/null
+++ b/junk
@@ -0,0 +1 @@
+this
-- 
1.4.2.3.gabd6-dirty
