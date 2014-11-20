From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC 4/4] Improve layout and reference msvc-build script
Date: Thu, 20 Nov 2014 23:38:02 +0000
Message-ID: <1416526682-6024-5-git-send-email-philipoakley@iee.org>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Wookey <michaelwookey@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBSPWXGRQKGQEDSVVTGY@googlegroups.com Fri Nov 21 00:37:47 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBSPWXGRQKGQEDSVVTGY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBSPWXGRQKGQEDSVVTGY@googlegroups.com>)
	id 1XrbII-0002ZP-RQ
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 00:37:46 +0100
Received: by mail-lb0-f192.google.com with SMTP id 10sf27142lbg.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 20 Nov 2014 15:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=KSrGUTPRpvh3APgTrjZf0LJA0ojnzU+bIabCkL8ifmY=;
        b=r7u5huu9iEsxuy7cTP8XwUkeTRGoESi8NmMfjGd2gQxe0gsIElmeQBVWG3DhNTgFEB
         /pDXiOJ4/M/JiWxZHXzB22pSl7ETL22l2Gn27bKIR5H3TVoP8FTO87ejxEEDbXNd14Ry
         oKpth0AeHUjOaooutiGtNsBnd3/pdvOkR8WdWPKJCD7B7S2gqDVkwGU4qZfEp7QlssZp
         Beiy+GgzDnumIyM46zt7aAZUcfsMOOoeGSFLhEbS7PUe3TaO61Lc4xIkOKo/nSPRPn7j
         7+uOAUZi8DyQNa3dyFo1R5TsiHvvoDst+wxjFp+y22iu1eSTipff7MUSW76kgkIVcvjJ
         vQSw==
X-Received: by 10.152.21.38 with SMTP id s6mr12847lae.7.1416526666744;
        Thu, 20 Nov 2014 15:37:46 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.200 with SMTP id x8ls116316lae.76.gmail; Thu, 20 Nov
 2014 15:37:45 -0800 (PST)
X-Received: by 10.112.147.131 with SMTP id tk3mr369517lbb.2.1416526665058;
        Thu, 20 Nov 2014 15:37:45 -0800 (PST)
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net. [62.24.128.242])
        by gmr-mx.google.com with ESMTP id jv2si90840wid.1.2014.11.20.15.37.44
        for <msysgit@googlegroups.com>;
        Thu, 20 Nov 2014 15:37:45 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.242 as permitted sender) client-ip=62.24.128.242;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgYqAPx5blROl3PwPGdsb2JhbABagw5VWYI2xlyCTodDBAICgQYXAQEBAQEBBQEBAQE4O4QDAQVWIxAISTkKBg4GExuIKgnUcwEBAQEGAiCRCAeESwWXNYhfPZECiAQ9MIJLAQEB
X-IPAS-Result: AgYqAPx5blROl3PwPGdsb2JhbABagw5VWYI2xlyCTodDBAICgQYXAQEBAQEBBQEBAQE4O4QDAQVWIxAISTkKBg4GExuIKgnUcwEBAQEGAiCRCAeESwWXNYhfPZECiAQ9MIJLAQEB
X-IronPort-AV: E=Sophos;i="5.07,426,1413241200"; 
   d="scan'208";a="651403032"
Received: from host-78-151-115-240.as13285.net (HELO localhost) ([78.151.115.240])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 20 Nov 2014 23:37:44 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.242 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Layout the 'either/or' with more white space to clarify
which alternatives are matched up.

Reference the build script which automates one sequence of options.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 compat/vcbuild/README | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index df8a657..f4f6723 100644
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
@@ -33,18 +37,27 @@ The Steps of Build Git with VS2008
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
+Or, use the msvc-build script; also in /msysgit/bin/msvc-build
+
+For those with VS2010: You may need to associate the generated .sln file with VS2010 rather than the MS version selector program.
-- 
1.9.4.msysgit.0

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
