From: imyousuf@gmail.com
Subject: [JGit Patch v2 7/7] Add ignore list for mavenized JGit
Date: Thu, 21 Aug 2008 09:13:14 +0600
Message-ID: <1219288394-1241-7-git-send-email-imyousuf@gmail.com>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-2-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-3-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-4-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-5-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-6-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 05:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0eJ-0007mF-Tc
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbYHUDOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbYHUDOl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:14:41 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:16913 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbYHUDOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:14:40 -0400
Received: by ik-out-1112.google.com with SMTP id c28so587486ika.5
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 20:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ik5tC26/SCvotrayBuPSkyOlSaxACHSRbbUKXka2Vmk=;
        b=xWcK/OeTb+0l0G2o2v9LvQ93uuV7IzF3WFRkN6TeIqevjMzBZMvn+HtBJpikAM7el9
         ro9hY0Cj1RJS50xJzb6u01L6f4vk8OKGuicvDw1FCGmTe5nHEHen/5lh0xgYwzaBwW3J
         i0iKV/whXCsLzzf/u4HL6SQf3od6IrBbfoadw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oEuAivFaPo+LBcDrqIDLYVFjrL0sSVRzuc7IDxfE2Tq9JY84i6bHjwpYFkFD3428sw
         to9AgW68T8LrUj21r4lxH80OwI9syWGY0nqqjB8mQXW7R8en9W+8mNIq0R5ubY+w7xso
         T1yollVvGANlQh2uPMbGHSXu4ocfU/FH19uoE=
Received: by 10.210.120.17 with SMTP id s17mr1148183ebc.181.1219288478743;
        Wed, 20 Aug 2008 20:14:38 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id 6sm72075nfv.21.2008.08.20.20.14.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 20:14:38 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1219288394-1241-6-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93103>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 jgit-maven/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 jgit-maven/.gitignore

diff --git a/jgit-maven/.gitignore b/jgit-maven/.gitignore
new file mode 100644
index 0000000..eb5a316
--- /dev/null
+++ b/jgit-maven/.gitignore
@@ -0,0 +1 @@
+target
-- 
1.5.6
