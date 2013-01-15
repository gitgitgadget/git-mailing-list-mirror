From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/14] imap-send.c: remove unused field imap_store::uidvalidity
Date: Tue, 15 Jan 2013 09:06:30 +0100
Message-ID: <1358237193-8887-13-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:08:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1Ys-0002qx-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab3AOIHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:07:31 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:44319 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288Ab3AOIH3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:07:29 -0500
X-AuditID: 1207440e-b7f116d0000008ae-b2-50f50e403960
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.C9.02222.04E05F05; Tue, 15 Jan 2013 03:07:28 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5Y029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:27 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqOvA9zXA4NdWMYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7YPHsRS8EH5ootax+zNTB2
	MXcxcnJICJhIbFk5lw3CFpO4cG89kM3FISRwmVHiZMNBsCIhgTNMEvfWFoDYbAK6Eot6mplA
	bBEBNYmJbYdYQGxmAQeJzZ8bGUFsYYEgiXlbLrCC2CwCqhLTXt5mB7F5BVwkHv/fwAixTEHi
	9c5LYDWcQPGrP49B7XKW+LLhNOMERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIz
	S/RSU0o3MUJChW8HY/t6mUOMAhyMSjy8hgZfAoRYE8uKK3MPMUpyMCmJ8nZwfQ0Q4kvKT6nM
	SCzOiC8qzUktPsQowcGsJMLr8w6onDclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUI
	JivDwaEkwRvDCzRUsCg1PbUiLTOnBCHNxMEJIrhANvAAbXjFDVTIW1yQmFucmQ5RdIpRUUqc
	1wxkggBIIqM0D24ALKpfMYoD/SPMGwRSxQNMCHDdr4AGMwEN3rT3M8jgkkSElFQDY2+Cjs7e
	43GPNZLu7rc8NSvBZ+vN9VFyGgdWplg9qvqVd9kpgOmEYGfi9yTDc9ud7/1OlzDgzOede/IS
	TzbnthOMK62WRwZ+s7CzMuT7+PCbk3isr/mNT14rK2Q3bgj9cktcnP+U4KSORTeWBAorLvWP
	7fKInVG75cST6c+sIpLe+a1LDTftVWIpzkg01GIuKk4EAFUeZu7FAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213612>

I suspect that the existence of both imap_store::uidvalidity and
store::uidvalidity was an accident.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 48c646c..a0f42bb 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -124,7 +124,6 @@ struct imap {
 
 struct imap_store {
 	struct store gen;
-	int uidvalidity;
 	struct imap *imap;
 	const char *prefix;
 };
-- 
1.8.0.3
