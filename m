From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 34/35] lockfile.c: rename static functions
Date: Tue, 16 Sep 2014 21:33:55 +0200
Message-ID: <1410896036-12750-35-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:43:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyeg-00049I-Jt
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301AbaIPTm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2014 15:42:57 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50620 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755247AbaIPTmi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:38 -0400
X-AuditID: 12074412-f792e6d000005517-58-541890ec6e08
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id AD.45.21783.CE098145; Tue, 16 Sep 2014 15:35:08 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcc001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:35:06 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsUixO6iqPtmgkSIQVcTl0XXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi38Taiw6O74yOrB7/H3/gcljwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBn9F/qYC84y1kx69YxxgbG3+xdjJwcEgImEi+bL7BA
	2GISF+6tZ+ti5OIQErjMKLF01yQmCOcEk8Sm4y2sIFVsAroSi3qawRIiAm2MErsubmYFcZgF
	uhkl3p84zQRSJSxgK/Gq7wfYDhYBVYkdh5awgdi8Aq4SC+7NY4PYJyexYfd/xi5GDg5OoPjX
	fQUgppCAi8TBu34Q1YISJ2c+YQEJMwuoS6yfJwQSZhaQl2jeOpt5AqPALCRVsxCqZiGpWsDI
	vIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMjJAqEdjCuPyl3iFGAg1GJh9fj
	kXiIEGtiWXFl7iFGSQ4mJVHef90SIUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeH/4AuV4UxIr
	q1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4b/YDNQoWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSD4jS+GBipICkeoL0fQdp5iwsSc4GiEK2nGI05/i3/0MvEsa7z
	Wz+TEEtefl6qlDivDUipAEhpRmke3CJY+nvFKA70tzDvO5AqHmDqhJv3CmgVE9Cqsz1iIKtK
	EhFSUg2MZYobl0SJ7nriuiW2yX1isPIFgdKIj4udBNfKfdiyNjqwu5EzYMla18vV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257179>

* remove_lock_file() -> remove_lock_files()
* remove_lock_file_on_signal() -> remove_lock_files_on_signal()

Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 432d624..0b63554 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -73,7 +73,7 @@
=20
 static struct lock_file *volatile lock_file_list;
=20
-static void remove_lock_file(void)
+static void remove_lock_files(void)
 {
 	pid_t me =3D getpid();
=20
@@ -84,9 +84,9 @@ static void remove_lock_file(void)
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
@@ -162,8 +162,8 @@ static int lock_file(struct lock_file *lk, const ch=
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
