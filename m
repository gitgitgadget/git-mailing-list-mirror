From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 12/12] Add gitignore and ReadMe file for MSVC Build
Date: Wed, 19 Aug 2009 23:57:55 +0800
Message-ID: <1250697475-4340-1-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:58:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnY7-0003vR-2y
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbZHSP57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbZHSP56
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:57:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:42031 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZHSP56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:57:58 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1312061rvb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=tuIjt6bYFxrTGFNkdc393r+ImWzOBmnhXIdlc3DQIJw=;
        b=jj/ht4zyvTU4/bYpk41CKE7LpuvSPQ+Q1rautYAZ+8W2l1tEc57QssEj4wMer+1tTO
         YiKTyFWFHguslc/RxrLPduDnIe6pXYT0fe4d96OaScj9alqaZkg+de+aqnTfUPSLMZDn
         wArI3aml3P5mMWHQEuY8l6UwVxqzcYCZdsJa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=H/lORVpFpDEb4qrOFaADKa/ZplgTMhEOnukyv/dQbYjN9ZYTzqJ/zbboN8X8hJ3PM9
         fhRcvDY7G/ddSZ3n1PTGc9AhJnKoiBq/gR7+5yZU5deJCCydDDVL8gYslGz4nk1DzTga
         BP3L+zPAlLRR3h44kf8arwnJntQ3t4/ZwsqxM=
Received: by 10.140.208.15 with SMTP id f15mr3714086rvg.164.1250697479704;
        Wed, 19 Aug 2009 08:57:59 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id k2sm1266380rvb.3.2009.08.19.08.57.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:57:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126562>

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
index 0000000..f4e5efa
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
+   git submodule update --init
+
+3. Open gitbuild\gitbuild.sln with VS2008. Then press F7.
\ No newline at end of file
-- 
1.6.4.msysgit.0
