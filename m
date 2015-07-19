From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 08/16] engine.pl: ignore invalidcontinue.obj
 which is known to MSVC
Date: Sun, 19 Jul 2015 21:08:08 +0100
Message-ID: <1437336497-4072-9-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB3EGWCWQKGQETFQ6EPY@googlegroups.com Sun Jul 19 22:07:09 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB3EGWCWQKGQETFQ6EPY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB3EGWCWQKGQETFQ6EPY@googlegroups.com>)
	id 1ZGurd-0002KJ-5A
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:09 +0200
Received: by wgjf7 with SMTP id f7sf441375wgj.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=3amP+0BKJQKq4Ve78a2JWQdlKH8gWt8yGiGo6cK3VDg=;
        b=nTRpUD6kLcRxM6kpQHEDKuhygyjXahxeOtAHJiTqRHFhsj51epPUeVB3NhLuwLQYT6
         FGEmpXVjzSk+X9W+ew2YIIxjRAdemUyMV4915hz/bc55kZ3CKtglEppzdqNPO0YUS5FE
         l7O+oxNq/A1Gb43rC3/Uv1SC3oZo/j6ggiPaLViV9Sf9+sCDXmIk0FmdBuasGYC9w45u
         L3QhwrK8wIGzqy/AaWJ68VWiLvO7hEe7bWWwuOuVciQaYAS+L4lJBK9W7BpcscoyWvdM
         wpVODKZldF71oY3U/ojr92OYejvCDP9HMDHKyw4MXgfLbapvFXlU7QVmqZIwBdfxmLiV
         +TAw==
X-Received: by 10.180.216.4 with SMTP id om4mr27882wic.3.1437336428884;
        Sun, 19 Jul 2015 13:07:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.91.77 with SMTP id cc13ls673561wib.36.canary; Sun, 19 Jul
 2015 13:07:08 -0700 (PDT)
X-Received: by 10.180.105.226 with SMTP id gp2mr4463494wib.1.1437336428304;
        Sun, 19 Jul 2015 13:07:08 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.08
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:08 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CVCwCSAqxVPN4GFlxcgkFSVGmGUbUUCYFthXkEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDLEaAErkFIHhCsFlFKEb4k7ln6BCYMaPTGCSwEBAQ
X-IPAS-Result: A2CVCwCSAqxVPN4GFlxcgkFSVGmGUbUUCYFthXkEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDLEaAErkFIHhCsFlFKEb4k7ln6BCYMaPTGCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118937"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:09 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274284>

Commit 4b623d8 (MSVC: link in invalidcontinue.obj for better
POSIX compatibility, 2014-03-29) is not processed correctly
by the buildsystem. Ignore it.

Also split the .o and .obj processing; 'make' does not produce .obj
files. Only substitute filenames ending with .o when generating the
source .c filename.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 60c7a7d..9db3d43 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -289,7 +289,7 @@ sub handleLibLine
 #    exit(1);
     foreach (@objfiles) {
         my $sourcefile = $_;
-        $sourcefile =~ s/\.o/.c/;
+        $sourcefile =~ s/\.o$/.c/;
         push(@sources, $sourcefile);
         push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
         push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
@@ -333,8 +333,12 @@ sub handleLinkLine
         } elsif ($part =~ /\.(a|lib)$/) {
             $part =~ s/\.a$/.lib/;
             push(@libs, $part);
-        } elsif ($part =~ /\.(o|obj)$/) {
+        } elsif ($part eq 'invalidcontinue.obj') {
+            # ignore - known to MSVC
+        } elsif ($part =~ /\.o$/) {
             push(@objfiles, $part);
+        } elsif ($part =~ /\.obj$/) {
+            # do nothing, 'make' should not be producing .obj, only .o files
         } else {
             die "Unhandled link option @ line $lineno: $part";
         }
@@ -343,7 +347,7 @@ sub handleLinkLine
 #    exit(1);
     foreach (@objfiles) {
         my $sourcefile = $_;
-        $sourcefile =~ s/\.o/.c/;
+        $sourcefile =~ s/\.o$/.c/;
         push(@sources, $sourcefile);
         push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
         push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
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
