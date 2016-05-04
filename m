From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v5 1/4] githooks.txt: Improve the intro section
Date: Wed,  4 May 2016 20:18:45 +0000
Message-ID: <1462393128-26762-2-git-send-email-avarab@gmail.com>
References: <xmqqinz4f8mg.fsf@gitster.mtv.corp.google.com>
 <1462393128-26762-1-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed May 04 22:19:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay3Gi-0005Iu-HH
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbcEDUTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 16:19:25 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35957 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbcEDUTX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:19:23 -0400
Received: by mail-wm0-f44.google.com with SMTP id n129so203631683wmn.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3WO+SmmEgAY8H+HDXiD8OhQtrpSZ6q9fjh8R9c+0K4=;
        b=WaR/B13tmkMLQ6PudQ2H4Uq8JM22PhEosPsKrfUsFgrnFd9D7m1ehL/AiifPYhJVyN
         U5CKamSsxdyKruwC0HR9HgcgwIaUj+MqQfYnYvjzy67drOzaYRpwsgfoXNZH3bwbU/tL
         10UhnQo02FRpH8nieIHJ9iS9ShRU85VudAVF3JKAX6mpKhV2ZJkGiHFkb2jZOfYYRqRx
         pdDnvxROCONZLBK6zCuaLK8mf5UOtnU4rDqT9Fxa8z3YSOcpcKd5q/Rrn2u+fN2c0wW0
         AExJN6DthAtoVoza+rjIloLWaL2DdwsaZH2BA3ZlsE+M2IqZe02fXADM8EadwhzS9aFC
         Uh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3WO+SmmEgAY8H+HDXiD8OhQtrpSZ6q9fjh8R9c+0K4=;
        b=ftCLq2b9OhbgE+nkP6cj6iZLPz5OiPhDokbU9klDF1Xld8j03FljEYi6ua31fxNnYH
         K2or5ZBdIYsA/QeBEVZfvssWECNa3dK4yelW4BMhrfzJGX03M4OS9Owkb6OG1iXOAolV
         P/3Bla7jrCyGhxXSV3OsvZmnJVDKb7xnjaA+MD0MBWUYLIxIhsc+i3Gk05A+E2N0OF3+
         sOZm4XKY5DnN/5er0JnbRNyj1ofb/jSVEqyVzg68+dnSrsw3vkRviWa7kRRbgq4Sr12h
         S641rIQBc1b3hJHCPyaQ3mk6es9dPyi0bxZYcHTHGLBAwD3PyIE74B1UoBV3peQbejZi
         pA7Q==
X-Gm-Message-State: AOPr4FURpchDEQyyp2p8Tvi799xzv2zwFWrhbyikfgspaAR0XYSflLirIMl6tbxygCbxMg==
X-Received: by 10.28.148.149 with SMTP id w143mr11080364wmd.10.1462393157039;
        Wed, 04 May 2016 13:19:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w79sm6795893wme.19.2016.05.04.13.19.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 13:19:15 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1462393128-26762-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293584>

Change the documentation so that:

 * We don't talk about "little scripts". Hooks can be as big as you
   want, and don't have to be scripts, just call them "programs".

 * We note that we change the working directory before a hook is called=
,
   nothing documented this explicitly, but the current behavior is
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
 Documentation/githooks.txt | 33 +++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 13 deletions(-)

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
index a2f59b1..cc082d2 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -13,18 +13,27 @@ $GIT_DIR/hooks/*
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
+Hooks don't need to worry about the user's current working
+directory. Before Git invokes a hook it changes its working
+directory. The working directory will be the root of the working tree
+in a non-bare repository, or in the $GIT_DIR directory in a bare
+repository.
+
+Hooks can get their arguments via the environment, command-line
+arguments, and stdin. See the documentation for each hook below for
+details.
+
+'git init' may copy hooks to the new repository, depending on its
+configuration. See the "TEMPLATE DIRECTORY" section in
+linkgit:git-init[1] for details. When the rest of this document refers
+to "default hooks" it's talking about the default template shipped
+with Git.
+
+The currently supported hooks are described below.
=20
 HOOKS
 -----
--=20
2.1.3
