From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 35/39] lockfile.c: rename static functions
Date: Fri, 26 Sep 2014 12:08:35 +0200
Message-ID: <1411726119-31598-36-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSTL-0004Bi-B4
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201AbaIZKJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2014 06:09:51 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61750 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752464AbaIZKJr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:47 -0400
X-AuditID: 12074414-f79446d000001f1d-e8-54253b6bbb9a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2D.0F.07965.B6B35245; Fri, 26 Sep 2014 06:09:47 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMK013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:45 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUgTYRznubu5Z7aL81zuyUzpbEovm1p9uCwjyOoysCiL6ss63emm2ym7
	baiEGDNLSzL85MS07A2JtJmWWRHLXhR6MxGjDAozECQp7YVKu3Opffs9/98bD/8/xOkXqkho
	E12CU+TtTEgoQatTlxnzNhgyEp+fptnK/pMYW1rVj7PD9UM4O/b6AmDfXGnA2R9lp3B2qvoI
	W3FiEmyG3J/P4xjX6RtSc41+N/d+tFLNjVTdAdzLvljuqz+aezPSQeyGhxZszORdnr22HDFh
	0+EF1kcfO1QFTzWFNbWrSsEvdSXQQEStQ1/aW0OCOAK9eNci41BIU68Aqr869u/hx1Dd3acz
	jhDKiM6f8mIK1lFx6Ex5gFBEONWEoeqAfyYqnEpBwz0+lYIJyoA6Jx7glQBCktqKmnuZYFs0
	au2aBgrWyOOjNwdmME2lorKWGkLBJBWGemqHCcWKU/Go5SytjHEqBnnb6/BqQPn+U/nmVb7/
	VI0AbwbRvN3tMDp4m10SsoxSFi+KgtPImhw2l0mwuP0guAvdLdDdEx0AFASMlhy8tjyDVvEe
	qcgRAIshxiwiJ1hDBr0wM99SZOUlq9nptgtSACCIMzry7RqZIy18UbHgzJ+llkCC0ZPfmuLT
	aSqHdwl5glAgOGfZKAgZRLYly8Ywp5AjFGbb7K55GoMaJTw0UicJokVw8m6X1ays1CzJO1Uo
	rdx7XLGTUgHvkKdBay9YC6cuj1dh8FrFt9MYTYj5ohCpJ7vXy1JKkVrd4lzR7CGOAr3873Dy
	sRKolc90Lm9UrsLkKqY7Vqly8fNUZCmov34sV8P0PWxbsefAvXHeahIbVrPEnV6d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257518>

* remove_lock_file() -> remove_lock_files()
* remove_lock_file_on_signal() -> remove_lock_files_on_signal()

Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index a1cc08a..0a8c3c8 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -57,7 +57,7 @@
=20
 static struct lock_file *volatile lock_file_list;
=20
-static void remove_lock_file(void)
+static void remove_lock_files(void)
 {
 	pid_t me =3D getpid();
=20
@@ -68,9 +68,9 @@ static void remove_lock_file(void)
 	}
 }
=20
-static void remove_lock_file_on_signal(int signo)
+static void remove_lock_files_on_signal(int signo)
 {
-	remove_lock_file();
+	remove_lock_files();
 	sigchain_pop(signo);
 	raise(signo);
 }
@@ -146,8 +146,8 @@ static int lock_file(struct lock_file *lk, const ch=
ar *path, int flags)
=20
 	if (!lock_file_list) {
 		/* One-time initialization */
-		sigchain_push_common(remove_lock_file_on_signal);
-		atexit(remove_lock_file);
+		sigchain_push_common(remove_lock_files_on_signal);
+		atexit(remove_lock_files);
 	}
=20
 	if (lk->active)
--=20
2.1.0
