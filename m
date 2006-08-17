From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7/7] gitweb: Uniquify version info output, add meta generator in page header
Date: Thu, 17 Aug 2006 11:21:28 +0200
Message-ID: <11558064901150-git-send-email-jnareb@gmail.com>
References: <11558064883957-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 17 11:22:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe4j-0002Cb-9l
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWHQJVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWHQJVj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:21:39 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:18824 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932458AbWHQJVi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:21:38 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7H9KQRf023259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Aug 2006 11:20:27 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7H9LU17003725;
	Thu, 17 Aug 2006 11:21:30 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7H9LUjq003724;
	Thu, 17 Aug 2006 11:21:30 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11558064883957-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25568>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d132aab..5467880 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1049,10 +1049,11 @@ sub git_header_html {
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
-<!-- git web interface v$version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
+<!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
 <!-- git core binaries version $git_version -->
 <head>
 <meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
+<meta name="generator" content="gitweb/$version git/$git_version"/>
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 <link rel="stylesheet" type="text/css" href="$stylesheet"/>
-- 
1.4.1.1
