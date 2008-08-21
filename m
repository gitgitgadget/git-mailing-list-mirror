From: imyousuf@gmail.com
Subject: [JGit Patch 3/6] Add test resources directory as a classpath entry
Date: Thu, 21 Aug 2008 08:47:25 +0600
Message-ID: <1219286848-22758-3-git-send-email-imyousuf@gmail.com>
References: <1219286848-22758-1-git-send-email-imyousuf@gmail.com>
 <1219286848-22758-2-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 04:49:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0FC-0002OQ-3J
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 04:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbYHUCsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 22:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbYHUCsp
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 22:48:45 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:35957 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbYHUCsb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 22:48:31 -0400
Received: by ey-out-2122.google.com with SMTP id 6so13453eyi.37
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 19:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AnDJyk23ilpYGwce6lEKupLmnUnhtrzHeTAyAq7GA6w=;
        b=r3fDrHEOUOQ1lU3hHbo4/wX/u8WB8qetfnHkFuFGpyvhGH2wrbGwp4ULL16BE8s00K
         hGXYEAQahfXiq31dynA210UNMHrMXGgwWn2XVaTJfjIryP8r7ZWL+IcaEotLLWtl7ROc
         TlUWq75jjUb6ugksiYXD6nmFZTXy8PhfTl3Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dK/x60sOAY0ukl0TbIMKs6sDd1VrbEUNU9HwrHnvAJOLXuCqQ4PTFScCc+1IAF84rd
         NLq7jMJPNGoq0cxFPRx4arH5iiKjvIxDdo38RfcDRYGnc7KFC1qIiz5Bc6xs6nkMWbYQ
         PCuKcrIEvV90twNhXK5pWG+wfH2jDnFpHp44I=
Received: by 10.210.27.20 with SMTP id a20mr1120187eba.89.1219286909848;
        Wed, 20 Aug 2008 19:48:29 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id 33sm2379182nfu.7.2008.08.20.19.48.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 19:48:29 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1219286848-22758-2-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93093>

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
