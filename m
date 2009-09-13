From: mr.gaffo@gmail.com
Subject: [PATCH JGit 11/19] removed unused import
Date: Sun, 13 Sep 2009 13:44:27 -0500
Message-ID: <1252867475-858-12-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-9-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-10-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-11-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:53:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmuC4-00056H-Hl
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbZIMSwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbZIMSww
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:52:52 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:1418 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbZIMSwv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:52:51 -0400
Received: by an-out-0708.google.com with SMTP id d40so7558446and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Nd2Hqb4z8y9XbAtE/eMax9wZIjaSkzG2JA4VqaG48QA=;
        b=FzJu+mb1f5+JKlp+olOqtGkx6VBXNHye52gyZPwEQZHlBY1FVLfFlaL6ORz1V8IuaG
         00OoNhlV9/LUQoMxkUE5zwFex1vhHy4y617uJwHcfr6+cX8flZfauYT4JOKuBIz/z/KW
         8jEQJ4hkhb5iYze3cggRLjw0/qWiqSTzDuJVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hpIwItVuhzZEOMNA5UMl4yBbUIsQTQ1Mj6FuGpjz/MMjr4HzEN0R5YTWDWLXDjWzvM
         HWBypNEz/39ldN0VTC9w4MZGiiX3QGL0HtmWC7/rkZ+RBFsx6aaXVolLG4T+cmdc+Dxr
         JdDpFLkFnxVakw+rakU0E5ju70khpZB5tLhEc=
Received: by 10.100.244.24 with SMTP id r24mr5594256anh.8.1252867495265;
        Sun, 13 Sep 2009 11:44:55 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-11-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128401>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../lib/UpdateDirectoryBasedPacksInfoCache.java    |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
index 3e24cd2..e4caa43 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
@@ -1,6 +1,5 @@
 package org.spearce.jgit.lib;
 
-import java.io.BufferedWriter;
 import java.io.File;
 import java.io.FileOutputStream;
 import java.io.IOException;
-- 
1.6.4.2
