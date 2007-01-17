From: Chris Wedgwood <cw@f00f.org>
Subject: [PATCH] cache.h; fix a couple of prototypes
Date: Tue, 16 Jan 2007 22:28:02 -0800
Message-ID: <20070117062802.GA19068@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 17 07:34:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H74Nk-0002Ec-Gu
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 07:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbXAQGeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 01:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbXAQGeq
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 01:34:46 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:26528 "HELO
	smtp112.sbc.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751055AbXAQGep (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jan 2007 01:34:45 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 01:34:45 EST
Received: (qmail 38670 invoked from network); 17 Jan 2007 06:28:03 -0000
Received: from unknown (HELO stupidest.org) (cwedgwood@sbcglobal.net@24.5.75.45 with login)
  by smtp112.sbc.mail.re2.yahoo.com with SMTP; 17 Jan 2007 06:28:03 -0000
X-YMail-OSG: xH.oHngVM1lKsPWOWmnO51_G0sI4OENNMgKAp2ftLuKKs6CS.TtKQrrAQObHhDOYrpVRxYKJJlK9c0uvB_9HdsPwQAHtRJ6n6QGKaglphipOGkCUt8U8JOtnUXp.gj4cJ_kA3EWzqVLj8kfWXx7CZejwRey7o2D9
Received: by tuatara.stupidest.org (Postfix, from userid 10000)
	id 650951826121; Tue, 16 Jan 2007 22:28:02 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36989>

Trivial patch.

diff --git a/cache.h b/cache.h
index 620b6a4..fda3f8e 100644
--- a/cache.h
+++ b/cache.h
@@ -317,7 +317,7 @@ void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
 
 extern int setup_ident(void);
-extern void ignore_missing_committer_name();
+extern void ignore_missing_committer_name(void);
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 
@@ -400,7 +400,7 @@ extern void install_packed_git(struct packed_git *pack);
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1, 
 					 struct packed_git *packs);
 
-extern void pack_report();
+extern void pack_report(void);
 extern unsigned char* use_pack(struct packed_git *, struct pack_window **, unsigned long, unsigned int *);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(char *, int, int);
