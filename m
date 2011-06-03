From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Move "Requirements" up in gitweb/INSTALL
Date: Fri, 3 Jun 2011 18:31:48 +0200
Message-ID: <201106031831.50496.jnareb@gmail.com>
References: <1307026553-1181-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 18:32:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSXI6-0005Xo-DM
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 18:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab1FCQcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 12:32:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60246 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab1FCQcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 12:32:00 -0400
Received: by bwz15 with SMTP id 15so1884730bwz.19
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=AEqBUm2zbszfvMjoyIexbaleRNbEYICmyAxJ7ix6x14=;
        b=JjU69xphHvX5Q0W54yGnXkDzo3mQLzT015rSJ3aqhfO29SzOtnRDVggBE5u+dZdRC9
         J52OsPlkaMKIk2hlOZi4vomu5QQFGBtQMlRxtXz304D7ZTSEiNHV5LpCPbSVepG25L5S
         te7eQG8nDvHC/9VqPnuYP7cs2fd4bnj9tqwuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mDxrYukU0m1S+tYTi0F5Eqo9PP8Up+imxVsrY11p5FY2CU2geQp/M7X0difEMIfbYg
         X468WSrUloctlop7laSNxvdBycNA+wxg/QrYd7vXS7rOXTp5wGGYlHvsQ1TAA9OYGr6j
         JWhyq1Xkpvd/u5BkufI9ZDktAC7SWyOVtj02k=
Received: by 10.204.127.68 with SMTP id f4mr2081308bks.42.1307118718581;
        Fri, 03 Jun 2011 09:31:58 -0700 (PDT)
Received: from [192.168.1.13] (abwc24.neoplus.adsl.tpnet.pl [83.8.226.24])
        by mx.google.com with ESMTPS id l24sm1378279bkw.15.2011.06.03.09.31.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 09:31:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1307026553-1181-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175016>

This way you can examine prerequisites at first glance, before
detailed instructions on installing gitweb.  Straightforward
text movement.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is another fall off from my work on continuing Drew Northup and
mine work of adding gitweb.conf(5) and gitweb(1) manpages (moving
gitweb documentation to manpages).

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
