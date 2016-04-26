From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 1/4] githooks.txt: Improve the intro section
Date: Tue, 26 Apr 2016 18:13:19 +0000
Message-ID: <1461694402-9629-2-git-send-email-avarab@gmail.com>
References: <1461694402-9629-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:14:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7Up-0006kV-PH
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbcDZSN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 14:13:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33214 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbcDZSN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:13:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so6593659wme.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lcf3tCpKs15s8cLRCsk1I2PtCuyfBMqxWEQDkks1/Ao=;
        b=B02l62u66fRJ482Mslq16DcmceCv3/Tm+0wCI635Li1OZuB1hrA+nx8kV4S+xhgY7s
         /utPAJgrz3KH84i85kSx0C5W4N6EtL6hZh2SQvdOMQAZU8a/B4SM7P9dT6LQU90duUZj
         8XwJTIw7xTC5AawMRXB59ayo57RXcQEE3f0fEkArkZoey9zdWkDH/43eKgA1tXUqUZho
         TsYOPXl5/WPVfEXF+0zt9cxCGzOsurM04AwXyvnMG1FnouNugK1hTfNPV7NZD3SUXIqn
         1urJUmpESEbiPweSsBl/7A85xC3aonkdI0+9SXIwL/Ji181zU1Qfbkqxo5OzsVboTfb4
         9yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lcf3tCpKs15s8cLRCsk1I2PtCuyfBMqxWEQDkks1/Ao=;
        b=h4q8c0cQiTbgSy+0jYnNOAtvyfbf4su0jTobFrRKzFhLu6tNO00nth91Ipa3/+z1jM
         EZbc8OgUGVjoeYYXagW3gKOpjd9XdyYsPkhiNMkllJ+9kwCBZy5sKncVX6Y/nRg2ZzxN
         YYHfzOYfyIik9cagOaRaMSTSkx/0wQjwaMd1xpxr/ZM+T2QPjZXMkeqG/A6esbKRtjmR
         Fzcuzv3n9aRlDo1TNSU5O40VUgPFPoxpYMbHIOC3+L9rdLGr5dv+Msjz/hUzaWGoYPJ3
         lnGGbFCOtmHW5+ROEID6jsPxR1iWlasudkMMzQbNRfwO7WeXanM7s+BEgItVzwxQB5Qf
         ITpw==
X-Gm-Message-State: AOPr4FXmdXBbceHCsAYqV6D0hekdOTOuF52WEe7kAnd7/esTIMO4CcSnmrP1oXjX/yKfaA==
X-Received: by 10.194.58.138 with SMTP id r10mr4597984wjq.153.1461694435294;
        Tue, 26 Apr 2016 11:13:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h8sm4392371wmd.2.2016.04.26.11.13.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2016 11:13:54 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1461694402-9629-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292637>

Change the documentation so that:

 * We don't talk about "little scripts". Hooks can be as big as you
   want, and don't have to be scripts, just call them "programs".

 * We note what happens with chdir() before a hook is called, nothing
   documented this explicitly, but the current behavior is
   predictable. It helps a lot to know what directory these hooks will
   be executed from.

 * We don't make claims about the example hooks which may not be true
   depending on the configuration of 'init.templateDir'. Clarify that
   we're talking about the default settings of git-init in those cases,
   and move some of this documentation into git-init's documentation
   about the default templates.

 * We briefly note in the intro that hooks can get their arguments in
   various different ways, and that how exactly is described below for
   each hook.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/git-init.txt |  7 ++++++-
 Documentation/githooks.txt | 32 ++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 8174d27..6364e5d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -130,7 +130,12 @@ The template directory will be one of the followin=
g (in order):
  - the default template directory: `/usr/share/git-core/templates`.
=20
 The default template directory includes some directory structure, sugg=
ested
-"exclude patterns" (see linkgit:gitignore[5]), and sample hook files (=
see linkgit:githooks[5]).
+"exclude patterns" (see linkgit:gitignore[5]), and sample hook files.
+
+The sample hooks are all disabled by default, To enable one of the
+sample hooks rename it by removing its `.sample` suffix.
+
+See linkgit:githooks[5] for more general info on hook execution.
=20
 EXAMPLES
 --------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a2f59b1..7660b95 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -13,18 +13,26 @@ $GIT_DIR/hooks/*
 DESCRIPTION
 -----------
=20
-Hooks are little scripts you can place in `$GIT_DIR/hooks`
-directory to trigger action at certain points.  When
-'git init' is run, a handful of example hooks are copied into the
-`hooks` directory of the new repository, but by default they are
-all disabled.  To enable a hook, rename it by removing its `.sample`
-suffix.
-
-NOTE: It is also a requirement for a given hook to be executable.
-However - in a freshly initialized repository - the `.sample` files ar=
e
-executable by default.
-
-This document describes the currently defined hooks.
+Hooks are programs you can place in the `$GIT_DIR/hooks` directory to
+trigger actions at certain points in git's execution. Hooks that don't
+have the executable bit set are ignored.
+
+When a hook is invoked, it is run at the root of the working tree in a
+non-bare repository, or in the $GIT_DIR in a bare
+repository. I.e. hooks don't need to worry about the user's current
+working directory.
+
+Hooks can get their arguments via the environment, command-line
+arguments, and stdin. See the documentation for each hook below for
+details.
+
+When 'git init' is run it may, depending on its configuration, copy
+hooks to the new repository, see the the "TEMPLATE DIRECTORY" section
+in linkgit:git-init[1] for details. When the rest of this document
+refers to "default hooks" it's talking about the default template
+shipped with Git.
+
+The currently supported hooks are described below.
=20
 HOOKS
 -----
--=20
2.1.3
