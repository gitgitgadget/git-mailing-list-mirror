From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/12] refs: remove the gap in the REF_* constant values
Date: Thu, 12 Feb 2015 12:12:13 +0100
Message-ID: <1423739543-1025-3-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:13:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLrhg-0004Bo-4u
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbbBLLMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:12:51 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50383 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755592AbbBLLMg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:12:36 -0500
X-AuditID: 1207440f-f792a6d000001284-4c-54dc8aa2949e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.A0.04740.2AA8CD45; Thu, 12 Feb 2015 06:12:34 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7V003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:33 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqLuo606IwcdX2hZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgz7ryeyViwjrXi9s/DTA2Mc1i6GDk5JARMJKZPXckMYYtJXLi3nq2L
	kYtDSOAyo8TUmwugnBNMEp0PHzKBVLEJ6Eos6mkGs0UE1CQmth0Cm8QssJpJYutdNhBbWMBb
	Ytu0dYwgNouAqsTUOVfBbF4BZ4llf94wQmyTkzh//CfYZk4BF4l3lxrA4kJANbvatrBOYORd
	wMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMkzPh3MHatlznEKMDBqMTD
	u8L0TogQa2JZcWXuIUZJDiYlUV6uVqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV7fJqAcb0pi
	ZVVqUT5MSpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mCt7wTqFGwKDU9tSItM6cEIc3E
	wQkynEtKpDg1LyW1KLG0JCMeFBvxxcDoAEnxAO0VA2nnLS5IzAWKQrSeYtTlWNC+fyaTEEte
	fl6qlDhvJkiRAEhRRmke3ApYUnnFKA70sTCvBDDFCPEAExLcpFdAS5iAlkyccRtkSUkiQkqq
	gbFb3s5bxEnL9eTbgo5twb/ttjsoXNDg8u4Xv/RJV9d/u/XMTWcO575R+3L1tYjIiTiJe53l
	sim/70XVb05bE8p0PHDW7Nns5rJ/WaZZ6tZ2vH1QlnyAd5pLNt/jXToHcvo8a9dn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263721>

There is no reason to "reserve" a gap between the public and private
flags values.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 5e6355c..4de1383 100644
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
