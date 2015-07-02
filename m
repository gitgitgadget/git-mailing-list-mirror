From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH 4/4] git-log: update man documentation for --count
Date: Wed,  1 Jul 2015 22:38:56 -0700
Message-ID: <1435815536-30611-4-git-send-email-lawrencesiebert@gmail.com>
References: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
Cc: gitster@pobox.com, Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 07:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAXDq-0001dH-CK
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 07:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbbGBFjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 01:39:35 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35897 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbbGBFj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 01:39:26 -0400
Received: by ykdr198 with SMTP id r198so59122920ykd.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 22:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ImX71qlKAPgAmVJUPoYDxKGPZ944YvZOXAMcGZNk4ns=;
        b=Wnic+2q0BW5pPLd7JNZI9S1KSZ7ZM8L35mIq7fcQ2H6ISnF103IilGr1CXBdiDl0eA
         Y8Co1e8gz88AbbYol5HuyHxcRqWE/7dapjNQbwMX5LENCdffTeAgqXRSw1Z/knHwO/sh
         O2jASw3C7MrH0jQE+bDck9T0sDlJ1a8+n7tkGZixFC7ZXD2SknFQyoe2zfk0tiXJNN4Q
         p5J0jSqTtlWYWHyyyXVEMfjWOuWXc1TAb0tGRJU+suf5MnkArxtC9w3mlrPz4DibOTJN
         DIxwqZ/J5eg9lBo20Zv1T3M68poekimVHxSoveqF4+8X4CMeq4+y+w/RtetEn50pYFSY
         Dvbg==
X-Received: by 10.170.143.213 with SMTP id k204mr35756575ykc.91.1435815566030;
        Wed, 01 Jul 2015 22:39:26 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id m12sm4563641ywd.22.2015.07.01.22.39.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 22:39:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273214>

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
