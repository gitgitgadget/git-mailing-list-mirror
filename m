From: Thomas Matysik <thomas@matysik.co.nz>
Subject: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push)
 to RPM spec.
Date: Sun, 13 Nov 2005 17:56:55 +1300
Message-ID: <4376C797.3050600@matysik.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Nov 13 05:58:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb9vn-00086Z-MI
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 05:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVKME52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 23:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVKME52
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 23:57:28 -0500
Received: from [202.37.90.137] ([202.37.90.137]:35276 "EHLO xena.matysik.co.nz")
	by vger.kernel.org with ESMTP id S1751349AbVKME52 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 23:57:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by xena.matysik.co.nz (Postfix) with ESMTP id 52C0C189C4C
	for <git@vger.kernel.org>; Sun, 13 Nov 2005 17:56:54 +1300 (NZDT)
Received: from xena.matysik.co.nz ([127.0.0.1])
 by localhost (xena.matysik.co.nz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13756-08 for <git@vger.kernel.org>;
 Sun, 13 Nov 2005 17:56:53 +1300 (NZDT)
Received: from [202.37.90.142] (joxer.matysik.co.nz [202.37.90.142])
	by xena.matysik.co.nz (Postfix) with ESMTP id 8068B189C30
	for <git@vger.kernel.org>; Sun, 13 Nov 2005 17:56:53 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.92.0.0
X-Virus-Scanned: by amavisd-new at matysik.co.nz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11727>


Signed-off-by: Thomas Matysik <thomas@matysik.co.nz>
---

 git-core.spec.in |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 76d3d1c302c20b82fd976e958aabd19f7f01e7b5
b33499b703fbeac7e055a50a7f250ed71a516517
diff --git a/git-core.spec.in b/git-core.spec.in
index cf7e942..91f8677 100644
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -7,9 +7,9 @@ License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
-BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
+BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
-Requires:	zlib >= 1.2, rsync, rcs, curl, less, openssh-clients, python >= 2.3, tk >= 8.4
+Requires:	zlib >= 1.2, rsync, rcs, curl, less, openssh-clients, python >= 2.3, tk >= 8.4, expat

 %description
 This is a stupid (but extremely fast) directory content manager.  It
---
0.99.9g
