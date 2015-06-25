From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 02/17] .gitignore: ignore library directories
 created by MSVC VS2008 buildsystem
Date: Thu, 25 Jun 2015 01:03:38 +0100
Message-ID: <1435190633-2208-3-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:16 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f56.google.com ([209.85.215.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001JM-50
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by lamq1 with SMTP id q1sf16770029lam.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Sw7VXMcoHBQVY7u7ThFjo8m1Xb3TxHhrAPK4vPipZ24=;
        b=Lx2xb1/MRCTn1vC+Jge5xCQ4+JEy7/CoZOoc5ofqfnPOic5RcF5FzZLtp+YggEq2iZ
         pDfZp4Pwk3PjRx+Tcc5ENXWHIkjZW0bP8UIlXRPTz38a3Wq7p9Pud1rixh0qnsc7ojfS
         yLZgDql8yepLANKk0cbCfgh/YJgbBIIsc4/5fWXxG1KN/dpb1S81sJidysfcbKyYM3pU
         FD9IUq5UEJpKUgZ+8pztPNR170AjJtOEAj3yvaBeyDGkZ+b8cNQ0ctHAjJS/V4x5gq/k
         ICxqlWX2wG7VwuzQWFhIFPdkzkt8bvwTaNTTYBo1Oswqljd8/MAQnld0bZOR8fMPoM0Z
         SGUQ==
X-Received: by 10.152.115.162 with SMTP id jp2mr523424lab.4.1435190530923;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.120.102 with SMTP id lb6ls220757lab.49.gmail; Wed, 24 Jun
 2015 17:02:09 -0700 (PDT)
X-Received: by 10.152.27.130 with SMTP id t2mr37755237lag.2.1435190529730;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id da3si4921wib.1.2015.06.24.17.02.09
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CvDwCSRItVPCWpEVxbgxGBM4ZMgViwQIwMBAICgUxNAQEBAQEBBwEBAQFBP0EFg10BAQRWIxAISTkKFAYTiDPNagEBCCKNB4NJB4QrBZQFpAmBCYE2JIE+PTGCSAEBAQ
X-IPAS-Result: A2CvDwCSRItVPCWpEVxbgxGBM4ZMgViwQIwMBAICgUxNAQEBAQEBBwEBAQFBP0EFg10BAQRWIxAISTkKFAYTiDPNagEBCCKNB4NJB4QrBZQFpAmBCYE2JIE+PTGCSAEBAQ
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366767"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:53 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.237 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272616>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 55498c1..706d0d9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -177,6 +177,7 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
+/libgit
 /test-chmtime
 /test-ctype
 /test-config
@@ -209,6 +210,8 @@
 /test-urlmatch-normalization
 /test-wildmatch
 /common-cmds.h
+/vcs-svn_lib
+/xdiff_lib
 *.tar.gz
 *.dsc
 *.deb
-- 
2.3.1

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
