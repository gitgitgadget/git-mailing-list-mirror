From: Jonathan Lebon <jonathan.lebon@gmail.com>
Subject: [PATCH 1/4] diff-highlight: add `less -r` to cmd in README
Date: Mon,  2 Nov 2015 21:05:31 -0500
Message-ID: <1446516334-27652-2-git-send-email-jonathan.lebon@gmail.com>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Cc: peff@peff.net, Jonathan Lebon <jonathan.lebon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 03:06:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtQzU-00030D-Gx
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 03:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbbKCCGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 21:06:24 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33337 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbbKCCGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 21:06:21 -0500
Received: by qgeo38 with SMTP id o38so2387714qge.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 18:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BCrkzZ/AUr910tfg711f4Xg0atcywc5iDoX9yFjFuxE=;
        b=qMcE8P5HaUfktoJ0qhxszQzg+CyWpRt5VNx+iVX+Z+8QkpQn+84mp6XI2yiR5FEtdn
         2YYvNx45emTIyBsF4L/oG8RZt36NM581tr0GUCIop2j8e3+1fyXHTfD7hz5fD53tWJEZ
         w5mYbXEM3wb9YywAOuLKiIgHoBDkRFm7D7W9sswqwFHN843y4IkuEr6BUe63KtKr00Ay
         DWfLLzpOdwCzzvCFodgzakXkDquVVfCPR8OqzTx4SaiDBj9+0K+iiPUNGA4dehk230Dj
         M11UYeJCtXxRi8V5b9L7TZdP2UgVlham9PpNzar6hJm8HEIsH9vRTwuXqdeSBeq+XFKz
         MmAw==
X-Received: by 10.140.93.104 with SMTP id c95mr33228894qge.101.1446516380698;
        Mon, 02 Nov 2015 18:06:20 -0800 (PST)
Received: from vostro.yyz.redhat.com ([38.104.156.250])
        by smtp.gmail.com with ESMTPSA id s21sm9013447qkl.36.2015.11.02.18.06.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 18:06:20 -0800 (PST)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280741>

As it is, the suggested command for trying out diff-highlight will just
dump the whole git log output to the terminal. Let's pipe it through
`less` so users aren't surprised on the first try.

Signed-off-by: Jonathan Lebon <jonathan.lebon@gmail.com>
---
 contrib/diff-highlight/README | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
index 836b97a..bbbfdda 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -44,9 +44,9 @@ Use
 
 You can try out the diff-highlight program with:
 
----------------------------------------------
-git log -p --color | /path/to/diff-highlight
----------------------------------------------
+------------------------------------------------------
+git log -p --color | /path/to/diff-highlight | less -r
+------------------------------------------------------
 
 If you want to use it all the time, drop it in your $PATH and put the
 following in your git configuration:
-- 
2.6.0
