From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 01/17] .gitignore: improve MSVC ignore patterns
Date: Thu, 25 Jun 2015 01:03:37 +0100
Message-ID: <1435190633-2208-2-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:28 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001JD-4j
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by wibbw19 with SMTP id bw19sf18187065wib.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=8X4VwyLNPWTqnp/sEtqEKy7hu1z7+D123ZdZzEh1IDY=;
        b=bq8+7kY9H9ccSCQU+dXfjW5P/C3FMokEN+w4e88U/xd3zaT5A3WmlpslFRHblj47Xa
         dzekmm1/Z3e0TVIvTmVmBHkoqTk4fxZDluaaJrweWM+pgr66LjMstIdyUjWzg0iw8GIV
         lvCCKQUt7YTypEroeYCRpzsPm2hxD9WjHpd2oImTK7mqQ97DueJYQAtSCKhsbH1GaSNz
         3D1UPsCuy/nfVpcfyrldiHQpRpfY1k44yzuu7WWpWldlIozUEbcISqBp4Ztvwol2/gTl
         JtW4+hWCvgRb3ySssrm/bseiR0Go24exgWzxqAJ2DfzkLuPoO1VbswCs8l0sPCTqWhun
         GdGA==
X-Received: by 10.152.29.5 with SMTP id f5mr562983lah.19.1435190530762;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.199 with SMTP id m7ls278429lam.83.gmail; Wed, 24 Jun
 2015 17:02:09 -0700 (PDT)
X-Received: by 10.152.37.101 with SMTP id x5mr37740598laj.5.1435190529523;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id da3si4921wib.1.2015.06.24.17.02.09
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CvDwCSRItVPCWpEVxbgxGBM4ZMgViwQIwMBAICgUxNAQEBAQEBBwEBAQFBP0EFg10BAQRWIxAISTkKFAYTiDPNagErkFAHhCsFhVqOK6QJgQmDGD0xgkgBAQE
X-IPAS-Result: A2CvDwCSRItVPCWpEVxbgxGBM4ZMgViwQIwMBAICgUxNAQEBAQEBBwEBAQFBP0EFg10BAQRWIxAISTkKFAYTiDPNagErkFAHhCsFhVqOK6QJgQmDGD0xgkgBAQE
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366753"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:52 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272619>

Add the Microsoft .manifest pattern, and correct the generic 'Debug'
and 'Release' directory patterns which were mechanically adjusted way
back in c591d5f (gitignore: root most patterns at the top-level directory,
2009-10-26) to allow multi-level projects within the Git suite.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 .gitignore | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 422c538..55498c1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -246,5 +246,6 @@
 *.user
 *.idb
 *.pdb
-/Debug/
-/Release/
+*.manifest
+**/Debug/
+**/Release/
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
