From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] Documentation: Add definition of "evil merge" to GIT Glossary
Date: Sat, 26 May 2007 00:37:39 +0200
Message-ID: <1180132662719-git-send-email-jnareb@gmail.com>
References: <11801326601014-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 00:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HriLA-0006ZS-Ak
	for gcvg-git@gmane.org; Sat, 26 May 2007 00:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXEYWcr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 18:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbXEYWcq
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 18:32:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:3930 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbXEYWcn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 18:32:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1222479ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 15:32:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pVssClfs2vJ68ZtWctZgc2abmpURDcZGCOwevvgEeQ2yuOp5/H8is0T1fSA5UHXqOmR8qPxIUUNGKvld418XeP8l+f8ZGy7ZITH6CifL0YZ8LivmVpzdwLGdG6RCQXyK93frzUiZcI2dqy8gDbB4C6NxvRYz4YDgbdnccans7wA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Dd7JL5qpnG4BDYK2OxkFQAh9K+bY70QGkvrreVGr3iuaYCgwdQd/h8ztG1h5JqfkTHq0KKnj6rlrCjK0JhRGuAS8bsl5jq4ACkcgE3w8HgPHxKOZnhu7xKeMfNRv4172DRHx1K/W/JQKL+WSd645hMx5rGhtvykq1wBMQQ/4fdM=
Received: by 10.66.216.14 with SMTP id o14mr3227212ugg.1180132361301;
        Fri, 25 May 2007 15:32:41 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id j2sm15553639mue.2007.05.25.15.32.38;
        Fri, 25 May 2007 15:32:39 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4PMbhNG015338;
	Sat, 26 May 2007 00:37:43 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4PMbg3N015337;
	Sat, 26 May 2007 00:37:42 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11801326601014-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48428>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Applies cleanly to 'master' branch 18bece43675ea0dc9022a7868865e02808b7af7f

 Documentation/glossary.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index ba52618..e903abf 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -121,6 +121,10 @@ to point at the new commit.
 	`http://en.wikipedia.org/wiki/Ent_(Middle-earth)` for an in-depth
 	explanation. Avoid this term, not to confuse people.
 
+[[def_evil_merge]]evil merge::
+	An evil merge is a <<def_merge,merge>> that introduces changes that
+	do not appear in any <<def_parent,parent>>.
+
 [[def_fast_forward]]fast forward::
 	A fast-forward is a special type of <<def_merge,merge>> where you have a
 	<<def_revision,revision>> and you are "merging" another
-- 
1.5.2
