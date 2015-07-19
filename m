From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 03/16] .gitignore: ignore library directories
 created by MSVC VS2008 buildsystem
Date: Sun, 19 Jul 2015 21:08:03 +0100
Message-ID: <1437336497-4072-4-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBZUGWCWQKGQELVGQZLA@googlegroups.com Sun Jul 19 22:07:05 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBZUGWCWQKGQELVGQZLA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBZUGWCWQKGQELVGQZLA@googlegroups.com>)
	id 1ZGurW-0002Hq-QR
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:02 +0200
Received: by wgjf7 with SMTP id f7sf441176wgj.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=OlPdsmRi9BEjbufIlcZP4KkKJD9+k37WUV2DPZhH6RQ=;
        b=tX70kFadEgxkBSHZv8i5txdcGu0NVpte+ry0tuU5Uozu0kAC1jjUPKHUH2lBa8eU1e
         zpLDj7TNVVUH09SqFAAf9ht+8z1k8LBRGfqGpGk9+T5v7kRm/P/8RqkOyZHu0JyAfUg4
         fJuCFr8KHqyoSJG/qS02JGpVfaerDkA+swj29Agn7BN9w7+mc1FTvFe6o5/Q9nLAN1EF
         A/G8kogh7VY2j4Kp9ZDetg+HDLnLIPGGfLE1EkJjZQndAykz4e5PzkCvtKK3o9W2V28e
         g4ebcFT4Iu8SBf8dViMPShh4yu5DrM37nvov2YexAkg+b8BglGZ9foNsO9zN1fRnJjt6
         gKZQ==
X-Received: by 10.180.187.226 with SMTP id fv2mr28080wic.1.1437336422503;
        Sun, 19 Jul 2015 13:07:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.210.40 with SMTP id mr8ls674047wic.30.gmail; Sun, 19 Jul
 2015 13:07:01 -0700 (PDT)
X-Received: by 10.194.184.6 with SMTP id eq6mr13197456wjc.4.1437336421847;
        Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.01
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:01 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AvEgCSAqxVPN4GFlxcgkFSgT2GUb0DBAICgRo8EQEBAQEBAQEGAQEBAUABP4QkAQEEViMQCEk5ChQGE4gyxGgBAQgijQmDSQeEKwWUUqUogQmBNySBPz0xgksBAQE
X-IPAS-Result: A2AvEgCSAqxVPN4GFlxcgkFSgT2GUb0DBAICgRo8EQEBAQEBAQEGAQEBAUABP4QkAQEEViMQCEk5ChQGE4gyxGgBAQgijQmDSQeEKwWUUqUogQmBNySBPz0xgksBAQE
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118927"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:02 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274278>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 91e75ee..e35c492 100644
--- a/.gitignore
+++ b/.gitignore
@@ -178,6 +178,7 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
+/libgit
 /test-chmtime
 /test-ctype
 /test-config
@@ -210,6 +211,8 @@
 /test-urlmatch-normalization
 /test-wildmatch
 /common-cmds.h
+/vcs-svn_lib
+/xdiff_lib
 *.tar.gz
 *.dsc
 *.deb
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
