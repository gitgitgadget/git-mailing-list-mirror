From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 0/3] extract proper comments for l10n translators
Date: Thu, 17 Apr 2014 13:50:56 +0800
Message-ID: <CANYiYbGUKiOyoBOPHH+jvdZx1hKoUshh7O0KnpWUQEzbvd8TfQ@mail.gmail.com>
References: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com>
	<cover.1397712142.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 07:51:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WafE0-0000ye-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 07:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbaDQFu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 01:50:59 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:45621 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbaDQFu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 01:50:58 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so11834046wes.31
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1e9j/9cXXc6cfrFQ4dh+f9vE+yFtWt8Nxj4pA+nIa9E=;
        b=auXj4wva6W9IU5qN9mgSDK+rC+wCN8qSDga2zwqx+YkQngydJ8tIFY/ly8nxaPV6io
         X0iOPNTyecLshZCV3cEqsXEj8h+ugp8Utyf3gM6gIFMh6zS2Opejm7bOQw8fURmkfASV
         su6Msnl0bjiQIBS9sQ20NY1Ibv7Q9QF042sEH/cfBx6OK42a8UtHwLLK6Jo54aIpIvF9
         Jqp+DPQnwdApuiCjVYmJf9yNsDhVrHjpRuC4LJXNZ1V/3miYAD3yGZZDpOSs+/zMnqMT
         PTlwnoEsU4U/oGxPE6pXeoLB5v3wR+Jb221xIrHCHfkx3yfYWKtgcAtlso0VW9ow2nRZ
         M6tg==
X-Received: by 10.194.174.42 with SMTP id bp10mr360127wjc.57.1397713856911;
 Wed, 16 Apr 2014 22:50:56 -0700 (PDT)
Received: by 10.217.58.65 with HTTP; Wed, 16 Apr 2014 22:50:56 -0700 (PDT)
In-Reply-To: <cover.1397712142.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246406>

2014-04-17 13:37 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
> When generate git.pot, many irrelevant comments are extracted as references
> for translators, but one useful comment is lost.  This series patches will
> fix this issue.

Brief changes of po/git.pot after applied these patches:

diff --git a/po/git.pot b/po/git.pot
index f70b46b..9e474f3 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -23,10 +23,6 @@ msgstr ""
 msgid "hint: %.*s\n"
 msgstr ""

-#.
-#. * Message used both when 'git commit' fails and when
-#. * other commands doing a merge do.
-#.
 #: advice.c:85
 msgid ""
 "Fix them up in the work tree,\n"
@@ -399,6 +395,7 @@ msgid_plural "%lu years"
 msgstr[0] ""
 msgstr[1] ""

+#. TRANSLATORS: "%s" is "<n> years"
 #: date.c:149
 #, c-format
 msgid "%s, %lu month ago"
@@ -582,8 +579,6 @@ msgstr ""
 msgid "Removing %s to make room for subdirectory\n"
 msgstr ""

-#. something else exists
-#. .. but not some other error (who really cares what?)
 #: merge-recursive.c:700 merge-recursive.c:721
 msgid ": perhaps a D/F conflict?"
 msgstr ""
@@ -899,11 +894,6 @@ msgstr ""
 msgid "Pathspec '%s' is in submodule '%.*s'"
 msgstr ""

-#.
-#. * We may want to substitute "this command" with a command
-#. * name. E.g. when add--interactive dies when running
-#. * "checkout -p"
-#.
 #: pathspec.c:353
 #, c-format
 msgid "%s: pathspec magic not supported by this command: %s"
@@ -953,11 +943,6 @@ msgstr ""
 msgid "%s tracks both %s and %s"
 msgstr ""

-#.
-#. * This last possibility doesn't occur because
-#. * FETCH_HEAD_IGNORE entries always appear at
-#. * the end of the list.
-#.
 #: remote.c:774
 msgid "Internal error"
 msgstr ""
@@ -1306,13 +1291,11 @@ msgstr ""
 msgid "Could not find section in .gitmodules where path=%s"
 msgstr ""

-#. Maybe the user already did that, don't error out here
 #: submodule.c:76
 #, c-format
 msgid "Could not update .gitmodules entry %s"
 msgstr ""

