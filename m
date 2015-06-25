From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 03/17] (msvc-build) Vcproj.pm: remove duplicate GUID
Date: Thu, 25 Jun 2015 01:03:39 +0100
Message-ID: <1435190633-2208-4-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:23 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001Jm-AQ
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by lbiv13 with SMTP id v13sf16791853lbi.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=2jrGJbPIcdky80mBRckFnPGlR88/QIBEg8ST9xC1q4Q=;
        b=qxHOULxWeXDulbf3SVQpDJC7z5mIsG4k+YkEDwOl7YaUSlAtsTojfvOwTe0wKoMVqf
         8c1gAA8XZCWX5W2pOtvOTnW2lyHlZxZiqnYvkXTQRgM8uN8FFyc5YkmWkBz5Zgh+lJbK
         +uOW8EuFX9uVeM/VbIULMm9s/X8HmZEbN+YCFM2q6PNlLXs63BHiErUyUOq+BGJocQdZ
         ENASHsxyZDMJaHW+GypZ/mo+kpfzVQ8uA7io6SPlJ7PBYspz0v/HkGqt3sFcwDdvPIzO
         GUaOXnpT/zocsJt3kTTL2dnvR9Ph3TziVehPKUgcWxfQU0TGnXiIlggruJzVZXGr+zRO
         F8dg==
X-Received: by 10.152.6.40 with SMTP id x8mr567639lax.40.1435190531056;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.227 with SMTP id n3ls288403lan.0.gmail; Wed, 24 Jun 2015
 17:02:09 -0700 (PDT)
X-Received: by 10.152.87.146 with SMTP id ay18mr15273089lab.6.1435190529832;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id da3si4921wib.1.2015.06.24.17.02.09
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C1DwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoGDgYTiDPNagErj2tlB4QrBZQFhFiIdZY8gQmBKRyBUz0xgQOBRQEBAQ
X-IPAS-Result: A2C1DwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoGDgYTiDPNagErj2tlB4QrBZQFhFiIdZY8gQmBKRyBUz0xgQOBRQEBAQ
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366768"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:54 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272626>

Delete the duplicated GUID from the generation code for the Visual Studio
.sln project file.

The duplicate GUID tended to be allocated to test-svn-fe, which was then
ignored by Visual Studio / MSVC, and it's omission from the build never
noticed.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
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
