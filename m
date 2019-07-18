Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEDB81F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390540AbfGRNTT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:19 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33374 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390494AbfGRNTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:15 -0400
Received: by mail-wm1-f53.google.com with SMTP id h19so21502444wme.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JqEGn0iA9IcZlVsF3NPyPohrppKBFD3c4h35f5Za8Is=;
        b=StBejCXq7vCu34WQgeqB1sXM8oekRNAoBzAvluB9My/GnDgfeaS3Xfmkgst+0fLDXB
         VijSwwRjTZHqduTNf7RF/SRmrPLY2Bz9mXxIhKZ1U8Sz4DnCyVGvXeertybiIdXOFhgi
         /mTb/owj5nKm2fdlvYcEd0Pu1vykPK05yLneDxlsgcbdSnVUnIWNt0D5do5wfrZSlkEq
         ZzbUl092k95CganD/0W4KQ3IiSfjS3h1jz92bSh28muD/u8i1uLnUK5wgZ4RSJaHq23d
         fD2ayK9X8tQoYQ+RMTQxzNEeX77wm8mSllf0tj07EgVr+abooWHrsCYS8sAf4PfEkV/I
         LZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JqEGn0iA9IcZlVsF3NPyPohrppKBFD3c4h35f5Za8Is=;
        b=mztv2h/ZtLtWQrXvp5fFskUH2OIgITJWSV4vKAlt30Xqxbpe64QhX7YvjLGZ2C52Bs
         JGBNNw9AiTXvUXwtc3WF6yL102or1KOLv+Byob5sdReVdLkwTSjylKpkIOfOcC0lyUKp
         +Hp/Y2kTKQSLxvsKnbsLXwScwvOIryRSCqvexoPTWXl9HgxLtiXrhAO+k0vscXVXDAPJ
         8Y3q5xGqmnT08GH+3uMPzvaQtH2Cqk2zX4vvwl0RvVWB5vNdklfjAmEwW0AvcIRbFbsT
         DqvcQYxtUbxWpdRDDKmGd1Z3FUW3BHsNYcPxkncicL6LwHsWAgRH2olBQiPyZLIZkbQe
         2yOw==
X-Gm-Message-State: APjAAAWtfac0eyRHnZ4xI5JBR6pkNSQs+wihV/spi1fbl3NTRwaMp3hB
        IokQ7oO4VfTimLZil0ZpJKpqv/F1
X-Google-Smtp-Source: APXvYqzsJOUgiNfxSst9J/AiJ8hebZilv/asdVQjP3I1vNy+GV5JBFR/ZtCviDjxngvVjLC2DlwD2w==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr43135915wmb.19.1563455952501;
        Thu, 18 Jul 2019 06:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm50706661wra.27.2019.07.18.06.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:12 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:12 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:52 GMT
Message-Id: <59c50989eabc9da12246e58ddc3d87b34e6b46e4.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 17/24] contrib/buildsystems: add a backend for modern Visual
 Studio versions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Based on the previous patches in this patch series that fixed the
generator for `.vcproj` files (which were used by Visual Studio prior to
2015 to define projects), this patch offers to generate project
definitions for neweer versions of Visual Studio (which use `.vcxproj`
files).

To that end, this patch copy-edits the generator of the `.vcproj`.

In addition, we now use the `vcpkg` system which allows us to build
Git's dependencies (e.g. curl, libexpat) conveniently. The support
scripts were introduced in the `jh/msvc` patch series, and with this
patch we initialize the `vcpkg` conditionally, in the `libgit` project's
`PreBuildEvent`. To allow for parallel building of the projects, we
therefore put `libgit` at the bottom of the project hierarchy.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/Generators/Vcxproj.pm | 384 +++++++++++++++++++++
 1 file changed, 384 insertions(+)
 create mode 100644 contrib/buildsystems/Generators/Vcxproj.pm

diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
new file mode 100644
index 0000000000..9e7ed24912
--- /dev/null
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -0,0 +1,384 @@
+package Generators::Vcxproj;
+require Exporter;
+
+use strict;
+use vars qw($VERSION);
+use Digest::SHA qw(sha256_hex);
+
+our $VERSION = '1.00';
+our(@ISA, @EXPORT, @EXPORT_OK, @AVAILABLE);
+@ISA = qw(Exporter);
+
+BEGIN {
+    push @EXPORT_OK, qw(generate);
+}
+
+sub generate_guid ($) {
+	my $hex = sha256_hex($_[0]);
+	$hex =~ s/^(.{8})(.{4})(.{4})(.{4})(.{12}).*/{$1-$2-$3-$4-$5}/;
+	$hex =~ tr/a-z/A-Z/;
+	return $hex;
+}
+
+sub generate {
+    my ($git_dir, $out_dir, $rel_dir, %build_structure) = @_;
+    my @libs = @{$build_structure{"LIBS"}};
+    foreach (@libs) {
+        createProject($_, $git_dir, $out_dir, $rel_dir, \%build_structure, 1);
+    }
+
+    my @apps = @{$build_structure{"APPS"}};
+    foreach (@apps) {
+        createProject($_, $git_dir, $out_dir, $rel_dir, \%build_structure, 0);
+    }
+
+    createGlueProject($git_dir, $out_dir, $rel_dir, %build_structure);
+    return 0;
+}
+
+sub createProject {
+    my ($name, $git_dir, $out_dir, $rel_dir, $build_structure, $static_library) = @_;
+    my $label = $static_library ? "lib" : "app";
+    my $prefix = $static_library ? "LIBS_" : "APPS_";
+    my $config_type = $static_library ? "StaticLibrary" : "Application";
+    print "Generate $name vcxproj $label project\n";
+    my $cdup = $name;
+    $cdup =~ s/[^\/]+/../g;
+    $cdup =~ s/\//\\/g;
+    $rel_dir = $rel_dir eq "." ? $cdup : "$cdup\\$rel_dir";
+    $rel_dir =~ s/\//\\/g;
+
+    my $target = $name;
+    if ($static_library) {
+      $target =~ s/\.a//;
+    } else {
+      $target =~ s/\.exe//;
+    }
+
+    my $uuid = generate_guid($name);
+    $$build_structure{"$prefix${target}_GUID"} = $uuid;
+    my $vcxproj = $target;
+    $vcxproj =~ s/(.*\/)?(.*)/$&\/$2.vcxproj/;
+    $vcxproj =~ s/([^\/]*)(\/lib)\/(lib.vcxproj)/$1$2\/$1_$3/;
+    $$build_structure{"$prefix${target}_VCXPROJ"} = $vcxproj;
+
+    my @srcs = sort(map("$rel_dir\\$_", @{$$build_structure{"$prefix${name}_SOURCES"}}));
+    my @sources;
+    foreach (@srcs) {
+        $_ =~ s/\//\\/g;
+        push(@sources, $_);
+    }
+    my $defines = join(";", sort(@{$$build_structure{"$prefix${name}_DEFINES"}}));
+    my $includes= join(";", sort(map { s/^-I//; s/\//\\/g; File::Spec->file_name_is_absolute($_) ? $_ : "$rel_dir\\$_" } @{$$build_structure{"$prefix${name}_INCLUDES"}}));
+    my $cflags = join(" ", sort(map { s/^-[GLMOWZ].*//; s/.* .*/"$&"/; $_; } @{$$build_structure{"$prefix${name}_CFLAGS"}}));
+    $cflags =~ s/</&lt;/g;
+    $cflags =~ s/>/&gt;/g;
+
+    my $libs_release = "\n    ";
+    my $libs_debug = "\n    ";
+    if (!$static_library) {
+      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
+      $libs_debug = $libs_release;
+      $libs_debug =~ s/zlib\.lib/zlibd\.lib/;
+    }
+
+    $defines =~ s/-D//g;
+    $defines =~ s/</&lt;/g;
+    $defines =~ s/>/&gt;/g;
+    $defines =~ s/\'//g;
+
+    die "Could not create the directory $target for $label project!\n" unless (-d "$target" || mkdir "$target");
+
+    open F, ">$vcxproj" or die "Could not open $vcxproj for writing!\n";
+    binmode F, ":crlf :utf8";
+    print F chr(0xFEFF);
+    print F << "EOM";
+<?xml version="1.0" encoding="utf-8"?>
+<Project DefaultTargets="Build" ToolsVersion="14.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|Win32">
+      <Configuration>Debug</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|Win32">
+      <Configuration>Release</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Debug|x64">
+      <Configuration>Debug</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|x64">
+      <Configuration>Release</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
+  </ItemGroup>
+  <PropertyGroup Label="Globals">
+    <ProjectGuid>$uuid</ProjectGuid>
+    <Keyword>Win32Proj</Keyword>
+    <VCPKGArch Condition="'\$(Platform)'=='Win32'">x86-windows</VCPKGArch>
+    <VCPKGArch Condition="'\$(Platform)'!='Win32'">x64-windows</VCPKGArch>
+    <VCPKGArchDirectory>$cdup\\compat\\vcbuild\\vcpkg\\installed\\\$(VCPKGArch)</VCPKGArchDirectory>
+    <VCPKGBinDirectory Condition="'\(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\bin</VCPKGBinDirectory>
+    <VCPKGLibDirectory Condition="'\(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\lib</VCPKGLibDirectory>
+    <VCPKGBinDirectory Condition="'\(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\bin</VCPKGBinDirectory>
+    <VCPKGLibDirectory Condition="'\(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\lib</VCPKGLibDirectory>
+    <VCPKGIncludeDirectory>\$(VCPKGArchDirectory)\\include</VCPKGIncludeDirectory>
+    <VCPKGLibs Condition="'\(Configuration)'=='Debug'">$libs_debug</VCPKGLibs>
+    <VCPKGLibs Condition="'\(Configuration)'!='Debug'">$libs_release</VCPKGLibs>
+  </PropertyGroup>
+  <Import Project="\$(VCTargetsPath)\\Microsoft.Cpp.Default.props" />
+  <PropertyGroup Condition="'\$(Configuration)'=='Debug'" Label="Configuration">
+    <UseDebugLibraries>true</UseDebugLibraries>
+    <LinkIncremental>true</LinkIncremental>
+  </PropertyGroup>
+  <PropertyGroup Condition="'\$(Configuration)'=='Release'" Label="Configuration">
+    <UseDebugLibraries>false</UseDebugLibraries>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+  </PropertyGroup>
+  <PropertyGroup>
+    <ConfigurationType>$config_type</ConfigurationType>
+    <PlatformToolset>v140</PlatformToolset>
+    <!-- <CharacterSet>UTF-8</CharacterSet> -->
+    <OutDir>..\\</OutDir>
+    <!-- <IntDir>\$(ProjectDir)\$(Configuration)\\</IntDir> -->
+  </PropertyGroup>
+  <Import Project="\$(VCTargetsPath)\\Microsoft.Cpp.props" />
+  <ImportGroup Label="ExtensionSettings">
+  </ImportGroup>
+  <ImportGroup Label="Shared">
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets">
+    <Import Project="\$(UserRootDir)\\Microsoft.Cpp.\$(Platform).user.props" Condition="exists('\$(UserRootDir)\\Microsoft.Cpp.\$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup>
+    <GenerateManifest>false</GenerateManifest>
+    <EnableManagedIncrementalBuild>true</EnableManagedIncrementalBuild>
+  </PropertyGroup>
+  <ItemDefinitionGroup>
+    <ClCompile>
+      <AdditionalOptions>$cflags %(AdditionalOptions)</AdditionalOptions>
+      <AdditionalIncludeDirectories>$cdup;$cdup\\compat;$cdup\\compat\\regex;$cdup\\compat\\win32;$cdup\\compat\\poll;$cdup\\compat\\vcbuild\\include;\$(VCPKGIncludeDirectory);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <EnableParallelCodeGeneration />
+      <InlineFunctionExpansion>OnlyExplicitInline</InlineFunctionExpansion>
+      <PrecompiledHeader />
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+    </ClCompile>
+    <Lib>
+      <SuppressStartupBanner>true</SuppressStartupBanner>
+    </Lib>
+    <Link>
+      <AdditionalLibraryDirectories>\$(VCPKGLibDirectory);%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
+      <AdditionalDependencies>\$(VCPKGLibs);\$(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalOptions>invalidcontinue.obj %(AdditionalOptions)</AdditionalOptions>
+      <EntryPointSymbol>wmainCRTStartup</EntryPointSymbol>
+      <ManifestFile>$cdup\\compat\\win32\\git.manifest</ManifestFile>
+      <SubSystem>Console</SubSystem>
+    </Link>
+EOM
+    if ($target eq 'libgit') {
+        print F << "EOM";
+    <PreBuildEvent Condition="!Exists('$cdup\\compat\\vcbuild\\vcpkg\\installed\\\$(VCPKGArch)\\include\\openssl\\ssl.h')">
+      <Message>Initialize VCPKG</Message>
+      <Command>del "$cdup\\compat\\vcbuild\\vcpkg"</Command>
+      <Command>call "$cdup\\compat\\vcbuild\\vcpkg_install.bat"</Command>
+    </PreBuildEvent>
+EOM
+    }
+    print F << "EOM";
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'\$(Platform)'=='Win32'">
+    <Link>
+      <TargetMachine>MachineX86</TargetMachine>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'\$(Configuration)'=='Debug'">
+    <ClCompile>
+      <Optimization>Disabled</Optimization>
+      <PreprocessorDefinitions>WIN32;_DEBUG;$defines;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+    </ClCompile>
+    <Link>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'\$(Configuration)'=='Release'">
+    <ClCompile>
+      <Optimization>MaxSpeed</Optimization>
+      <IntrinsicFunctions>true</IntrinsicFunctions>
+      <PreprocessorDefinitions>WIN32;NDEBUG;$defines;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <FunctionLevelLinking>true</FunctionLevelLinking>
+      <FavorSizeOrSpeed>Speed</FavorSizeOrSpeed>
+    </ClCompile>
+    <Link>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+      <EnableCOMDATFolding>true</EnableCOMDATFolding>
+      <OptimizeReferences>true</OptimizeReferences>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemGroup>
+EOM
+    foreach(@sources) {
+        print F << "EOM";
+    <ClCompile Include="$_" />
+EOM
+    }
+    print F << "EOM";
+  </ItemGroup>
+EOM
+    if (!$static_library || $target =~ 'vcs-svn' || $target =~ 'xdiff') {
+      my $uuid_libgit = $$build_structure{"LIBS_libgit_GUID"};
+      my $uuid_xdiff_lib = $$build_structure{"LIBS_xdiff/lib_GUID"};
+
+      print F << "EOM";
+  <ItemGroup>
+    <ProjectReference Include="$cdup\\libgit\\libgit.vcxproj">
+      <Project>$uuid_libgit</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+EOM
+      if (!($name =~ 'xdiff')) {
+        print F << "EOM";
+    <ProjectReference Include="$cdup\\xdiff\\lib\\xdiff_lib.vcxproj">
+      <Project>$uuid_xdiff_lib</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+EOM
+      }
+      if ($name =~ /(test-(line-buffer|svn-fe)|^git-remote-testsvn)\.exe$/) {
+        my $uuid_vcs_svn_lib = $$build_structure{"LIBS_vcs-svn/lib_GUID"};
+        print F << "EOM";
+    <ProjectReference Include="$cdup\\vcs-svn\\lib\\vcs-svn_lib.vcxproj">
+      <Project>$uuid_vcs_svn_lib</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+EOM
+      }
+      print F << "EOM";
+  </ItemGroup>
+EOM
+    }
+    print F << "EOM";
+  <Import Project="\$(VCTargetsPath)\\Microsoft.Cpp.targets" />
+EOM
+    if (!$static_library) {
+      print F << "EOM";
+  <Target Name="${target}_AfterBuild" AfterTargets="AfterBuild">
+    <ItemGroup>
+      <DLLsAndPDBs Include="\$(VCPKGBinDirectory)\\*.dll;\$(VCPKGBinDirectory)\\*.pdb" />
+    </ItemGroup>
+    <Copy SourceFiles="@(DLLsAndPDBs)" DestinationFolder="\$(OutDir)" SkipUnchangedFiles="true" UseHardlinksIfPossible="true" />
+  </Target>
+EOM
+    }
+    print F << "EOM";
+</Project>
+EOM
+    close F;
+}
+
+sub createGlueProject {
+    my ($git_dir, $out_dir, $rel_dir, %build_structure) = @_;
+    print "Generate solutions file\n";
+    $rel_dir = "..\\$rel_dir";
+    $rel_dir =~ s/\//\\/g;
+    my $SLN_HEAD = "Microsoft Visual Studio Solution File, Format Version 11.00\n# Visual Studio 2010\n";
+    my $SLN_PRE  = "Project(\"{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}\") = ";
+    my $SLN_POST = "\nEndProject\n";
+
+    my @libs = @{$build_structure{"LIBS"}};
+    my @tmp;
+    foreach (@libs) {
+        $_ =~ s/\.a//;
+        push(@tmp, $_);
+    }
+    @libs = @tmp;
+
+    my @apps = @{$build_structure{"APPS"}};
+    @tmp = ();
+    foreach (@apps) {
+        $_ =~ s/\.exe//;
+        if ($_ eq "git" ) {
+            unshift(@tmp, $_);
+        } else {
+            push(@tmp, $_);
+        }
+    }
+    @apps = @tmp;
+
+    open F, ">git.sln" || die "Could not open git.sln for writing!\n";
+    binmode F, ":crlf :utf8";
+    print F chr(0xFEFF);
+    print F "$SLN_HEAD";
+
+    foreach (@apps) {
+        my $appname = $_;
+        my $uuid = $build_structure{"APPS_${appname}_GUID"};
+        print F "$SLN_PRE";
+	my $vcxproj = $build_structure{"APPS_${appname}_VCXPROJ"};
+	$vcxproj =~ s/\//\\/g;
+        $appname =~ s/.*\///;
+        print F "\"${appname}\", \"${vcxproj}\", \"${uuid}\"";
+        print F "$SLN_POST";
+    }
+    foreach (@libs) {
+        my $libname = $_;
+        my $uuid = $build_structure{"LIBS_${libname}_GUID"};
+        print F "$SLN_PRE";
+        my $vcxproj = $build_structure{"LIBS_${libname}_VCXPROJ"};
+	$vcxproj =~ s/\//\\/g;
+        $libname =~ s/\//_/g;
+        print F "\"${libname}\", \"${vcxproj}\", \"${uuid}\"";
+        print F "$SLN_POST";
+    }
+
+    print F << "EOM";
+Global
+	GlobalSection(SolutionConfigurationPlatforms) = preSolution
+		Debug|x64 = Debug|x64
+		Debug|x86 = Debug|x86
+		Release|x64 = Release|x64
+		Release|x86 = Release|x86
+	EndGlobalSection
+EOM
+    print F << "EOM";
+	GlobalSection(ProjectConfigurationPlatforms) = postSolution
+EOM
+    foreach (@apps) {
+        my $appname = $_;
+        my $uuid = $build_structure{"APPS_${appname}_GUID"};
+        print F "\t\t${uuid}.Debug|x64.ActiveCfg = Debug|x64\n";
+        print F "\t\t${uuid}.Debug|x64.Build.0 = Debug|x64\n";
+        print F "\t\t${uuid}.Debug|x86.ActiveCfg = Debug|Win32\n";
+        print F "\t\t${uuid}.Debug|x86.Build.0 = Debug|Win32\n";
+        print F "\t\t${uuid}.Release|x64.ActiveCfg = Release|x64\n";
+        print F "\t\t${uuid}.Release|x64.Build.0 = Release|x64\n";
+        print F "\t\t${uuid}.Release|x86.ActiveCfg = Release|Win32\n";
+        print F "\t\t${uuid}.Release|x86.Build.0 = Release|Win32\n";
+    }
+    foreach (@libs) {
+        my $libname = $_;
+        my $uuid = $build_structure{"LIBS_${libname}_GUID"};
+        print F "\t\t${uuid}.Debug|x64.ActiveCfg = Debug|x64\n";
+        print F "\t\t${uuid}.Debug|x64.Build.0 = Debug|x64\n";
+        print F "\t\t${uuid}.Debug|x86.ActiveCfg = Debug|Win32\n";
+        print F "\t\t${uuid}.Debug|x86.Build.0 = Debug|Win32\n";
+        print F "\t\t${uuid}.Release|x64.ActiveCfg = Release|x64\n";
+        print F "\t\t${uuid}.Release|x64.Build.0 = Release|x64\n";
+        print F "\t\t${uuid}.Release|x86.ActiveCfg = Release|Win32\n";
+        print F "\t\t${uuid}.Release|x86.Build.0 = Release|Win32\n";
+    }
+
+    print F << "EOM";
+	EndGlobalSection
+	GlobalSection(SolutionProperties) = preSolution
+		HideSolutionNode = FALSE
+	EndGlobalSection
+EndGlobal
+EOM
+    close F;
+}
+
+1;
-- 
gitgitgadget

