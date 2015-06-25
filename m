From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 13/17] engine.pl: provide more debug print statements
Date: Thu, 25 Jun 2015 01:03:49 +0100
Message-ID: <1435190633-2208-14-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBA4KVWWAKGQE2AJN6UQ@googlegroups.com Thu Jun 25 02:02:20 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBA4KVWWAKGQE2AJN6UQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBA4KVWWAKGQE2AJN6UQ@googlegroups.com>)
	id 1Z7ucN-0001KW-Lk
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by wibbw19 with SMTP id bw19sf18187239wib.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=EnYWwAbRPL6sig9OHAzLJA9OTxODPVThVVZiKB+szEw=;
        b=Tl+nJVS9C9Wh5F3Iwa/txQNRVBj0OXjjuBBhbLdrspr8I6153J5ncHsvYp6Z3Kb0N/
         iBxTxZuacf6jcHL0akhkNUySgr3IdRwXO54AN5L9YWUeMVhr1BOH6LF+YH3rwUAi2I7q
         zWSv8N3sgQXOzxRJXXHDrM7/xtXgVUbvpIV9JWScXSvD+6PsBfrxqvREiir88+lM1Yj5
         5kib0QlTTC3w2gzGRsRK2lSMsfISY/XVzzBHljEPcuXkl1sHcjUbdkv4yKDk1KX3A5r9
         mq7CNcdhdZpPEJtF35OF1wggymEhurvwUrZpVtNPUP2qCmNioi6eRv87U0McEQj9FCD3
         m7CQ==
X-Received: by 10.152.19.5 with SMTP id a5mr550229lae.23.1435190531396;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.228 with SMTP id z4ls282683lal.90.gmail; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.152.88.70 with SMTP id be6mr18392408lab.9.1435190530439;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id da3si4921wib.1.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CYBwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKFAYTFYgezWoBK5BQB4QrBZQFhFiEW4NsLpY8gQmDGD0xgkgBAQE
X-IPAS-Result: A2CYBwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKFAYTFYgezWoBK5BQB4QrBZQFhFiEW4NsLpY8gQmDGD0xgkgBAQE
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366782"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:59 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272627>

Assist developers transitioning between the two cultures
by including appropriate, but commented out, debug statements.

The exception is when an unhandled compiler option is detected,
where printing of the full line will supplement the line number and
option part. Otherwise the OP has no immediate mechanism for
inspecting the relevant part of the makedry output.

These debug print statements act as a guide for a poor man's --verbose
option. The test suite doesn't cover the contrib/buildsystems (or
Msysgit's msvc-build) contributions so fails to notice breakages there-in.

It is doubly hard to get developers to ride both horses so, contrary to
normal convention, retain selected debug statements as a safety net for
those willing to try.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 7a2aeef..ac2970a 100644
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
