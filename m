From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 13/16] Vcproj.pm: list git.exe first to be
 startup project
Date: Sun, 19 Jul 2015 21:08:13 +0100
Message-ID: <1437336497-4072-14-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB34GWCWQKGQEP4PFRLA@googlegroups.com Sun Jul 19 22:07:27 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB34GWCWQKGQEP4PFRLA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB34GWCWQKGQEP4PFRLA@googlegroups.com>)
	id 1ZGurl-0002MX-Cq
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:17 +0200
Received: by wicmv11 with SMTP id mv11sf137877wic.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=TK0n+Z1GIQ4T/ysu0klsLGG6MlPO3/hoWj3RP4Vudrw=;
        b=KKX0HyB7XM425zGs9U6sy8c8/wrXW3gws/pDm8tbMf6fQptNwn7Q1tTGBdIJ4Nk+O1
         5YrQo1K0n6GbO96Hev9dtb6pmTVEBapbljk9zem/j7q8u0MTModcgTUZnjBYInebGfRc
         RMwKxSSrlR8KBeP4tiQ6VJSqw9jfgDaQ865/zHpIOnzL7TDd9MfIJttxg4BnpfTIN6mS
         iFQ54g/WuYuzAhV/EBEVw7TMo97CFVdfXdr7Y/8X6/DY0/ehcx6fRu1bLmivEi+Y92KQ
         8D+8/djFMB4nLLtd5KIC5LM7wDU//DLuwdjsVEbGNu5ZfaNg1C73Gp1/XxS8e9lxLZYz
         P4YA==
X-Received: by 10.180.206.84 with SMTP id lm20mr28107wic.13.1437336431988;
        Sun, 19 Jul 2015 13:07:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.126.3 with SMTP id mu3ls679069wib.45.canary; Sun, 19 Jul
 2015 13:07:11 -0700 (PDT)
X-Received: by 10.180.106.10 with SMTP id gq10mr4474194wib.0.1437336431342;
        Sun, 19 Jul 2015 13:07:11 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.11
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:11 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AVEQCSAqxVPN4GFlxcgkFSVGmzHIpHhXEEAgKBGj0QAQEBAQEBAQYBAQEBQAE/hCQBAQQjDwEjIxAIHQImAgI5CgYOBhMbiBcJryOVPAEBAQcCIIEijzAHgmiBQwWHDo1EhG+CYIZbln6BCYEqHIFUPTGCSwEBAQ
X-IPAS-Result: A2AVEQCSAqxVPN4GFlxcgkFSVGmzHIpHhXEEAgKBGj0QAQEBAQEBAQYBAQEBQAE/hCQBAQQjDwEjIxAIHQImAgI5CgYOBhMbiBcJryOVPAEBAQcCIIEijzAHgmiBQwWHDo1EhG+CYIZbln6BCYEqHIFUPTGCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118943"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:11 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274291>

Visual Studio takes the first listed application/library as the default
startup project [1].

Detect the 'git' project and place it the head of the apps list, rather
than the tail.

Export the apps list before libs list for both the projects and global
structures of the .sln file.

[1] http://stackoverflow.com/questions/1238553/
vs2008-where-is-the-startup-project-setting-stored-for-a-solution
    "In the solution file, there are a list of pseudo-XML "Project"
    entries. It turns out that whatever is the first one ends up as
    the Startup Project, unless it=E2=80=99s overridden in the suo file. Ar=
gh.
    I just rearranged the order in the file and it=E2=80=99s good."

    "just moving the pseudo-xml isn't enough. You also have to move the
    group of entries in the "GlobalSection(ProjectConfigurationPlatforms)
    =3D postSolution" group that has the GUID of the project you moved to
    the top. So there are two places to move lines."

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/Generators/Vcproj.pm | 33 ++++++++++++++++++---------=
----
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsyste=
ms/Generators/Vcproj.pm
index 1b01d58..cc2fa21 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -560,20 +560,18 @@ sub createGlueProject {
     foreach (@apps) {
         $_ =3D~ s/\//_/g;
         $_ =3D~ s/\.exe//;
-        push(@tmp, $_);
+        if ($_ eq "git" ) {
+            unshift(@tmp, $_);
+        } else {
+            push(@tmp, $_);
+        }
     }
     @apps =3D @tmp;
=20
     open F, ">git.sln" || die "Could not open git.sln for writing!\n";
     binmode F, ":crlf";
     print F "$SLN_HEAD";
-    foreach (@libs) {
-        my $libname =3D $_;
-        my $uuid =3D $build_structure{"LIBS_${libname}_GUID"};
-        print F "$SLN_PRE";
-        print F "\"${libname}\", \"${libname}\\${libname}.vcproj\", \"${uu=
id}\"";
-        print F "$SLN_POST";
-    }
+
     my $uuid_libgit =3D $build_structure{"LIBS_libgit_GUID"};
     my $uuid_xdiff_lib =3D $build_structure{"LIBS_xdiff_lib_GUID"};
     foreach (@apps) {
@@ -587,6 +585,13 @@ sub createGlueProject {
         print F "	EndProjectSection";
         print F "$SLN_POST";
     }
+    foreach (@libs) {
+        my $libname =3D $_;
+        my $uuid =3D $build_structure{"LIBS_${libname}_GUID"};
+        print F "$SLN_PRE";
+        print F "\"${libname}\", \"${libname}\\${libname}.vcproj\", \"${uu=
id}\"";
+        print F "$SLN_POST";
+    }
=20
     print F << "EOM";
 Global
@@ -598,17 +603,17 @@ EOM
     print F << "EOM";
 	GlobalSection(ProjectConfigurationPlatforms) =3D postSolution
 EOM
-    foreach (@libs) {
-        my $libname =3D $_;
-        my $uuid =3D $build_structure{"LIBS_${libname}_GUID"};
+    foreach (@apps) {
+        my $appname =3D $_;
+        my $uuid =3D $build_structure{"APPS_${appname}_GUID"};
         print F "\t\t${uuid}.Debug|Win32.ActiveCfg =3D Debug|Win32\n";
         print F "\t\t${uuid}.Debug|Win32.Build.0 =3D Debug|Win32\n";
         print F "\t\t${uuid}.Release|Win32.ActiveCfg =3D Release|Win32\n";
         print F "\t\t${uuid}.Release|Win32.Build.0 =3D Release|Win32\n";
     }
-    foreach (@apps) {
-        my $appname =3D $_;
-        my $uuid =3D $build_structure{"APPS_${appname}_GUID"};
+    foreach (@libs) {
+        my $libname =3D $_;
+        my $uuid =3D $build_structure{"LIBS_${libname}_GUID"};
         print F "\t\t${uuid}.Debug|Win32.ActiveCfg =3D Debug|Win32\n";
         print F "\t\t${uuid}.Debug|Win32.Build.0 =3D Debug|Win32\n";
         print F "\t\t${uuid}.Release|Win32.ActiveCfg =3D Release|Win32\n";
--=20
2.4.2.windows.1.5.gd32afb6

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
