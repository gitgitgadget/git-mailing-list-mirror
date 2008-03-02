From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation: Remove --{min,max}-age option from git-log(1)
Date: Sun,  2 Mar 2008 15:11:35 +0100
Message-ID: <1204467095-24701-1-git-send-email-jnareb@gmail.com>
References: <715587AA-D485-4B31-A786-D26334506007@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 15:12:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVovG-0002jn-B0
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 15:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbYCBOLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 09:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbYCBOLi
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 09:11:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:12431 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbYCBOLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 09:11:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1408043ugc.16
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 06:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uECSkLRP2pKfVxKhEUafMW2h8C5QWL85Au2+Xv52Rvo=;
        b=TBCWEATgtwUWZYq1JY+4ylAI7me2S7M9PNburrxoOxOzf/YUAR4KzmIYm2S3afM6mDuUB2ZsvRsaYXq47Q6LTrXfbHdlZ/VmTlo3EeZxYLnRpgqBZmgMoOpj8fBTg8LJiUOr3xVplsS0DL8Cj8/IqNyHVtRzsQ4tUmUpKruPm9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xXwJlws2YbL8+JSf/wN0wXm+oRQfqVYUcpy+04Jg2WC1sGGivuDtyIr54u6JDsEj3+Xno8Q0qZabsJkm/MO+qGTXQIWqnfMsmYc8BPnjiRN4yLBUGF7XNwZ91t876Z1HK7Op+L9hfTFOw8UTEp3yKJtoAtcQ70bsaP4y+VxbfOA=
Received: by 10.78.133.2 with SMTP id g2mr15217162hud.33.1204467095747;
        Sun, 02 Mar 2008 06:11:35 -0800 (PST)
Received: from localhost.localdomain ( [83.8.212.124])
        by mx.google.com with ESMTPS id z33sm20665514ikz.0.2008.03.02.06.11.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 06:11:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m22EBaDs024735;
	Sun, 2 Mar 2008 15:11:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m22EBZM1024734;
	Sun, 2 Mar 2008 15:11:35 +0100
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <715587AA-D485-4B31-A786-D26334506007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75780>

The --max-age=<timestamp> and --min-age=<timestamp> are now shown only
in the git-rev-list manpage (plumbing).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/rev-list-options.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a8138e2..c62ff49 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -130,9 +130,11 @@ limiting may be applied.
 
 	Show commits older than a specific date.
 
+ifdef::git-rev-list[]
 --max-age='timestamp', --min-age='timestamp'::
 
 	Limit the commits output to specified time range.
+endif::git-rev-list[]
 
 --author='pattern', --committer='pattern'::
 
-- 
1.5.4.2

