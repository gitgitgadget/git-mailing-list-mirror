From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 16/16] config.mak.uname: add MSVC
 No_SafeExeceptionHandler option
Date: Sun, 19 Jul 2015 21:08:17 +0100
Message-ID: <1437336497-4072-18-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB4UGWCWQKGQEKYFPOVY@googlegroups.com Sun Jul 19 22:07:16 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB4UGWCWQKGQEKYFPOVY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB4UGWCWQKGQEKYFPOVY@googlegroups.com>)
	id 1ZGurj-0002NE-FL
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:15 +0200
Received: by wicmv11 with SMTP id mv11sf138023wic.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=P7yj7h1/2wvn83gMlu4HAMuYuZLG5sfwlUovw41+XZY=;
        b=RRSUYZ32pT8xNLUxmiR+B3Tv1QfrBRixUY2Y5+bTz92sMcpSoCtCY8lL3My+b86ER1
         Kb3xn/AsjqWwYjE9mlLDKeBQswoh7Dq48woJ1bX/LubXDiFexxFUAV9a/zrqxzYPHN8r
         hj50/EmV6ZB+BVI/BF/6rp4dDtiAiR6slbWtAUmOFuhy1tMa1d5PeIjH045tx298PmI6
         egILsjK7344U0FxZul7ebCAvKweLwCwuI/DdyP6neT8dNRe9xgCrK4ucpK/W5+Gnn6WV
         9gv7tYx01+SiCHglcb1pryiF+nYLKSjF3+f1rQptyWTpvQhg5ujXLanp1szhYFF/MNSM
         r+6g==
X-Received: by 10.152.1.39 with SMTP id 7mr362168laj.18.1437336435170;
        Sun, 19 Jul 2015 13:07:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.30.36 with SMTP id p4ls50812lah.63.gmail; Sun, 19 Jul 2015
 13:07:13 -0700 (PDT)
X-Received: by 10.112.13.200 with SMTP id j8mr13161790lbc.14.1437336433989;
        Sun, 19 Jul 2015 13:07:13 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.13
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:13 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DQCgCSAqxVPN4GFlxcgkFSVGm7ZQmBdYVxBAICgRo5FAEBAQEBAQEGAQEBAUABP4QkAQEEViMQCEk5CgYBDQYTiDIJxF8BAQEHAiCCTo0rWQeEKwWFYI5yhG+JO4wZimWBCYMaPTEBgQOBRwEBAQ
X-IPAS-Result: A2DQCgCSAqxVPN4GFlxcgkFSVGm7ZQmBdYVxBAICgRo5FAEBAQEBAQEGAQEBAUABP4QkAQEEViMQCEk5CgYBDQYTiDIJxF8BAQEHAiCCTo0rWQeEKwWFYI5yhG+JO4wZimWBCYMaPTEBgQOBRwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118948"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:14 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274287>

Microsoft flipped the Windows Safe Exception Handling default
in VS2013 so that zlib became unacceptable to certain OS versions
(Vista and subsequent 32-bit OS's) without the addition of
the option -SAFESEH:NO.

Provide a switch to disable the Safe Exeption Handler when required.

The option ImageHasSafeExceptionHandlers for VS2013 is not available in
earlier versions, so use the SAFESEH:NO linker flag. See
https://msdn.microsoft.com/en-us/library/9a89h429.aspx for
further details.

This has only had limited testing due to the lack of a suitable system.

Helped-by: Yue Lin Ho <b8732003@student.nsysu.edu.tw>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Junio/my discussion on reviews: http://marc.info/?l=git&m=143526063906215&w=2 (2015-06-25)
Patch series v1: https://github.com/msysgit/git/pull/318
Yue Lin Ho: https://github.com/msysgit/git/pull/318#issuecomment-81292918
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
2.4.2.windows.1.5.gd32afb6

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
