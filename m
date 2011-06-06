From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 3/5] gitweb: Move "Requirements" up in gitweb/INSTALL
Date: Mon,  6 Jun 2011 19:44:29 +0200
Message-ID: <1307382271-7677-4-git-send-email-jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 19:59:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTe5H-0000Me-1D
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 19:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757038Ab1FFR7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 13:59:21 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36202 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab1FFR7U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 13:59:20 -0400
Received: by wwa36 with SMTP id 36so4077509wwa.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=nMODKv5maT0mrDUWHiym1t4wHUVdXHc29SklKcXiMZc=;
        b=ckJeuC6tOT3xF6LbOuWtgDkMUEgaNW6LnuUx3exzOquYD18kg8EF0xohTwkOvbgaxL
         mGu/T08zoZBhytg+d7/+m0N4uJczeMMt722qLAx201UjP69z7oBm3iVfHnT7MTAj+AiH
         dq6mbPbmVkkfTMmzFWDwm1KyJ/DzGtMpTbiLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PAJDoxuMYJ4qZhjZi6iuaLG9RiBovSxg80WyLQchLT3elpppC/WTC65ha4VnOhqndx
         bscZiCh8Xc673tNaig7cx1bFrjNWQz6U7tGM+d1S10GMEP9rlsCJkgnks9I/5rAPajYi
         8rwn+NaD1/EA0FOUpMzvX/TsVoRt6TsEJEDGk=
Received: by 10.216.221.30 with SMTP id q30mr5011575wep.84.1307383158993;
        Mon, 06 Jun 2011 10:59:18 -0700 (PDT)
Received: from localhost.localdomain (abwr100.neoplus.adsl.tpnet.pl [83.8.241.100])
        by mx.google.com with ESMTPS id t79sm2440982weq.5.2011.06.06.10.59.16
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 10:59:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175144>

This way you can examine prerequisites at first glance, before
detailed instructions on installing gitweb.  Straightforward code
movement.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
No differences from previous version.

 gitweb/INSTALL |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 2346aad..c5236fe 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -25,6 +25,21 @@ The above example assumes that your web server is configured to run
 scripts).
 
 
+Requirements
+------------
+
+ - Core git tools
+ - Perl
+ - Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename.
+ - web server
+
+The following optional Perl modules are required for extra features
+ - Digest::MD5 - for gravatar support
+ - CGI::Fast and FCGI - for running gitweb as FastCGI script
+ - HTML::TagCloud - for fancy tag cloud in project list view
+ - HTTP::Date or Time::ParseDate - to support If-Modified-Since for feeds
+
+
 Build time configuration
 ------------------------
 
@@ -347,21 +362,6 @@ $projects_list variable in gitweb config):
 	perl -- /var/www/cgi-bin/gitweb.cgi
 
 
-Requirements
-------------
-
- - Core git tools
- - Perl
- - Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename.
- - web server
-
-The following optional Perl modules are required for extra features
- - Digest::MD5 - for gravatar support
- - CGI::Fast and FCGI - for running gitweb as FastCGI script
- - HTML::TagCloud - for fancy tag cloud in project list view
- - HTTP::Date or Time::ParseDate - to support If-Modified-Since for feeds
-
-
 Example web server configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.7.5
