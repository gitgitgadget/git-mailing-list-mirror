From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] remove Obsoletes from cogito.spec.in
Date: Mon, 11 Jul 2005 17:33:45 -0700
Message-ID: <20050712003345.GO19052@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 02:37:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds8lL-00052b-Hb
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 02:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVGLAgR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 20:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVGLAgD
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 20:36:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10715 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262304AbVGLAdz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 20:33:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C0XjjA006029
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 17:33:45 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C0XjA7011771;
	Mon, 11 Jul 2005 17:33:45 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j6C0Xjeg011770;
	Mon, 11 Jul 2005 17:33:45 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is leftover from early naming, and is no longer relevant.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/cogito.spec.in b/cogito.spec.in
--- a/cogito.spec.in
+++ b/cogito.spec.in
@@ -7,7 +7,6 @@ License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/cogito/
 Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.gz
-Obsoletes:	git
 BuildRequires:	zlib-devel, openssl-devel, curl-devel
 BuildRoot:	%{_tmppath}/%{name}-%{version}-root
 Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5
