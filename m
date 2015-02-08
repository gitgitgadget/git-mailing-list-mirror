From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/11] refs: remove the gap in the REF_* constant values
Date: Sun,  8 Feb 2015 17:13:56 +0100
Message-ID: <1423412045-15616-3-git-send-email-mhagger@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:21:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUbu-0005mY-Kp
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758588AbbBHQVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:21:22 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55590 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758490AbbBHQVV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:21:21 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Feb 2015 11:21:21 EST
X-AuditID: 12074413-f79f26d0000030e7-6a-54d78b5a98f2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.B1.12519.A5B87D45; Sun,  8 Feb 2015 11:14:18 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9l6014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:17 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqBvVfT3EYPUZC4uuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZ22YsZCpYx1qxaMEOtgbGOSxdjJwcEgImEhcuL2WEsMUkLtxbz9bF
	yMUhJHCZUWJn+xomkISQwAkmie+PpEBsNgFdiUU9zWBxEQE1iYlth8AGMQusZpLYeheomYND
	WMBDoruNByTMIqAqMenmVnYQm1fARWLH5bVMELvkJM4f/8kMYnMKuEosedPLDLHKRWLPrV6m
	CYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmuvlZpbopaaUbmKEhJjwDsZdJ+UOMQpw
	MCrx8BrIXA8RYk0sK67MPcQoycGkJMp7NBwoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR30eFr
	IUK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneE51AQwWLUtNTK9Iy
	c0oQ0kwcnCDDuaREilPzUlKLEktLMuJBcRFfDIwMkBQP0N5OkHbe4oLEXKAoROspRl2OBe37
	ZzIJseTl56VKifP+BykSACnKKM2DWwFLKK8YxYE+FuZN7QKq4gEmI7hJr4CWMAEtWbz0CsiS
	kkSElFQDY5CmV3Kv5JZYf7+lH1dG6m9YWaE48ZLs2u+zlexN2TXvT9/ifpT7wIb5mpu33nli
	mm74+VvPTzOfypeL7SzOnft9S94vPUvsScGKMxz3bh26lGpZk8+QNU0yypOPdYag 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263523>

There is no reason to "reserve" a gap between the public and private
flags values.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index cd5208b..477a5b3 100644
--- a/refs.c
+++ b/refs.c
@@ -44,7 +44,8 @@ static unsigned char refname_disposition[256] = {
  * Used as a flag to ref_transaction_delete when a loose ref is being
  * pruned.
  */
-#define REF_ISPRUNING	0x0100
+#define REF_ISPRUNING	0x04
+
 /*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
-- 
2.1.4
