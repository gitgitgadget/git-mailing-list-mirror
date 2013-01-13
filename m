From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC 1/7] contrib/subtree: Add vim modeline
Date: Sun, 13 Jan 2013 09:52:32 +0800
Message-ID: <1358041958-1998-2-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 13 02:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuCr4-0000pC-45
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 02:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239Ab3AMB7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 20:59:00 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49228 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213Ab3AMB7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 20:59:00 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so1571802pbc.33
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 17:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ujinRP++ZKJ6f6mKgER4FxT65SUtS8gY5EsGqa/rikQ=;
        b=cGU9hZs03Xcupc+xjgJ2i3WqgbEbxsi4rjN6obpvWMgTJ7rVcphNeDdgr4C/RykkVv
         p1olvIltKoLwKYnxdZ/aH7KmC29aaz23cgsDdSwK7D4jNte6qwy2YRlBArJz8zHFivAJ
         oFYZcL9Z/xgcpzSaBfWEbUTbkUFI1M8Tgo8TKJrKYJg9KUup6UJDG1LwMFx/5uaYwoU3
         v8V2ezIO1HKQK9dDJO6P2Q24C+G+mn2iuNxc7wC7f23CjCtuYvo3Jcj4k5Ck6gcyZy9p
         pHu7wRxU1yYueNi5dncrrIv3riM5R4c0KggKTawMU5Vd+ZpLNCqNlFxejcmWmLFE0hhq
         4yYA==
X-Received: by 10.68.83.68 with SMTP id o4mr245065853pby.25.1358042339883;
        Sat, 12 Jan 2013 17:58:59 -0800 (PST)
Received: from home.techlive.me ([122.244.155.16])
        by mx.google.com with ESMTPS id d8sm5908882pax.23.2013.01.12.17.58.26
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 17:58:59 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213321>

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/git-subtree.sh     | 2 ++
 contrib/subtree/t/t7900-subtree.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 920c664..138e1e0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -710,3 +710,5 @@ cmd_push()
 }
 
 "cmd_$command" "$@"
+
+# vim: set ts=4 sw=4 noet
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index bc2eeb0..3e02aeb 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -506,3 +506,5 @@ test_expect_success 'verify one file change per commit' '
 '
 
 test_done
+
+# vim: set et ts=4 sw=4
-- 
1.8.1
