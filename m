From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 04/16] (msvc-build) Vcproj.pm: remove duplicate GUID
Date: Sun, 19 Jul 2015 21:08:04 +0100
Message-ID: <1437336497-4072-5-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBZ4GWCWQKGQEH75LSHY@googlegroups.com Sun Jul 19 22:07:07 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBZ4GWCWQKGQEH75LSHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBZ4GWCWQKGQEH75LSHY@googlegroups.com>)
	id 1ZGurX-0002Ht-Mr
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:03 +0200
Received: by wgjf7 with SMTP id f7sf441249wgj.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=R2o9Ruj9SW97hiYAyWWjtpcvyfO+0/S5DxgxfmqYqDY=;
        b=U14RWT7YaI302zdu7N47GS/kzaV5jMdqdClt7Qz/yQlDWqro+QdzVsFNIQZgJU5Njf
         8Mfym11A1ZvI1h2XQ17Y1qASnYVusaJaDIMktf/Uv8WIcYb2MMRNSGWx6OKvKVC2jz/7
         IsamoK+zJ7imNPVT7BuIGOMtEGOCAq+nKutyIEs+qExmctoRkfT2bmac2dYTuxS5jFLl
         jHmPgycu/LismUdx1G1eq5tdYjI7l0IpsGJKPlGzgRtydtAd20ZfdnAqnHPaaElI+Lwt
         QEuDg87qdlKu9rzK26VkNJljwtv/ODzOH4euSBP+uAE8LpXsWywClgBE6v3i7vSIXKuA
         3Ofg==
X-Received: by 10.180.90.235 with SMTP id bz11mr28470wib.6.1437336423398;
        Sun, 19 Jul 2015 13:07:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.12.145 with SMTP id y17ls677068wib.39.canary; Sun, 19 Jul
 2015 13:07:02 -0700 (PDT)
X-Received: by 10.194.188.104 with SMTP id fz8mr3199764wjc.1.1437336422713;
        Sun, 19 Jul 2015 13:07:02 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.02
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:02 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AFEQCSAqxVPN4GFlxcgkFSVGm7boF1hXEEAgKBGjsSAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKBg4GE4gyCcRfAQEIIo9tZQeEKwWUUoRviTuWfoEJgSocgVQ9MYEEgUcBAQE
X-IPAS-Result: A2AFEQCSAqxVPN4GFlxcgkFSVGm7boF1hXEEAgKBGjsSAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKBg4GE4gyCcRfAQEIIo9tZQeEKwWUUoRviTuWfoEJgSocgVQ9MYEEgUcBAQE
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118928"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:03 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274285>

Delete the duplicated GUID from the generation code for the Visual Studio
.sln project file.

The duplicate GUID tended to be allocated to test-svn-fe, which was then
ignored by Visual Studio / MSVC, and its omission from the build never
noticed.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Eric Sunshine correction http://marc.info/?l=git&m=143546075320855&w=2
---
 contrib/buildsystems/Generators/Vcproj.pm | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
index cfa74ad..1b01d58 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -52,7 +52,6 @@ my @GUIDS = (
     "{00785268-A9CC-4E40-AC29-BAC0019159CE}",
     "{4C06F56A-DCDB-46A6-B67C-02339935CF12}",
     "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
-    "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
     "{9392EB58-D7BA-410B-B1F0-B2FAA6BC89A7}",
     "{2ACAB2D5-E0CE-4027-BCA0-D78B2D7A6C66}",
     "{86E216C3-43CE-481A-BCB2-BE5E62850635}",
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
