From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7/6] todo: Remove "Gitweb diff on merge commits" entry
Date: Mon,  7 May 2007 01:10:09 +0200
Message-ID: <1178493013727-git-send-email-jnareb@gmail.com>
References: <11784930091585-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 01:06:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkpod-0008BO-1D
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXEFXGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXEFXGw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:06:52 -0400
Received: from qb-out-0506.google.com ([72.14.204.234]:29537 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXEFXGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:06:51 -0400
Received: by qb-out-0506.google.com with SMTP id a16so3059982qbd
        for <git@vger.kernel.org>; Sun, 06 May 2007 16:06:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hVzjGOz7nMsXQgW/qmD3h/XyE8UZHuVtlF72YPnZ8ziU2Vr+fFeMXoZyhd2I/xZ786Dq115KgF2+WGfm9pcTxwUtEhdoTAmF2AFq2wU/vwXXggw5mwiWbb5LYhwvNHmd9zqu7EOwSAoebQr8Muo9Ty0B5WnivMqDRccQS1Dl1KE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Nvh7kLjeT/Lzim/vhrZDXix0PV1zzm+UozwU4+Heb5VBVXUTtwxhaPIoB1CR0ahCIA1APiTgQ0QGI0buG7MCqJgqSkPzY0Ptn+P7LOF/yVfu+nPQl2CwhvkcECAFNJrWxisL9p/IfCKaf3u3lQ8+bn7iH3K1MLPs+oTuRJG08Mc=
Received: by 10.64.251.9 with SMTP id y9mr8193084qbh.1178492757052;
        Sun, 06 May 2007 16:05:57 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id e15sm4752500qba.2007.05.06.16.05.55;
        Sun, 06 May 2007 16:05:56 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l46NADZ0015932;
	Mon, 7 May 2007 01:10:14 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l46NAD9k015931;
	Mon, 7 May 2007 01:10:13 +0200
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <11784930091585-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46392>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch applies to 'todo' branch!

Perhaps TODO entry should be replaced (updated) to say about format
of gitweb diff for merge commits (diffstat in HTML, improving difftree
for merges), instead of just deleting it.

 TODO |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/TODO b/TODO
index 6c603db..305363a 100644
--- a/TODO
+++ b/TODO
@@ -85,17 +85,6 @@ the box.
 
 [jc: limbo?]
 
-* Gitweb diff on merge commits
-
-From: Linus Torvalds <torvalds@osdl.org>
-Subject: Re: git show and gitweb gives different result for kernel
-Message-ID: <Pine.LNX.4.64.0610061202060.3952@g5.osdl.org>
-
-Maybe allow gitweb to show diff with any parent and diff --cc,
-not just diff with the first parent for a merge.
-
-[jc: Jakub is interested in it]
-
 * Delegate gitweb part to somebody else.
 
 * Use gitattributes for more things.
-- 
1.5.1.3
