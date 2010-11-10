From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2] Documentation/git-pull: clarify configuration
Date: Wed, 10 Nov 2010 08:13:08 +0100
Message-ID: <1289373188-32543-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 10 14:14:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGAVM-0006QV-AO
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 14:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab0KJNOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 08:14:19 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57891 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab0KJNOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 08:14:18 -0500
Received: by gxk23 with SMTP id 23so310851gxk.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 05:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fbY4fwYitdgAQUXwE5fWKjX8cAL6aO8ZQHB9H/GJHSI=;
        b=JbnmLjcJ8V7oj6zW8X+6TFQcD9VIScvgIiivs7ZvhNkHFY7rWuyv82unWoHcAmrEq5
         BFTSL0Dut3SFyXZw38eEwbuR0eGZ/C/capvbSxf6HtK03LeVlEaLsV6wOk+7qkbbCMhm
         rRu+ow9Y6fBFes3dqgM8kmQBDpCA2gERuFvr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uTBmolJ+q7kS7U2KZvpfe+p4bFFC+vCmSB7zY2gY8uOUiOVMg9QB5ahryyReVRmbYQ
         L0sVYpujiGzq6ylLOHLyivZdxokFqq8a2mun6KBOBe9WTnxeqtjuijRtwhhB7vFtoec7
         krtNA0Wy3xnhUH8n8vfWGJRBysxyMIuRXJ0rU=
Received: by 10.42.226.1 with SMTP id iu1mr380524icb.303.1289394857494;
        Wed, 10 Nov 2010 05:14:17 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id j7sm159077vcr.39.2010.11.10.05.14.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 05:14:17 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161149>

The sentence about 'branch.<name>.rebase' refers to the first sentence
in the paragraph. Clarify by putting it in a separate paragraph.

Text provided by Jonathan Nieder.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 Documentation/git-pull.txt |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c50f7dc..055126e 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -92,12 +92,15 @@ include::merge-options.txt[]
 :git-pull: 1
 
 --rebase::
-	Instead of a merge, perform a rebase after fetching.  If
-	there is a remote ref for the upstream branch, and this branch
-	was rebased since last fetched, the rebase uses that information
-	to avoid rebasing non-local changes. To make this the default
-	for branch `<name>`, set configuration `branch.<name>.rebase`
-	to `true`.
+	Instead of merging, rebase the current branch on top of the
+	upstream branch after fetching.  If there is a remote-tracking
+	branch corresponding to the upstream branch and the upstream
+	branch was rebased since last fetched, the rebase uses that
+	information to avoid rebasing non-local changes.
+
+	The default behavior is to merge rather than rebasing, but it
+	can be overridden per branch with the `branch.<name>.rebase`
+	configuration item (see git-config(1)).
 +
 [NOTE]
 This is a potentially _dangerous_ mode of operation.
-- 
1.7.3.2.167.ga361b
