From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 04/11] copy_msg(): rename to copy_reflog_msg()
Date: Mon,  9 Nov 2015 18:03:41 +0100
Message-ID: <482af811a0f3ed88740a0d1a3c62e925991decf3.1447085798.git.mhagger@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:11:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvpyc-00060m-OU
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbbKIRL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:11:28 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46278 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752177AbbKIRLY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:11:24 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2015 12:11:24 EST
X-AuditID: 12074414-f794f6d000007852-b0-5640d20bd341
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id AA.2D.30802.B02D0465; Mon,  9 Nov 2015 12:04:11 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Yr026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:10 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqMt9ySHM4Ps/TYv5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG26O37xOrA7vH3/Qcmj52z7rJ7nD2Y6fGsdw+jx8VLyh4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO6PzYhdzQT9nxdsN/WwNjMvYuxg5OCQETCR6duZ0
	MXICmWISF+6tZ+ti5OIQErjMKPHk+loWCOcEk8SRxq8sIFVsAroSi3qamUBsEQE1iYlth8CK
	mAU+MkrM/bEQLCEs4CjRdu4PK8gGFgFViakfNEDCvAJREld+fGaF2CYnMeV+O1g5p4CFxI4T
	/xhBbCEBc4mJq9YwTWDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMj
	JPBEdjAeOSl3iFGAg1GJhzdipn2YEGtiWXFl7iFGSQ4mJVHe6BMOYUJ8SfkplRmJxRnxRaU5
	qcWHGCU4mJVEeAt2AeV4UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR4
	ky8ANQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIiO+GBgbICkeoL22IO28xQWJ
	uUBRiNZTjIpS4hBzBUASGaV5cGNh6eQVozjQl8K8BheBqniAqQiu+xXQYCagwUv9wQaXJCKk
	pBoYRfZoLgq7qrq6/P/fuSHtf9K4NnE9CNXccOToNm19Sy+eFo0LGpHrFnNduBq0UO//lAu9
	j1RvMxYqXzJQPmL7fI/3Q9bD3XMTvyyaW/X7KGf67qTEyJjgGwyHA4JfHWyvWvrF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281065>

From: David Turner <dturner@twopensource.com>

We will soon increase the visibility of this function, so make its name
more distinctive.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index ddcdf81..480de9a 100644
--- a/refs.c
+++ b/refs.c
@@ -3287,7 +3287,7 @@ static int commit_ref(struct ref_lock *lock)
  * large, while cleaning up the whitespaces.  Especially, convert LF to space,
  * because reflog file is one line per entry.
  */
-static int copy_msg(char *buf, const char *msg)
+static int copy_reflog_msg(char *buf, const char *msg)
 {
 	char *cp = buf;
 	char c;
@@ -3391,7 +3391,7 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 			sha1_to_hex(new_sha1),
 			committer);
 	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
+		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
 
 	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 	free(logrec);
-- 
2.6.2
