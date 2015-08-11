From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH nd/dwim-wildcards-as-pathspecs] t2019: skip test
 requiring '*' in a file name non Windows
Date: Tue, 11 Aug 2015 22:38:46 +0200
Message-ID: <55CA5D56.6030800@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCJYV6HBKQINROVJVYCRUBH62EXVW@googlegroups.com Tue Aug 11 22:38:49 2015
Return-path: <msysgit+bncBCJYV6HBKQINROVJVYCRUBH62EXVW@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQINROVJVYCRUBH62EXVW@googlegroups.com>)
	id 1ZPGJs-0004o8-Q9
	for gcvm-msysgit@m.gmane.org; Tue, 11 Aug 2015 22:38:48 +0200
Received: by wicul11 with SMTP id ul11sf80687wic.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-spam-checked-in-group:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe;
        bh=kXvlY2/SpBzNdqvYg1pooDAOoPwURdsbF00diYouMJY=;
        b=e/mgLdjraIiiceEgCBgsyLBRFg9zdKQkEIg9r7QWS+IHB0GZ3/hA7oLXtw2UZ9DQQY
         UB0O80jwIeYWpB2YRte7KA6BcQOS5IQF5NzlXQvdUPX21ki/V8HKaiI7eNB7xdYLqoCZ
         /6ADLxGdLemFF3NabOPLweaMkB8wvf8SDQ4Rhr6MShr1ydYephB6hyZJXQx/LhYSzZyF
         Mrks8mEYcO2pQOSkDh9+cYTQzWEc/VHqHEXsWm6Fz10/kE/nbEaROqi4RrCLE6JLHE31
         7Vktv7hxpaYBamUTcaC1BLEl0PMohVOueLe2BZsD4eCDpohNJrNu/VcLFwk8Mpxm6CR2
         22fQ==
X-Received: by 10.180.80.202 with SMTP id t10mr77335wix.12.1439325528435;
        Tue, 11 Aug 2015 13:38:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.77.104 with SMTP id r8ls476257wiw.28.gmail; Tue, 11 Aug
 2015 13:38:47 -0700 (PDT)
X-Received: by 10.180.12.205 with SMTP id a13mr5898335wic.4.1439325527788;
        Tue, 11 Aug 2015 13:38:47 -0700 (PDT)
Received: from bsmtp8.bon.at (bsmtp8.bon.at. [213.33.87.20])
        by gmr-mx.google.com with ESMTPS id ec7si128442wib.3.2015.08.11.13.38.47
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 13:38:47 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.20 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.20;
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3mrQx31qr3z5tlH;
	Tue, 11 Aug 2015 22:38:47 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id D963B52D0;
	Tue, 11 Aug 2015 22:38:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 213.33.87.20 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mailfrom=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275722>

A test case introduced by ae454f61 (Add tests for wildcard "path vs ref"
disambiguation) allocates a file named '*.c'. This does not work on
Windows, because the OS forbids file names containing wildcard
characters. The test case fails where the shell attempts to allocate the
file. Skip the test on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This fixes a new failure in the test suite (t3404.8[67]) on Windows, but
 I got around to debug it only now.

 t/t2019-checkout-ambiguous-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index 8396320..199b22d 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -69,7 +69,7 @@ test_expect_success 'wildcard ambiguation, paths win' '
 	)
 '
 
-test_expect_success 'wildcard ambiguation, refs lose' '
+test_expect_success !MINGW 'wildcard ambiguation, refs lose' '
 	git init ambi2 &&
 	(
 		cd ambi2 &&
-- 
2.3.2.245.gb5bf9d3

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
