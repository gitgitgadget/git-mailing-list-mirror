From: David Symonds <dsymonds@gmail.com>
Subject: [REPLACEMENT PATCH] Rearrange git-format-patch synopsis to improve clarity.
Date: Tue,  6 Nov 2007 10:04:24 +1100
Message-ID: <1194303864671-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:04:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpAzz-00009i-LF
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXKEXEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbXKEXEf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:04:35 -0500
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:32417 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750741AbXKEXEf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 18:04:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAC4wL0d5LCBH/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,374,1188743400"; 
   d="scan'208";a="181862922"
Received: from ppp121-44-32-71.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.32.71])
  by ipmail03.adl2.internode.on.net with ESMTP; 06 Nov 2007 09:34:30 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63582>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 Documentation/git-format-patch.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 92c0ab6..9d4bae2 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,9 +9,10 @@ git-format-patch - Prepare patches for e-mail submission
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -N | -k] [-o <dir> | --stdout] [--thread]
+'git-format-patch' [-k] [-o <dir> | --stdout] [--thread]
                    [--attach[=<boundary>] | --inline[=<boundary>]]
                    [-s | --signoff] [<common diff options>]
+                   [-n | --numbered | -N | --no-numbered]
                    [--start-number <n>] [--numbered-files]
                    [--in-reply-to=Message-Id] [--suffix=.<sfx>]
                    [--ignore-if-in-upstream]
-- 
1.5.3.1
