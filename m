From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 29/29] Added a short style guide, and Emacs settings.
Date: Tue, 13 May 2014 22:31:05 +0200
Message-ID: <1400013065-27919-30-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:38:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJSu-0000Zn-Br
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbaEMUiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:38:14 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50140 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbaEMUiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:38:11 -0400
Received: by mail-lb0-f171.google.com with SMTP id 10so720000lbg.30
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esb1b0gLKkBLKAADjF3XQG/2tK1M56Xnx3tSO3CVCdY=;
        b=AS4aSnoe5J2L9KThNiytp7N3WQ/SpLoufhCdODBIYeGn2jKXX+nQ4igMPpQfaSH9uf
         oSJRVMhCyzifBZQ10az7tc8oKAcxRtSy1yq/13gBH/rtyH+kdVMyBX7ehJ1Pkwhli0NN
         mT9H++6FLNGZPov7KNhM3sDO8ls1o6985qRzFGVsUSrvpeilI+40koc6XXP/fQQu9W4z
         IJe6y9nBiEV0ewX6vog+SlIvF5VLsgFOYLsDy4kgj0VQkcFTzSIRH+jF78mEYYoX/d3O
         W69CX9X4wb91xHOVDj9oi+r7+7r6ymSjqv2NXLehO94zk51iCKETMbFd99s2kQ9eGrO4
         XKgQ==
X-Gm-Message-State: ALoCoQly3ClB0j+0RtZLgR+ucZm0hMmgbDJIyY4CfnVBt4Q9k/kEG6tC1RNMVIa44yCW1bQEgq3V
X-Received: by 10.152.197.69 with SMTP id is5mr14252902lac.10.1400013490181;
        Tue, 13 May 2014 13:38:10 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:38:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248846>

Signed-off-by: Per Cederqvist <cederp@opera.com>
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
