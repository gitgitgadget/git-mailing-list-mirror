From: imyousuf@gmail.com
Subject: [JGit Patch v2 3/7] Add test resources directory as a classpath entry
Date: Thu, 21 Aug 2008 09:13:10 +0600
Message-ID: <1219288394-1241-3-git-send-email-imyousuf@gmail.com>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-2-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 05:14:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0dV-0007ZL-HF
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbYHUDNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbYHUDNs
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:13:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:60542 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbYHUDNr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:13:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so370899nfc.21
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 20:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AnDJyk23ilpYGwce6lEKupLmnUnhtrzHeTAyAq7GA6w=;
        b=XZNx2fSSMPq6eos+yuQPxajx81dKqk9fBHOagMZVslRDhqf3aBHci6eJDw52X4XFpL
         t5/yjBUwqIFdZwdzoWp6IXiBvuoeyZl/CXWixHeiddFO3E0xVuw9Msd4jgGibpiKJpUn
         A3CIMHO388grlbcpfX1AijZdOXcwEBIGH0EJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aqBQqsDuVbqaOSOdQbDyB0onLwNtC25SGw0JSlFKTP7T7OrZ5/IN3s0dem5xaEGPR4
         VVVQi2UZwUGXGhCvG5MLxFPJUfCZPoRyGQfi+sM/9xYXYm5NzmBk2NbLMVFuKiMU+8/t
         rffZUItQN38hkQadpVPottBzuLzLpi5zaOYUs=
Received: by 10.210.76.12 with SMTP id y12mr1145919eba.151.1219288426777;
        Wed, 20 Aug 2008 20:13:46 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id f3sm2404029nfh.2.2008.08.20.20.13.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 20:13:46 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1219288394-1241-2-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93099>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Since test resources will be required to be read from classpath thus adding
record to Eclipse's .classpath setting file.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 org.spearce.jgit.test/.classpath |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/.classpath b/org.spearce.jgit.test/.classpath
index 592fa17..a276507 100644
--- a/org.spearce.jgit.test/.classpath
+++ b/org.spearce.jgit.test/.classpath
@@ -1,6 +1,7 @@
 <?xml version="1.0" encoding="UTF-8"?>
 <classpath>
 	<classpathentry excluding="**/*.idx|**/*.pack" kind="src" path="tst"/>
+	<classpathentry kind="src" path="tst-rsrc"/>
 	<classpathentry kind="src" path="exttst"/>
 	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/J2SE-1.5"/>
 	<classpathentry combineaccessrules="false" kind="src" path="/org.spearce.jgit"/>
-- 
1.5.6
