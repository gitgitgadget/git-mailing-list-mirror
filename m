From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 14/14] Add README and gitignore file for MSVC build
Date: Fri, 21 Aug 2009 15:30:46 +0200
Message-ID: <e82f1930173966ebb6b2d2815e037a26e079f969.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
 <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
 <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
 <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
 <4b8b550914cfc4e638ff905d9b9aa416e45913f4.1250860247.git.mstormo@gmail.com>
 <ba4e68ae32784d8e0c706fa665fbdbbfe67ce673.1250860247.git.mstormo@gmail.com>
 <6dd71f163e5410e401fc66088405736d1978ec55.1250860247.git.mstormo@gmail.com>
 <54673ddb6bef681194e141e5e05e930cdfaa07bc.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUE5-00012X-Ea
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbZHUNbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbZHUNbW
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:22 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:57834 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbZHUNbT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:19 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so637048ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=s9Bj4ozxcN6L67HebUUbOACYxDWZhwsTr6nl/jce0OE=;
        b=TH4xPa44zqwiO5R+T3FQuR0Z+MNBleiSpOXuS/gLotKOoDTIkEp8Usy0tHy/C0Y992
         QQIRQ9/xHaiBaHZF2LEEzVt4z1Vm4gqRCBnhUaq6Hf18h3DMZ1p/0425zY3xj8cXjpYj
         KcFDbWTZ5g9q44R9FsXJSeUU2XbUPtKYU4WCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xeGifA6fM5UIydciCsfxfpTeKG34CwjLsaOEHhl9OqgOdxUpTPkSUyRWd4mAzXgmM1
         dRq1OAD2WUwkqMQviG/MguJ32uicU2iflt6Jm1sVsiBmDvrc3znb1pehh23beGV89iXQ
         WJIqZ17P4F5OScFP5a7IyMsSh4aPAPOACCEGo=
Received: by 10.210.68.8 with SMTP id q8mr1471979eba.39.1250861480459;
        Fri, 21 Aug 2009 06:31:20 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <54673ddb6bef681194e141e5e05e930cdfaa07bc.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126715>

From: Frank Li <lznuaa@gmail.com>

Add a README file to tell users how to build git with MSVC.

Also add a gitignore file to make git ignore files generated
by a MSVC build.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/vcbuild/.gitignore |    3 +++
 compat/vcbuild/README     |   13 +++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/.gitignore
 create mode 100644 compat/vcbuild/README

diff --git a/compat/vcbuild/.gitignore b/compat/vcbuild/.gitignore
new file mode 100644
index 0000000..297ee5b
--- /dev/null
+++ b/compat/vcbuild/.gitignore
@@ -0,0 +1,3 @@
+Debug
+Release
+*.user
diff --git a/compat/vcbuild/README b/compat/vcbuild/README
new file mode 100644
index 0000000..3667ca3
--- /dev/null
+++ b/compat/vcbuild/README
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
-- 
1.6.3.msysgit.0.18.gef407
