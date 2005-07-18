From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 5/6] cogito: remove findutils dependency from Portfile
Date: Sun, 17 Jul 2005 22:51:25 -0400
Message-ID: <20050718025119.11198.75892.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 04:52:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuLjC-0008IZ-Su
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 04:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVGRCv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 22:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVGRCv2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 22:51:28 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:20151 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261501AbVGRCvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 22:51:25 -0400
Received: (qmail 93636 invoked from network); 18 Jul 2005 02:51:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=VI1z236WVgI93kPmR31/7aCkSNgsX9/xMDxEnvqdLIRRHiPgP7shJ29G0f5KBw9vwPEwAw7VyoKe6O1DtrL5+O1ixSYPSoEvhccSFS6gOxDp9MnjhtRqkgjrJxllohkeAPhEJ59vzLI7PZ6N20XMKRCS0gO7mOyFu27vPq66iks=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp110.mail.sc5.yahoo.com with SMTP; 18 Jul 2005 02:51:23 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Gnu findutils (xargs) is no longer required; remove the dependency.  
Gnu coreutils is still required, but only if awk is not installed.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 Portfile.in |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Portfile.in b/Portfile.in
--- a/Portfile.in
+++ b/Portfile.in
@@ -14,8 +14,8 @@ long_description  The git core, develope
 homepage          http://kernel.org/pub/software/scm/cogito/
 master_sites      http://kernel.org/pub/software/scm/cogito/
 configure	  {}
-depends_lib       bin:gcp:coreutils
-depends_lib       bin:gnuxargs:findutils
+depends_lib       bin:gstat:coreutils
+depends_lib	  lib:libz.dylib:zlib
 build.type        gnu
 destroot.type     gnu
 destroot.destdir  prefix=${prefix} DESTDIR=${destroot}
