From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Update copyright information
Date: Mon, 28 May 2007 11:58:46 +0200
Message-ID: <200705281158.47128.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 12:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HscI7-00032w-2K
	for gcvg-git@gmane.org; Mon, 28 May 2007 12:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762079AbXE1KQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 06:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762034AbXE1KQn
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 06:16:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11855 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471AbXE1KQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 06:16:41 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1594291ugf
        for <git@vger.kernel.org>; Mon, 28 May 2007 03:16:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=awmZtnG6sUCiq1VDFQ94lGmx0MQRhUIxbbRyUX/UO9zuzQrfiIpawDAR0tx8IpZUdgHIDVJNhtXs6Rx7RchbGtNGzZWyrRdNtERcLWXfpug/MPdJqsRZRohDnNSHCcyULzJeBxrNizp9uaUaiyccqLP+Yi7MpwkGTsyGYOUcK/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=d8+OJy+4+9BSvH8vmnj9WWslB1GocxjKKFWgEUDgNvBx6LnFp+k+0eFiMihjqUQR1ibe40jIuslwiUk36cQ9MJKCPEnWYYQ+LV8LW7U9cpxr9Eg03YlGqCsTQqKWc5OY/JeMsz20YyeLlCcoAyYRPVH7LAkjj5DYILDc/v37i+U=
Received: by 10.67.96.1 with SMTP id y1mr5169653ugl.1180347399873;
        Mon, 28 May 2007 03:16:39 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id m1sm7761725ugc.2007.05.28.03.16.38;
        Mon, 28 May 2007 03:16:38 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48612>

Update copyright information in file header, and remove obsolete
copyright information from the comment in HTML head, in the output.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Just a thought...

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f73f184..d51ae84 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2,6 +2,7 @@
 
 # gitweb - simple web interface to track changes in git repositories
 #
+# (C) 2006-2007, Git Development Community <git@vger.kernel.org>
 # (C) 2005-2006, Kay Sievers <kay.sievers@vrfy.org>
 # (C) 2005, Christian Gierke
 #
@@ -2072,7 +2073,7 @@ sub git_header_html {
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
-<!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
+<!-- git web interface version $version -->
 <!-- git core binaries version $git_version -->
 <head>
 <meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
-- 
1.5.2
