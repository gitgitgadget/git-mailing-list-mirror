From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 30/33] Added a short style guide, and Emacs settings.
Date: Mon, 19 May 2014 00:00:06 +0200
Message-ID: <1400450409-30998-31-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:13:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Kx-0002rI-EE
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbaERWNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:13:40 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:64691 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbaERWNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:13:39 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so3474799lab.11
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gpm6oXTM+6RoBzM4dNyUxc8EyGKrlJQpAxMcXT1RFtE=;
        b=DS6VjSvRXj4zZWa+HYrRn2of6Oq30SHniosVq+qBt09NxWGzoaT9TFVHoRSVfWdmpH
         1Yy+tRPZEN6NfWKeaAuMIze+NaLyvLQx9SvyA682P4pJxGJjLl6a8v9mpSqT9EhKgYp7
         tZFiscmC2VfJbQBCYpn2VQe5V4pTYYjJ3PB+KTj23kv9uU3iscQCzOjSvTLuNNbkuOGB
         eACsO0rtjkajHHvcLCY7a9oHk2t2DmPVYtkmad0N62R/T9aYxLKd8jG5vNQrsNbnrYRD
         bOXRckcVlChKG4KNBOcNRyqUDVmafONKc5b6lkrlkq4QCkTVIG4WYOn+BVZkrl+tSUPP
         HaLQ==
X-Gm-Message-State: ALoCoQmyki511kab2gfBsgf8WevlgoJoAUyfPvylFijJ3H3HtRZX0VyhLivfQniLxYesndWb1dA/
X-Received: by 10.152.87.136 with SMTP id ay8mr6828624lab.42.1400451218094;
        Sun, 18 May 2014 15:13:38 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.13.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:13:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249545>

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
