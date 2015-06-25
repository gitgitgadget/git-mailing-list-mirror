From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 17/17] config.mak.uname: add MSVC
 No_SafeExeceptionHandler option
Date: Thu, 25 Jun 2015 01:03:53 +0100
Message-ID: <1435190633-2208-18-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:17 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001KS-IO
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by wibbw19 with SMTP id bw19sf18076745wib.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=JHW0+aC7eD0HexjQFzeIhOOLLkIfRE/g4MeSmNN23yw=;
        b=qQQy2vqfgxTXjvH3h5LdlTlestHH1WWSYkB1znLxzjW7Tf+cLPtZ/LtCNOTZlXyRtb
         0HA7rW8SQAzjyBOWdJL1I8FuH25PqpvY8R8ql3I/1Uoq2xx2L3cSwViFph6DXxTcv2Ku
         GxgqLmreCKid5Dg8YVo6mXu8zPd6E797sLIO1GNW9Cziu0aIGuM+wpqjX169hSciqSJc
         r3onEQD51wN52boBkTMaKEp85X46xps6uNf1P4I//eKaRL3TsDF17YFDQgVHBs8goe7f
         M8Qs59cbSaEzQ6f8wEZPv9Iy+D9DP8vpGqRa+kuHgwiKsky8YyEyN6LmOakgiyohVtGr
         wWuA==
X-Received: by 10.181.13.47 with SMTP id ev15mr2183wid.12.1435190531228;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.86.165 with SMTP id q5ls108934wiz.24.gmail; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.180.97.9 with SMTP id dw9mr304675wib.2.1435190530530;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id t6si17968wiz.0.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CvDwCSRItVPCWpEVxbgxGBM4ZMgViwQIwMBAICgUxNAQEBAQEBBwEBAQFBP0EFg10BAQRWIxAISTkKBg4GE4gzzWoBAQgigk2OAweEKwWFWo4rmUaKQ4EJgxg9MYJIAQEB
X-IPAS-Result: A2CvDwCSRItVPCWpEVxbgxGBM4ZMgViwQIwMBAICgUxNAQEBAQEBBwEBAQFBP0EFg10BAQRWIxAISTkKBg4GE4gzzWoBAQgigk2OAweEKwWFWo4rmUaKQ4EJgxg9MYJIAQEB
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366786"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:02:02 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272613>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 config.mak.uname | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 943c439..1c27828 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -1,5 +1,9 @@
 # Platform specific Makefile tweaks based on uname detection
 
+# Define NO_SAFESEH if you need MSVC/Visual Studio to ignore the lack of
+# Microsoft's Safe Exception Handling in libraries (such as zlib).
+# Typically required for VS2013+/32-bit compilation on Vista+ versions.
+
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
@@ -385,6 +389,11 @@ ifeq ($(uname_S),Windows)
 	PTHREAD_LIBS =
 	lib =
 	BASIC_CFLAGS += -DPROTECT_NTFS_DEFAULT=1
+
+ifdef NO_SAFESEH
+	LDFLAGS += -SAFESEH:NO
+endif
+
 ifndef DEBUG
 	BASIC_CFLAGS += -GL -Os -MD
 	BASIC_LDFLAGS += -LTCG
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
