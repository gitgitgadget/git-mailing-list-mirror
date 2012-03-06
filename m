From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCHv2 3/3] Documentation/git-branch: add default for --contains
Date: Tue,  6 Mar 2012 10:32:45 +0100
Message-ID: <1331026365-7044-3-git-send-email-user@vincent-VirtualBox>
References: <1331023866-5658-1-git-send-email-vfr@lyx.org>
 <1331026365-7044-1-git-send-email-user@vincent-VirtualBox>
Mime-Version: 1.0
Cc: trast@inf.ethz.ch, gitster@pobox.com,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 10:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qmd-0007ZC-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 10:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758442Ab2CFJeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 04:34:03 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35114 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758302Ab2CFJdc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 04:33:32 -0500
Received: by mail-ee0-f46.google.com with SMTP id c41so1810023eek.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 01:33:32 -0800 (PST)
Received-SPF: pass (google.com: domain of  designates 10.14.45.72 as permitted sender) client-ip=10.14.45.72;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of  designates 10.14.45.72 as permitted sender) smtp.mail=
Received: from mr.google.com ([10.14.45.72])
        by 10.14.45.72 with SMTP id o48mr13144973eeb.110.1331026412144 (num_hops = 1);
        Tue, 06 Mar 2012 01:33:32 -0800 (PST)
Received: by 10.14.45.72 with SMTP id o48mr9992763eeb.110.1331026412015;
        Tue, 06 Mar 2012 01:33:32 -0800 (PST)
Received: from localhost.localdomain (wlan-145-94-169-074.wlan.tudelft.nl. [145.94.169.74])
        by mx.google.com with ESMTPS id d54sm26363433eei.9.2012.03.06.01.33.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 01:33:31 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1331026365-7044-1-git-send-email-user@vincent-VirtualBox>
X-Gm-Message-State: ALoCoQnyebcCqLcHT0IiZXkr85XHcROFqkUvGNTnKWtYo/RfWr4ewDo9KgKdYPUlpFn8hLSW+8zi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192324>

From: Vincent van Ravesteijn <vfr@lyx.org>

Indicate that the commit parameter of --contains defaults to HEAD.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Documentation/git-branch.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index cfceac5..6410c3d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -163,8 +163,9 @@ start-point is either a local or remote-tracking branch.
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
 
---contains <commit>::
-	Only list branches which contain the specified commit.
+--contains [<commit>]::
+	Only list branches which contain the specified commit (HEAD
+	if not specified).
 
 --merged [<commit>]::
 	Only list branches whose tips are reachable from the
-- 
1.7.5.4
