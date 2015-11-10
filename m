From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 03/10] copy_msg(): rename to copy_reflog_msg()
Date: Tue, 10 Nov 2015 12:42:33 +0100
Message-ID: <d5951e1c72531c497febfb08f5425c5080218476.1447154711.git.mhagger@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:50:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7RO-0006vD-1o
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbbKJLuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:50:12 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43077 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752726AbbKJLuI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:50:08 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2015 06:50:07 EST
X-AuditID: 12074412-f79a76d000007c8b-f7-5641d840f718
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 41.1A.31883.048D1465; Tue, 10 Nov 2015 06:42:56 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABglj7014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:42:55 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqOtwwzHM4OBtDYv5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG2mHnV2qK37xOrA4fH3/cfmDx2zrrL7nH2YKbHs949jB4X
	Lyl77F+6jc1jwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGd0XuxiLujnrHi7oZ+tgXEZexcj
	J4eEgInE42N7WSFsMYkL99azdTFycQgJXGaU+PTnJzOEc4JJYmvPFTaQKjYBXYlFPc1MILaI
	gJrExLZDLCA2s8AyJolZe21BbGEBR4nJ69aC1bMIqEpsnn0PbAOvQJTElrZeJohtchJT7rcD
	2RwcnAIWEnPPZYCEhQTMJY63T2ScwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5u
	ZoleakrpJkZIKArtYFx/Uu4QowAHoxIPr8UXhzAh1sSy4srcQ4ySHExKorz7TzmGCfEl5adU
	ZiQWZ8QXleakFh9ilOBgVhLhtX8BVM6bklhZlVqUD5OS5mBREuf9uVjdT0ggPbEkNTs1tSC1
	CCYrw8GhJMHrfh1oqGBRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB
	2psC0s5bXJCYCxSFaD3FqCglzqsFkhAASWSU5sGNhSWYV4ziQF8K8zqDVPEAkxNc9yugwUxA
	g5f6gzxUXJKIkJJqYLT0MVnUvKy0rk3Yc19yByv76jQd46pJshsU9JYqs3Cu/xEcs1DtadeD
	69v4D6mc9Ji6Zs/UYOVahkf/Ltc/nXBf9I+I0MSjb3VtXr+YInbWW3Lx/sM3lu+7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281116>

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
