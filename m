From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 11/11] Add gitignore and ReadMe file for MSVC Build
Date: Tue, 18 Aug 2009 00:09:00 +0800
Message-ID: <1250525340-412-1-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:09:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4m9-0007Mt-9K
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688AbZHQQJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756526AbZHQQJ2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:09:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:22792 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbZHQQJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:09:27 -0400
Received: by rv-out-0506.google.com with SMTP id f6so803680rvb.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VXAcshXVtTP2ODha45kQLhKCmdSvUu8RgCDAfRv2uhw=;
        b=eSOl6Pu8deVoK8vm8R9krH/zjNw9TRPZwaAVLCCiZnPaotB7S0vuUcVXET1f5Bq89S
         DlVVHTawihncpLVMAfRjlc0v68bR6hTgeiFCNbsUlGz6UMPsOe2ItaDLfipsL6e/9qIL
         nQvjoFUoZXDRqwRQC1ixqixjcERhi0CB8nkc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rbLdaA7WTdjDVVNeUS1cZBTkK4I1hmug0wZ2t2Sjho+QNkzb8AJ8h4LqpvMvlQQE1x
         fuHZhpxldUnWnJfr0yjMrBspW4XekWt4vN50MAXnyiYO8X0rorrpiL0h6hOmrQaH508f
         D8kVMdEUL6oRm/Efo7sTYrnUML+U6VRZHzPNc=
Received: by 10.140.201.19 with SMTP id y19mr2391753rvf.171.1250525369365;
        Mon, 17 Aug 2009 09:09:29 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id l31sm18031385rvb.4.2009.08.17.09.09.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:09:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126213>

Add ReadMe to user how to build git with MSVC.
Add gitignore to filter out files created file by MSVC.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/vcbuild/.gitignore |    3 +++
 compat/vcbuild/ReadMe     |   13 +++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/.gitignore
 create mode 100644 compat/vcbuild/ReadMe

diff --git a/compat/vcbuild/.gitignore b/compat/vcbuild/.gitignore
new file mode 100644
index 0000000..7796990
--- /dev/null
+++ b/compat/vcbuild/.gitignore
@@ -0,0 +1,3 @@
+Debug
+Release
+*.user
\ No newline at end of file
diff --git a/compat/vcbuild/ReadMe b/compat/vcbuild/ReadMe
new file mode 100644
index 0000000..47c089e
--- /dev/null
+++ b/compat/vcbuild/ReadMe
@@ -0,0 +1,13 @@
+The Steps of Build Git with VS2008
+
+1. Create VC Build Environment.
+
+   git clone git://repo.or.cz/gitbuild.git
+
+   gitbuild include VS solution file and library such as zlib.
+ 
+2. Get Submodule
+  
+   git submodule update
+
+3. Open gitbuild\gitbuild.sln with VS2008. Then press F7.
\ No newline at end of file
-- 
1.6.4.msysgit.0
