From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] doc: hooks.txt said post-commit default sends an email, it doesn't
Date: Fri, 2 Feb 2007 23:56:08 +0000
Message-ID: <200702022356.11180.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 00:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD8JI-0005B6-35
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 00:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933391AbXBBX7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 18:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933386AbXBBX7M
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 18:59:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:49022 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946179AbXBBX7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 18:59:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so905699uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 15:59:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=hsQc9xIdAGn4fRPJSxRoG2mQec/DOKheamAZp8uTpRn4i2LY+FCBtEo+Eo8CBbtlqJYzIyHHz9FQMuyW3WC/GTZXkqf0jJvsPtUCfA/xxFuhmrZRiGUaBhFcVK94Vh8/znivwyHMB/7ObyEwlwxuhQlZFV6ALdxWVnMOPChpnbk=
Received: by 10.67.21.11 with SMTP id y11mr5183011ugi.1170460750229;
        Fri, 02 Feb 2007 15:59:10 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 53sm6257368ugn.2007.02.02.15.59.08;
        Fri, 02 Feb 2007 15:59:08 -0800 (PST)
X-TUID: d602cfa4f0b9fea4
X-UID: 215
X-Length: 1321
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38542>

The default post-commit hook is actually empty; it is the update hook
that sends an email.  This patch corrects hooks.txt to reflect that.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/hooks.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index e3b76f9..b083290 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -90,9 +90,6 @@ parameter, and is invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git-commit`.
 
-The default 'post-commit' hook, when enabled, demonstrates how to
-send out a commit notification e-mail.
-
 update
 ------
 
@@ -130,6 +127,8 @@ The standard output of this hook is sent to `stderr`, so if you
 want to report something to the `git-send-pack` on the other end,
 you can simply `echo` your messages.
 
+The default 'update' hook, when enabled, demonstrates how to
+send out a notification e-mail.
 
 post-update
 -----------
-- 
1.5.0.rc1.gf4b6c
