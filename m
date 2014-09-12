From: Jonh Wendell <jonh.wendell@gmail.com>
Subject: [PATCH 2/2] describe: Add documentation for "--abbrev=+"
Date: Fri, 12 Sep 2014 11:26:44 -0300
Message-ID: <1410532004-22769-3-git-send-email-jonh.wendell@gmail.com>
References: <1410532004-22769-1-git-send-email-jonh.wendell@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonh Wendell <jonh.wendell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 16:27:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSRoq-0005er-Dx
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 16:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbaILO1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 10:27:17 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:37618 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbaILO1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 10:27:16 -0400
Received: by mail-qa0-f42.google.com with SMTP id j7so788672qaq.29
        for <git@vger.kernel.org>; Fri, 12 Sep 2014 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7z3k3veen3AYol1YxIFAGffhW1vynvbXswP7vPGHBJY=;
        b=hoGLiiINyQrM9zjdTchR4TE1efB4LBub8KMG8hGSGpKECXfplDP2O97qh3tKnM6ocW
         c8Rtl5BcYzIUkPsLV2SCIwqE+9r3bvVVTC8I1Mme2Ko5RB1K05+v1V90JeiITiMA4vcb
         0lWXKjEeJV6gdT60oxfO3EEUvmVoFGG02XuA1j3eJxHAqqQFGSzMM4ec8IGcLRBwocU5
         6D0qpMdP3eYwIo+Yt2/4OfpRfvM+06srAo9BPTyfNqTvakkpYF3eNng4FzdyX2pyXwqP
         vwuhWY8xMTA2hfCkZWeQ5XddZg+Gj7IRNAL45cgYDTAqtJ/PgKSiqf0op57L+bu495VG
         AnYA==
X-Received: by 10.140.82.213 with SMTP id h79mr4951109qgd.51.1410532035474;
        Fri, 12 Sep 2014 07:27:15 -0700 (PDT)
Received: from wendell-laptop.spo.virtua.com.br ([189.102.225.80])
        by mx.google.com with ESMTPSA id y10sm3088066qar.29.2014.09.12.07.27.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Sep 2014 07:27:15 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1410532004-22769-1-git-send-email-jonh.wendell@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256925>

Signed-off-by: Jonh Wendell <jonh.wendell@gmail.com>
---
 Documentation/git-describe.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index d20ca40..e291770 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -54,6 +54,12 @@ OPTIONS
 	abbreviated object name, use <n> digits, or as many digits
 	as needed to form a unique object name.  An <n> of 0
 	will suppress long format, only showing the closest tag.
+	+
+	+
+	A special case of <n> equals to "\+" (without quotes) will print
+	just a "+" sign instead of the whole suffix. This is useful if you
+	only need to know if the supplied <commit-ish> points to an exact
+	match or if there are commits between the tag found and the <commit-ish>.
 
 --candidates=<n>::
 	Instead of considering only the 10 most recent tags as
-- 
1.9.3
