Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A3B1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 08:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfF0Ith (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 04:49:37 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41158 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0Itg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 04:49:36 -0400
Received: by mail-ed1-f54.google.com with SMTP id p15so6285807eds.8
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xeSrcx/G6dzoNG8XYf9SQCa5bFuCu5yQ7YPXID9Jo7w=;
        b=ImhMX9/Uk98NGtcDjfw2Gnc4El7OjD7H3Zc6UqDMvGihuwURh3QuuzjpRGSvP3cR9t
         GCX4Qy6DFEwAoUpsUH46hY0tIEYGhZGkeAiyi2wjNr9p4i8pivSlzAqcjLWHe5eZNOPG
         aHjXuQ8BIbtUVYBWsD9sTckk6Gi85QI+XMtBWRG9xRPYtD88U7Cl2PYnQwKNYW1xYFAb
         4JVeWB/PmZrxldt6SflnRfvsmX+6vBo6Y6/dqP5m8eB904EA8FuJ6nIzaRy4m/aHYwGy
         arnUHBEolUPf8RgVmqQrygpmTS8BnjLR+T8dbrzSaGdV7JXAWWiEsRAAfe8Rhwh5T0n0
         O6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xeSrcx/G6dzoNG8XYf9SQCa5bFuCu5yQ7YPXID9Jo7w=;
        b=FLr6paNpOBGtWNaejqfcvJcy3ksFouxCASIxFWicisPLY1HV95Rkt9NcATrqD9H1M+
         gpiGdP2ZPthLeRzJJwoB7Od9AvG5+ORLKKglofC1i3nm/TL69YNfkMDigwi67iTyqOlM
         wA0xwTWp0TEAiu3ZfYgFa7/g2QkS0eZMKrEeVOCdv+dpoy+ClBLvwVJEv4XwHlydROec
         C5VNXPzygD46m5luzmeECKoKNCU40dB5LRz2+bzPzY47AqXsMVjGTQFhXC+knyJ1DrO8
         2p2yLgSbR0VAW0QKxmzDC75p0GDr94Y7V861mJddAVwN4SmQO/aaWaKFPnHu9G3xJn+f
         4dnA==
X-Gm-Message-State: APjAAAWCiC+H8lZteufinqnOpfXDIVuUF/HVlXsLhn2D3CBDhFj5ytM9
        xiX+4bPx7MTevntDWDQ/I/pdoa+C
X-Google-Smtp-Source: APXvYqxG3BIk42DHtn5Ab1NvI+dQu82070fDkCPuCYkGA3b3DwRBzamQsr+xYhXh+SXTF+2XoJk83A==
X-Received: by 2002:aa7:d781:: with SMTP id s1mr2703675edq.20.1561625374251;
        Thu, 27 Jun 2019 01:49:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b30sm535531edb.46.2019.06.27.01.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 01:49:33 -0700 (PDT)
Date:   Thu, 27 Jun 2019 01:49:33 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 08:49:32 GMT
Message-Id: <781bc458f2f72b435b9ae1f7b684ef60fe03c810.1561625372.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.214.git.gitgitgadget@gmail.com>
References: <pull.214.git.gitgitgadget@gmail.com>
From:   "Cesar Eduardo Barros via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: embed a manifest to trick UAC into Doing The Right
 Thing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Cesar Eduardo Barros <cesarb@cesarb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cesar Eduardo Barros <cesarb@cesarb.net>

On Windows >= Vista, not having an application manifest with a
requestedExecutionLevel can cause several kinds of confusing behavior.

The first and more obvious behavior is "Installer Detection" of the
"User Account Control" (also known as "UAC") feature, where Windows
sometimes decides (by looking at things like the file name and even
sequences of bytes within the executable) that an executable is an
installer and should run elevated (causing the well-known popup dialog
to appear). In Git's context, subcommands such as "git patch-id" or "git
update-index" fall prey to this behavior.

The second and more confusing behavior is "File Virtualization". It
means that when files are written without having write permission, it
does not fail (as expected), but they are instead redirected to
somewhere else. When the files are read, the original contents are
returned, though, not the ones that were just written somewhere else.
Even more confusing, not all write accesses are redirected; Trying to
write to write-protected .exe files, for example, will fail instead of
redirecting.

In addition to being unwanted behavior, File Virtualization causes
dramatic slowdowns in Git (see for instance
http://code.google.com/p/msysgit/issues/detail?id=320).

A third unwanted behavior of Windows >= Vista is that it lies about the
Windows version when calling `GetWindowsVersionEx()`.

There are two ways to prevent these unwanted behaviors: Either you embed
an application manifest (which really is an XML document conforming to a
specific schema) within all your executables, or you add an external
manifest (a file with the same name followed by `.manifest`) to all your
executables. Since Git's builtins are hardlinked (or copied), it is
simpler and more robust to embed a manifest.

Recent enough MSVC compilers already embed a working internal manifest,
and building with mingw-w64 (which is the case in Git for Windows' SDK)
does it, too, but for MinGW you have to do so by hand.

In any case, it is better to be explicit about this manifest, that way
changes in the compiler toolchain won't surprise us (as mingw-w64 once
did when it broke `GetWindowsVersionEx()` by mistake).

References:
  - New UAC Technologies for Windows Vista
    http://msdn.microsoft.com/en-us/library/bb756960.aspx
  - Create and Embed an Application Manifest (UAC)
    http://msdn.microsoft.com/en-us/library/bb756929.aspx

Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/git.manifest | 25 +++++++++++++++++++++++++
 git.rc                    |  2 ++
 2 files changed, 27 insertions(+)
 create mode 100644 compat/win32/git.manifest

diff --git a/compat/win32/git.manifest b/compat/win32/git.manifest
new file mode 100644
index 0000000000..771e3cce43
--- /dev/null
+++ b/compat/win32/git.manifest
@@ -0,0 +1,25 @@
+<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
+<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
+	<assemblyIdentity type="win32" name="Git" version="0.0.0.1" />
+	<trustInfo xmlns="urn:schemas-microsoft-com:asm.v2">
+		<security>
+			<requestedPrivileges>
+				<requestedExecutionLevel level="asInvoker" uiAccess="false" />
+			</requestedPrivileges>
+		</security>
+	</trustInfo>
+	<compatibility xmlns="urn:schemas-microsoft-com:compatibility.v1">
+		<application>
+			<!-- Windows Vista -->
+			<supportedOS Id="{e2011457-1546-43c5-a5fe-008deee3d3f0}"/>
+			<!-- Windows 7 -->
+			<supportedOS Id="{35138b9a-5d96-4fbd-8e2d-a2440225f93a}"/>
+			<!-- Windows 8 -->
+			<supportedOS Id="{4a2f28e3-53b9-4441-ba9c-d69d4a4a6e38}"/>
+			<!-- Windows 8.1 -->
+			<supportedOS Id="{1f676c76-80e1-4239-95bb-83d0f6d0da78}"/>
+			<!-- Windows 10 -->
+			<supportedOS Id="{8e0f7a12-bfb3-4fe8-b9a5-48fd50a15a9a}"/>
+		</application>
+	</compatibility>
+</assembly>
diff --git a/git.rc b/git.rc
index 49002e0d54..cc3fdc6cc6 100644
--- a/git.rc
+++ b/git.rc
@@ -20,3 +20,5 @@ BEGIN
     VALUE "Translation", 0x409, 1200
   END
 END
+
+1 RT_MANIFEST "compat/win32/git.manifest"
-- 
gitgitgadget
