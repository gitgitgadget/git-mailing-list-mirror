From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 1/3] githooks.txt: Improve the intro section
Date: Mon, 25 Apr 2016 14:14:23 +0000
Message-ID: <1461593665-31395-2-git-send-email-avarab@gmail.com>
References: <1461593665-31395-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 16:15:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auhI0-00085C-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 16:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbcDYOOt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 10:14:49 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37283 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbcDYOOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 10:14:48 -0400
Received: by mail-wm0-f45.google.com with SMTP id n3so130128670wmn.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GBM6zBE3aVb9kBUvNDQPkkLFxhCFUpHs4NjxMuPWDN4=;
        b=jMqgLRY60Xs/iUDCHdUu7CwhGppUtgLn3G/kpg7W9SrnolmvvMIMiJiSrOhJekw8tA
         gfPP0xNTSfkMtZQSiZ4DRSIyzvbuPXkSnEafFVxm730j0/gO39e4/A++FYzaLQVnrtSw
         xsi/OwvlJbvetw4/zYMYKyzRuldhLuObvmePbVRuhr4dwoH1wYCzzsdoRIezyGL6LWQt
         c7t2Tgf6oy5sx6Y9r9qU061MxeEI1dNsuBM1V959UM7zOGZ5oKXNvJqTufewWKL82hI2
         xYYFqh3KJ/FO6+Qzrpv6dGoclY6DaiYUSe8jhe4xuNILHQb+J7SkRvpezIo7OK9Q0iZ2
         ZfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GBM6zBE3aVb9kBUvNDQPkkLFxhCFUpHs4NjxMuPWDN4=;
        b=Ugvzgp1FpjZ2Arc7Q1r0WCs06mpr1NsjfykTze2zUWKlvbmArN5AMlf2N7vZhPfK24
         7ADU7OBMfPak0bIkIkX/FAYEc8eY3DrLBdU7yK2qsMGDNBGBhVRXV2JAV7l8aqPLXgiU
         BDz5NLKez2VD8/jPTC+kbuX6QSeOJXLt3fo2L1h5v8+rRRIhA9hG5L+fSjGisiTWPYAH
         MMn+DB8Vc60+unfLNwYNoSBSCmTxjzsrUg+4bwtWRhMQeLqbq+jXTENJ+vXuy8b2HVmu
         XwcRXJLB/ZUvz9ppjY3BovlESRyQZxwcjqWvgEVXAUCV8/P1WK9v6O0+grXNcjOHp1lE
         kqVw==
X-Gm-Message-State: AOPr4FVFuj641yQhgFFuipWX6krhwgVDPwcfNs2ucuHIL/QHcBpWFc3boCpx4Rkc5PN8XQ==
X-Received: by 10.28.24.195 with SMTP id 186mr12455906wmy.30.1461593686381;
        Mon, 25 Apr 2016 07:14:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d1sm23768565wjb.47.2016.04.25.07.14.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2016 07:14:45 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1461593665-31395-1-git-send-email-avarab@gmail.com>
In-Reply-To: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
References: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292482>

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
 Documentation/git-init.txt |  6 +++++-
 Documentation/githooks.txt | 32 ++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 8174d27..cc3be7d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -130,7 +130,11 @@ The template directory will be one of the followin=
g (in order):
  - the default template directory: `/usr/share/git-core/templates`.
=20
 The default template directory includes some directory structure, sugg=
ested
-"exclude patterns" (see linkgit:gitignore[5]), and sample hook files (=
see linkgit:githooks[5]).
+"exclude patterns" (see linkgit:gitignore[5]), and example hook files.
+
+The example hooks are all disabled by default. To enable a hook,
+rename it by removing its `.sample` suffix. See linkgit:githooks[5]
+for more info on hook execution.
=20
 EXAMPLES
 --------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a2f59b1..6db515e 100644
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
+trigger action at certain points. Hooks that don't have the executable
+bit set are ignored.
+
+When a hook is called in a non-bare repository the working directory
+is guaranteed to be the root of the working tree, in a bare repository
+the working directory will be the path to the repository. I.e. hooks
+don't need to worry about the user's current working directory.
+
+Hooks can get their arguments via the environment, command-line
+arguments, and stdin. See the documentation for each below hook for
+details.
+
+When 'git init' is run it may, depending on its configuration, copy
+hooks to the new repository, see the the "TEMPLATE DIRECTORY" section
+in linkgit:git-init[1] for details. When the rest of this document
+refers to "default hooks" we're talking about the default template
+shipped with Git.
+
+The currently supported hooks are described below.
=20
 HOOKS
 -----
--=20
2.1.3
