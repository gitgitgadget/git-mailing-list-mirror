From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/14] iamp-send.c: remove unused struct imap_store_conf
Date: Tue, 15 Jan 2013 09:06:21 +0100
Message-ID: <1358237193-8887-4-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:07:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1YQ-0002RC-33
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001Ab3AOIHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:07:08 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:46911 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755800Ab3AOIHH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:07:07 -0500
X-AuditID: 12074411-b7fa36d0000008cc-48-50f50e2a2a0a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 42.B9.02252.A2E05F05; Tue, 15 Jan 2013 03:07:06 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5P029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:05 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqKvF9zXAYM5ydYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M44dvsQY8FH5oq/i2cyNjD2
	MHcxcnJICJhIPHm2ng3CFpO4cA/E5uIQErjMKHGlZTk7hHOGSWLqxMOMIFVsAroSi3qamUBs
	EQE1iYlth1hAbGYBB4nNnxvBaoQFvCVWL3sGZrMIqErM/DIXzOYVcJb4OfURC8Q2BYnXOy+x
	gticAi4SV38eA7tICKjmy4bTjBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s
	0UtNKd3ECAkWwR2MM07KHWIU4GBU4uE1NfgSIMSaWFZcmXuIUZKDSUmUt4Pra4AQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEV6fd0DlvCmJlVWpRfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUw
	WRkODiUJXgVeoKGCRanpqRVpmTklCGkmDk4QwQWygQdowytuoELe4oLE3OLMdIiiU4yKUuK8
	f3iAEgIgiYzSPLgBsLh+xSgO9I8wryjIHh5gSoDrfgU0mAlo8Ka9n0EGlyQipKQaGMOWyCRd
	+sHOfangJPOhzgOi96KsXe5/bw+tYuFbsXOSxbMqyZpNjjbHfIx14z/POSi6bc2Ojtz2Fi2j
	rqv8ixVmn5mWXTkveXMNb3blM1WWHeH2bH9tGyYu9bzHsJl10Ua3aRddXlhrXfJ7U+y9UH/u
	fLM9vYudAtJWdWlEhItXpG77z8x/W4mlOCPRUIu5qDgRAMWq3r3GAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213605>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 29c10a4..dbe0546 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -130,11 +130,6 @@ static struct imap_server_conf server = {
 	NULL,	/* auth_method */
 };
 
-struct imap_store_conf {
-	struct store_conf gen;
-	struct imap_server_conf *server;
-};
-
 #define NIL	(void *)0x1
 #define LIST	(void *)0x2
 
-- 
1.8.0.3
