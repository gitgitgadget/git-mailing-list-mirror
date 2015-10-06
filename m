From: David Turner <dturner@twopensource.com>
Subject: [PATCH] error message typo fixes: unkown -> unknown
Date: Tue,  6 Oct 2015 16:00:33 -0400
Message-ID: <1444161633-1816-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 22:00:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjYPt-0007NS-3U
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 22:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbbJFUAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 16:00:48 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36715 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbbJFUAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 16:00:47 -0400
Received: by qgx61 with SMTP id 61so185044972qgx.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 13:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QDZIzBLKUxO1f3U5pRoLhI4gV8W4A2lBQCC0+ZX1Oek=;
        b=jB0x1uV++fEqiC0mU1KWvLppeVDrkYE3w0KycIEX3a7lpReCPnvZR1xk6bVbbo1KQP
         btvSVDIipG6RvaGOkEc0lVOW/3rdqsUpvyvJrLS509Doabu2JROT1UGHpsUvzKHVGV2O
         F6oqEgI0KbFvysJLe6LsN2yOChd1BZ3sIMuKJJGqLPkYsLsLvVqvv2JvqSy6PWzqibS5
         3pQ7+VDIapYFQwvDDDDU54Zsl/ONGgsYqTbdcFCJgrHdwx0ypKDVnU3OMAqvJNUKtl8b
         aiZOwfuVL8Tu0PnVZ+kvAe7dqGS5ZQIwjJAZy9l+02FT+BE+M6VyJFLrIH+AM/Zt6WTw
         HZmg==
X-Gm-Message-State: ALoCoQk4iPVaSykxUWqHcsKiJ7sMyfLbisFFgxyGVwF9P1r7Z/16GAfx06cwT6+5X1C/oF5d83Ii
X-Received: by 10.140.35.75 with SMTP id m69mr50393525qgm.39.1444161647169;
        Tue, 06 Oct 2015 13:00:47 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id g197sm14495004qhc.35.2015.10.06.13.00.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Oct 2015 13:00:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279165>

Fix two instances of a typo in user-visible error messages.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 connect.c   | 2 +-
 sha1_file.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index ced4961..d3283b8 100644
--- a/connect.c
+++ b/connect.c
@@ -255,7 +255,7 @@ static const char *prot_name(enum protocol protocol)
 		case PROTO_GIT:
 			return "git";
 		default:
-			return "unkown protocol";
+			return "unknown protocol";
 	}
 }
 
diff --git a/sha1_file.c b/sha1_file.c
index d295a32..bb5a3b8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1719,7 +1719,7 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 		strbuf_add(oi->typename, type_buf, type_len);
 	/*
 	 * Set type to 0 if its an unknown object and
-	 * we're obtaining the type using '--allow-unkown-type'
+	 * we're obtaining the type using '--allow-unknown-type'
 	 * option.
 	 */
 	if ((flags & LOOKUP_UNKNOWN_OBJECT) && (type < 0))
-- 
2.4.2.644.g97b850b-twtrsrc
