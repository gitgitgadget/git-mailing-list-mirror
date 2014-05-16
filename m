From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 30/31] Added a short style guide, and Emacs settings.
Date: Fri, 16 May 2014 16:46:17 +0200
Message-ID: <1400251578-17221-31-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:57:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJZJ-0004dr-N9
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbaEPO5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:57:01 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:62639 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481AbaEPO5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:57:00 -0400
Received: by mail-lb0-f180.google.com with SMTP id p9so1981557lbv.25
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gpm6oXTM+6RoBzM4dNyUxc8EyGKrlJQpAxMcXT1RFtE=;
        b=RzpTj2fNCJR98dkVk3FD91QcIIcbGGPVTaJNMrE3Ha5dY4+awMwHaKRaURCXJEwjvf
         8qhKqoozn6NhnUcevEbBEqCoRrdWqPvQQmReVqpXTEHX5hyyhorJ3jEYFqknDntgMRMM
         SOhuum+rzCo9bReKHkwf9pOp0T6gbfuc4J8usahI9Qx0y6G3uW0g4fsbiRQhJymER6JA
         AJgk2MeBm7/+mwK31I4a5A/TseS7YIEkrRjODywoabn7PHU0CDqQ/SuoEMFgJwntwbnH
         6GoqDZ/FfZoIeQiCU++e4tBnkMCERKsgHlphrmTEk26aqJg9JVVcZHE6eocM5kWhpiRL
         M4QQ==
X-Gm-Message-State: ALoCoQmqCqX1mMRDb7Q3YsknB/qUbePu6kY7oLLbKezsJF6aqbk7b8YbPzREnAI0jmdHxSlAzGdy
X-Received: by 10.152.203.129 with SMTP id kq1mr12467377lac.6.1400252218982;
        Fri, 16 May 2014 07:56:58 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.56.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:56:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249339>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 .dir-locals.el             |  3 +++
 Documentation/Contributing | 15 +++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 .dir-locals.el

diff --git a/.dir-locals.el b/.dir-locals.el
new file mode 100644
index 0000000..50ef2b7
--- /dev/null
+++ b/.dir-locals.el
@@ -0,0 +1,3 @@
+((nil . ((indent-tabs-mode . t)
+	 (tab-width . 8)))
+ (sh-mode . ((sh-basic-offset . 8))))
diff --git a/Documentation/Contributing b/Documentation/Contributing
index abf3480..0da49d6 100644
--- a/Documentation/Contributing
+++ b/Documentation/Contributing
@@ -4,6 +4,21 @@ Documentation/SubmittingPatches file. :)
 
 1) Hack on the code a bit
 
+Please follow this style guide:
+
+ - Use tabs for indentation.
+
+ - Put "then" on the same line as "if".
+
+ - Follow the style of the existing code, except if it breaks the
+   above guidlines.
+
+ - If you change the code to conform to the style guide, please do so
+   in a separate commit that does not change anything else.
+
+Please check that you change does not break "make test".  Please add
+new testcases for any new functionality, and if you fix a bug.
+
 2) Make a patch:
 
 Use "diff -up" or "diff -uprN" to create patches. Or simply use git to
-- 
1.8.3.1
