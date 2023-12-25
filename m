Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB053E0A
	for <git@vger.kernel.org>; Mon, 25 Dec 2023 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHuyYlXp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d3ae326f6so46429695e9.3
        for <git@vger.kernel.org>; Mon, 25 Dec 2023 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703539290; x=1704144090; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3lbiIWnx5tR+feZcYSMVxmz6JGjtYmh5kbsynKwbA0=;
        b=VHuyYlXpFIRQRdeOE6Eg3mPDrF0sPdXErm6G80Hvkp3WKvy1JQpq/RVrg0r+yZOEDB
         BotJ2jQF/alyOQlSnA31sd1a53UOfvl0zJkWMtLnBDZ3VorCiuX1AJjuutBRu1jpJKSf
         dieCu3sx9yFfjo122wrnIBBxNw7OoTzfQqQEEdZn/51bS5xZNdNm9urwqvv5EfFdMQIN
         kRdlKxSMsvIpIafkRdAv1XhshRaYrI92ipOiz8U/3LVVJeTecIaVncDhRFv8VGwXi5Md
         0lRAlyLh5Gmim6cb+Sn4qkKMitu6n2sNBiQrv7k0cE9Qrh4ioDJK8DGNYFEZurTg8rDJ
         sReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703539290; x=1704144090;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3lbiIWnx5tR+feZcYSMVxmz6JGjtYmh5kbsynKwbA0=;
        b=j8hRjYJqvux+NxyeOTpAAnHD95p458HpXQpwJXq/NKaQXMBwSiwBLLSEL79psZgxgI
         pqy/OL5bW5GmrLbyz7JYqhk1GG6yU7H4UbcaYcECAwimkvyZgCh3ZLrfKjNsKHI9Xdjb
         wlrvLJP7pDdDw8sZm5Sb0OZTEmYOKLBj3OhAYVktHl/3eoeDw+Um/k1z9KyQfqykXAAk
         YzdZZZLblMw5cpsKkXeUAJFXEYchZEepIlOGNu0OmHyp3QES3VjWI/0BzXTkNTosYRd6
         dL0+A0ksZZUeAQk4bUOhB7Utn7W0qHB2lAkuZFd0Wo6NKxzneMCY2xUMGqC5UukxvMNO
         DNeQ==
X-Gm-Message-State: AOJu0YxGhIqtnuIdA4e9m9bzHE5SEilyYWcIQhW7G97XAtljhMaxnNNM
	8SE4ErH2EcN7BDYQKMXvRXYIW0KHKHU=
X-Google-Smtp-Source: AGHT+IEK+cSjxOoUeYaSMXXYMjuvdzuWawY/Vp2En/wemMv/LeTW+STK8i924Z31xw668UelYCTURQ==
X-Received: by 2002:a05:600c:4da4:b0:40d:3ab1:92ed with SMTP id v36-20020a05600c4da400b0040d3ab192edmr3348408wmp.33.1703539290114;
        Mon, 25 Dec 2023 13:21:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fl6-20020a05600c0b8600b0040b30be6244sm18932304wmb.24.2023.12.25.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 13:21:29 -0800 (PST)
