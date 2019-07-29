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
	by dcvr.yhbt.net (Postfix) with ESMTP id B816D1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfG2UIV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:21 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37633 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfG2UIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:15 -0400
Received: by mail-wm1-f53.google.com with SMTP id f17so54558386wme.2
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VUEfmsBgPCNJ7yQ+GSXcoxV5ux3vtIFPNiAvdBsJMUc=;
        b=OuzHLvEmyuVqpcng4Tam8BjA2i/FYH3TQOAlm8MXzbjVBDj2YsxkEleqtRcy54JE/u
         afTf0SmMi5Y6Qq2E3LiFOxRUTvhotc4OtT7/x+Utio0tHu6rawEVHKqF9T+x1S1qoVhr
         r5IDNiwdtmiyYrBZMK8NCbH3okYgNOVeYvTaDgwZCnW+6Qi5wJSawy7Im+g5tZ5wUfwJ
         SEaXyEBzQj3Agn1wL0k7nLtD7FGYhNDKzoOWZPjPSHW5Rq6vZTmGgY1UOzXQHaxMiMbf
         YeqQ21ewAT4XdC2aHa1Y/nUd5ngNp6MP1LRganf4TPhecnw8KMXPNKvxWPGuZGVBWUeH
         aiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VUEfmsBgPCNJ7yQ+GSXcoxV5ux3vtIFPNiAvdBsJMUc=;
        b=tW6kXF5avKSoW+81SgegH310oMBxFKto1MGxkOeZbJINBPFpvy1OOc7hgxZQyH+VtR
         YNXyCYXIkacFkGpmpYpb/3FK39/iEG9gzpYVOOt2aw8EZnBHnDsbp5jsNtnl+nx7giUT
         XP7+c040UMw5MM7SkmP0ujf15bDNu79Bb1eX7x4MC4qtGTeLxydm6XOiJEtKnHFJVjwq
         Id4ZvRDwkh5rqbRM87c26uP4aqb9UfrxgIRu/Z92vINZftUC9J1IiJjv7cudei7WUeCD
         5jdWjQE4XInJYB8Et6nAwdq0849gXxPRzZDkv4OTpuYQbI/dGVBwVmLQxozRhZeXBx57
         BiwQ==
X-Gm-Message-State: APjAAAVeGg3zvMCz+6jyqRSL2EkJuVB1yXLWIVlwSfGwwad2p8439QcY
        G+/x7Vj3ScDbMWqJqA7eGF3k7+zg
X-Google-Smtp-Source: APXvYqwSB6jrHBMORlIGjXAVb+aAhUanLFUmMFrt7L7HYPHWzKS/hoTx1Crzb6cjaIe4EqEzu7rrtA==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr51077155wmj.39.1564430892674;
        Mon, 29 Jul 2019 13:08:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm59924958wrh.67.2019.07.29.13.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:12 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:12 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:53 GMT
Message-Id: <bc6a10ba47eed97e8122b35e95c26eb136d008bd.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 17/23] contrib/buildsystems: add a backend for modern
 Visual Studio versions
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
 contrib/buildsystems/Generators/Vcxproj.pm | 385 +++++++++++++++++++++
 1 file changed, 385 insertions(+)
 create mode 100644 contrib/buildsystems/Generators/Vcxproj.pm

diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
new file mode 100644
index 0000000000..e65d78e16d
--- /dev/null
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -0,0 +1,385 @@
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
+    <MakeDir Directories="..\\templates\\blt\\branches" />
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

