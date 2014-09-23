From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] de.po: Fixup one translation
Date: Tue, 23 Sep 2014 09:37:27 +0200
Message-ID: <1411457847-10419-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: ralf.thielow@googlemail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 09:37:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWKfQ-0001RL-Qm
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 09:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbaIWHhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 03:37:40 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38812 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbaIWHhk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 03:37:40 -0400
Received: by mail-wi0-f178.google.com with SMTP id z2so4428625wiv.5
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LbQKXGxmTvEhFgdqNSw5lXMpJSbCZ9hDjOi5y9VxhfY=;
        b=mZx9DiKiquYgCGoji82EpmnbzBjzDkN1AYyeD4jxa4DvOnfgLTImpSG6hm0u6fWKVw
         ecyynKl+a41UKc60vLzupo6jlIiKQ9xX83+1ENXczLk1Twe1WcSfEy8FQdJB/wmP1d/c
         rYyfmPjNkOiGuIzbZtu92Ryy38jaY0tPUC78QIfGHSreSh6modJA8LEBCONmtOQnDyyJ
         XCdDLtaiLm91XvUYLunidm9ncS/+9hInoxoG4B5CKViNCWrKdSCuEnXBiAY4ihVeGma8
         R/jj6od0FINrsaYUgx7wdTZNfFa2G0KE+azK9t/Zx4nXe6UMlC0PyrG3BpmLWuHi8tX4
         fQRA==
X-Received: by 10.180.9.73 with SMTP id x9mr1248507wia.20.1411457858538;
        Tue, 23 Sep 2014 00:37:38 -0700 (PDT)
Received: from localhost (p5B095AC8.dip0.t-ipconnect.de. [91.9.90.200])
        by mx.google.com with ESMTPSA id u7sm1264497wif.7.2014.09.23.00.37.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Sep 2014 00:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.238.gce1d3a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257395>

English grammar with German words doesn't make it a German translation. ;)
We also need to fix the

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 po/de.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/po/de.po b/po/de.po
index e5d2b25..bae3723 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3463,13 +3463,13 @@ msgid_plural ""
 "\n"
 "%s\n"
 msgstr[0] ""
-"Warnung: Sie sind um %d Commit hinterher, nicht verbunden zu\n"
-"einem Ihrer Branches:\n"
+"Warnung: Sie sind um %d Commit hinterher, folgende Commits sind in\n"
+"keinem Ihrer Branches enthalten: \n"
 "\n"
 "%s\n"
 msgstr[1] ""
-"Warnung: Sie sind um %d Commits hinterher, nicht verbunden zu\n"
-"einem Ihrer Branches:\n"
+"Warnung: Sie sind um %d Commits hinterher, folgende Commits sind in\n"
+"keinem Ihrer Branches enthalten: \n"
 "\n"
 "%s\n"
 
-- 
2.1.0.238.gce1d3a9
