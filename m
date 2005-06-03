From: Konstantin Antselovich <konstantin@antselovich.com>
Subject: [PATCH] simple one-liner for README file
Date: Fri, 03 Jun 2005 04:22:44 -0700
Organization: http://konstantin.antselovich.com
Message-ID: <42A03D84.4020601@antselovich.com>
Reply-To: konstantin@antselovich.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070406000607090400040301"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 14:11:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeB13-00061q-Do
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 14:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFCMOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 08:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFCMOJ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 08:14:09 -0400
Received: from orangecode.net ([69.36.165.200]:14982 "EHLO orangecode.net")
	by vger.kernel.org with ESMTP id S261236AbVFCMOC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 08:14:02 -0400
Received: from proliant.myhome (c-24-130-184-220.hsd1.ca.comcast.net [24.130.184.220])
	by orangecode.net (8.11.6/8.11.6) with ESMTP id j53BOGF05964;
	Fri, 3 Jun 2005 05:24:17 -0600
Received: from [192.168.0.2] (lifebook.myhome [192.168.0.2])
	(authenticated bits=0)
	by proliant.myhome (8.13.3/8.12.8) with ESMTP id j53BwnQX026719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jun 2005 04:58:50 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
X-Enigmail-Version: 0.91.0.0
X-Virus-Scanned: ClamAV 0.85.1/908/Thu Jun  2 13:39:40 2005 on proliant.myhome
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070406000607090400040301
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr,

I noticed a very small error in README file.
I'm not sure if I should submit is as a patch, as
it's just a change to one line.  (but I attached a patch anyways)

Regards,
-Konstantin

-- 
Konstantin Antselovich
mailto: konstantin@antselovich.com
http://konstantin.antselovich.com

--------------070406000607090400040301
Content-Type: text/x-patch;
 name="readme.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="readme.patch"

Simple one-liner for an error in README file.
Suggested command 
  'cg-clone -s rsync://rsync.kernel.org/pub/scm/cogito/cogito.git cogitodir'
leads to: cg-clone: specifying both -s and DESTDIR makes no sense
So, just delete directory name from the end of line

---
commit a8f5b28c32978d7b0c996172e15e61f3e63b6ff4
tree fc5ee658a6fedd886d43c6342e9df184fd751fbd
parent d140154ad84eb3fc89c4d7cb2019412bcf8e3ed7
author Konstantin Antselovich <konstantin@antselovich.com> Fri, 03 Jun 2005 04:11:59 -0700
committer Konstantin Antselovich <konstantin@antselovich.com> Fri, 03 Jun 2005 04:11:59 -0700

 README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/README b/README
--- a/README
+++ b/README
@@ -106,7 +106,7 @@ If, instead, you want to clone the repos
 first make sure you are in an empty directory. Then give the following
 command:
 
-	$ cg-clone -s rsync://rsync.kernel.org/pub/scm/cogito/cogito.git cogitodir
+	$ cg-clone -s rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
 
 When you get your prompt back, do an ls to see the source tree and .git
 directory.

--------------070406000607090400040301--
