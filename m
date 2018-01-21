Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88981F576
	for <e@80x24.org>; Sun, 21 Jan 2018 12:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeAUMTM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 21 Jan 2018 07:19:12 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:59046 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeAUMTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 07:19:11 -0500
X-Greylist: delayed 3581 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2018 07:19:11 EST
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id w0LBJUow026498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 06:19:30 -0500
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: git svn clone - Malformed network data: The XML response contains invalid XML: Malformed XML: no element found at /usr/share/perl5/vendor_perl/5.26/Git/SVN/Ra.pm line 312
Date:   Sun, 21 Jan 2018 06:19:30 -0500
Organization: PD Inc
Message-ID: <042F7DAF79EF4C29B85958BD75AE019F@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdOSqbTsX/wClepxS46ZdaYEHn6jVg==
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I am asuming that this is an issue caused by codeplex's svn from tfs implementation. Does anyone here have any insight?

$ git --version
git version 2.15.0

$ git svn clone https://smtp4dev.svn.codeplex.com/svn smtp4dev
Initialized empty Git repository in /cygdrive/c/Users/Public/Desktop/projects/smtp4dev/.git/
r20111 = 443d627cdfeeb240162b9f089ab50c6f058a1260 (refs/remotes/git-svn)
        A       trunk/smtp4dev/smtp4dev.csproj
        A       trunk/smtp4dev/Resources/Icon2.ico
        A       trunk/smtp4dev/Resources/Icon1.ico
        A       trunk/smtp4dev/RegistrySettings.cs
        A       trunk/smtp4dev/Properties/Settings.settings
        A       trunk/smtp4dev/Properties/Settings.Designer.cs
        A       trunk/smtp4dev/Properties/Resources.resx
        A       trunk/smtp4dev/Properties/Resources.Designer.cs
        A       trunk/smtp4dev/Properties/AssemblyInfo.cs
        A       trunk/smtp4dev/Program.cs
        A       trunk/smtp4dev/OptionsForm.resx
        A       trunk/smtp4dev/OptionsForm.Designer.cs
        A       trunk/smtp4dev/OptionsForm.cs
        A       trunk/smtp4dev/obj/Debug/TempPE/Properties.Resources.Designer.cs.dll
        A       trunk/smtp4dev/obj/Debug/smtp4dev.Properties.Resources.resources
        A       trunk/smtp4dev/obj/Debug/smtp4dev.pdb
        A       trunk/smtp4dev/obj/Debug/smtp4dev.OptionsForm.resources
        A       trunk/smtp4dev/obj/Debug/smtp4dev.MainForm.resources
        A       trunk/smtp4dev/obj/Debug/smtp4dev.exe
        A       trunk/smtp4dev/obj/Debug/smtp4dev.csproj.GenerateResource.Cache
        A       trunk/smtp4dev/obj/Debug/smtp4dev.csproj.FileListAbsolute.txt
        A       trunk/smtp4dev/obj/Debug/ResolveAssemblyReference.cache
        A       trunk/smtp4dev/MainForm.resx
        A       trunk/smtp4dev/MainForm.Designer.cs
        A       trunk/smtp4dev/MainForm.cs
        A       trunk/smtp4dev/lib/log4net.dll
        A       trunk/smtp4dev/lib/cses.smtp.server.xml
        A       trunk/smtp4dev/lib/cses.smtp.server.dll
        A       trunk/smtp4dev/Email.cs
        A       trunk/smtp4dev/bin/Debug/smtp4dev.vshost.exe
        A       trunk/smtp4dev/bin/Debug/smtp4dev.vshost.exe.manifest
        A       trunk/smtp4dev/bin/Debug/smtp4dev.vshost.exe.config
        A       trunk/smtp4dev/bin/Debug/smtp4dev.pdb
        A       trunk/smtp4dev/bin/Debug/smtp4dev.exe
        A       trunk/smtp4dev/bin/Debug/smtp4dev.exe.config
        A       trunk/smtp4dev/bin/Debug/log4net.dll
        A       trunk/smtp4dev/bin/Debug/cses.smtp.server.xml
        A       trunk/smtp4dev/bin/Debug/cses.smtp.server.dll
        A       trunk/smtp4dev/app.config
        A       trunk/smtp4dev.suo
        A       trunk/smtp4dev.sln
        A       trunk/smtp4dev.4.5.resharper.user
        A       trunk/Setup/Setup.vdproj
        A       trunk/Setup/Debug/smtp4dev-1.0.0.0.zip
        A       trunk/Setup/Debug/Setup.msi
        A       trunk/Setup/Debug/setup.exe
        A       trunk/Setup/Debug/LICENSE
        A       trunk/Setup/Debug/LICENSE.log4net
        A       trunk/Setup/Debug/LICENSE.cses-smtp-server
        A       trunk/LICENSE
        A       trunk/LICENSE.rtf
        A       trunk/LICENSE.log4net
        A       trunk/LICENSE.cses-smtp-server
        A       trunk/_ReSharper.smtp4dev/Xaml/CacheProvider.dat
        A       trunk/_ReSharper.smtp4dev/WordIndex.New/6/61e28584.dat
        A       trunk/_ReSharper.smtp4dev/WordIndex.New/.version
        A       trunk/_ReSharper.smtp4dev/WebsiteFileReferences/.version
        A       trunk/_ReSharper.smtp4dev/TodoCache/9/3ace61b9.dat
        A       trunk/_ReSharper.smtp4dev/TodoCache/.version
        A       trunk/_ReSharper.smtp4dev/ProjectModel/ProjectModel.dat
        A       trunk/_ReSharper.smtp4dev/CachesImage.bin
W: +empty_dir: trunk/Setup/Release
W: +empty_dir: trunk/smtp4dev/obj/Debug/Refactor
r20114 = 569cc523b14d6346f3198f37b27fccb8cb572ab1 (refs/remotes/git-svn)
... It chugs along then ...
W: -empty_dir: trunk/Rnwood.Smtp4dev/Behaviour.cs
W: -empty_dir: trunk/Rnwood.SmtpServer/SmtpRequest.cs
r27599 = 9e769d8327767a155d7b96b7cc28579cf0ed4c93 (refs/remotes/git-svn)
Malformed network data: The XML response contains invalid XML: Malformed XML: no element found at /usr/share/perl5/vendor_perl/5.26/Git/SVN/Ra.pm line 312.


I have tried to fiddle with --log-window-size but nothing seemed to work. (https://stackoverflow.com/questions/38071052/getting-error-while-migrating-code-from-svn-to-git-repository-malformed-network)


-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

