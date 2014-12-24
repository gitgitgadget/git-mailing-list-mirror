From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 4/5] vcbuild/readme: Improve layout and reference msvc-build script
Date: Wed, 24 Dec 2014 10:47:13 +0000
Message-ID: <1419418034-6276-5-git-send-email-philipoakley@iee.org>
References: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 11:47:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3jTY-0004aY-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 11:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbaLXKr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 05:47:26 -0500
Received: from b216.a.smtp2go.com ([216.22.18.216]:44009 "EHLO
	b216.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbaLXKrY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 05:47:24 -0500
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261807>

Layout the 'either/or' with more white space to clarify
which alternatives are matched up.

Reference the Msysgit build script which automates one sequence of options.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 compat/vcbuild/README | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index df8a657..7548dc4 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -3,20 +3,24 @@ The Steps of Build Git with VS2008
 1. You need the build environment, which contains the Git dependencies
    to be able to compile, link and run Git with MSVC.
 
-   You can either use the binary repository:
+   You can either:
+      use the binary repository:
 
        WWW: http://repo.or.cz/w/msvcgit.git
        Git: git clone git://repo.or.cz/msvcgit.git
        Zip: http://repo.or.cz/w/msvcgit.git?a=snapshot;h=master;sf=zip
 
-   and call the setup_32bit_env.cmd batch script before compiling Git,
-   (see repo/package README for details), or the source repository:
+      and call the setup_32bit_env.cmd batch script before compiling Git,
+     (see repo/package README for details),
+
+   or:
+      use the source repository:
 
        WWW: http://repo.or.cz/w/gitbuild.git
        Git: git clone git://repo.or.cz/gitbuild.git
        Zip: (None, as it's a project with submodules)
 
-   and build the support libs as instructed in that repo/package.
+     and build the support libs as instructed in that repo/package.
 
 2. Ensure you have the msysgit environment in your path, so you have
    GNU Make, bash and perl available.
@@ -33,18 +37,25 @@ The Steps of Build Git with VS2008
        make common-cmds.h
    to generate the common-cmds.h file needed to compile git.
 
-4. Then either build Git with the GNU Make Makefile in the Git projects
-   root
+4. Then either
+
+     build Git with the GNU Make Makefile in the Git projects root
        make MSVC=1
-   or generate Visual Studio solution/projects (.sln/.vcproj) with the
+   or
+
+   generate Visual Studio solution/projects (.sln/.vcproj) with the
    command
        perl contrib/buildsystems/generate -g Vcproj
    and open and build the solution with the IDE
        devenv git.sln /useenv
-   or build with the IDE build engine directly from the command line
+     or
+
+   build with the IDE build engine directly from the command line
        devenv git.sln /useenv /build "Release|Win32"
    The /useenv option is required, so Visual Studio picks up the
    environment variables for the support libraries required to build
    Git, which you set up in step 1.
 
 Done!
+
+Or, use the Msysgit msvc-build script; available from that project.
-- 
2.1.0