Message-ID: <da1026cb2c7875cd29d894cda2525d88308aae1d.1703539287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1626.git.1703539287.gitgitgadget@gmail.com>
References: <pull.1626.git.1703539287.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Dec 2023 21:21:26 +0000
Subject: [PATCH 1/2] doc: enforce dashes in placeholders
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The CodingGuidelines documents stipulates that multi-word placeholders
are to be separated by dashes, not underscores nor spaces.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-blame.txt                |  2 +-
 Documentation/git-bugreport.txt            |  4 ++--
 Documentation/git-commit-graph.txt         |  2 +-
 Documentation/git-cvsserver.txt            |  4 ++--
 Documentation/git-daemon.txt               |  6 +++---
 Documentation/git-diagnose.txt             |  2 +-
 Documentation/git-fast-import.txt          |  4 ++--
 Documentation/git-fetch.txt                |  4 ++--
 Documentation/git-filter-branch.txt        |  6 +++---
 Documentation/git-format-patch.txt         | 20 ++++++++++----------
 Documentation/git-mv.txt                   |  2 +-
 Documentation/git-notes.txt                |  2 +-
 Documentation/git-replace.txt              |  6 +++---
 Documentation/git-revert.txt               |  4 ++--
 Documentation/git-send-email.txt           |  2 +-
 Documentation/git-status.txt               |  4 ++--
 Documentation/git-submodule.txt            |  4 ++--
 Documentation/git-svn.txt                  | 18 +++++++++---------
 Documentation/git-tag.txt                  |  2 +-
 Documentation/git.txt                      |  2 +-
 Documentation/gitdiffcore.txt              |  8 ++++----
 Documentation/gitformat-index.txt          |  4 ++--
 Documentation/githooks.txt                 |  8 ++++----
 Documentation/gitk.txt                     |  4 ++--
 Documentation/gitprotocol-capabilities.txt |  2 +-
 Documentation/gitprotocol-http.txt         | 14 +++++++-------
 Documentation/gitprotocol-v2.txt           |  8 ++++----
 Documentation/gitsubmodules.txt            |  4 ++--
 Documentation/gitweb.conf.txt              | 10 +++++-----
 Documentation/gitweb.txt                   |  2 +-
 Documentation/trace2-target-values.txt     |  2 +-
 Documentation/urls.txt                     |  8 ++++----
 Documentation/user-manual.txt              |  4 ++--
 builtin/commit-graph.c                     |  2 +-
 34 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 5720d04ffe4..b1d7fb539d0 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -210,7 +210,7 @@ annotated.
 
 . Each blame entry always starts with a line of:
 
-	<40-byte hex sha1> <sourceline> <resultline> <num_lines>
+	<40-byte-hex-sha1> <sourceline> <resultline> <num-lines>
 +
 Line numbers count from 1.
 
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 392d9eb6aec..ca626f7fc68 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -52,7 +52,7 @@ OPTIONS
 -s <format>::
 --suffix <format>::
 	Specify an alternate suffix for the bugreport name, to create a file
-	named 'git-bugreport-<formatted suffix>'. This should take the form of a
+	named 'git-bugreport-<formatted-suffix>'. This should take the form of a
 	strftime(3) format string; the current local time will be used.
 
 --no-diagnose::
@@ -60,7 +60,7 @@ OPTIONS
 	Create a zip archive of supplemental information about the user's
 	machine, Git client, and repository state. The archive is written to the
 	same output directory as the bug report and is named
-	'git-diagnostics-<formatted suffix>'.
+	'git-diagnostics-<formatted-suffix>'.
 +
 Without `mode` specified, the diagnostic archive will contain the default set of
 statistics reported by `git diagnose`. An optional `mode` value may be specified
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index c8dbceba014..903b16830ea 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git commit-graph write' [--object-dir <dir>] [--append]
 			[--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]
 			[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]
-			<split options>
+			<split-options>
 
 
 DESCRIPTION
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index cf4a5a283ec..4c475efeab9 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -197,7 +197,7 @@ allowing access over SSH.
 5. Clients should now be able to check out the project. Use the CVS 'module'
    name to indicate what Git 'head' you want to check out.  This also sets the
    name of your newly checked-out directory, unless you tell it otherwise with
-   `-d <dir_name>`.  For example, this checks out 'master' branch to the
+   `-d <dir-name>`.  For example, this checks out 'master' branch to the
    `project-master` directory:
 +
 ------
@@ -224,7 +224,7 @@ the database to work reliably (otherwise you need to make sure
 that the database is up to date any time 'git-cvsserver' is executed).
 
 By default it uses SQLite databases in the Git directory, named
-`gitcvs.<module_name>.sqlite`. Note that the SQLite backend creates
+`gitcvs.<module-name>.sqlite`. Note that the SQLite backend creates
 temporary files in the same directory as the database file on
 write so it might not be enough to grant the users using
 'git-cvsserver' write access to the database file without granting
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index e064f91c9e3..6ab792228a1 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 	     [--allow-override=<service>] [--forbid-override=<service>]
 	     [--access-hook=<path>] [--[no-]informative-errors]
 	     [--inetd |
-	      [--listen=<host_or_ipaddr>] [--port=<n>]
+	      [--listen=<host-or-ipaddr>] [--port=<n>]
 	      [--user=<user> [--group=<group>]]]
 	     [--log-destination=(stderr|syslog|none)]
 	     [<directory>...]
