Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4851F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeG3RSX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:23 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:46038 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeG3RSV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:21 -0400
Received: by mail-pg1-f179.google.com with SMTP id f1-v6so7459916pgq.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M1o44EZHEeIhuiY6YyRnD/SbimisWm4v7vdKTl7ZnPU=;
        b=uenktQgm4mzL8kAtBkVhZZ9yX9okRiV+lCDvLK0s2Sf+7bWfeuvLQ0DHXDf8TNY9q9
         p42dlbkhcujtT3gtpqf511Od/GQEFeKpV7ic00ItlrFPNR7yZVyHUgN30p6RKohGtKLp
         ubKMgCpsWgotwG0H0UxgTpsjdbZx8RXFMMS+/9DwT889UtCe08QGDOLPT/OzyPWxORx9
         BDqMlfoVY0nsUAVxfpKHff3+GvHnbOFVykE+99Vmy2IiFthXghmocXb3WQ4wkKSTiaIB
         Tq9liAyVRoafTLoUSHRktPIxB7tEivIF3tYBN9Dxmf9KHPyrvQXdLjyrHz0+jcI7C1kF
         le4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M1o44EZHEeIhuiY6YyRnD/SbimisWm4v7vdKTl7ZnPU=;
        b=smo3z888M1f8B5YfgnBYXVVlm3CRW5sBsfeIartJ4MaiT1oeM4XS6qIDh5djdfwxKT
         AS6pmibavxtOhc1Bd5SqTPkB9ZDdXjpsr2gQRrwwm1kAwHLnHJuxOcYYtCnXCvtc73+l
         PP2x7GvoXpuQYtWiYmLOAc5pQVqKYMt6kZJPapW5U7yadTHCdsYnThDcZwjJUj6Yc1a5
         c/Zr2POfTpRP6RlnlhYqjTHDWJJCBSDxhTeY19kn6DptZwnGif3qkCIF6L+D1azpoXgc
         ifwOldiof6plYsmwuUIHm70tEeyXI3m/7AWc35ai63wtWrJajK9hPjNJLFfDwQZAKv/D
         dX4w==
X-Gm-Message-State: AOUpUlE+TeK3hR8hzzPvYBY8z2njeXcFf1hpt8gB+rjghU7tIpi4dL2B
        8NIbI5RtJvZeF1ZrMNnerf0HFKgm
X-Google-Smtp-Source: AAOMgpdtYHiUMOPKjFclBvvUirmpOi2PhdnSKoKraMydg0SACSrUd6GIDjYXZi2n4AER2sWxj8mNbw==
X-Received: by 2002:a63:a502:: with SMTP id n2-v6mr17063485pgf.263.1532965367727;
        Mon, 30 Jul 2018 08:42:47 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id l84-v6sm19461209pfg.3.2018.07.30.08.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:46 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:46 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:34 GMT
Message-Id: <bbf13e40a501b6d46766cbf69fd6022b9c0b47b3.1532965363.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.v2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
        <pull.2.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/9] contrib: add a script to initialize VS Code
 configuration
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

VS Code is a lightweight but powerful source code editor which runs on
your desktop and is available for Windows, macOS and Linux. Among other
languages, it has support for C/C++ via an extension, which offers to
not only build and debug the code, but also Intellisense, i.e.
code-aware completion and similar niceties.

This patch adds a script that helps set up the environment to work
effectively with VS Code: simply run the Unix shell script
contrib/vscode/init.sh, which creates the relevant files, and open the
top level folder of Git's source code in VS Code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                    |   1 +
 contrib/vscode/.gitattributes |   1 +
 contrib/vscode/README.md      |  14 +++
 contrib/vscode/init.sh        | 165 ++++++++++++++++++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 contrib/vscode/.gitattributes
 create mode 100644 contrib/vscode/README.md
 create mode 100755 contrib/vscode/init.sh

diff --git a/.gitignore b/.gitignore
index 388cc4bee..592e8f879 100644
--- a/.gitignore
+++ b/.gitignore
@@ -206,6 +206,7 @@
 /config.mak.autogen
 /config.mak.append
 /configure
+/.vscode/
 /tags
 /TAGS
 /cscope*
