From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Documentation/merge-strategies: avoid hyphenated commands
Date: Sun, 16 Mar 2014 18:54:56 -0400
Message-ID: <1395010496-20383-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 23:54:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPJx9-0004su-0U
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 23:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbaCPWyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 18:54:18 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:42453 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbaCPWyR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 18:54:17 -0400
Received: by mail-yh0-f50.google.com with SMTP id c41so4569086yho.23
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=RzpPo9X7LWKQRGASXoJ3H7tZZb1u8U7MKsoHnalEtFA=;
        b=VMKmpPWJarZH4yufTYwurqChpojwbY/CyaSx6/x304PzadXGnF/smwuApn7x9vDolX
         EayX57tSgNbiok8QKCZvvD8DRJJLYO1TkOdylvOyW9kRRxcw+Whq1U/dOKTgbTJksAih
         H/axzk3ItT2rbobbnYuCosOpIwnaaSfPtN/6XLpRuM2xoYgEOfuebnIq7WOMXcrrX/bW
         RdtlKj7/P9ulWVXl7VP44JLCaksJ8DiXu/dLvghoE/YQS4rticjBcCx8GecsiJSEDR/T
         LdkG0LlsOyqkiZqNvkNRKFfQr0lRCh2oYB5xaeRW5xhhnXca7QSCG2jA8WWwRHp5ShUN
         WUHQ==
X-Received: by 10.236.159.165 with SMTP id s25mr5300078yhk.24.1395010457057;
        Sun, 16 Mar 2014 15:54:17 -0700 (PDT)
Received: from fran.hsd1.ga.comcast.net. (c-98-242-72-155.hsd1.ga.comcast.net. [98.242.72.155])
        by mx.google.com with ESMTPSA id 44sm29880562yhp.17.2014.03.16.15.54.15
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Mar 2014 15:54:15 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.431.g014438b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244213>

Replace git-pull and git-merge with the corresponding un-hyphenated
versions. While at it, use ` to mark it up instead of '.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/merge-strategies.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 12133b9..19f3a5d 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -1,10 +1,10 @@
 MERGE STRATEGIES
 ----------------
 
-The merge mechanism ('git-merge' and 'git-pull' commands) allows the
+The merge mechanism (`git merge` and `git pull` commands) allows the
 backend 'merge strategies' to be chosen with `-s` option.  Some strategies
 can also take their own options, which can be passed by giving `-X<option>`
-arguments to 'git-merge' and/or 'git-pull'.
+arguments to `git merge` and/or `git pull`.
 
 resolve::
 	This can only resolve two heads (i.e. the current branch
-- 
1.9.0.431.g014438b
