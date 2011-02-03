From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Mention optional Perl modules in INSTALL
Date: Fri, 04 Feb 2011 00:20:48 +0100
Message-ID: <20110203232048.29709.14506.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 04 00:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl8UL-0001aC-Pc
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 00:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab1BCXVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 18:21:17 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61062 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab1BCXVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 18:21:16 -0500
Received: by wwa36 with SMTP id 36so1780260wwa.1
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 15:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=JH3ELY87aCQUD21GBC+42enaP8W7YdxVPy/OcANSQkU=;
        b=IDyizFrf150RcxIgRmDhuw1pjq5wcHITUDg9nWOm+Ro7laj7altFB9P4+NDzKMbkfk
         UuFgzNyBjPrdFPYlHihtAi8DyQwRqh11GF2PvKUqEi0BvQTgAgs74CebEcCZPqq5MWw7
         ZrTmvi3D2nnEM8NhtbG3Wyp9zoXI4njF6tBQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=uFHFukfrgJ4ItlczFDrF1mxQR/vyAvZQu0aR131/ZzuOk+b7hl6sKR9JHefUvx6wUd
         N4ggocoBOfmnpWmERqFZkfGS2jKsaSS0a9UvPgv1aZ561uImiV/3UuyWycj1oRHLl/jJ
         ox6co52p/0iff9M9SstzHL12+gFz1jsFn/YY4=
Received: by 10.216.166.2 with SMTP id f2mr29769wel.24.1296775274925;
        Thu, 03 Feb 2011 15:21:14 -0800 (PST)
Received: from localhost.localdomain (abwe108.neoplus.adsl.tpnet.pl [83.8.228.108])
        by mx.google.com with ESMTPS id m50sm35847wek.32.2011.02.03.15.21.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Feb 2011 15:21:14 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p13NKm1F029737;
	Fri, 4 Feb 2011 00:20:59 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166008>



Some optional additional Perl modules are required for some of extra
features.  Mention those in gitweb/INSTALL.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/INSTALL |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 8230531..4964a67 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -237,6 +237,12 @@ Requirements
  - Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename.
  - web server
 
+The following optional Perl modules are required for extra features
+ - Digest::MD5 - for gravatar support
+ - CGI::Fast and FCGI - for running gitweb as FastCGI script
+ - HTML::TagCloud - for fancy tag cloud in project list view
+ - HTTP::Date or Time::ParseDate - to support If-Modified-Since for feeds
+
 
 Example web server configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
