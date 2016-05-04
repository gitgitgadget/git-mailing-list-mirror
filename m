From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v6 1/4] githooks.txt: Improve the intro section
Date: Wed,  4 May 2016 22:58:09 +0000
Message-ID: <1462402692-24712-2-git-send-email-avarab@gmail.com>
References: <xmqqa8k5eakb.fsf@gitster.mtv.corp.google.com>
 <1462402692-24712-1-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 05 00:58:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5kb-0002U0-1R
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbcEDW6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 18:58:31 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37447 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbcEDW6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:58:30 -0400
Received: by mail-wm0-f48.google.com with SMTP id a17so601576wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnsT6hlv1g2HGHUAqf4xwcyhlDarqCQGlT3A8Ow7zag=;
        b=wKYKVK4bkaTSF9/GkW8qzF7MvMQUZV6fxRZejx/mxCFvj3qxJmlBL6nPjHD5vl7zRz
         yHuAbH8ntYgHIpiLDSz9zTNX+dq/xGTk3It12sopZLOGLagHc2Z3K0w8Wcl2XdAhMlHs
         qJQej88WGv2rkPxjbmMVUVZ5CddjWz9+YPbbUJwsiQcaOOfxCyIwnHktB/FeDpzJOKcz
         s6y/8iFxd+k44FFuNgyUuAnxLrTvBfEKB4ZCxmbEPTjcwu/uZt6BVciS58C/2peuoJby
         Lk5DYaDZjeXuQY6spzwXB8pvt6oClvUev2sqkKAmhutkKjeg6nx6bKR+UACHJ3ChjuQO
         K5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnsT6hlv1g2HGHUAqf4xwcyhlDarqCQGlT3A8Ow7zag=;
        b=jO47DM99DEGjFK/lg9ox0iH0YgbC3soee0HUqKIvcBygi9buFiiP3Q3/Pk1BULJcFZ
         p2kD0r3JP0m1FHYz5sInhuWmDq1WJagVBIxLXSvdAjBuKybmsvlonirEhWtZVoL/WIih
         MGSpAOHDidP4BjONC0ZiyyJAadNaP4vFYaWJJ10zbDlAwVCT6d/QixJgmsHCq80j2QVK
         aqToYCLEIIYTb9GAOZY6NGuS5aaIEtSqk6gIF4ej9kYpimy/rrzI1NaP/4Z1srLcENkK
         Z11LxhZf+znMRJdMhIoOW6SYv/QzSGgQ1+3JPNaFZbXxVkBLkZs44khLr1j7ZrT66rN1
         D9kg==
X-Gm-Message-State: AOPr4FUuVYt+j88Lg84DVCXND8XMHmf2USXCs0ugt+JcgufZQeL/RtZcrE2ifgXSpYRvZw==
X-Received: by 10.194.77.42 with SMTP id p10mr10644610wjw.111.1462402709114;
        Wed, 04 May 2016 15:58:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id us3sm6557967wjc.41.2016.05.04.15.58.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 15:58:26 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1462402692-24712-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293615>

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
 Documentation/githooks.txt | 31 +++++++++++++++++++------------
 2 files changed, 25 insertions(+), 13 deletions(-)

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
index a2f59b1..0d94337 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -13,18 +13,25 @@ $GIT_DIR/hooks/*
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
+Before Git invokes a hook, it changes its working directory to either
+the root of the working tree in a non-bare repository, or to the
+$GIT_DIR in a bare repository.
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
