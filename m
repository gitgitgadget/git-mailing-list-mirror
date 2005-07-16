From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 5/5] cogito: remove findutils dependency from Portfile
Date: Sat, 16 Jul 2005 19:24:10 -0400
Message-ID: <20050716232404.7317.86971.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 01:24:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtw1Q-0007Y9-AN
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 01:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVGPXYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVGPXYV
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 19:24:21 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:44657 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261882AbVGPXYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 19:24:10 -0400
Received: (qmail 68599 invoked from network); 16 Jul 2005 23:24:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=Cex47NBA60c0Bvf4EmhQuaKyv90nZvrwn36qBulYOBXso7wfX5eKoQ+K/hHLAFELqRJvGaaDJXsb3d5f+XtyfkHtXsdNaMKAQivD3LouzVeSzV/BKgf6HH8tNJl1Eu0ik/s52EHUBbWkvfW37I/lS8npZfoZDsZGtG79MKnsJH4=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@65.93.75.85 with plain)
  by smtp011.mail.yahoo.com with SMTP; 16 Jul 2005 23:24:09 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Gnu findutils (xargs) is no longer required; remove the dependency.  
Gnu coreutils is still required, but only if awk is not installed.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 Portfile.in |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Portfile.in b/Portfile.in
--- a/Portfile.in
+++ b/Portfile.in
@@ -14,8 +14,7 @@ long_description  The git core, develope
 homepage          http://kernel.org/pub/software/scm/cogito/
 master_sites      http://kernel.org/pub/software/scm/cogito/
 configure	  {}
-depends_lib       bin:gcp:coreutils
-depends_lib       bin:gnuxargs:findutils
+depends_lib       bin:gstat:coreutils
 build.type        gnu
 destroot.type     gnu
 destroot.destdir  prefix=${prefix} DESTDIR=${destroot}
