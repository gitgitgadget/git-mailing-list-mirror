From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 02/16] .gitignore: improve MSVC ignore patterns
Date: Sun, 19 Jul 2015 21:08:02 +0100
Message-ID: <1437336497-4072-3-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBZMGWCWQKGQE6YO5OFY@googlegroups.com Sun Jul 19 22:07:02 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBZMGWCWQKGQE6YO5OFY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f59.google.com ([209.85.215.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBZMGWCWQKGQE6YO5OFY@googlegroups.com>)
	id 1ZGurW-0002HA-3F
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:02 +0200
Received: by lagw2 with SMTP id w2sf52350493lag.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=/KEsw/FQwtzs6MqUdvh72IRYSP9TWSUDBhohskkTQEE=;
        b=TOgdtlh2wGQIY4lntkFYQibipsk4UU6DG9DXCOEiVTBiGaVqzVFKjwCy0gSVAIEVuJ
         Dal4RCFnbrtx2e9NbSzCGIZaVcvCmuoApZ707WvBg4k3yzryeMy4w4EVSSEkFCh9Aukd
         rOCgjsmutnLRkNUajAPf20R+oP+ydlLMMgMC+Q6L1r35oLW8JTkp4NC4N/s6K5XfxIRj
         lWUDyUTAAwpCSVTiQ8gbqSMfJhQZY9ocb+ENiNHjxhU/6wLSutbd9os7t9caQ47O7piF
         teZoV04qqXrxB5L52rx3RFfsBK8mOJ+GcGlXqD0YrQa/pM2ebYJOY524ki6Fer4tdkN0
         Gd6g==
X-Received: by 10.180.86.165 with SMTP id q5mr27932wiz.0.1437336421825;
        Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.24.103 with SMTP id t7ls695278wif.51.canary; Sun, 19 Jul
 2015 13:07:01 -0700 (PDT)
X-Received: by 10.194.173.3 with SMTP id bg3mr1440223wjc.5.1437336421226;
        Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.01
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AEEQCSAqxVPN4GFlxcgkFSVGm7boF1hXEEAgKBGjoTAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDIJxF8BAQgikFIHhCsFhWCOcoRviTuWfoEJgxo9MYJLAQEB
X-IPAS-Result: A2AEEQCSAqxVPN4GFlxcgkFSVGm7boF1hXEEAgKBGjoTAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDIJxF8BAQgikFIHhCsFhWCOcoRviTuWfoEJgxo9MYJLAQEB
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118925"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:01 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274280>

Add the Microsoft .manifest pattern, and correct the generic 'Debug'
and 'Release' directory patterns which were mechanically adjusted way
back in c591d5f (gitignore: root most patterns at the top-level directory,
2009-10-26) to allow multi-level projects within the Git suite.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Junio's correction http://marc.info/?l=git&m=143524522500906&w=2
(2015-06-25)
---
 .gitignore | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index a685ec1..91e75ee 100644
--- a/.gitignore
+++ b/.gitignore
@@ -247,5 +247,6 @@
 *.user
 *.idb
 *.pdb
-/Debug/
-/Release/
+*.manifest
+Debug/
+Release/
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
