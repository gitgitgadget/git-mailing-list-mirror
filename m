From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 14/17] Vcproj.pm: list git.exe first to be startup project
Date: Thu, 25 Jun 2015 01:03:50 +0100
Message-ID: <1435190633-2208-15-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:16 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f191.google.com ([209.85.217.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001KM-DO
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by lbiv13 with SMTP id v13sf16788008lbi.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=+zVW2ad2wIh7wWCKPSYEfIp1ocxLJYG9EPBzd0WaSoQ=;
        b=vLzvQKfFX5wC9esZJJcHEUFo8hB0942BfK+0cSHbombasIXjXQra1c920900oXQUOl
         AOKTWs0PHv7jDxajvzBB82FG80rpbfyA/EJpA55uitnUsCNneS/Gvk9QPaTc/xpA8gR5
         PpxFDz6M/f5Av5W7ILhNj5fghJ46XSHDdNLFRnVJgyK5Hw3EPYPJMSNI1h1JxphITkwK
         rilLCowNXASauhXJMo5Ttvs/uOsj68T1nrHgRDqb1u6Cj1DfQ0mLVatduM3qW+OMGD85
         DeLv2E0zhb5k4F0IsyuOC98AJPaxialx+sRawNe/QfhCLmk3qmWcSrBumIeGoMltJwWd
         IAwA==
X-Received: by 10.181.8.204 with SMTP id dm12mr2201wid.16.1435190531154;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.202.37 with SMTP id kf5ls1309445wic.50.canary; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.180.87.201 with SMTP id ba9mr280671wib.3.1435190530461;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id t6si17968wiz.0.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C8BwCSRItVPCWpEVxbgxFUX4MehQasPIQEhhqFcgQCAoFMTQEBAQEBAQcBAQEBQT+EIwEBBCMPASMjEAgdAiYCAjkKBg4GExuIGAm3LZY0AQEBBwIggSGPLweCaIFDBYcDjQKEWIJXhh6WPIEJgSkcgVM9MYJIAQEB
X-IPAS-Result: A2C8BwCSRItVPCWpEVxbgxFUX4MehQasPIQEhhqFcgQCAoFMTQEBAQEBAQcBAQEBQT+EIwEBBCMPASMjEAgdAiYCAjkKBg4GExuIGAm3LZY0AQEBBwIggSGPLweCaIFDBYcDjQKEWIJXhh6WPIEJgSkcgVM9MYJIAQEB
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366783"
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272618>

Visual Studio take the first listed application/library as the default
startup project [1]. Parse the application list for git.exe, then list
the libraries, then the other git dashed forms in the git.sln file.

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
2.3.1

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
