From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/15] ref_remove_duplicates(): improve documentation comment
Date: Wed, 23 Oct 2013 17:50:41 +0200
Message-ID: <1382543448-2586-9-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0jG-00025n-Ln
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab3JWPwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:52:09 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43689 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751622Ab3JWPwI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:52:08 -0400
X-AuditID: 1207440f-b7f306d000006d99-cf-5267f0a6876f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 91.CA.28057.6A0F7625; Wed, 23 Oct 2013 11:52:07 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLt1009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:52:04 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqLv8Q3qQwcP9nBbTu1azWHRd6Way
	aOi9wmwx7+4uJotVt5YxW6yccYPR4vaK+cwWTzsrLea9eMFm8aOlh9mBy+Pv+w9MHpfWvWTy
	OPRnCrvHsxPtbB6XXn5n83jWu4fR4+IlZY8ZLa9ZPD5vkvM4cPkxWwBXFLdNUmJJWXBmep6+
	XQJ3xrX+c2wFu9krvsx4zNTA+Iu1i5GTQ0LARGL/9f0sELaYxIV769m6GLk4hAQuM0r8P7ya
	HcK5wiSx7soWJpAqNgFdiUU9zWC2iICaxMS2QywgRcwCE5kljk9fBDZKWMBX4sjMFrAVLAKq
	EqtmXwWL8wo4S3yaf5m5i5EDaJ2cxMNvsSBhTgEXiQvHp4OVCwGVTFg4lX0CI+8CRoZVjHKJ
	OaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCFhy7+DsWu9zCFGAQ5GJR7ehy1pQUKs
	iWXFlbmHGCU5mJREedmBQS/El5SfUpmRWJwRX1Sak1p8iFGCg1lJhHfHXaAcb0piZVVqUT5M
	SpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mC9+d7oEbBotT01Iq0zJwShDQTByeI4ALZ
	wAO0QRBkO29xQWJucWY6RNEpRkUpcV5mkIQASCKjNA9uACzBvGIUB/pHmPcmyB4eYHKC634F
	NJgJaPCUJWkgg0sSEVJSDYyBhhnqLxaLN0+wTJVq2+FQ2Wg+89OmiO3C/Ff8fPVZpy94x9iX
	q6p8seB+5RzbsiOKHgyzJ2a9846Tn5GtlPJ5etzt3yuz3LW4Q79d2730vPxRvlVz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236517>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/remote.h b/remote.h
index 131130a..40293c0 100644
--- a/remote.h
+++ b/remote.h
@@ -149,7 +149,14 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
 
 /*
- * Removes and frees any duplicate refs in the map.
+ * Remove and free all but the first of any entries in the input list
+ * that map the same remote reference to the same local reference.  If
+ * there are two entries that map different remote references to the
+ * same local reference, die.
+ *
+ * Note that the first entry is never removed; therefore, the pointer
+ * passed in as argument still points to the head of the list after
+ * the function returns.
  */
 void ref_remove_duplicates(struct ref *ref_map);
 
-- 
1.8.4
