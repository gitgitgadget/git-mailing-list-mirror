From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] Update RPM core package description
Date: Tue, 13 Feb 2007 11:39:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702131136220.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 17:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH0gT-00031R-QN
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 17:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbXBMQjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 11:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbXBMQjJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 11:39:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64858 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbXBMQjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 11:39:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDE00AI2U919G30@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Feb 2007 11:39:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39540>

Git isn't as stupid as it used to be

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/git.spec.in b/git.spec.in
index ffab6bb..46aee88 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -12,12 +12,9 @@ BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk, git-gui, perl-Git
 
 %description
-This is a stupid (but extremely fast) directory content manager.  It
-doesn't do a whole lot, but what it _does_ do is track directory
-contents efficiently. It is intended to be the base of an efficient,
-distributed source code management system. This package includes
-rudimentary tools that can be used as a SCM, but you should look
-elsewhere for tools for ordinary humans layered on top of this.
+Git is a fast, scalable, distributed revision control system with an
+unusually rich command set that provides both high-level operations
+and full access to internals.
 
 This is a dummy package which brings in all subpackages.
 
@@ -26,12 +23,9 @@ Summary:	Core git tools
 Group:		Development/Tools
 Requires:	zlib >= 1.2, rsync, curl, less, openssh-clients, expat
 %description core
-This is a stupid (but extremely fast) directory content manager.  It
-doesn't do a whole lot, but what it _does_ do is track directory
-contents efficiently. It is intended to be the base of an efficient,
-distributed source code management system. This package includes
-rudimentary tools that can be used as a SCM, but you should look
-elsewhere for tools for ordinary humans layered on top of this.
+Git is a fast, scalable, distributed revision control system with an
+unusually rich command set that provides both high-level operations
+and full access to internals.
 
 These are the core tools with minimal dependencies.
 
@@ -173,6 +167,9 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %doc Documentation/*.html }
 
 %changelog
+* Mon Feb 13 2007 Nicolas Pitre <nico@cam.org>
+- Update core package description (Git isn't as stupid as it used to be)
+
 * Mon Feb 12 2007 Junio C Hamano <junkio@cox.net>
 - Add git-gui and git-citool.
 
