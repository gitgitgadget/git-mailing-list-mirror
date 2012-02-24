From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 1/2] CodingGuidelines: Add a note about spaces after redirection
Date: Fri, 24 Feb 2012 16:12:00 -0500
Message-ID: <1330117921-8257-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 27 18:42:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S24b9-0000Yi-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 18:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab2B0Rmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 12:42:50 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43502 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab2B0Rmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 12:42:50 -0500
Received: by vcqp1 with SMTP id p1so1717979vcq.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 09:42:49 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.220.142.82 as permitted sender) client-ip=10.220.142.82;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.220.142.82 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.220.142.82])
        by 10.220.142.82 with SMTP id p18mr9271830vcu.5.1330364569455 (num_hops = 1);
        Mon, 27 Feb 2012 09:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cq/1fQwW3cHTdQYrUY1pfSWSTkCwFnhTPDKm34xpruI=;
        b=Lv1bijvfSwWHknN48MK1jabcEyr6riA9RuCSkGTIMSWEL1PGcYzAlQukdp4xG7dF7s
         BEWvwWw04Mw/Lpjz8pw2ijkAurtwrKpERQVTuYdfOthRqmvIJ05BDL+v3+Y+zjbut+QE
         7wg1qM5pPUtnmjZfzMIfmI4h8Onz9acWcbVFQ=
Received: by 10.220.142.82 with SMTP id p18mr7465482vcu.5.1330364569351;
        Mon, 27 Feb 2012 09:42:49 -0800 (PST)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id q18sm11548739vdi.10.2012.02.27.09.42.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 09:42:48 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191634>

During code review of some patches, it was noted that redirection operators
should have space before, but no space after them.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 Documentation/CodingGuidelines |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4830086..a4ffe7c 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -35,6 +35,11 @@ For shell scripts specifically (not exhaustive):
 
  - Case arms are indented at the same depth as case and esac lines.
 
+ - Redirection operators should be written with space before, but
+   no space after them.  For example:
+      'echo test >$file'  is preferred over
+      'echo test > $file'
+
  - We prefer $( ... ) for command substitution; unlike ``, it
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
-- 
1.7.9.1
