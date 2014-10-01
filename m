From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 34/38] lockfile.c: rename static functions
Date: Wed,  1 Oct 2014 12:28:38 +0200
Message-ID: <1412159322-2622-35-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAR-0002pF-Ra
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbaJAK3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 06:29:49 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47506 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751762AbaJAK3s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:48 -0400
X-AuditID: 1207440c-f79036d000005e77-76-542bd79b8067
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E0.68.24183.B97DB245; Wed,  1 Oct 2014 06:29:47 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6X026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:46 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsUixO6iqDv7unaIQfc/PYuuK91MFg29V5gt
	nsy9y2zx9uYSRovbK+YzW/xo6WG2+DehxqKz4yujA4fH3/cfmDx2zrrL7rFgU6nHw1dd7B7P
	evcwely8pOzxeZOcx+1n21gCOKK4bZISS8qCM9Pz9O0SuDOOPd3GWnCWs2LyTO0Gxt/sXYyc
	HBICJhI/P3VA2WISF+6tZwOxhQQuM0rMWiXcxcgFZB9nkrjT08cCkmAT0JVY1NPMBGKLCKhJ
	TGw7xAJSxCywmEliwqFNYN3CArYSfxZ/ZQWxWQRUJe7OPQLWwCvgIrFw1xlGiG1yEht2/wez
	OYHiyy83s0BsdpbYcecrVL2gxMmZT4DiHEAL1CXWzxMCCTMLyEs0b53NPIFRYBaSqlkIVbOQ
	VC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuol5tZopeaUrqJERIXPDsYv62TOcQowMGo
	xMOrkKAdIsSaWFZcmXuIUZKDSUmUd9EloBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3uwDQDne
	lMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvlGtAjYJFqempFWmZOSUI
	aSYOTpDhXFIixal5KalFiaUlGfGgKI0vBsYpSIoHaO9OkHbe4oLEXKAoROspRmOOf8s/9DJx
	rOv81s8kxJKXn5cqJc6bCVIqAFKaUZoHtwiWEF8xigP9Lcx7AaSKB5hM4ea9AlrFBLQqeQ3Y
	qpJEhJRUA+My3W/5J7br8MzYGBp9m7EiXVA07GPxWftbD/PChHdzbDq9eQrnKpOb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257716>

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
