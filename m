From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH v2 4/4] git-log: update man documentation for --count
Date: Thu,  2 Jul 2015 16:50:11 -0700
Message-ID: <1435881011-13879-5-git-send-email-lawrencesiebert@gmail.com>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr, gitster@pobox.com,
	Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 01:50:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAoFu-0005H0-4h
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 01:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbbGBXuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 19:50:54 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36296 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002AbbGBXup (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 19:50:45 -0400
Received: by ykdr198 with SMTP id r198so82511920ykd.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ImX71qlKAPgAmVJUPoYDxKGPZ944YvZOXAMcGZNk4ns=;
        b=Yp8OW47kwd93EWad7oKWb8/tCAnTKN2qa3qWeoB6woYN0Ezz/KPNgyQAgQcVHnbaNY
         H1rEJCo1GR59OFvSsz2be+W8JTPUUAIuJe1d9FzAqLYBXWKO6l0SPuYkI4Do5XTM1UJK
         9DolojFUXHCa4FMcadlWgWJyhLG2q8AZi+NdxMdD5A+S+bpBpKnM5bpdM+xYJ7/9TmOv
         WDCOdXVpdCzsEP7jeeCjk6RfeAtdCide0nNOV2rE1hxaIG5aofWXt6IfXiTXUwOMXdv1
         USUyqQqH558ZsZVcwDITiSskq0vBxeJNX8EJ0xWTxs5uPOWMsK+K7R7wn9xIbZtJN9Gl
         0aMQ==
X-Received: by 10.13.252.6 with SMTP id m6mr42366596ywf.83.1435881044636;
        Thu, 02 Jul 2015 16:50:44 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id b131sm7190938ywc.18.2015.07.02.16.50.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 16:50:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273277>

I'm not altogether sure the best way to update the internal usage
from git-log -h, but this at least updates the man page.

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 Documentation/git-log.txt          | 2 ++
 Documentation/rev-list-options.txt | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5692945..0e10e44 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -90,6 +90,8 @@ include::line-range-format.txt[]
 Paths may need to be prefixed with ``\-- '' to separate them from
 options or the revision range, when confusion arises.
 
+
+:git-log: 1
 include::rev-list-options.txt[]
 
 include::pretty-formats.txt[]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 77ac439..f4e15fb 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -797,7 +797,7 @@ This implies the `--topo-order` option by default, but the
 	in between them in that case. If `<barrier>` is specified, it
 	is the string that will be shown instead of the default one.
 
-ifdef::git-rev-list[]
+ifdef::git-log,git-rev-list[]
 --count::
 	Print a number stating how many commits would have been
 	listed, and suppress all other output.  When used together
-- 
1.9.1