-#. Maybe the user already did that, don't error out here
 #: submodule.c:109
 #, c-format
 msgid "Could not remove .gitmodules entry for %s"
@@ -1884,7 +1867,6 @@ msgstr ""
 msgid "add changes from all tracked and untracked files"
 msgstr ""

-#. takes no arguments
 #: builtin/add.c:260
 msgid "ignore paths removed in the working tree (same as --no-all)"
 msgstr ""
@@ -2044,7 +2026,6 @@ msgstr ""
 msgid "corrupt binary patch at line %d: %.*s"
 msgstr ""

-#. there has to be one hunk (forward hunk)
 #: builtin/apply.c:1900
 #, c-format
 msgid "unrecognized binary patch at line %d"
@@ -2232,7 +2213,6 @@ msgstr ""
 msgid "internal error"
 msgstr ""

-#. Say this even without --verbose
 #: builtin/apply.c:4043
 #, c-format
 msgid "Applying patch %%s with %d reject..."
@@ -3232,7 +3212,6 @@ msgstr ""
 msgid " ... and %d more.\n"
 msgstr ""

-#. The singular version
 #: builtin/checkout.c:711
 #, c-format
 msgid ""
@@ -3280,7 +3259,6 @@ msgstr ""
 msgid "invalid reference: %s"
 msgstr ""

-#. case (1): want a tree
 #: builtin/checkout.c:1002
 #, c-format
 msgid "reference is not a tree: %s"
@@ -4276,7 +4254,6 @@ msgstr ""
 msgid "GPG sign commit"
 msgstr ""

-#. end commit message options
 #: builtin/commit.c:1508
 msgid "Commit contents options"
 msgstr ""
@@ -5140,7 +5117,6 @@ msgstr ""
 msgid "See \"git help gc\" for manual housekeeping.\n"
 msgstr ""

-#. be quiet on --auto
 #: builtin/gc.c:336
 #, c-format
 msgid ""
@@ -5894,12 +5870,10 @@ msgstr ""
 msgid "unable to move %s to %s"
 msgstr ""

-#.
-#. * TRANSLATORS: The first '%s' is either "Reinitialized
-#. * existing" or "Initialized empty", the second " shared" or
-#. * "", and the last '%s%s' is the verbatim directory name.
-#.
-#: builtin/init-db.c:420
+#. TRANSLATORS: The first '%s' is either "Reinitialized
+#. existing" or "Initialized empty", the second " shared" or
+#. "", and the last '%s%s' is the verbatim directory name.
+#: builtin/init-db.c:418
 #, c-format
 msgid "%s%s Git repository in %s%s\n"
 msgstr ""
@@ -6627,7 +6601,6 @@ msgstr ""
 msgid "Commit %s has a bad GPG signature allegedly by %s."
 msgstr ""

-#. 'N'
 #: builtin/merge.c:1279
 #, c-format
 msgid "Commit %s does not have a GPG signature."
@@ -9593,8 +9566,6 @@ msgstr ""
 msgid "'git bisect bad' can take only one argument."
 msgstr ""

-#. have bad but not good.  we could bisect although
-#. this is less optimum.
 #: git-bisect.sh:273
 msgid "Warning: bisecting only with a bad commit."
 msgstr ""
@@ -9690,10 +9661,6 @@ msgstr ""
 msgid "updating an unborn branch with changes added to the index"
 msgstr ""

-#. The fetch involved updating the current branch.
-#. The working tree and the index file is still based on the
-#. $orig_head commit, but we are merging into $curr_head.
-#. First update the working tree to match $curr_head.
 #: git-pull.sh:271
 #, sh-format
 msgid ""
@@ -9835,7 +9802,6 @@ msgstr ""
 msgid "Changes from $mb to $onto:"
 msgstr ""

-#. Detach HEAD and reset the tree
 #: git-rebase.sh:609
 msgid "First, rewinding head to replay your work on top of it..."
 msgstr ""
@@ -10218,7 +10184,6 @@ msgstr ""
 msgid "The --cached option cannot be used with the --files option"
 msgstr ""

-#. unexpected type
 #: git-submodule.sh:1097
 #, sh-format
 msgid "unexpected mode $mod_dst"


-- 
Jiang Xin