@@ -86,10 +86,10 @@ OPTIONS
 	Incompatible with --detach, --port, --listen, --user and --group
 	options.
 
---listen=<host_or_ipaddr>::
+--listen=<host-or-ipaddr>::
 	Listen on a specific IP address or hostname.  IP addresses can
 	be either an IPv4 address or an IPv6 address if supported.  If IPv6
-	is not supported, then --listen=hostname is also not supported and
+	is not supported, then --listen=<hostname> is also not supported and
 	--listen must be given an IPv4 address.
 	Can be given more than once.
 	Incompatible with `--inetd` option.
diff --git a/Documentation/git-diagnose.txt b/Documentation/git-diagnose.txt
index 3ec8cc7ad72..0711959e6f6 100644
--- a/Documentation/git-diagnose.txt
+++ b/Documentation/git-diagnose.txt
@@ -45,7 +45,7 @@ OPTIONS
 -s <format>::
 --suffix <format>::
 	Specify an alternate suffix for the diagnostics archive name, to create
-	a file named 'git-diagnostics-<formatted suffix>'. This should take the
+	a file named 'git-diagnostics-<formatted-suffix>'. This should take the
 	form of a strftime(3) format string; the current local time will be
 	used.
 
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index bd7b1e0a2ea..b2607366b91 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -745,11 +745,11 @@ paths for a commit are encouraged to do so.
 
 `notemodify`
 ^^^^^^^^^^^^
-Included in a `commit` `<notes_ref>` command to add a new note
+Included in a `commit` `<notes-ref>` command to add a new note
 annotating a `<commit-ish>` or change this annotation contents.
 Internally it is similar to filemodify 100644 on `<commit-ish>`
 path (maybe split into subdirectories). It's not advised to
-use any other commands to write to the `<notes_ref>` tree except
+use any other commands to write to the `<notes-ref>` tree except
 `filedeleteall` to delete all existing notes in this tree.
 This command has two different means of specifying the content
 of the note.
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index f123139c581..50900a50dab 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -186,8 +186,8 @@ origin:
 ------------------------------------------------
 $ git fetch origin --prune --prune-tags
 $ git fetch origin --prune 'refs/tags/*:refs/tags/*'
-$ git fetch <url of origin> --prune --prune-tags
-$ git fetch <url of origin> --prune 'refs/tags/*:refs/tags/*'
+$ git fetch <url-of-origin> --prune --prune-tags
+$ git fetch <url-of-origin> --prune 'refs/tags/*:refs/tags/*'
 ------------------------------------------------
 
 OUTPUT
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 62e482a95e2..5a4f853785d 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--prune-empty]
 	[--original <namespace>] [-d <directory>] [-f | --force]
-	[--state-branch <branch>] [--] [<rev-list options>...]
+	[--state-branch <branch>] [--] [<rev-list-options>...]
 
 WARNING
 -------
@@ -32,7 +32,7 @@ listed there as reasonably possible.
 DESCRIPTION
 -----------
 Lets you rewrite Git revision history by rewriting the branches mentioned
-in the <rev-list options>, applying custom filters on each revision.
+in the <rev-list-options>, applying custom filters on each revision.
 Those filters can modify each tree (e.g. removing a file or running
 a perl rewrite on all files) or information about each commit.
 Otherwise, all information (including original commit times or merge
@@ -624,7 +624,7 @@ with:
      real backup; it dereferences tags first.)
 
   ** Running git-filter-branch with either --tags or --all in your
