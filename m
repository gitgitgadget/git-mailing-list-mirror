From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 12/16] engine.pl: provide more debug print statements
Date: Sun, 19 Jul 2015 21:08:12 +0100
Message-ID: <1437336497-4072-13-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB34GWCWQKGQEP4PFRLA@googlegroups.com Sun Jul 19 22:07:21 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB34GWCWQKGQEP4PFRLA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB34GWCWQKGQEP4PFRLA@googlegroups.com>)
	id 1ZGurg-0002MY-DB
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:12 +0200
Received: by wgik5 with SMTP id k5sf789262wgi.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=TjHdo5EivpmVbNAnHN/L6I8fyHE/DaOEk87q3hQMs6g=;
        b=JORmna5RdXauqFAX3q1CKIaoU494aqouEwhCR6Pfb/VjRhFBtBOaYtsOp7f5LDHNrl
         skD6xXspn2kDp2CmsztFh+LsLjQ1qEMtQ6ucOy1Vc2mlliRuW0bGsJNbdPYz32q8J56V
         MynAA1ZSnEviIHdwKwKWZgID/YHZLw4Z8gl7iGdoaSjDIKFRVnmy81jts4bx/VsGGL9g
         HuewIBEnFz0HovRakryBw3lXEpC+J7JEXxp7AOsxTgMqDzKvYLlVx/gg0DIhjOuWvg6D
         K8dYOxM4vKw/y6T0ztjj/bU8ggqz4OsDJmX5+LdJGP5refeM6Pi+3BkxxaNZFDnAIdPk
         wYLw==
X-Received: by 10.153.4.129 with SMTP id ce1mr368669lad.0.1437336432020;
        Sun, 19 Jul 2015 13:07:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.120.3 with SMTP id ky3ls709359lab.70.gmail; Sun, 19 Jul
 2015 13:07:10 -0700 (PDT)
X-Received: by 10.112.215.67 with SMTP id og3mr13469657lbc.8.1437336430748;
        Sun, 19 Jul 2015 13:07:10 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.10
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AkCwCSAqxVPN4GFlxcgkFSVGm7ZQmBdYJDgy4EAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTFYgdCbMAkV8BAQEHIpBSB4QrBZRShG+FC4N/MZZ+gQmDGj0xgksBAQE
X-IPAS-Result: A2AkCwCSAqxVPN4GFlxcgkFSVGm7ZQmBdYJDgy4EAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTFYgdCbMAkV8BAQEHIpBSB4QrBZRShG+FC4N/MZZ+gQmDGj0xgksBAQE
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118942"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:11 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274290>

Assist developers transitioning between the two cultures
by including appropriate, but commented out, debug statements.

The exception is when an unhandled compiler option is detected,
where printing of the full line will supplement the line number and
option part. Otherwise the OP has no immediate mechanism for
inspecting the relevant part of the makedry output.

The commented out code is "deactivated code", not dead code, as per
DO178B safety critical software development guideline [1].

These debug print statements act as a guide for a poor man's --verbose
option. The test suite doesn't cover the contrib/buildsystems (or
Msysgit's msvc-build) contributions so fails to notice breakages there-in.

It is doubly hard to get developers to ride both horses so, contrary to
normal convention, retain selected debug statements as a safety net for
those willing to try.

[1] Dead code : Dead code is source code (and it is a part of binary code)
that is not executed in the final system and it will be not having
traceability to any requirements (one can say unintentional code).

Deactivated code: code which is commented out or removed via #ifdef's
(it is not a part of final binary code) and it will be having
traceability to its low level requirements (its a intentional code and
it can be activated in some configurations through hardware traps for
debugging or other purposes.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
My response to Sebastian Schuberth's comment on dead code
http://marc.info/?l=git&m=143630748919942&w=2 (2015-07-07)
---
 contrib/buildsystems/engine.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 4a843f3..3238d16 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -41,6 +41,7 @@ EOM
 # Parse command-line options
 while (@ARGV) {
     my $arg = shift @ARGV;
+	#print "Arg: $arg \n";
     if ("$arg" eq "-h" || "$arg" eq "--help" || "$arg" eq "-?") {
 	showUsage();
 	exit(0);
@@ -129,6 +130,7 @@ sub parseMakeOutput
     print "Parsing GNU Make output to figure out build structure...\n";
     my $line = 0;
     while (my $text = shift @makedry) {
+		#print "Make: $text\n"; # show the makedry line
         my $ate_next;
         do {
             $ate_next = 0;
@@ -263,6 +265,7 @@ sub handleCompileLine
         } elsif ($part =~ /\.(c|cc|cpp)$/) {
             $sourcefile = $part;
         } else {
+            print "full line: $line\n";
             die "Unhandled compiler option @ line $lineno: $part";
         }
     }
@@ -288,6 +291,7 @@ sub handleLibLine
             $libout = $part;
             $libout =~ s/\.a$//;
         } else {
+            print "full line: $line\n";
             die "Unhandled lib option @ line $lineno: $part";
         }
     }
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
