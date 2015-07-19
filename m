From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 14/16] vcbuild/readme: Improve layout and
 reference msvc-build script
Date: Sun, 19 Jul 2015 21:08:14 +0100
Message-ID: <1437336497-4072-15-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB4EGWCWQKGQE7CFDCOY@googlegroups.com Sun Jul 19 22:07:22 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB4EGWCWQKGQE7CFDCOY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB4EGWCWQKGQE7CFDCOY@googlegroups.com>)
	id 1ZGurg-0002Ms-V5
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:13 +0200
Received: by wilh8 with SMTP id h8sf28718771wil.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=YaM+bVHk0XQYr+PDqoycZ31S9zpcjBktwgmNs0sLce0=;
        b=CLgdsvH3vsgQOESkliLooCme1SnpY6XUs0mJ0ejSan7mQ8EB3Csf8abYzf0zNVyDxw
         5KpupO3sMVWL9dEkLBO8PDNKh/6B7+PZEEgSA41AZi0qneX0DLcFMZnt1N9Ft7E593D7
         bmGf1O3U9UNgvB4tRQ5lI/LhGu0n0CaFSszx51ULQdJBC2P090Ab9W5etTqNY34yJ/XK
         p2PfRmSIpuEWJSQA0l0IMRiteUFxz6D+pdj6IVnwlJokhMLXB33rR6PbYwu+Y3ClYA3p
         Jnb3V8ltqSiBi3UXzsk+9i8aWGVioKJe4ziMGqZoCeAEaVj5sNBr38Eh0wqy99/suCfy
         5Mag==
X-Received: by 10.180.219.107 with SMTP id pn11mr28298wic.10.1437336432685;
        Sun, 19 Jul 2015 13:07:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.104.68 with SMTP id gc4ls678247wib.26.canary; Sun, 19 Jul
 2015 13:07:12 -0700 (PDT)
X-Received: by 10.180.205.202 with SMTP id li10mr4457512wic.5.1437336432052;
        Sun, 19 Jul 2015 13:07:12 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.12
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:12 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AhDwCSAqxVPN4GFlxcgkFSVGm6Q4EiCYF1hXEEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKBg4GExuIFwnEXwErkFIHhCsFlFKEb4h1RpMdg2GBCYMaPTGCSwEBAQ
X-IPAS-Result: A2AhDwCSAqxVPN4GFlxcgkFSVGm6Q4EiCYF1hXEEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKBg4GExuIFwnEXwErkFIHhCsFlFKEb4h1RpMdg2GBCYMaPTGCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118944"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:12 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274292>

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
