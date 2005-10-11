From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] cogito: Use %{?dist} in RPM release number
Date: Tue, 11 Oct 2005 16:50:23 -0700
Message-ID: <20051011235023.GS8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 01:51:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPTtc-00050p-Ns
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 01:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVJKXuf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 19:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVJKXuf
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 19:50:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8582 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932366AbVJKXue (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 19:50:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9BNoN4s010335
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 16:50:24 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9BNoNwu004027;
	Tue, 11 Oct 2005 16:50:23 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j9BNoNsQ004026;
	Tue, 11 Oct 2005 16:50:23 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9992>

Useful when tracking multiple distro branches.  Somehow I never sent
you this small bit.

Signed-off-by: Chris Wright <chris@osdl.org>

---

 cogito.spec.in |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

8711e755f38f7458abf5e040e079da534820dd85
diff --git a/cogito.spec.in b/cogito.spec.in
--- a/cogito.spec.in
+++ b/cogito.spec.in
@@ -1,6 +1,6 @@
 Name: 		cogito
 Version: 	@@VERSION@@
-Release: 	1
+Release: 	1%{?dist}
 Summary:  	The Cogito Version Control System
 License: 	GPL
 Group: 		Development/Tools
@@ -38,6 +38,9 @@ rm -rf $RPM_BUILD_ROOT
 %doc README COPYING Documentation/*
 
 %changelog
+* Tue Oct 11 2005 Chris Wright <chrisw@osdl.org> 0.15.1-1
+- use %dist
+
 * Fri Sep 16 2005 Chris Wright <chrisw@osdl.org> 0.14.1-2
 - fix _libdir breakage on 64-bit, the irony...
 
