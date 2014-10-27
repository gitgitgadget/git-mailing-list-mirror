From: Roberto Decurnex <decurnex.roberto@gmail.com>
Subject: [PATCH] git-fetch.txt: Update over git fetch example on using `+`.
Date: Mon, 27 Oct 2014 17:39:16 -0300
Message-ID: <1414442356-25688-1-git-send-email-roberto.decurnex@avature.net>
Cc: Roberto Decurnex <decurnex.roberto@gmail.com>,
	"J . Bruce Fields" <bfields@citi.umich.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 21:40:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xir5W-0004RO-FQ
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 21:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbaJ0UkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 16:40:22 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:62715 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaJ0UkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 16:40:22 -0400
Received: by mail-qg0-f51.google.com with SMTP id j5so2322038qga.24
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4EMKbxQGiEQuvjApCArlc8BZjLCug7b+/+h9JTvaBO0=;
        b=rmTbN2RorA9xaCLLU+m7EprjNcUmfY8HGHO8Mq+9I2E1iTLZciMUKAi/efzrqmqeyY
         m6LD7NJ70rBpnMl8z896DqdYbc8akUjg6TXeV+eskvhiIXUYFdus9hBBq8gSDWK6RaGk
         FtWO+ilDoW5PY2+pbTTeQ+JNnW9LNfLyw4B0GudbVZRjange3kVkwSlbEu89HGVseDDn
         Ukee8DCaV7UU1VxztURVHYvNn0HlY/fCN9OJANC69ZGozgpicNJt/qRUZ9bxbzcrMQ3a
         khFGB2h++nU4ZKYXMHVHz87dXwBevtQm/60YpGpaUADmZOVQ5JKgC1trfDtjtQZLmwHR
         RkIQ==
X-Received: by 10.140.81.21 with SMTP id e21mr34637602qgd.45.1414442421469;
        Mon, 27 Oct 2014 13:40:21 -0700 (PDT)
Received: from nbba-rdecurnex (200-127-146-186.net.prima.net.ar. [200.127.146.186])
        by mx.google.com with ESMTPSA id g34sm9690226qge.18.2014.10.27.13.40.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 Oct 2014 13:40:20 -0700 (PDT)
X-Google-Original-From: Roberto Decurnex <roberto.decurnex@avature.net>
Received: from nbba-rdecurnex (localhost [127.0.0.1])
	by nbba-rdecurnex (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s9RKeHi5025993;
	Mon, 27 Oct 2014 17:40:17 -0300
Received: (from roberto@localhost)
	by nbba-rdecurnex (8.14.4/8.14.4/Submit) id s9RKeGuj025727;
	Mon, 27 Oct 2014 17:40:16 -0300
X-Mailer: git-send-email 2.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Roberto Decurnex <decurnex.roberto@gmail.com>

Making clear that `+` before a branch name will force the update even for non-fast-forward branches.

Signed-off-by: Roberto Decurnex <decurnex.roberto@gmail.com>
---
 Documentation/git-fetch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 8deb614..b971a2b 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -124,7 +124,7 @@ This updates (or creates, as necessary) branches `pu` and `tmp` in
 the local repository by fetching from the branches (respectively)
 `pu` and `maint` from the remote repository.
 +
-The `pu` branch will be updated even if it is does not fast-forward,
+The `pu` branch will be updated even if it is non-fast-forward,
 because it is prefixed with a plus sign; `tmp` will not be.
 
 * Peek at a remote's branch, without configuring the remote in your local
-- 
2.0.4
