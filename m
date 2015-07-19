From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 09/16] engine.pl: name the msvc buildsystem's
 makedry error file
Date: Sun, 19 Jul 2015 21:08:09 +0100
Message-ID: <1437336497-4072-10-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB3MGWCWQKGQE2SWNGUI@googlegroups.com Sun Jul 19 22:07:11 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB3MGWCWQKGQE2SWNGUI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB3MGWCWQKGQE2SWNGUI@googlegroups.com>)
	id 1ZGure-0002Kb-IJ
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:10 +0200
Received: by wgjf7 with SMTP id f7sf441392wgj.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=ATs1w1c1tT+YrRfkkfupVK3gl2nVP/hfHeXZC/Ibi/A=;
        b=CJQtQHpSixa8S/KWf8nK5DgrDBBDXxHcFmLEL2ItEl0V9LuMH/VLikVbnJawkYW5TB
         HFeETGw/nVtB+HKXV6+rzuzTsdtppXcV/G46yinG2ebTMutTkMPhKFQUA0gBfJTqRm86
         mE0use8gFrQKBRZC6VX/WaPtCqgfQDI6oFBoRaDOMyFkbucEFKqw8OXBR9uexB0lyGFp
         EvDC6yJWMyItTAfb86xXcLGrFLGH0/5mYkw0yOZZbiv8JD5s5kPGp+J+uNptpomVnuBT
         GOuOUzvp/4pp9SywLTWyYF1QSGoSHlyc/lyH6p/Kmp5G8OyhkkWBvLK59j480Y3mBiFm
         JAog==
X-Received: by 10.152.18.231 with SMTP id z7mr357118lad.23.1437336430279;
        Sun, 19 Jul 2015 13:07:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.161 with SMTP id x1ls46170lal.45.gmail; Sun, 19 Jul
 2015 13:07:08 -0700 (PDT)
X-Received: by 10.112.148.101 with SMTP id tr5mr13095064lbb.13.1437336428956;
        Sun, 19 Jul 2015 13:07:08 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.08
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:08 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ChAwCSAqxVPN4GFlxcgkFSVGm7bn8FcYVxBAICgRo6EwEBAQEBAQEGAQEBAUABP4QkAQEEViMQCEk5ChQGE4gyCcRfAQEBAQYCII9tZQeEKwWMOIgahG+JO5Z+gQmDGj0xgQSBRwEBAQ
X-IPAS-Result: A2ChAwCSAqxVPN4GFlxcgkFSVGm7bn8FcYVxBAICgRo6EwEBAQEBAQEGAQEBAUABP4QkAQEEViMQCEk5ChQGE4gyCcRfAQEBAQYCII9tZQeEKwWMOIgahG+JO5Z+gQmDGj0xgQSBRwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118939"
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274283>

Save the stderr from the dry MSVC make to a well named file for
later review. Use 'msvc-build-makedryerrors.txt' which should be
obvious as to its source, and is not ignored by 'git status'.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
fixed false mode change:- Junio's report (last line of)
http://marc.info/?l=git&m=143524504500824 (2015-06-25),

The cause was probably an early 'commit --amend' during a
rebase, and using the git gui to unstage the whole commit, then
pick up and commit hunks one at a time. Unfortunately, on Msysgit/g4w
core.filemode is false, so the execute bit was lost during the
unstage, never noticed, and there's no simple way of adding it back.

Discussion on correcting file mode on msysgit/git4Windows is at
https://groups.google.com/forum/#!topic/msysgit/zwH-qj0xR48
---
 contrib/buildsystems/engine.pl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 9db3d43..a6999b6 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -73,7 +73,10 @@ Running GNU Make to figure out build structure...
 EOM
 
 # Pipe a make --dry-run into a variable, if not already loaded from file
-@makedry = `cd $git_dir && make -n MSVC=1 V=1 2>/dev/null` if !@makedry;
+# Capture the make dry stderr to file for review (will be empty for a release build).
+
+my $ErrsFile = "msvc-build-makedryerrors.txt";
+@makedry = `cd $git_dir && make -n MSVC=1 V=1 2>$ErrsFile` if !@makedry;
 
 # Parse the make output into usable info
 parseMakeOutput();
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
