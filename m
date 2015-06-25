From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 10/17] engine.pl: name the msvc buildsystem's
 makedry error file
Date: Thu, 25 Jun 2015 01:03:46 +0100
Message-ID: <1435190633-2208-11-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:35 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001K7-Bz
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by lams18 with SMTP id s18sf16781071lam.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=AtUJLMH26Xkj8qqGnK5WjxFCmsE9H9nyMoP9RoE+3GM=;
        b=eoB1VyVp8J3d/u79d1x6dlEKQFZy2EBbkvnj8pp3Qm8EtRZoEuZBLKik1CVOxd/QJR
         SO0CG17IlouzC0w27mxrWAkub+hdTr/8fFKyAoIvup+YLQN8bSy3+m7OrUjNvKvAQHZb
         Xj5LME7/b7uTVTyoyOOqSPpL9MaEDi1IXCwjYpipHvYk2uhBulv92Z7Ca03HfGmMECOo
         Y7KD2N8/mJ79hklydf9BtOVQjSLDWg6jIa/63S6oTZ/ONzzvkuMGno8yMqsIb+NJmPxT
         xuyqP91duGOdNEQ8wAmYmkEXH0TQPBEubmeosyCfQzGu5F/oiNj94KxhtTEHU2a0JCR5
         xijw==
X-Received: by 10.180.39.205 with SMTP id r13mr2318wik.2.1435190531098;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.93.201 with SMTP id cw9ls511853wib.33.gmail; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.180.81.170 with SMTP id b10mr298787wiy.4.1435190530319;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id t6si17968wiz.0.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C1DwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoUBhOIM81qASuPa2UHhCsFjBOHcoRYiHWWPIEJgxg9MYEDgUUBAQE
X-IPAS-Result: A2C1DwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoUBhOIM81qASuPa2UHhCsFjBOHcoRYiHWWPIEJgxg9MYEDgUUBAQE
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366777"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:57 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272628>

Save the stderr from the dry MSVC make to a well named file for
later review. Use 'msvc-build-makedryerrors.txt' which should be
obvious as to its source, and is not ignored by 'git status'.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
 mode change 100755 => 100644 contrib/buildsystems/engine.pl

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
old mode 100755
new mode 100644
index e8aa8ea..7eba870
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -73,7 +73,10 @@ Running GNU Make to figure out build structure...
 EOM
 
 # Pipe a make --dry-run into a variable, if not already loaded from file
-@makedry = `cd $git_dir && make -n MSVC=1 NO_PERL=1 V=1 2>/dev/null` if !@makedry;
+# Capture the make dry stderr to file for review (will be empty for a release build).
+
+my $ErrsFile = "msvc-build-makedryerrors.txt";
+@makedry = `cd $git_dir && make -n MSVC=1 NO_PERL=1 V=1 2>$ErrsFile` if !@makedry;
 
 # Parse the make output into usable info
 parseMakeOutput();
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
