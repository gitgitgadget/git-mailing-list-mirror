From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 15/17] vcbuild/readme: Improve layout and reference
 msvc-build script
Date: Thu, 25 Jun 2015 01:03:51 +0100
Message-ID: <1435190633-2208-16-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBA4KVWWAKGQE2AJN6UQ@googlegroups.com Thu Jun 25 02:02:12 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBA4KVWWAKGQE2AJN6UQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f61.google.com ([74.125.82.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBA4KVWWAKGQE2AJN6UQ@googlegroups.com>)
	id 1Z7ucN-0001Km-V2
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:12 +0200
Received: by wggz12 with SMTP id z12sf16837262wgg.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Uc4MkGWtkR6R1SKOekmJFMY7lP3l1q7jL9H960pRpPc=;
        b=jh0WP4YRKETlpRHKFF+LVXoLMd3YJ7dt4RaySCyX0OOJNeX1lJcQGb66mYnhrumMr2
         s2mvb2zB2J3i81Ug7NvlKnzMfN6F9qG6ecwo3fR+89yd7PirNDje75NneFIBSLIIjrBE
         Hp1mwqErWoFj8LnpFr6FmnUMhgfTj0j/Cxsi80Vhbkq0IcLssOfCCxnHxCt1rPEd1eae
         VdM7J+8YdctVIpDx0SNvL6bZhrZSGxypoKfBh1EVtLmvJrnDDBSsHFpwP3rqrLBWymTr
         BsIyCZqfL/xcJViWSt1OEsqlNHCrKsYcq9TbCqoIcGe28gqeb1s1qf3vYjjst8oAk69H
         z6Kg==
X-Received: by 10.152.1.39 with SMTP id 7mr551781laj.18.1435190531685;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.23.195 with SMTP id o3ls282084laf.1.gmail; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.152.219.166 with SMTP id pp6mr37753022lac.1.1435190530541;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id da3si4921wib.1.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BLDQCSRItVPCWpEVxbgxFUX4gksECDAIMahXIEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKBg4GExuIGAnNYQErkFAHhCsFlAWEWIgzQpJgg1yBCYMYPTGCSAEBAQ
X-IPAS-Result: A2BLDQCSRItVPCWpEVxbgxFUX4gksECDAIMahXIEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKBg4GExuIGAnNYQErkFAHhCsFlAWEWIgzQpJgg1yBCYMYPTGCSAEBAQ
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366784"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:02:00 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272611>

Layout the 'either/or' with more white space to clarify
which alternatives are matched up.

Reference the Msysgit build script which automates one sequence of options.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 compat/vcbuild/README | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index df8a657..7548dc4 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -3,20 +3,24 @@ The Steps of Build Git with VS2008
 1. You need the build environment, which contains the Git dependencies
    to be able to compile, link and run Git with MSVC.
 
-   You can either use the binary repository:
+   You can either:
+      use the binary repository:
 
        WWW: http://repo.or.cz/w/msvcgit.git
        Git: git clone git://repo.or.cz/msvcgit.git
        Zip: http://repo.or.cz/w/msvcgit.git?a=snapshot;h=master;sf=zip
 
-   and call the setup_32bit_env.cmd batch script before compiling Git,
-   (see repo/package README for details), or the source repository:
+      and call the setup_32bit_env.cmd batch script before compiling Git,
+     (see repo/package README for details),
+
+   or:
+      use the source repository:
 
        WWW: http://repo.or.cz/w/gitbuild.git
        Git: git clone git://repo.or.cz/gitbuild.git
        Zip: (None, as it's a project with submodules)
 
-   and build the support libs as instructed in that repo/package.
+     and build the support libs as instructed in that repo/package.
 
 2. Ensure you have the msysgit environment in your path, so you have
    GNU Make, bash and perl available.
@@ -33,18 +37,25 @@ The Steps of Build Git with VS2008
        make common-cmds.h
    to generate the common-cmds.h file needed to compile git.
 
-4. Then either build Git with the GNU Make Makefile in the Git projects
-   root
+4. Then either
+
+     build Git with the GNU Make Makefile in the Git projects root
        make MSVC=1
-   or generate Visual Studio solution/projects (.sln/.vcproj) with the
+   or
+
+   generate Visual Studio solution/projects (.sln/.vcproj) with the
    command
        perl contrib/buildsystems/generate -g Vcproj
    and open and build the solution with the IDE
        devenv git.sln /useenv
-   or build with the IDE build engine directly from the command line
+     or
+
+   build with the IDE build engine directly from the command line
        devenv git.sln /useenv /build "Release|Win32"
    The /useenv option is required, so Visual Studio picks up the
    environment variables for the support libraries required to build
    Git, which you set up in step 1.
 
 Done!
+
+Or, use the Msysgit msvc-build script; available from that project.
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
