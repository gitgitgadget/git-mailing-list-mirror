From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/13] refs: remove the gap in the REF_* constant values
Date: Tue, 17 Feb 2015 18:00:12 +0100
Message-ID: <1424192423-27979-3-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:07:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlci-0007B3-8a
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbbBQRHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:07:44 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58002 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751791AbbBQRHm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:07:42 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2015 12:07:42 EST
X-AuditID: 12074414-f797f6d000004084-90-54e373b31aa8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 79.C3.16516.3B373E45; Tue, 17 Feb 2015 12:00:35 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXX000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:34 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqLu5+HGIwZolBhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgz7ryeyViwjrXi9s/DTA2Mc1i6GDk5JARMJCbPvskKYYtJXLi3nq2L
	kYtDSOAyo8Td+9uhnONMEj0d68Gq2AR0JRb1NDOB2CICahIT2w6BTWIWWM0ksfUuG4gtLOAt
	0bn9J1gNi4CqRNuV3+wgNq+Ai8TkGQ+htslJnD/+kxnE5hRwlVj2axlYjRBQzfyO2UwTGHkX
	MDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSndxAgJM5EdjEdOyh1iFOBgVOLh
	tZjwKESINbGsuDL3EKMkB5OSKG940eMQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8QSlAOd6U
	xMqq1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCd6vhUCNgkWp6akVaZk5JQhp
	Jg5OkOFcUiLFqXkpqUWJpSUZ8aDYiC8GRgdIigdorx7ITbzFBYm5QFGI1lOMuhwL2vfPZBJi
	ycvPS5US530HskMApCijNA9uBSypvGIUB/pYmDcXZBQPMCHBTXoFtIQJaMn8P49AlpQkIqSk
	Ghib/H6039/r1mXoZ+R8t/ahyEQhZ8VpjWdfnuBZLvYm7WTYsWnRvH9FHr5RP61659jEwwIH
	Vost2Xajuk/q4Q6BMyf0y1P3H90cYFxwyHQyr0bx0pazZ9ganh2NPxK2Qvj5ro0/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263965>

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
