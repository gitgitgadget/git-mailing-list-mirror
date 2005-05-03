From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH 1/3] cogito spec file 0.7-1
Date: Tue, 3 May 2005 11:30:38 -0700
Message-ID: <20050503183038.GM18917@shell0.pdx.osdl.net>
References: <20050503182850.GL18917@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 20:29:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT28c-0001fl-66
	for gcvg-git@gmane.org; Tue, 03 May 2005 20:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVECSd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVECSbT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 14:31:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:40415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261548AbVECSao (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 14:30:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43IUcs4007115
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 11:30:38 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43IUciu008667;
	Tue, 3 May 2005 11:30:38 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j43IUc1I008666;
	Tue, 3 May 2005 11:30:38 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050503182850.GL18917@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update spec file to 0.7

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- cogito/git.spec~0.6.3-1	2005-05-03 11:01:52.000000000 -0700
+++ cogito/git.spec	2005-05-03 11:10:32.000000000 -0700
@@ -1,5 +1,5 @@
 Name: 		git
-Version: 	0.6.3
+Version: 	0.7
 Release: 	1
 Vendor: 	Petr Baudis <pasky@ucw.cz>
 Summary:  	Git core and tools
@@ -39,5 +39,8 @@ rm -rf $RPM_BUILD_ROOT
 #%{_mandir}/*/*
 
 %changelog
+* Mon Apr 25 2005 Chris Wright <chrisw@osdl.org> 0.7-1
+- Update to 0.7
+
 * Thu Apr 21 2005 Chris Wright <chrisw@osdl.org> 0.6.3-1
 - Initial rpm build