-     <rev-list options>.  In order to retain annotated tags as
+     <rev-list-options>.  In order to retain annotated tags as
      annotated, you must use --tag-name-filter (and must not have
      restored from refs/original/ in a previously botched rewrite).
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index aaafce24be2..7eb873b2c75 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -17,10 +17,10 @@ SYNOPSIS
 		   [--signature-file=<file>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
-		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
+		   [--in-reply-to=<message-id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream] [--always]
 		   [--cover-from-description=<mode>]
-		   [--rfc] [--subject-prefix=<subject prefix>]
+		   [--rfc] [--subject-prefix=<subject-prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
@@ -30,8 +30,8 @@ SYNOPSIS
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--filename-max-length=<n>]
 		   [--progress]
-		   [<common diff options>]
-		   [ <since> | <revision range> ]
+		   [<common-diff-options>]
+		   [ <since> | <revision-range> ]
 
 DESCRIPTION
 -----------
@@ -64,7 +64,7 @@ There are two ways to specify which commits to operate on.
    to the tip of the current branch that are not in the history
    that leads to the <since> to be output.
 
-2. Generic <revision range> expression (see "SPECIFYING
+2. Generic <revision-range> expression (see "SPECIFYING
    REVISIONS" section in linkgit:gitrevisions[7]) means the
    commits in the specified range.
 
@@ -179,9 +179,9 @@ Beware that the default for 'git send-email' is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
---in-reply-to=<message id>::
+--in-reply-to=<message-id>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
-	reply to the given <message id>, which avoids breaking threads to
+	reply to the given <message-id>, which avoids breaking threads to
 	provide a new patch series.
 
 --ignore-if-in-upstream::
@@ -219,9 +219,9 @@ populated with placeholder text.
 	Use the contents of <file> instead of the branch's description
 	for generating the cover letter.
 
---subject-prefix=<subject prefix>::
+--subject-prefix=<subject-prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
-	line, instead use '[<subject prefix>]'. This can be used
+	line, instead use '[<subject-prefix>]'. This can be used
 	to name a patch series, and can be combined with the
 	`--numbered` option.
 +
@@ -403,7 +403,7 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	`format.useAutoBase` configuration.
 
 --root::
-	Treat the revision argument as a <revision range>, even if it
+	Treat the revision argument as a <revision-range>, even if it
 	is just a single commit (that would normally be treated as a
 	<since>).  Note that root commits included in the specified
 	range are always formatted as creation patches, independently
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 7f991a33802..dc1bf615341 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Move or rename a file, directory, or symlink.
 
  git mv [-v] [-f] [-n] [-k] <source> <destination>
- git mv [-v] [-f] [-n] [-k] <source> ... <destination directory>
+ git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>
 
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index f8310e56a85..c9221a68cce 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -56,7 +56,7 @@ SUBCOMMANDS
 list::
 	List the notes object for a given object. If no object is
 	given, show a list of all note objects and the objects they
-	annotate (in the format "<note object> <annotated object>").
+	annotate (in the format "<note-object> <annotated-object>").
 	This is the default subcommand if no subcommand is given.
 
 add::
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 4f257126e33..0a65460adbd 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -114,11 +114,11 @@ FORMATS
 The following formats are available:
 
 * 'short':
-	<replaced sha1>
+	<replaced-sha1>
 * 'medium':
-	<replaced sha1> -> <replacement sha1>
+	<replaced-sha1> -> <replacement-sha1>
 * 'long':
-	<replaced sha1> (<replaced type>) -> <replacement sha1> (<replacement type>)
+	<replaced-sha1> (<replaced-type>) -> <replacement-sha1> (<replacement-type>)
 
 CREATING REPLACEMENT OBJECTS
 ----------------------------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index cbe0208834d..568925db533 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -116,7 +116,7 @@ include::rerere-options.txt[]
 
 --reference::
 	Instead of starting the body of the log message with "This
-	reverts <full object name of the commit being reverted>.",
+	reverts <full-object-name-of-the-commit-being-reverted>.",
 	refer to the commit using "--pretty=reference" format
 	(cf. linkgit:git-log[1]).  The `revert.reference`
 	configuration variable can be used to enable this option by
@@ -149,7 +149,7 @@ While git creates a basic commit message automatically, it is
 _strongly_ recommended to explain why the original commit is being
 reverted.
 In addition, repeatedly reverting reverts will result in increasingly
-unwieldy subject lines, for example 'Reapply "Reapply "<original subject>""'.
+unwieldy subject lines, for example 'Reapply "Reapply "<original-subject>""'.
 Please consider rewording these to be shorter and more unique.
 
 CONFIGURATION
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 465011bad50..c1b39acaab4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git send-email' [<options>] <file|directory>...
-'git send-email' [<options>] <format-patch options>
+'git send-email' [<options>] <format-patch-options>
 'git send-email' --dump-aliases
 
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 10fecc51a75..4dbb88373bc 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -309,7 +309,7 @@ Line                                     Notes
 ------------------------------------------------------------
 # branch.oid <commit> | (initial)        Current commit.
 # branch.head <branch> | (detached)      Current branch.
-# branch.upstream <upstream_branch>      If upstream is set.
+# branch.upstream <upstream-branch>      If upstream is set.
 # branch.ab +<ahead> -<behind>           If upstream is set and
 					 the commit is present.
 ------------------------------------------------------------
@@ -502,7 +502,7 @@ results, so it could be faster on subsequent runs.
 	usually worth the additional size.
 
 * `core.untrackedCache=true` and `core.fsmonitor=true` or
-	`core.fsmonitor=<hook_command_pathname>` (see
+	`core.fsmonitor=<hook-command-pathname>` (see
 	linkgit:git-update-index[1]): enable both the untracked cache
 	and FSMonitor features and only search directories that have
 	been modified since the previous `git status` command.  This
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 695730609aa..ca0347a37b5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -136,7 +136,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter spec>] [--] [<path>...]::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter-spec>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -185,7 +185,7 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 
-If `--filter <filter spec>` is specified, the given partial clone filter will be
+If `--filter <filter-spec>` is specified, the given partial clone filter will be
 applied to the submodule. See linkgit:git-rev-list[1] for details on filter
 specifications.
 --
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4e92308e85d..43c68c2ec44 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -37,12 +37,12 @@ COMMANDS
 	argument.  Normally this command initializes the current
 	directory.
 
--T<trunk_subdir>;;
---trunk=<trunk_subdir>;;
--t<tags_subdir>;;
---tags=<tags_subdir>;;
--b<branches_subdir>;;
---branches=<branches_subdir>;;
+-T<trunk-subdir>;;
+--trunk=<trunk-subdir>;;
+-t<tags-subdir>;;
+--tags=<tags-subdir>;;
+-b<branches-subdir>;;
+--branches=<branches-subdir>;;
 -s;;
 --stdlayout;;
 	These are optional command-line options for init.  Each of
@@ -726,9 +726,9 @@ ADVANCED OPTIONS
 	when tracking a single URL.  The 'log' and 'dcommit' commands
 	no longer require this switch as an argument.
 
--R<remote name>::
---svn-remote <remote name>::
-	Specify the [svn-remote "<remote name>"] section to use,
+-R<remote-name>::
+--svn-remote <remote-name>::
+	Specify the [svn-remote "<remote-name>"] section to use,
 	this allows SVN multiple repositories to be tracked.
 	Default: "svn"
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index d42efb31127..5fe519c31ec 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -224,7 +224,7 @@ it in the repository configuration as follows:
 
 -------------------------------------
 [user]
-    signingKey = <gpg-key_id>
+    signingKey = <gpg-key-id>
 -------------------------------------
 
 `pager.tag` is only respected when listing tags, i.e., when `-l` is
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2535a30194f..d51473a3274 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -838,7 +838,7 @@ of the SID and an optional counter (to avoid filename
 collisions).
 +
 In addition, if the variable is set to
-`af_unix:[<socket_type>:]<absolute-pathname>`, Git will try
+`af_unix:[<socket-type>:]<absolute-pathname>`, Git will try
 to open the path as a Unix Domain Socket.  The socket type
 can be either `stream` or `dgram`.
 +
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 3cda2e07c24..642c51227b5 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -245,20 +245,20 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation limits the set of filepairs to those that change
 specified strings between the preimage and the postimage in a certain
-way.  -S<block of text> and -G<regular expression> options are used to
+way.  -S<block-of-text> and -G<regular-expression> options are used to
 specify different ways these strings are sought.
 
-"-S<block of text>" detects filepairs whose preimage and postimage
+"-S<block-of-text>" detects filepairs whose preimage and postimage
 have different number of occurrences of the specified block of text.
 By definition, it will not detect in-file moves.  Also, when a
 changeset moves a file wholesale without affecting the interesting
 string, diffcore-rename kicks in as usual, and `-S` omits the filepair
 (since the number of occurrences of that string didn't change in that
 rename-detected filepair).  When used with `--pickaxe-regex`, treat
-the <block of text> as an extended POSIX regular expression to match,
+the <block-of-text> as an extended POSIX regular expression to match,
 instead of a literal string.
 
-"-G<regular expression>" (mnemonic: grep) detects filepairs whose
+"-G<regular-expression>" (mnemonic: grep) detects filepairs whose
 textual diff has an added or a deleted line that matches the given
 regular expression.  This means that it will detect in-file (or what
 rename-detection considers the same file) moves, which is noise.  The
diff --git a/Documentation/gitformat-index.txt b/Documentation/gitformat-index.txt
index 0773e5c3800..145cace1fe9 100644
--- a/Documentation/gitformat-index.txt
+++ b/Documentation/gitformat-index.txt
@@ -386,8 +386,8 @@ The remaining data of each directory block is grouped by type:
 	long, "REUC" extension that is M-bytes long, followed by "EOIE",
 	then the hash would be:
 
-	Hash("TREE" + <binary representation of N> +
-		"REUC" + <binary representation of M>)
+	Hash("TREE" + <binary-representation-of-N> +
+		"REUC" + <binary-representation-of-M>)
 
 == Index Entry Offset Table
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 883982e7a05..37f91d5b50c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -243,7 +243,7 @@ named remote is not being used both values will be the same.
 Information about what is to be pushed is provided on the hook's standard
 input with lines of the form:
 
-  <local ref> SP <local object name> SP <remote ref> SP <remote object name> LF
+  <local-ref> SP <local-object-name> SP <remote-ref> SP <remote-object-name> LF
 
 For instance, if the command +git push origin master:foreign+ were run the
 hook would receive a line like the following:
@@ -251,9 +251,9 @@ hook would receive a line like the following:
   refs/heads/master 67890 refs/heads/foreign 12345
 
 although the full object name would be supplied.  If the foreign ref does not
-yet exist the `<remote object name>` will be the all-zeroes object name.  If a
-ref is to be deleted, the `<local ref>` will be supplied as `(delete)` and the
-`<local object name>` will be the all-zeroes object name.  If the local commit
+yet exist the `<remote-object-name>` will be the all-zeroes object name.  If a
+ref is to be deleted, the `<local-ref>` will be supplied as `(delete)` and the
+`<local-object-name>` will be the all-zeroes object name.  If the local commit
 was specified by something other than a name which could be expanded (such as
 `HEAD~`, or an object name) it will be supplied as it was originally given.
 
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index c2213bb77b3..35b39960296 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -8,7 +8,7 @@ gitk - The Git repository browser
 SYNOPSIS
 --------
 [verse]
-'gitk' [<options>] [<revision range>] [--] [<path>...]
+'gitk' [<options>] [<revision-range>] [--] [<path>...]
 
 DESCRIPTION
 -----------
@@ -124,7 +124,7 @@ gitk-specific options
 	range to show.  The command is expected to print on its
 	standard output a list of additional revisions to be shown,
 	one per line.  Use this instead of explicitly specifying a
-	'<revision range>' if the set of commits to show may vary
+	'<revision-range>' if the set of commits to show may vary
 	between refreshes.
 
 --select-commit=<ref>::
diff --git a/Documentation/gitprotocol-capabilities.txt b/Documentation/gitprotocol-capabilities.txt
index d6c6effc215..2cf7735be47 100644
--- a/Documentation/gitprotocol-capabilities.txt
+++ b/Documentation/gitprotocol-capabilities.txt
@@ -378,7 +378,7 @@ fetch-pack may send "filter" commands to request a partial clone
 or partial fetch and request that the server omit various objects
 from the packfile.
 
-session-id=<session id>
+session-id=<session-id>
 -----------------------
 
 The server may advertise a session ID that can be used to identify this process
diff --git a/Documentation/gitprotocol-http.txt b/Documentation/gitprotocol-http.txt
index 21b73b7a1f5..d834c745f71 100644
--- a/Documentation/gitprotocol-http.txt
+++ b/Documentation/gitprotocol-http.txt
@@ -391,14 +391,14 @@ C: Start a queue, `c_pending`, ordered by commit time (popping newest
 
 C: Send one `$GIT_URL/git-upload-pack` request:
 
-   C: 0032want <want #1>...............................
-   C: 0032want <want #2>...............................
+   C: 0032want <want-#1>...............................
+   C: 0032want <want-#2>...............................
    ....
-   C: 0032have <common #1>.............................
-   C: 0032have <common #2>.............................
+   C: 0032have <common-#1>.............................
+   C: 0032have <common-#2>.............................
    ....
-   C: 0032have <have #1>...............................
-   C: 0032have <have #2>...............................
+   C: 0032have <have-#1>...............................
+   C: 0032have <have-#2>...............................
    ....
    C: 0000
 
@@ -512,7 +512,7 @@ Within the command portion of the request body clients SHOULD send
 the id obtained through ref discovery as old_id.
 
   update_request  =  command_list
-		     "PACK" <binary data>
+		     "PACK" <binary-data>
 
   command_list    =  PKT-LINE(command NUL cap_list LF)
 		     *(command_pkt)
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 8c1e7c61eac..0b800abd567 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -199,7 +199,7 @@ which can be used to limit the refs sent from the server.
 
 Additional features not supported in the base command will be advertised
 as the value of the command in the capability advertisement in the form
-of a space separated list of features: "<command>=<feature 1> <feature 2>"
+of a space separated list of features: "<command>=<feature-1> <feature-2>"
 
 ls-refs takes in the following arguments:
 
@@ -245,7 +245,7 @@ addition of future extensions.
 
 Additional features not supported in the base command will be advertised
 as the value of the command in the capability advertisement in the form
-of a space separated list of features: "<command>=<feature 1> <feature 2>"
+of a space separated list of features: "<command>=<feature-1> <feature-2>"
 
 A `fetch` request can take the following arguments:
 
@@ -363,7 +363,7 @@ can be included in the client's request as well as the potential
 addition of the 'packfile-uris' section in the server's response as
 explained below.
 
-    packfile-uris <comma-separated list of protocols>
+    packfile-uris <comma-separated-list-of-protocols>
 	Indicates to the server that the client is willing to receive
 	URIs of any of the given protocols in place of objects in the
 	sent packfile. Before performing the connectivity check, the
@@ -534,7 +534,7 @@ with objects using hash algorithm X.  If not specified, the server is assumed to
 only handle SHA-1.  If the client would like to use a hash algorithm other than
 SHA-1, it should specify its object-format string.
 
-session-id=<session id>
+session-id=<session-id>
 ~~~~~~~~~~~~~~~~~~~~~~~
 
 The server may advertise a session ID that can be used to identify this process
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 8400d591da0..f7b5a25a0ca 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -151,7 +151,7 @@ the superproject's `$GIT_DIR/config` file, so the superproject's history
 is not affected. This can be undone using `git submodule init`.
 
  * Deleted submodule: A submodule can be deleted by running
-`git rm <submodule path> && git commit`. This can be undone
+`git rm <submodule-path> && git commit`. This can be undone
 using `git revert`.
 +
 The deletion removes the superproject's tracking data, which are
@@ -229,7 +229,7 @@ Workflow for a third party library
   git submodule add <URL> <path>
 
   # Occasionally update the submodule to a new version:
-  git -C <path> checkout <new version>
+  git -C <path> checkout <new-version>
   git add <path>
   git commit -m "update submodule to new version"
 
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index b078fef6f5c..39c959cbe7d 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -343,7 +343,7 @@ $home_link_str::
 	Label for the "home link" at the top of all pages, leading to `$home_link`
 	(usually the main gitweb page, which contains the projects list).  It is
 	used as the first component of gitweb's "breadcrumb trail":
-	`<home link> / <project> / <action>`.  Can be set at build time using
+	`<home-link> / <project> / <action>`.  Can be set at build time using
 	the `GITWEB_HOME_LINK_STR` variable.  By default it is set to "projects",
 	as this link leads to the list of projects.  Another popular choice is to
 	set it to the name of site.  Note that it is treated as raw HTML so it
@@ -604,9 +604,9 @@ Many gitweb features can be enabled (or disabled) and configured using the
 Each `%feature` hash element is a hash reference and has the following
 structure:
 ----------------------------------------------------------------------
-"<feature_name>" => {
-	"sub" => <feature-sub (subroutine)>,
-	"override" => <allow-override (boolean)>,
+"<feature-name>" => {
+	"sub" => <feature-sub-(subroutine)>,
+	"override" => <allow-override-(boolean)>,
 	"default" => [ <options>... ]
 },
 ----------------------------------------------------------------------
@@ -614,7 +614,7 @@ Some features cannot be overridden per project.  For those
 features the structure of appropriate `%feature` hash element has a simpler
 form:
 ----------------------------------------------------------------------
-"<feature_name>" => {
+"<feature-name>" => {
 	"override" => 0,
 	"default" => [ <options>... ]
 },
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 1030e9667ea..7b2f2ea6fc1 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -305,7 +305,7 @@ pathnames.  In most general form such path_info (component) based gitweb URL
 looks like this:
 
 -----------------------------------------------------------------------
-.../gitweb.cgi/<repo>/<action>/<revision_from>:/<path_from>..<revision_to>:/<path_to>?<arguments>
+.../gitweb.cgi/<repo>/<action>/<revision-from>:/<path-from>..<revision-to>:/<path-to>?<arguments>
 -----------------------------------------------------------------------
 
 
diff --git a/Documentation/trace2-target-values.txt b/Documentation/trace2-target-values.txt
index 3985b6d3c29..06f19533134 100644
--- a/Documentation/trace2-target-values.txt
+++ b/Documentation/trace2-target-values.txt
@@ -5,7 +5,7 @@
 * `<absolute-pathname>` - Writes to the file in append mode. If the target
 already exists and is a directory, the traces will be written to files (one
 per process) underneath the given directory.
-* `af_unix:[<socket_type>:]<absolute-pathname>` - Write to a
+* `af_unix:[<socket-type>:]<absolute-pathname>` - Write to a
 Unix DomainSocket (on platforms that support them).  Socket
 type can be either `stream` or `dgram`; if omitted Git will
 try both.
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 4e79c1589ec..ce671f812d4 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -73,8 +73,8 @@ use will be rewritten into URLs that work), you can create a
 configuration section of the form:
 
 ------------
-	[url "<actual url base>"]
-		insteadOf = <other url base>
+	[url "<actual-url-base>"]
+		insteadOf = <other-url-base>
 ------------
 
 For example, with this:
@@ -92,8 +92,8 @@ If you want to rewrite URLs for push only, you can create a
 configuration section of the form:
 
 ------------
-	[url "<actual url base>"]
-		pushInsteadOf = <other url base>
+	[url "<actual-url-base>"]
+		pushInsteadOf = <other-url-base>
 ------------
 
 For example, with this:
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d8dbe6b56d4..163e8fe77aa 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4100,8 +4100,8 @@ independently of the contents or the type of the object: all objects can
 be validated by verifying that (a) their hashes match the content of the
 file and (b) the object successfully inflates to a stream of bytes that
 forms a sequence of
-`<ascii type without space> + <space> + <ascii decimal size> +
-<byte\0> + <binary object data>`.
+`<ascii-type-without-space> + <space> + <ascii-decimal-size> +
+<byte\0> + <binary-object-data>`.
 
 The structured objects can further have their structure and
 connectivity to other objects verified. This is generally done with
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 45d035af600..597927bc56e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -22,7 +22,7 @@
 	N_("git commit-graph write [--object-dir <dir>] [--append]\n" \
 	   "                       [--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]\n" \
 	   "                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]\n" \
-	   "                       <split options>")
+	   "                       <split-options>")
 
 static const char * builtin_commit_graph_verify_usage[] = {
 	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
-- 
gitgitgadget

