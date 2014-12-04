From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/23] expire_reflog(): remove unused parameter
Date: Fri,  5 Dec 2014 00:08:16 +0100
Message-ID: <1417734515-11812-5-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:08:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfW3-0002oj-W3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320AbaLDXIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:08:50 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60069 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933299AbaLDXIt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:49 -0500
X-AuditID: 1207440e-f79d26d000001b6e-89-5480e97f52de
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id FA.67.07022.F79E0845; Thu,  4 Dec 2014 18:08:47 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de1027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:46 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqFv/siHE4Os1a4uuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xpUTYQVreCue/JvN1sB4n6uLkZNDQsBE4s/kLcwQtpjEhXvr2boYuTiEBC4z
	Ssy90M4I4Rxjkmg6ehCsik1AV2JRTzMTiC0ioCYxc9VssA5mgROMEr8mdzOCJIQF7CXePr8B
	VsQioCqx9+dvoGYODl4BF4m/V7RATAkBOYmt67xBKjgFXCWmzmwF6xQCqni2aSH7BEbeBYwM
	qxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCAotvB2P7eplDjAIcjEo8vAW7
	60OEWBPLiitzDzFKcjApifKefdoQIsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE1/gIUI43JbGy
	KrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMFb+gKoUbAoNT21Ii0zpwQhzcTB
	CTKcS0qkODUvJbUosbQkIx4UF/HFwMgASfEA7S0DaectLkjMBYpCtJ5iVJQS57UGSQiAJDJK
	8+DGwtLFK0ZxoC+FIbbzAFMNXPcroMFMQIPPNtSCDC5JREhJNTCqsKpuPxaTJGLWus9thmHw
	tz1KDQ9tP7xvPMq69cQ7kRpOredtIj/YXktHnJwctOi8ldS2la7fr7feslIT1mw7+eTfUS6h
	qoJNS2evf2azUGo1x+Qr3kFXExPzRZ4kHItn1lYW2W8tK8jmuvGx78HAyBP9XE/V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260811>

It was called "unused", so at least it was self-consistent.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2d85d26..3e11bee 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -349,7 +349,7 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 	return 0;
 }
 
-static int expire_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
+static int expire_reflog(const char *ref, const unsigned char *sha1, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
@@ -663,7 +663,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
-			status |= expire_reflog(e->reflog, e->sha1, 0, &cb);
+			status |= expire_reflog(e->reflog, e->sha1, &cb);
 			free(e);
 		}
 		free(collected.e);
@@ -677,7 +677,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		set_reflog_expiry_param(&cb, explicit_expiry, ref);
-		status |= expire_reflog(ref, sha1, 0, &cb);
+		status |= expire_reflog(ref, sha1, &cb);
 	}
 	return status;
 }
@@ -748,7 +748,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.expire_total = 0;
 		}
 
-		status |= expire_reflog(ref, sha1, 0, &cb);
+		status |= expire_reflog(ref, sha1, &cb);
 		free(ref);
 	}
 	return status;
-- 
2.1.3
