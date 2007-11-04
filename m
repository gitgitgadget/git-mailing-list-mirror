From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] Rearrange git-format-patch synopsis to improve clarity.
Date: Mon,  5 Nov 2007 09:27:05 +1100
Message-ID: <119421522591-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 23:27:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IonwV-00041X-8H
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 23:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbXKDW11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 17:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbXKDW11
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 17:27:27 -0500
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:13986 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752983AbXKDW10 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 17:27:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAHrTLUd5LCBH/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,369,1188743400"; 
   d="scan'208";a="181185228"
Received: from ppp121-44-32-71.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.32.71])
  by ipmail03.adl2.internode.on.net with ESMTP; 05 Nov 2007 08:57:10 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63451>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 Documentation/git-format-patch.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 92c0ab6..d8a89a1 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,10 +9,11 @@ git-format-patch - Prepare patches for e-mail submission
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -N | -k] [-o <dir> | --stdout] [--thread]
+'git-format-patch' [-k] [-o <dir> | --stdout] [--thread]
                    [--attach[=<boundary>] | --inline[=<boundary>]]
                    [-s | --signoff] [<common diff options>]
-                   [--start-number <n>] [--numbered-files]
+                   [-n | --numbered-files | -N | --no-numbered]
+                   [--start-number <n>]
                    [--in-reply-to=Message-Id] [--suffix=.<sfx>]
                    [--ignore-if-in-upstream]
                    [--subject-prefix=Subject-Prefix]
-- 
1.5.3.1