diff --git a/contrib/vscode/.gitattributes b/contrib/vscode/.gitattributes
new file mode 100644
index 000000000..e89f2236e
--- /dev/null
+++ b/contrib/vscode/.gitattributes
@@ -0,0 +1 @@
+init.sh whitespace=-indent-with-non-tab
diff --git a/contrib/vscode/README.md b/contrib/vscode/README.md
new file mode 100644
index 000000000..8202d6203
--- /dev/null
+++ b/contrib/vscode/README.md
@@ -0,0 +1,14 @@
+Configuration for VS Code
+=========================
+
+[VS Code](https://code.visualstudio.com/) is a lightweight but powerful source
+code editor which runs on your desktop and is available for
+[Windows](https://code.visualstudio.com/docs/setup/windows),
+[macOS](https://code.visualstudio.com/docs/setup/mac) and
+[Linux](https://code.visualstudio.com/docs/setup/linux). Among other languages,
+it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools).
+
+To start developing Git with VS Code, simply run the Unix shell script called
+`init.sh` in this directory, which creates the configuration files in
+`.vscode/` that VS Code consumes. `init.sh` needs access to `make` and `gcc`,
+so run the script in a Git SDK shell if you are using Windows.
diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
new file mode 100755
index 000000000..3cc93243f
--- /dev/null
+++ b/contrib/vscode/init.sh
@@ -0,0 +1,165 @@
+#!/bin/sh
+
+die () {
+	echo "$*" >&2
+	exit 1
+}
+
+cd "$(dirname "$0")"/../.. ||
+die "Could not cd to top-level directory"
+
+mkdir -p .vscode ||
+die "Could not create .vscode/"
+
+# General settings
+
+cat >.vscode/settings.json <<\EOF ||
+{
+    "C_Cpp.intelliSenseEngine": "Default",
+    "C_Cpp.intelliSenseEngineFallback": "Disabled",
+    "files.associations": {
+        "*.h": "c",
+        "*.c": "c"
+    }
+}
+EOF
+die "Could not write settings.json"
+
+# Infer some setup-specific locations/names
+
+GCCPATH="$(which gcc)"
+GDBPATH="$(which gdb)"
+MAKECOMMAND="make -j5 DEVELOPER=1"
+OSNAME=
+X=
+case "$(uname -s)" in
+MINGW*)
+	GCCPATH="$(cygpath -am "$GCCPATH")"
+	GDBPATH="$(cygpath -am "$GDBPATH")"
+	MAKE_BASH="$(cygpath -am /git-cmd.exe) --command=usr\\\\bin\\\\bash.exe"
+	MAKECOMMAND="$MAKE_BASH -lc \\\"$MAKECOMMAND\\\""
+	OSNAME=Win32
+	X=.exe
+	;;
+Linux)
+	OSNAME=Linux
+	;;
+Darwin)
+	OSNAME=macOS
+	;;
+esac
+
+# Default build task
+
+cat >.vscode/tasks.json <<EOF ||
+{
+    // See https://go.microsoft.com/fwlink/?LinkId=733558
+    // for the documentation about the tasks.json format
+    "version": "2.0.0",
+    "tasks": [
+        {
+            "label": "make",
+            "type": "shell",
+            "command": "$MAKECOMMAND",
+            "group": {
+                "kind": "build",
+                "isDefault": true
+            }
+        }
+    ]
+}
+EOF
+die "Could not install default build task"
+
+# Debugger settings
+
+cat >.vscode/launch.json <<EOF ||
+{
+    // Use IntelliSense to learn about possible attributes.
+    // Hover to view descriptions of existing attributes.
+    // For more information, visit:
+    // https://go.microsoft.com/fwlink/?linkid=830387
+    "version": "0.2.0",
+    "configurations": [
+        {
+            "name": "(gdb) Launch",
+            "type": "cppdbg",
+            "request": "launch",
+            "program": "\${workspaceFolder}/git$X",
+            "args": [],
+            "stopAtEntry": false,
+            "cwd": "\${workspaceFolder}",
+            "environment": [],
+            "externalConsole": true,
+            "MIMode": "gdb",
+            "miDebuggerPath": "$GDBPATH",
+            "setupCommands": [
+                {
+                    "description": "Enable pretty-printing for gdb",
+                    "text": "-enable-pretty-printing",
+                    "ignoreFailures": true
+                }
+            ]
+        }
+    ]
+}
+EOF
+die "Could not write launch configuration"
+
+# C/C++ extension settings
+
+make -f - OSNAME=$OSNAME GCCPATH="$GCCPATH" vscode-init \
+	>.vscode/c_cpp_properties.json <<\EOF ||
+include Makefile
+
+vscode-init:
+	@mkdir -p .vscode && \
+	incs= && defs= && \
+	for e in $(ALL_CFLAGS); do \
+		case "$$e" in \
+		-I.) \
+			incs="$$(printf '% 16s"$${workspaceRoot}",\n%s' \
+				"" "$$incs")" \
+			;; \
+		-I/*) \
+			incs="$$(printf '% 16s"%s",\n%s' \
+				"" "$${e#-I}" "$$incs")" \
+			;; \
+		-I*) \
+			incs="$$(printf '% 16s"$${workspaceRoot}/%s",\n%s' \
+				"" "$${e#-I}" "$$incs")" \
+			;; \
+		-D*) \
+			defs="$$(printf '% 16s"%s",\n%s' \
+				"" "$$(echo "$${e#-D}" | sed 's/"/\\&/g')" \
+				"$$defs")" \
+			;; \
+		esac; \
+	done && \
+	echo '{' && \
+	echo '    "configurations": [' && \
+	echo '        {' && \
+	echo '            "name": "$(OSNAME)",' && \
+	echo '            "intelliSenseMode": "clang-x64",' && \
+	echo '            "includePath": [' && \
+	echo "$$incs" | sort | sed '$$s/,$$//' && \
+	echo '            ],' && \
+	echo '            "defines": [' && \
+	echo "$$defs" | sort | sed '$$s/,$$//' && \
+	echo '            ],' && \
+	echo '            "browse": {' && \
+	echo '                "limitSymbolsToIncludedHeaders": true,' && \
+	echo '                "databaseFilename": "",' && \
+	echo '                "path": [' && \
+	echo '                    "$${workspaceRoot}"' && \
+	echo '                ]' && \
+	echo '            },' && \
+	echo '            "cStandard": "c11",' && \
+	echo '            "cppStandard": "c++17",' && \
+	echo '            "compilerPath": "$(GCCPATH)"' && \
+	echo '        }' && \
+	echo '    ],' && \
+	echo '    "version": 4' && \
+	echo '}'
+EOF
+die "Could not write settings for the C/C++ extension"
-- 
gitgitgadget

