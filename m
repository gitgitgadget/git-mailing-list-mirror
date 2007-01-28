From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sat, 27 Jan 2007 18:40:09 -0800
Message-ID: <20070128024009.GB6545@socrates.priv>
References: <20070127062826.GE14205@fieldses.org>
 <20070128002246.GA10179@moooo.ath.cx>
 <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
 <20070128013452.GA11244@moooo.ath.cx>
 <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 04:40:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB0uD-0003jq-Bp
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 04:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbXA1Dk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 22:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbXA1Dk1
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 22:40:27 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45606 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbXA1DkX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 22:40:23 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Jan 2007 22:40:22 EST
Received: from pd4mr2so.prod.shaw.ca
 (pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JCK00CG64RA9I60@l-daemon> for git@vger.kernel.org; Sat,
 27 Jan 2007 19:40:22 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JCK00I0D4QU3Y70@pd4mr2so.prod.shaw.ca> for
 git@vger.kernel.org; Sat, 27 Jan 2007 19:40:22 -0700 (MST)
Received: from socrates.priv ([68.148.57.191])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JCK00J664QQ5GK3@l-daemon> for git@vger.kernel.org; Sat,
 27 Jan 2007 19:40:05 -0700 (MST)
Received: from socrates.priv (localhost [127.0.0.1])
	by socrates.priv (8.13.4/8.13.4) with ESMTP id l0S2e9Jl005892; Sat,
 27 Jan 2007 19:40:09 -0700
Received: (from cougar@localhost)	by socrates.priv (8.13.4/8.13.4/Submit)
 id l0S2e9JX005891; Sat, 27 Jan 2007 18:40:09 -0800
In-reply-to: <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
Mail-followup-to: Linus Torvalds <torvalds@linux-foundation.org>,
 git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>,
 Junio C Hamano <junkio@cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.11-2006-05-17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38016>

On Sat, Jan 27, 2007 at 05:47:49PM -0800, Linus Torvalds wrote:
> Btw, one thing I don't like about "git-repo-config" is the name.
>
> Many people thought "git init-db" was confusing, and now we call it just
> "git init".
>
> Can I vote for doing that for "git repo-config" too? Is there something
> wrong with just calling it "git config"?
>
> Especially as it's not even repo-specific. Use "--global", and it has
> almost nothing at all to do with the particular "repo" you're working
> with.
>
> What would also mean that we'd have the man-page with a simple
>
>       man git-config
>
> which makes tons of sense if it documents both the config file *and* the
> "git config" program.
>
> Or is that too sneaky?
>
>               Linus
---
 .gitignore                                         |    1 +
 Documentation/cmd-list.perl                        |    2 +-
 Documentation/config.txt                           |    2 +-
 Documentation/core-tutorial.txt                    |    2 +-
 Documentation/cvs-migration.txt                    |    2 +-
 Documentation/everyday.txt                         |    4 +-
 Documentation/git-config.txt                       |  227 ++++++++++++++++++++
 Documentation/git-pull.txt                         |    4 +-
 Documentation/git-remote.txt                       |    4 +-
 Documentation/git-repo-config.txt                  |  227 --------------------
 Documentation/git-svn.txt                          |   20 +-
 Documentation/git-update-index.txt                 |    4 +-
 Documentation/git-var.txt                          |    4 +-
 Documentation/git.txt                              |    2 +-
 Documentation/howto/setup-git-server-over-http.txt |    4 +-
 Documentation/tutorial.txt                         |    8 +-
 Makefile                                           |    4 +-
 builtin-config.c                                   |  220 +++++++++++++++++++
 builtin-repo-config.c                              |  220 -------------------
 builtin.h                                          |    2 +-
 contrib/completion/git-completion.bash             |   15 +-
 contrib/emacs/git.el                               |    8 +-
 contrib/gitview/gitview                            |    2 +-
 contrib/remotes2config.sh                          |    4 +-
 git-clone.sh                                       |   10 +-
 git-commit.sh                                      |    4 +-
 git-cvsserver.perl                                 |    6 +-
 git-fetch.sh                                       |    2 +-
 git-instaweb.sh                                    |   10 +-
 git-ls-remote.sh                                   |    2 +-
 git-merge.sh                                       |    4 +-
 git-p4import.py                                    |    4 +-
 git-parse-remote.sh                                |   14 +-
 git-remote.perl                                    |    8 +-
 git-repack.sh                                      |    2 +-
 git-revert.sh                                      |    2 +-
 git-sh-setup.sh                                    |    2 +-
 git-svn.perl                                       |   20 +-
 git.c                                              |    3 +-
 gitk                                               |    2 +-
 gitweb/gitweb.perl                                 |    2 +-
 ident.c                                            |    4 +-
 perl/Git.pm                                        |    8 +-
 t/t1300-repo-config.sh                             |  102 +++++-----
 t/t1400-update-ref.sh                              |    4 +-
 t/t1410-reflog.sh                                  |    2 +-
 t/t3200-branch.sh                                  |    6 +-
 t/t3700-add.sh                                     |    6 +-
 t/t3900-i18n-commit.sh                             |   24 +-
 t/t3901-i18n-patch.sh                              |   58 +++---
 t/t4000-diff-format.sh                             |    2 +-
 t/t4006-diff-mode.sh                               |    2 +-
 t/t4013-diff-various.sh                            |    2 +-
 t/t4102-apply-rename.sh                            |    2 +-
 t/t5301-sliding-window.sh                          |   14 +-
 t/t5400-send-pack.sh                               |    2 +-
 t/t5500-fetch-pack.sh                              |    2 +-
 t/t5510-fetch.sh                                   |   10 +-
 t/t6200-fmt-merge-msg.sh                           |    6 +-
 59 files changed, 674 insertions(+), 671 deletions(-)
 create mode 100644 Documentation/git-config.txt
 delete mode 100644 Documentation/git-repo-config.txt
 create mode 100644 builtin-config.c
 delete mode 100644 builtin-repo-config.c

diff --git a/.gitignore b/.gitignore
index 6da1cdb..b4dccd7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,6 +23,7 @@ git-clean
 git-clone
 git-commit
 git-commit-tree
+git-config
 git-convert-objects
 git-count-objects
 git-cvsexportcommit
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 744db82..8244625 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -144,7 +144,7 @@ git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
 git-repack                              ancillarymanipulators
-git-repo-config                         ancillarymanipulators
+git-config                              ancillarymanipulators
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3f2fa09..4897c55 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -62,7 +62,7 @@ The values following the equals sign in variable assign are all either
 a string, an integer, or a boolean.  Boolean values may be given as yes/no,
 0/1 or true/false.  Case is not significant in boolean values, when
 converting value to the canonical form using '--bool' type specifier;
-`git-repo-config` will ensure that the output is "true" or "false".
+`git-config` will ensure that the output is "true" or "false".
 
 String values may be entirely or partially enclosed in double quotes.
 You need to enclose variable value in double quotes if you want to
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 7317489..86a9c75 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -1130,7 +1130,7 @@ the remote repository URL in the local repository's config file
 like this:
 
 ------------------------------------------------
-$ git repo-config remote.linus.url http://www.kernel.org/pub/scm/git/git.git/
+$ git config remote.linus.url http://www.kernel.org/pub/scm/git/git.git/
 ------------------------------------------------
 
 and use the "linus" keyword with `git pull` instead of the full URL.
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 775bf42..764cc56 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -36,7 +36,7 @@ them first before running git pull.
 ================================
 The `pull` command knows where to get updates from because of certain
 configuration variables that were set by the first `git clone`
-command; see `git repo-config -l` and the gitlink:git-repo-config[1] man
+command; see `git config -l` and the gitlink:git-config[1] man
 page for details.
 ================================
 
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index ca36a76..fbbbc92 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -212,12 +212,12 @@ Push into another repository.::
 ------------
 satellite$ git clone mothership:frotz frotz <1>
 satellite$ cd frotz
-satellite$ git repo-config --get-regexp '^(remote|branch)\.' <2>
+satellite$ git config --get-regexp '^(remote|branch)\.' <2>
 remote.origin.url mothership:frotz
 remote.origin.fetch refs/heads/*:refs/remotes/origin/*
 branch.master.remote origin
 branch.master.merge refs/heads/master
-satellite$ git repo-config remote.origin.push \
+satellite$ git config remote.origin.push \
            master:refs/remotes/satellite/master <3>
 satellite$ edit/compile/test/commit
 satellite$ git push origin <4>
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
new file mode 100644
index 0000000..b0dbfb2
--- /dev/null
+++ b/Documentation/git-config.txt
@@ -0,0 +1,227 @@
+git-config(1)
+==================
+
+NAME
+----
+git-config - Get and set repository or global options
+
+
+SYNOPSIS
+--------
+[verse]
+'git-config' [--global] [type] name [value [value_regex]]
+'git-config' [--global] [type] --add name value
+'git-config' [--global] [type] --replace-all name [value [value_regex]]
+'git-config' [--global] [type] --get name [value_regex]
+'git-config' [--global] [type] --get-all name [value_regex]
+'git-config' [--global] [type] --unset name [value_regex]
+'git-config' [--global] [type] --unset-all name [value_regex]
+'git-config' [--global] -l | --list
+
+DESCRIPTION
+-----------
+You can query/set/replace/unset options with this command. The name is
+actually the section and the key separated by a dot, and the value will be
+escaped.
+
+Multiple lines can be added to an option by using the '--add' option.
+If you want to update or unset an option which can occur on multiple
+lines, a POSIX regexp `value_regex` needs to be given.  Only the
+existing values that match the regexp are updated or unset.  If
+you want to handle the lines that do *not* match the regex, just
+prepend a single exclamation mark in front (see EXAMPLES).
+
+The type specifier can be either '--int' or '--bool', which will make
+'git-config' ensure that the variable(s) are of the given type and
+convert the value to the canonical form (simple decimal number for int,
+a "true" or "false" string for bool). If no type specifier is passed,
+no checks or transformations are performed on the value.
+
+This command will fail if:
+
+. The .git/config file is invalid,
+. Can not write to .git/config,
+. no section was provided,
+. the section or key is invalid,
+. you try to unset an option which does not exist,
+. you try to unset/set an option for which multiple lines match, or
+. you use --global option without $HOME being properly set.
+
+
+OPTIONS
+-------
+
+--replace-all::
+	Default behavior is to replace at most one line. This replaces
+	all lines matching the key (and optionally the value_regex).
+
+--add::
+	Adds a new line to the option without altering any existing
+	values.  This is the same as providing '^$' as the value_regex.
+
+--get::
+	Get the value for a given key (optionally filtered by a regex
+	matching the value). Returns error code 1 if the key was not
+	found and error code 2 if multiple key values were found.
+
+--get-all::
+	Like get, but does not fail if the number of values for the key
+	is not exactly one.
+
+--get-regexp::
+	Like --get-all, but interprets the name as a regular expression.
+
+--global::
+	Use global ~/.gitconfig file rather than the repository .git/config.
+
+--unset::
+	Remove the line matching the key from config file.
+
+--unset-all::
+	Remove all matching lines from config file.
+
+-l, --list::
+	List all variables set in config file.
+
+--bool::
+	git-config will ensure that the output is "true" or "false"
+
+--int::
+	git-config will ensure that the output is a simple
+	decimal number.  An optional value suffix of 'k', 'm', or 'g'
+	in the config file will cause the value to be multiplied
+	by 1024, 1048576, or 1073741824 prior to output.
+
+
+ENVIRONMENT
+-----------
+
+GIT_CONFIG::
+	Take the configuration from the given file instead of .git/config.
+	Using the "--global" option forces this to ~/.gitconfig.
+
+GIT_CONFIG_LOCAL::
+	Currently the same as $GIT_CONFIG; when Git will support global
+	configuration files, this will cause it to take the configuration
+	from the global configuration file in addition to the given file.
+
+
+EXAMPLE
+-------
+
+Given a .git/config like this:
+
+	#
+	# This is the config file, and
+	# a '#' or ';' character indicates
+	# a comment
+	#
+
+	; core variables
+	[core]
+		; Don't trust file modes
+		filemode = false
+
+	; Our diff algorithm
+	[diff]
+		external = "/usr/local/bin/gnu-diff -u"
+		renames = true
+
+	; Proxy settings
+	[core]
+		gitproxy="ssh" for "ssh://kernel.org/"
+		gitproxy="proxy-command" for kernel.org
+		gitproxy="myprotocol-command" for "my://"
+		gitproxy=default-proxy ; for all the rest
+
+you can set the filemode to true with
+
+------------
+% git config core.filemode true
+------------
+
+The hypothetical proxy command entries actually have a postfix to discern
+what URL they apply to. Here is how to change the entry for kernel.org
+to "ssh".
+
+------------
+% git config core.gitproxy '"ssh" for kernel.org' 'for kernel.org$'
+------------
+
+This makes sure that only the key/value pair for kernel.org is replaced.
+
+To delete the entry for renames, do
+
+------------
+% git config --unset diff.renames
+------------
+
+If you want to delete an entry for a multivar (like core.gitproxy above),
+you have to provide a regex matching the value of exactly one line.
+
+To query the value for a given key, do
+
+------------
+% git config --get core.filemode
+------------
+
+or
+
+------------
+% git config core.filemode
+------------
+
+or, to query a multivar:
+
+------------
+% git config --get core.gitproxy "for kernel.org$"
+------------
+
+If you want to know all the values for a multivar, do:
+
+------------
+% git config --get-all core.gitproxy
+------------
+
+If you like to live dangerous, you can replace *all* core.gitproxy by a
+new one with
+
+------------
+% git config --replace-all core.gitproxy ssh
+------------
+
+However, if you really only want to replace the line for the default proxy,
+i.e. the one without a "for ..." postfix, do something like this:
+
+------------
+% git config core.gitproxy ssh '! for '
+------------
+
+To actually match only values with an exclamation mark, you have to
+
+------------
+% git config section.key value '[!]'
+------------
+
+To add a new proxy, without altering any of the existing ones, use
+
+------------
+% git config core.gitproxy '"proxy" for example.com'
+------------
+
+
+include::config.txt[]
+
+
+Author
+------
+Written by Johannes Schindelin <Johannes.Schindelin@gmx.de>
+
+Documentation
+--------------
+Documentation by Johannes Schindelin, Petr Baudis and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 3e5f115..a81d68c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -42,7 +42,7 @@ git pull, git pull origin::
 	current branch.  Normally the branch merged in is
 	the HEAD of the remote repository, but the choice is
 	determined by the branch.<name>.remote and
-	branch.<name>.merge options; see gitlink:git-repo-config[1]
+	branch.<name>.merge options; see gitlink:git-config[1]
 	for details.
 
 git pull origin next::
@@ -94,7 +94,7 @@ gitlink:git-reset[1].
 
 SEE ALSO
 --------
-gitlink:git-fetch[1], gitlink:git-merge[1], gitlink:git-repo-config[1]
+gitlink:git-fetch[1], gitlink:git-merge[1], gitlink:git-config[1]
 
 
 Author
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 5b93a8c..358c1ac 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -28,7 +28,7 @@ In the third form, gives some information about the remote <name>.
 
 The remote configuration is achieved using the `remote.origin.url` and
 `remote.origin.fetch` configuration variables.  (See
-gitlink:git-repo-config[1]).
+gitlink:git-config[1]).
 
 Examples
 --------
@@ -58,7 +58,7 @@ See Also
 --------
 gitlink:git-fetch[1]
 gitlink:git-branch[1]
-gitlink:git-repo-config[1]
+gitlink:git-config[1]
 
 Author
 ------
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
deleted file mode 100644
index 9db3d30..0000000
--- a/Documentation/git-repo-config.txt
+++ /dev/null
@@ -1,227 +0,0 @@
-git-repo-config(1)
-==================
-
-NAME
-----
-git-repo-config - Get and set repository or global options
-
-
-SYNOPSIS
---------
-[verse]
-'git-repo-config' [--global] [type] name [value [value_regex]]
-'git-repo-config' [--global] [type] --add name value
-'git-repo-config' [--global] [type] --replace-all name [value [value_regex]]
-'git-repo-config' [--global] [type] --get name [value_regex]
-'git-repo-config' [--global] [type] --get-all name [value_regex]
-'git-repo-config' [--global] [type] --unset name [value_regex]
-'git-repo-config' [--global] [type] --unset-all name [value_regex]
-'git-repo-config' [--global] -l | --list
-
-DESCRIPTION
------------
-You can query/set/replace/unset options with this command. The name is
-actually the section and the key separated by a dot, and the value will be
-escaped.
-
-Multiple lines can be added to an option by using the '--add' option.
-If you want to update or unset an option which can occur on multiple
-lines, a POSIX regexp `value_regex` needs to be given.  Only the
-existing values that match the regexp are updated or unset.  If
-you want to handle the lines that do *not* match the regex, just
-prepend a single exclamation mark in front (see EXAMPLES).
-
-The type specifier can be either '--int' or '--bool', which will make
-'git-repo-config' ensure that the variable(s) are of the given type and
-convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool). If no type specifier is passed,
-no checks or transformations are performed on the value.
-
-This command will fail if:
-
-. The .git/config file is invalid,
-. Can not write to .git/config,
-. no section was provided,
-. the section or key is invalid,
-. you try to unset an option which does not exist,
-. you try to unset/set an option for which multiple lines match, or
-. you use --global option without $HOME being properly set.
-
-
-OPTIONS
--------
-
---replace-all::
-	Default behavior is to replace at most one line. This replaces
-	all lines matching the key (and optionally the value_regex).
-
---add::
-	Adds a new line to the option without altering any existing
-	values.  This is the same as providing '^$' as the value_regex.
-
---get::
-	Get the value for a given key (optionally filtered by a regex
-	matching the value). Returns error code 1 if the key was not
-	found and error code 2 if multiple key values were found.
-
---get-all::
-	Like get, but does not fail if the number of values for the key
-	is not exactly one.
-
---get-regexp::
-	Like --get-all, but interprets the name as a regular expression.
-
---global::
-	Use global ~/.gitconfig file rather than the repository .git/config.
-
---unset::
-	Remove the line matching the key from config file.
-
---unset-all::
-	Remove all matching lines from config file.
-
--l, --list::
-	List all variables set in config file.
-
---bool::
-	git-repo-config will ensure that the output is "true" or "false"
-
---int::
-	git-repo-config will ensure that the output is a simple
-	decimal number.  An optional value suffix of 'k', 'm', or 'g'
-	in the config file will cause the value to be multiplied
-	by 1024, 1048576, or 1073741824 prior to output.
-
-
-ENVIRONMENT
------------
-
-GIT_CONFIG::
-	Take the configuration from the given file instead of .git/config.
-	Using the "--global" option forces this to ~/.gitconfig.
-
-GIT_CONFIG_LOCAL::
-	Currently the same as $GIT_CONFIG; when Git will support global
-	configuration files, this will cause it to take the configuration
-	from the global configuration file in addition to the given file.
-
-
-EXAMPLE
--------
-
-Given a .git/config like this:
-
-	#
-	# This is the config file, and
-	# a '#' or ';' character indicates
-	# a comment
-	#
-
-	; core variables
-	[core]
-		; Don't trust file modes
-		filemode = false
-
-	; Our diff algorithm
-	[diff]
-		external = "/usr/local/bin/gnu-diff -u"
-		renames = true
-
-	; Proxy settings
-	[core]
-		gitproxy="ssh" for "ssh://kernel.org/"
-		gitproxy="proxy-command" for kernel.org
-		gitproxy="myprotocol-command" for "my://"
-		gitproxy=default-proxy ; for all the rest
-
-you can set the filemode to true with
-
-------------
-% git repo-config core.filemode true
-------------
-
-The hypothetical proxy command entries actually have a postfix to discern
-what URL they apply to. Here is how to change the entry for kernel.org
-to "ssh".
-
-------------
-% git repo-config core.gitproxy '"ssh" for kernel.org' 'for kernel.org$'
-------------
-
-This makes sure that only the key/value pair for kernel.org is replaced.
-
-To delete the entry for renames, do
-
-------------
-% git repo-config --unset diff.renames
-------------
-
-If you want to delete an entry for a multivar (like core.gitproxy above),
-you have to provide a regex matching the value of exactly one line.
-
-To query the value for a given key, do
-
-------------
-% git repo-config --get core.filemode
-------------
-
-or
-
-------------
-% git repo-config core.filemode
-------------
-
-or, to query a multivar:
-
-------------
-% git repo-config --get core.gitproxy "for kernel.org$"
-------------
-
-If you want to know all the values for a multivar, do:
-
-------------
-% git repo-config --get-all core.gitproxy
-------------
-
-If you like to live dangerous, you can replace *all* core.gitproxy by a
-new one with
-
-------------
-% git repo-config --replace-all core.gitproxy ssh
-------------
-
-However, if you really only want to replace the line for the default proxy,
-i.e. the one without a "for ..." postfix, do something like this:
-
-------------
-% git repo-config core.gitproxy ssh '! for '
-------------
-
-To actually match only values with an exclamation mark, you have to
-
-------------
-% git repo-config section.key value '[!]'
-------------
-
-To add a new proxy, without altering any of the existing ones, use
-
-------------
-% git repo-config core.gitproxy '"proxy" for example.com'
-------------
-
-
-include::config.txt[]
-
-
-Author
-------
-Written by Johannes Schindelin <Johannes.Schindelin@gmx.de>
-
-Documentation
---------------
-Documentation by Johannes Schindelin, Petr Baudis and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
-
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b95ff1d..aea4a6b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -204,7 +204,7 @@ removed by default if there are no files left in them.  git
 cannot version empty directories.  Enabling this flag will make
 the commit to SVN act like git.
 
-repo-config key: svn.rmdir
+config key: svn.rmdir
 
 -e::
 --edit::
@@ -215,7 +215,7 @@ Edit the commit message before committing to SVN.  This is off by
 default for objects that are commits, and forced on when committing
 tree objects.
 
-repo-config key: svn.edit
+config key: svn.edit
 
 -l<num>::
 --find-copies-harder::
@@ -226,8 +226,8 @@ They are both passed directly to git-diff-tree see
 gitlink:git-diff-tree[1] for more information.
 
 [verse]
-repo-config key: svn.l
-repo-config key: svn.findcopiesharder
+config key: svn.l
+config key: svn.findcopiesharder
 
 -A<filename>::
 --authors-file=<filename>::
@@ -245,7 +245,7 @@ will abort operation. The user will then have to add the
 appropriate entry.  Re-running the previous git-svn command
 after the authors-file is modified should continue operation.
 
-repo-config key: svn.authorsfile
+config key: svn.authorsfile
 
 -q::
 --quiet::
@@ -262,8 +262,8 @@ repo-config key: svn.authorsfile
 
 	--repack-flags are passed directly to gitlink:git-repack[1].
 
-repo-config key: svn.repack
-repo-config key: svn.repackflags
+config key: svn.repack
+config key: svn.repackflags
 
 -m::
 --merge::
@@ -304,7 +304,7 @@ used to track branches across multiple SVN _repositories_.
 This option may be specified multiple times, once for each
 branch.
 
-repo-config key: svn.branch
+config key: svn.branch
 
 -i<GIT_SVN_ID>::
 --id <GIT_SVN_ID>::
@@ -320,7 +320,7 @@ for more information on using GIT_SVN_ID.
 	started tracking a branch and never tracked the trunk it was
 	descended from.
 
-repo-config key: svn.followparent
+config key: svn.followparent
 
 --no-metadata::
 	This gets rid of the git-svn-id: lines at the end of every commit.
@@ -332,7 +332,7 @@ repo-config key: svn.followparent
 	The 'git-svn log' command will not work on repositories using this,
 	either.
 
-repo-config key: svn.nometadata
+config key: svn.nometadata
 
 --
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 5bbae42..b161c8b 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -289,7 +289,7 @@ Configuration
 
 The command honors `core.filemode` configuration variable.  If
 your repository is on an filesystem whose executable bits are
-unreliable, this should be set to 'false' (see gitlink:git-repo-config[1]).
+unreliable, this should be set to 'false' (see gitlink:git-config[1]).
 This causes the command to ignore differences in file modes recorded
 in the index and the file mode on the filesystem if they differ only on
 executable bit.   On such an unfortunate filesystem, you may
@@ -301,7 +301,7 @@ The command looks at `core.ignorestat` configuration variable.  See
 
 See Also
 --------
-gitlink:git-repo-config[1]
+gitlink:git-config[1]
 
 
 Author
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 8a50638..9b0de1c 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -20,7 +20,7 @@ OPTIONS
 	Cause the logical variables to be listed. In addition, all the
 	variables of the git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
-	is deprecated in favor of `git-repo-config -l`.)
+	is deprecated in favor of `git-config -l`.)
 
 EXAMPLE
 --------
@@ -49,7 +49,7 @@ See Also
 --------
 gitlink:git-commit-tree[1]
 gitlink:git-tag[1]
-gitlink:git-repo-config[1]
+gitlink:git-config[1]
 
 Author
 ------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9761de3..7cd3467 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -24,7 +24,7 @@ link:everyday.html[Everyday Git] for a useful minimum set of commands, and
 also want to read link:cvs-migration.html[CVS migration].
 
 The COMMAND is either a name of a Git command (see below) or an alias
-as defined in the configuration file (see gitlink:git-repo-config[1]).
+as defined in the configuration file (see gitlink:git-config[1]).
 
 OPTIONS
 -------
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index a202f3a..8eadc20 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -205,7 +205,7 @@ To check whether all is OK, do:
 Now, add the remote in your existing repository which contains the project
 you want to export:
 
-   $ git-repo-config remote.upload.url \
+   $ git-config remote.upload.url \
        http://<username>@<servername>/my-new-repo.git/
 
 It is important to put the last '/'; Without it, the server will send
@@ -222,7 +222,7 @@ From your client repository, do
 
 This pushes branch 'master' (which is assumed to be the branch you
 want to export) to repository called 'upload', which we previously
-defined with git-repo-config.
+defined with git-config.
 
 
 Troubleshooting:
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index c27a450..adb1e32 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -16,8 +16,8 @@ public email address before doing any operation.  The easiest
 way to do so is:
 
 ------------------------------------------------
-$ git repo-config --global user.name "Your Name Comes Here"
-$ git repo-config --global user.email you@yourdomain.example.com
+$ git config --global user.name "Your Name Comes Here"
+$ git config --global user.email you@yourdomain.example.com
 ------------------------------------------------
 
 
@@ -353,12 +353,12 @@ repository in the repository configuration, and that location is
 used for pulls:
 
 -------------------------------------
-$ git repo-config --get remote.origin.url
+$ git config --get remote.origin.url
 /home/bob/myrepo
 -------------------------------------
 
 (The complete configuration created by git-clone is visible using
-"git repo-config -l", and the gitlink:git-repo-config[1] man page
+"git config -l", and the gitlink:git-config[1] man page
 explains the meaning of each option.)
 
 Git also keeps a pristine copy of Alice's master branch under the
diff --git a/Makefile b/Makefile
index 07246f3..fd8a522 100644
--- a/Makefile
+++ b/Makefile
@@ -213,7 +213,7 @@ EXTRA_PROGRAMS =
 
 BUILT_INS = \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
-	git-get-tar-commit-id$X git-init$X \
+	git-get-tar-commit-id$X git-init$X git-repo-config$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
@@ -299,7 +299,7 @@ BUILTIN_OBJS = \
 	builtin-push.o \
 	builtin-read-tree.o \
 	builtin-reflog.o \
-	builtin-repo-config.o \
+	builtin-config.o \
 	builtin-rerere.o \
 	builtin-rev-list.o \
 	builtin-rev-parse.o \
diff --git a/builtin-config.c b/builtin-config.c
new file mode 100644
index 0000000..3c3860f
--- /dev/null
+++ b/builtin-config.c
@@ -0,0 +1,220 @@
+#include "builtin.h"
+#include "cache.h"
+
+static const char git_config_set_usage[] =
+"git-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
+
+static char *key;
+static regex_t *key_regexp;
+static regex_t *regexp;
+static int show_keys;
+static int use_key_regexp;
+static int do_all;
+static int do_not_match;
+static int seen;
+static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
+
+static int show_all_config(const char *key_, const char *value_)
+{
+	if (value_)
+		printf("%s=%s\n", key_, value_);
+	else
+		printf("%s\n", key_);
+	return 0;
+}
+
+static int show_config(const char* key_, const char* value_)
+{
+	char value[256];
+	const char *vptr = value;
+	int dup_error = 0;
+
+	if (!use_key_regexp && strcmp(key_, key))
+		return 0;
+	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
+		return 0;
+	if (regexp != NULL &&
+			 (do_not_match ^
+			  regexec(regexp, (value_?value_:""), 0, NULL, 0)))
+		return 0;
+
+	if (show_keys)
+		printf("%s ", key_);
+	if (seen && !do_all)
+		dup_error = 1;
+	if (type == T_INT)
+		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
+	else if (type == T_BOOL)
+		vptr = git_config_bool(key_, value_) ? "true" : "false";
+	else
+		vptr = value_?value_:"";
+	seen++;
+	if (dup_error) {
+		error("More than one value for the key %s: %s",
+				key_, vptr);
+	}
+	else
+		printf("%s\n", vptr);
+
+	return 0;
+}
+
+static int get_value(const char* key_, const char* regex_)
+{
+	int ret = -1;
+	char *tl;
+	char *global = NULL, *config = NULL;
+	const char *local;
+
+	local = getenv(CONFIG_ENVIRONMENT);
+	if (!local) {
+		const char *home = getenv("HOME");
+		local = getenv(CONFIG_LOCAL_ENVIRONMENT);
+		if (!local)
+			local = config = xstrdup(git_path("config"));
+		if (home)
+			global = xstrdup(mkpath("%s/.gitconfig", home));
+	}
+
+	key = xstrdup(key_);
+	for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
+		*tl = tolower(*tl);
+	for (tl=key; *tl && *tl != '.'; ++tl)
+		*tl = tolower(*tl);
+
+	if (use_key_regexp) {
+		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
+		if (regcomp(key_regexp, key, REG_EXTENDED)) {
+			fprintf(stderr, "Invalid key pattern: %s\n", key_);
+			goto free_strings;
+		}
+	}
+
+	if (regex_) {
+		if (regex_[0] == '!') {
+			do_not_match = 1;
+			regex_++;
+		}
+
+		regexp = (regex_t*)xmalloc(sizeof(regex_t));
+		if (regcomp(regexp, regex_, REG_EXTENDED)) {
+			fprintf(stderr, "Invalid pattern: %s\n", regex_);
+			goto free_strings;
+		}
+	}
+
+	if (do_all && global)
+		git_config_from_file(show_config, global);
+	git_config_from_file(show_config, local);
+	if (!do_all && !seen && global)
+		git_config_from_file(show_config, global);
+
+	free(key);
+	if (regexp) {
+		regfree(regexp);
+		free(regexp);
+	}
+
+	if (do_all)
+		ret = !seen;
+	else
+		ret = (seen == 1) ? 0 : seen > 1 ? 2 : 1;
+
+free_strings:
+	free(config);
+	free(global);
+	return ret;
+}
+
+int cmd_config(int argc, const char **argv, const char *prefix)
+{
+	int nongit = 0;
+	setup_git_directory_gently(&nongit);
+
+	while (1 < argc) {
+		if (!strcmp(argv[1], "--int"))
+			type = T_INT;
+		else if (!strcmp(argv[1], "--bool"))
+			type = T_BOOL;
+		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
+			return git_config(show_all_config);
+		else if (!strcmp(argv[1], "--global")) {
+			char *home = getenv("HOME");
+			if (home) {
+				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+				setenv("GIT_CONFIG", user_config, 1);
+				free(user_config);
+			} else {
+				die("$HOME not set");
+			}
+		} else if (!strcmp(argv[1], "--rename-section")) {
+			int ret;
+			if (argc != 4)
+				usage(git_config_set_usage);
+			ret = git_config_rename_section(argv[2], argv[3]);
+			if (ret < 0)
+				return ret;
+			if (ret == 0) {
+				fprintf(stderr, "No such section!\n");
+				return 1;
+			}
+			return 0;
+		} else
+			break;
+		argc--;
+		argv++;
+	}
+
+	switch (argc) {
+	case 2:
+		return get_value(argv[1], NULL);
+	case 3:
+		if (!strcmp(argv[1], "--unset"))
+			return git_config_set(argv[2], NULL);
+		else if (!strcmp(argv[1], "--unset-all"))
+			return git_config_set_multivar(argv[2], NULL, NULL, 1);
+		else if (!strcmp(argv[1], "--get"))
+			return get_value(argv[2], NULL);
+		else if (!strcmp(argv[1], "--get-all")) {
+			do_all = 1;
+			return get_value(argv[2], NULL);
+		} else if (!strcmp(argv[1], "--get-regexp")) {
+			show_keys = 1;
+			use_key_regexp = 1;
+			do_all = 1;
+			return get_value(argv[2], NULL);
+		} else
+
+			return git_config_set(argv[1], argv[2]);
+	case 4:
+		if (!strcmp(argv[1], "--unset"))
+			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
+		else if (!strcmp(argv[1], "--unset-all"))
+			return git_config_set_multivar(argv[2], NULL, argv[3], 1);
+		else if (!strcmp(argv[1], "--get"))
+			return get_value(argv[2], argv[3]);
+		else if (!strcmp(argv[1], "--get-all")) {
+			do_all = 1;
+			return get_value(argv[2], argv[3]);
+		} else if (!strcmp(argv[1], "--get-regexp")) {
+			show_keys = 1;
+			use_key_regexp = 1;
+			do_all = 1;
+			return get_value(argv[2], argv[3]);
+		} else if (!strcmp(argv[1], "--add"))
+			return git_config_set_multivar(argv[2], argv[3], "^$", 0);
+		else if (!strcmp(argv[1], "--replace-all"))
+
+			return git_config_set_multivar(argv[2], argv[3], NULL, 1);
+		else
+
+			return git_config_set_multivar(argv[1], argv[2], argv[3], 0);
+	case 5:
+		if (!strcmp(argv[1], "--replace-all"))
+			return git_config_set_multivar(argv[2], argv[3], argv[4], 1);
+	case 1:
+	default:
+		usage(git_config_set_usage);
+	}
+	return 0;
+}
diff --git a/builtin-repo-config.c b/builtin-repo-config.c
deleted file mode 100644
index 9063311..0000000
--- a/builtin-repo-config.c
+++ /dev/null
@@ -1,220 +0,0 @@
-#include "builtin.h"
-#include "cache.h"
-
-static const char git_config_set_usage[] =
-"git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
-
-static char *key;
-static regex_t *key_regexp;
-static regex_t *regexp;
-static int show_keys;
-static int use_key_regexp;
-static int do_all;
-static int do_not_match;
-static int seen;
-static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
-
-static int show_all_config(const char *key_, const char *value_)
-{
-	if (value_)
-		printf("%s=%s\n", key_, value_);
-	else
-		printf("%s\n", key_);
-	return 0;
-}
-
-static int show_config(const char* key_, const char* value_)
-{
-	char value[256];
-	const char *vptr = value;
-	int dup_error = 0;
-
-	if (!use_key_regexp && strcmp(key_, key))
-		return 0;
-	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
-		return 0;
-	if (regexp != NULL &&
-			 (do_not_match ^
-			  regexec(regexp, (value_?value_:""), 0, NULL, 0)))
-		return 0;
-
-	if (show_keys)
-		printf("%s ", key_);
-	if (seen && !do_all)
-		dup_error = 1;
-	if (type == T_INT)
-		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
-	else if (type == T_BOOL)
-		vptr = git_config_bool(key_, value_) ? "true" : "false";
-	else
-		vptr = value_?value_:"";
-	seen++;
-	if (dup_error) {
-		error("More than one value for the key %s: %s",
-				key_, vptr);
-	}
-	else
-		printf("%s\n", vptr);
-
-	return 0;
-}
-
-static int get_value(const char* key_, const char* regex_)
-{
-	int ret = -1;
-	char *tl;
-	char *global = NULL, *repo_config = NULL;
-	const char *local;
-
-	local = getenv(CONFIG_ENVIRONMENT);
-	if (!local) {
-		const char *home = getenv("HOME");
-		local = getenv(CONFIG_LOCAL_ENVIRONMENT);
-		if (!local)
-			local = repo_config = xstrdup(git_path("config"));
-		if (home)
-			global = xstrdup(mkpath("%s/.gitconfig", home));
-	}
-
-	key = xstrdup(key_);
-	for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
-		*tl = tolower(*tl);
-	for (tl=key; *tl && *tl != '.'; ++tl)
-		*tl = tolower(*tl);
-
-	if (use_key_regexp) {
-		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
-		if (regcomp(key_regexp, key, REG_EXTENDED)) {
-			fprintf(stderr, "Invalid key pattern: %s\n", key_);
-			goto free_strings;
-		}
-	}
-
-	if (regex_) {
-		if (regex_[0] == '!') {
-			do_not_match = 1;
-			regex_++;
-		}
-
-		regexp = (regex_t*)xmalloc(sizeof(regex_t));
-		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			fprintf(stderr, "Invalid pattern: %s\n", regex_);
-			goto free_strings;
-		}
-	}
-
-	if (do_all && global)
-		git_config_from_file(show_config, global);
-	git_config_from_file(show_config, local);
-	if (!do_all && !seen && global)
-		git_config_from_file(show_config, global);
-
-	free(key);
-	if (regexp) {
-		regfree(regexp);
-		free(regexp);
-	}
-
-	if (do_all)
-		ret = !seen;
-	else
-		ret = (seen == 1) ? 0 : seen > 1 ? 2 : 1;
-
-free_strings:
-	free(repo_config);
-	free(global);
-	return ret;
-}
-
-int cmd_repo_config(int argc, const char **argv, const char *prefix)
-{
-	int nongit = 0;
-	setup_git_directory_gently(&nongit);
-
-	while (1 < argc) {
-		if (!strcmp(argv[1], "--int"))
-			type = T_INT;
-		else if (!strcmp(argv[1], "--bool"))
-			type = T_BOOL;
-		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
-			return git_config(show_all_config);
-		else if (!strcmp(argv[1], "--global")) {
-			char *home = getenv("HOME");
-			if (home) {
-				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-				setenv("GIT_CONFIG", user_config, 1);
-				free(user_config);
-			} else {
-				die("$HOME not set");
-			}
-		} else if (!strcmp(argv[1], "--rename-section")) {
-			int ret;
-			if (argc != 4)
-				usage(git_config_set_usage);
-			ret = git_config_rename_section(argv[2], argv[3]);
-			if (ret < 0)
-				return ret;
-			if (ret == 0) {
-				fprintf(stderr, "No such section!\n");
-				return 1;
-			}
-			return 0;
-		} else
-			break;
-		argc--;
-		argv++;
-	}
-
-	switch (argc) {
-	case 2:
-		return get_value(argv[1], NULL);
-	case 3:
-		if (!strcmp(argv[1], "--unset"))
-			return git_config_set(argv[2], NULL);
-		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, NULL, 1);
-		else if (!strcmp(argv[1], "--get"))
-			return get_value(argv[2], NULL);
-		else if (!strcmp(argv[1], "--get-all")) {
-			do_all = 1;
-			return get_value(argv[2], NULL);
-		} else if (!strcmp(argv[1], "--get-regexp")) {
-			show_keys = 1;
-			use_key_regexp = 1;
-			do_all = 1;
-			return get_value(argv[2], NULL);
-		} else
-
-			return git_config_set(argv[1], argv[2]);
-	case 4:
-		if (!strcmp(argv[1], "--unset"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
-		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 1);
-		else if (!strcmp(argv[1], "--get"))
-			return get_value(argv[2], argv[3]);
-		else if (!strcmp(argv[1], "--get-all")) {
-			do_all = 1;
-			return get_value(argv[2], argv[3]);
-		} else if (!strcmp(argv[1], "--get-regexp")) {
-			show_keys = 1;
-			use_key_regexp = 1;
-			do_all = 1;
-			return get_value(argv[2], argv[3]);
-		} else if (!strcmp(argv[1], "--add"))
-			return git_config_set_multivar(argv[2], argv[3], "^$", 0);
-		else if (!strcmp(argv[1], "--replace-all"))
-
-			return git_config_set_multivar(argv[2], argv[3], NULL, 1);
-		else
-
-			return git_config_set_multivar(argv[1], argv[2], argv[3], 0);
-	case 5:
-		if (!strcmp(argv[1], "--replace-all"))
-			return git_config_set_multivar(argv[2], argv[3], argv[4], 1);
-	case 1:
-	default:
-		usage(git_config_set_usage);
-	}
-	return 0;
-}
diff --git a/builtin.h b/builtin.h
index 0b3c9f6..cfe5990 100644
--- a/builtin.h
+++ b/builtin.h
@@ -53,7 +53,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
-extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
+extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7c7520e..83c69ec 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -145,7 +145,7 @@ __git_remotes ()
 		echo ${i#$d/remotes/}
 	done
 	[ "$ngoff" ] && shopt -u nullglob
-	for i in $(git --git-dir="$d" repo-config --list); do
+	for i in $(git --git-dir="$d" config --list); do
 		case "$i" in
 		remote.*.url=*)
 			i="${i#remote.}"
@@ -286,7 +286,7 @@ __git_commandlist="$(__git_commands 2>/dev/null)"
 __git_aliases ()
 {
 	local i IFS=$'\n'
-	for i in $(git --git-dir="$(__gitdir)" repo-config --list); do
+	for i in $(git --git-dir="$(__gitdir)" config --list); do
 		case "$i" in
 		alias.*)
 			i="${i#alias.}"
@@ -299,7 +299,7 @@ __git_aliases ()
 __git_aliased_command ()
 {
 	local word cmdline=$(git --git-dir="$(__gitdir)" \
-		repo-config --get "alias.$1")
+		config --get "alias.$1")
 	for word in $cmdline; do
 		if [ "${word##-*}" ]; then
 			echo $word
@@ -629,7 +629,7 @@ _git_rebase ()
 	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
-_git_repo_config ()
+_git_config ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	local prv="${COMP_WORDS[COMP_CWORD-1]}"
@@ -806,6 +806,7 @@ _git ()
 	checkout)    _git_checkout ;;
 	cherry-pick) _git_cherry_pick ;;
 	commit)      _git_commit ;;
+	config)      _git_config ;;
 	diff)        _git_diff ;;
 	diff-tree)   _git_diff_tree ;;
 	fetch)       _git_fetch ;;
@@ -819,7 +820,7 @@ _git ()
 	pull)        _git_pull ;;
 	push)        _git_push ;;
 	rebase)      _git_rebase ;;
-	repo-config) _git_repo_config ;;
+	repo-config) _git_config ;;
 	reset)       _git_reset ;;
 	show)        _git_show ;;
 	show-branch) _git_log ;;
@@ -856,7 +857,7 @@ complete -o default            -F _git_name_rev git-name-rev
 complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
 complete -o default            -F _git_rebase git-rebase
-complete -o default            -F _git_repo_config git-repo-config
+complete -o default            -F _git_config git-config
 complete -o default            -F _git_reset git-reset
 complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_log git-show-branch
@@ -879,7 +880,7 @@ complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
 complete -o default            -F _git_merge_base git-merge-base.exe
 complete -o default            -F _git_name_rev git-name-rev.exe
 complete -o default -o nospace -F _git_push git-push.exe
-complete -o default            -F _git_repo_config git-repo-config
+complete -o default            -F _git_config git-config
 complete -o default -o nospace -F _git_show git-show.exe
 complete -o default -o nospace -F _git_log git-show-branch.exe
 complete -o default -o nospace -F _git_log git-whatchanged.exe
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index d90ba81..24629eb 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -222,7 +222,7 @@ and returns the process output as a string."
   "Return the name to use as GIT_COMMITTER_NAME."
   ; copied from log-edit
   (or git-committer-name
-      (git-repo-config "user.name")
+      (git-config "user.name")
       (and (boundp 'add-log-full-name) add-log-full-name)
       (and (fboundp 'user-full-name) (user-full-name))
       (and (boundp 'user-full-name) user-full-name)))
@@ -231,7 +231,7 @@ and returns the process output as a string."
   "Return the email address to use as GIT_COMMITTER_EMAIL."
   ; copied from log-edit
   (or git-committer-email
-      (git-repo-config "user.email")
+      (git-config "user.email")
       (and (boundp 'add-log-mailing-address) add-log-mailing-address)
       (and (fboundp 'user-mail-address) (user-mail-address))
       (and (boundp 'user-mail-address) user-mail-address)))
@@ -298,9 +298,9 @@ and returns the process output as a string."
   (git-get-string-sha1
    (git-call-process-env-string nil "rev-parse" rev)))
 
-(defun git-repo-config (key)
+(defun git-config (key)
   "Retrieve the value associated to KEY in the git repository config file."
-  (let ((str (git-call-process-env-string nil "repo-config" key)))
+  (let ((str (git-call-process-env-string nil "config" key)))
     (and str (car (split-string str "\n")))))
 
 (defun git-symbolic-ref (ref)
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 3b6bdce..521b2fc 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -497,7 +497,7 @@ class GitView:
 		fp.close()
 
 	def get_encoding(self):
-		fp = os.popen("git repo-config --get i18n.commitencoding")
+		fp = os.popen("git config --get i18n.commitencoding")
 		self.encoding=string.strip(fp.readline())
 		fp.close()
 		if (self.encoding == ""):
diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
index b996996..dc09eae 100644
--- a/contrib/remotes2config.sh
+++ b/contrib/remotes2config.sh
@@ -26,8 +26,8 @@ if [ -d "$GIT_DIR"/remotes ]; then
 				mv "$GIT_DIR"/remotes "$GIT_DIR"/remotes.old
 			fi ;;
 		*)
-			echo "git-repo-config $key "$value" $regex"
-			git-repo-config $key "$value" $regex || error=1 ;;
+			echo "git-config $key "$value" $regex"
+			git-config $key "$value" $regex || error=1 ;;
 		esac
 	done
 fi
diff --git a/git-clone.sh b/git-clone.sh
index ced7dfb..1531da5 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -36,7 +36,7 @@ clone_dumb_http () {
 	clone_tmp="$GIT_DIR/clone-tmp" &&
 	mkdir -p "$clone_tmp" || exit 1
 	if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
-		"`git-repo-config --bool http.noEPSV`" = true ]; then
+		"`git-config --bool http.noEPSV`" = true ]; then
 		curl_extra_args="${curl_extra_args} --disable-epsv"
 	fi
 	http_fetch "$1/info/refs" "$clone_tmp/refs" ||
@@ -386,17 +386,17 @@ then
 		git-update-ref HEAD "$head_sha1" &&
 
 		# Upstream URL
-		git-repo-config remote."$origin".url "$repo" &&
+		git-config remote."$origin".url "$repo" &&
 
 		# Set up the mappings to track the remote branches.
-		git-repo-config remote."$origin".fetch \
+		git-config remote."$origin".fetch \
 			"+refs/heads/*:$remote_top/*" '^$' &&
 		rm -f "refs/remotes/$origin/HEAD"
 		git-symbolic-ref "refs/remotes/$origin/HEAD" \
 			"refs/remotes/$origin/$head_points_at" &&
 
-		git-repo-config branch."$head_points_at".remote "$origin" &&
-		git-repo-config branch."$head_points_at".merge "refs/heads/$head_points_at"
+		git-config branch."$head_points_at".remote "$origin" &&
+		git-config branch."$head_points_at".merge "refs/heads/$head_points_at"
 	esac
 
 	case "$no_checkout" in
diff --git a/git-commit.sh b/git-commit.sh
index d8c236b..85c278a 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -429,7 +429,7 @@ then
 	fi
 elif test "$use_commit" != ""
 then
-	encoding=$(git repo-config i18n.commitencoding || echo UTF-8)
+	encoding=$(git config i18n.commitencoding || echo UTF-8)
 	git show -s --pretty=raw --encoding="$encoding" "$use_commit" |
 	sed -e '1,/^$/d' -e 's/^    //'
 elif test -f "$GIT_DIR/MERGE_MSG"
@@ -485,7 +485,7 @@ then
 		q
 	}
 	'
-	encoding=$(git repo-config i18n.commitencoding || echo UTF-8)
+	encoding=$(git config i18n.commitencoding || echo UTF-8)
 	set_author_env=`git show -s --pretty=raw --encoding="$encoding" "$use_commit" |
 	LANG=C LC_ALL=C sed -ne "$pick_author_script"`
 	eval "$set_author_env"
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index e18e901..9371788 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -172,11 +172,11 @@ sub req_Root
        return 0;
     }
 
-    my @gitvars = `git-repo-config -l`;
+    my @gitvars = `git-config -l`;
     if ($?) {
-       print "E problems executing git-repo-config on the server -- this is not a git repository or the PATH is not set correctly.\n";
+       print "E problems executing git-config on the server -- this is not a git repository or the PATH is not set correctly.\n";
         print "E \n";
-        print "error 1 - problem executing git-repo-config\n";
+        print "error 1 - problem executing git-config\n";
        return 0;
     }
     foreach my $line ( @gitvars )
diff --git a/git-fetch.sh b/git-fetch.sh
index 61c8cf4..c1f6e1e 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -321,7 +321,7 @@ fetch_main () {
 	      curl_extra_args="-k"
 	  fi
 	  if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
-		"`git-repo-config --bool http.noEPSV`" = true ]; then
+		"`git-config --bool http.noEPSV`" = true ]; then
 	      noepsv_opt="--disable-epsv"
 	  fi
 
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 80adc83..cbc7418 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -15,11 +15,11 @@ case "$GIT_DIR" in
 	fqgitdir="$PWD/$GIT_DIR" ;;
 esac
 
-local="`git repo-config --bool --get instaweb.local`"
-httpd="`git repo-config --get instaweb.httpd`"
-browser="`git repo-config --get instaweb.browser`"
-port=`git repo-config --get instaweb.port`
-module_path="`git repo-config --get instaweb.modulepath`"
+local="`git config --bool --get instaweb.local`"
+httpd="`git config --get instaweb.httpd`"
+browser="`git config --get instaweb.browser`"
+port=`git config --get instaweb.port`
+module_path="`git config --get instaweb.modulepath`"
 
 conf=$GIT_DIR/gitweb/httpd.conf
 
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index dd22783..e6f574b 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -58,7 +58,7 @@ http://* | https://* | ftp://* )
             curl_extra_args="-k"
         fi
 	if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
-		"`git-repo-config --bool http.noEPSV`" = true ]; then
+		"`git-config --bool http.noEPSV`" = true ]; then
 		curl_extra_args="${curl_extra_args} --disable-epsv"
 	fi
 	curl -nsf $curl_extra_args --header "Pragma: no-cache" "$peek_repo/info/refs" ||
diff --git a/git-merge.sh b/git-merge.sh
index 7b59026..e5d6229 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -233,7 +233,7 @@ case "$use_strategies" in
 '')
 	case "$#" in
 	1)
-		var="`git-repo-config --get pull.twohead`"
+		var="`git-config --get pull.twohead`"
 		if test -n "$var"
 		then
 			use_strategies="$var"
@@ -241,7 +241,7 @@ case "$use_strategies" in
 			use_strategies="$default_twohead_strategies"
 		fi ;;
 	*)
-		var="`git-repo-config --get pull.octopus`"
+		var="`git-config --get pull.octopus`"
 		if test -n "$var"
 		then
 			use_strategies="$var"
diff --git a/git-p4import.py b/git-p4import.py
index 5c56cac..60a758b 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -193,13 +193,13 @@ class git_command:
 
     def get_config(self, variable):
         try:
-            return self.git("repo-config --get %s" % variable)[0].rstrip()
+            return self.git("config --get %s" % variable)[0].rstrip()
         except:
             return None
 
     def set_config(self, variable, value):
         try:
-            self.git("repo-config %s %s"%(variable, value) )
+            self.git("config %s %s"%(variable, value) )
         except:
             die("Could not set %s to " % variable, value)
 
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 1122c83..87864fb 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -10,7 +10,7 @@ get_data_source () {
 		echo ''
 		;;
 	*)
-		if test "$(git-repo-config --get "remote.$1.url")"
+		if test "$(git-config --get "remote.$1.url")"
 		then
 			echo config
 		elif test -f "$GIT_DIR/remotes/$1"
@@ -32,7 +32,7 @@ get_remote_url () {
 		echo "$1"
 		;;
 	config)
-		git-repo-config --get "remote.$1.url"
+		git-config --get "remote.$1.url"
 		;;
 	remotes)
 		sed -ne '/^URL: */{
@@ -50,7 +50,7 @@ get_remote_url () {
 
 get_default_remote () {
 	curr_branch=$(git-symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
-	origin=$(git-repo-config --get "branch.$curr_branch.remote")
+	origin=$(git-config --get "branch.$curr_branch.remote")
 	echo ${origin:-origin}
 }
 
@@ -60,7 +60,7 @@ get_remote_default_refs_for_push () {
 	'' | branches)
 		;; # no default push mapping, just send matching refs.
 	config)
-		git-repo-config --get-all "remote.$1.push" ;;
+		git-config --get-all "remote.$1.push" ;;
 	remotes)
 		sed -ne '/^Push: */{
 			s///p
@@ -139,7 +139,7 @@ canon_refs_list_for_fetch () {
 		then
 			curr_branch=$(git-symbolic-ref -q HEAD | \
 			    sed -e 's|^refs/heads/||')
-			merge_branches=$(git-repo-config \
+			merge_branches=$(git-config \
 			    --get-all "branch.${curr_branch}.merge")
 		fi
 		if test -z "$merge_branches" && test $is_explicit != explicit
@@ -205,7 +205,7 @@ get_remote_default_refs_for_fetch () {
 		echo "HEAD:" ;;
 	config)
 		canon_refs_list_for_fetch -d "$1" \
-			$(git-repo-config --get-all "remote.$1.fetch") ;;
+			$(git-config --get-all "remote.$1.fetch") ;;
 	branches)
 		remote_branch=$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
 		case "$remote_branch" in '') remote_branch=master ;; esac
@@ -284,7 +284,7 @@ get_uploadpack () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
 	config)
-		uplp=$(git-repo-config --get "remote.$1.uploadpack")
+		uplp=$(git-config --get "remote.$1.uploadpack")
 		echo ${uplp:-git-upload-pack}
 		;;
 	*)
diff --git a/git-remote.perl b/git-remote.perl
index fc055b6..c813fe1 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -64,7 +64,7 @@ sub list_remote {
 	my ($git) = @_;
 	my %seen = ();
 	my @remotes = eval {
-		$git->command(qw(repo-config --get-regexp), '^remote\.');
+		$git->command(qw(config --get-regexp), '^remote\.');
 	};
 	for (@remotes) {
 		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
@@ -103,7 +103,7 @@ sub list_branch {
 	my ($git) = @_;
 	my %seen = ();
 	my @branches = eval {
-		$git->command(qw(repo-config --get-regexp), '^branch\.');
+		$git->command(qw(config --get-regexp), '^branch\.');
 	};
 	for (@branches) {
 		if (/^branch\.([^.]*)\.(\S*)\s+(.*)$/) {
@@ -238,8 +238,8 @@ sub add_remote {
 		print STDERR "remote $name already exists.\n";
 		exit(1);
 	}
-	$git->command('repo-config', "remote.$name.url", $url);
-	$git->command('repo-config', "remote.$name.fetch",
+	$git->command('config', "remote.$name.url", $url);
+	$git->command('config', "remote.$name.fetch",
 		      "+refs/heads/*:refs/remotes/$name/*");
 }
 
diff --git a/git-repack.sh b/git-repack.sh
index da8e67f..ddfa8b4 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -28,7 +28,7 @@ done
 # Later we will default repack.UseDeltaBaseOffset to true
 default_dbo=false
 
-case "`git repo-config --bool repack.usedeltabaseoffset ||
+case "`git config --bool repack.usedeltabaseoffset ||
        echo $default_dbo`" in
 true)
 	extra="$extra --delta-base-offset" ;;
diff --git a/git-revert.sh b/git-revert.sh
index bb8f1ca..866d622 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -81,7 +81,7 @@ prev=$(git-rev-parse --verify "$commit^1" 2>/dev/null) ||
 git-rev-parse --verify "$commit^2" >/dev/null 2>&1 &&
 	die "Cannot run $me a multi-parent commit."
 
-encoding=$(git repo-config i18n.commitencoding || echo UTF-8)
+encoding=$(git config i18n.commitencoding || echo UTF-8)
 
 # "commit" is an existing commit.  We would want to apply
 # the difference it introduces since its first parent "prev"
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6b1c142..b4aa4b2 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -29,7 +29,7 @@ set_reflog_action() {
 }
 
 is_bare_repository () {
-	git-repo-config --bool --get core.bare ||
+	git-config --bool --get core.bare ||
 	case "$GIT_DIR" in
 	.git | */.git) echo false ;;
 	*) echo true ;;
diff --git a/git-svn.perl b/git-svn.perl
index 83ec03d..68156fc 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -593,7 +593,7 @@ sub multi_init {
 				      "$trunk_url ($_trunk)\n";
 			}
 			init($trunk_url);
-			command_noisy('repo-config', 'svn.trunk', $trunk_url);
+			command_noisy('config', 'svn.trunk', $trunk_url);
 		}
 	}
 	$_prefix = '' unless defined $_prefix;
@@ -772,22 +772,22 @@ sub log_use_color {
 	return 1 if $_color;
 	my ($dc, $dcvar);
 	$dcvar = 'color.diff';
-	$dc = `git-repo-config --get $dcvar`;
+	$dc = `git-config --get $dcvar`;
 	if ($dc eq '') {
 		# nothing at all; fallback to "diff.color"
 		$dcvar = 'diff.color';
-		$dc = `git-repo-config --get $dcvar`;
+		$dc = `git-config --get $dcvar`;
 	}
 	chomp($dc);
 	if ($dc eq 'auto') {
 		my $pc;
-		$pc = `git-repo-config --get color.pager`;
+		$pc = `git-config --get color.pager`;
 		if ($pc eq '') {
 			# does not have it -- fallback to pager.color
-			$pc = `git-repo-config --bool --get pager.color`;
+			$pc = `git-config --bool --get pager.color`;
 		}
 		else {
-			$pc = `git-repo-config --bool --get color.pager`;
+			$pc = `git-config --bool --get color.pager`;
 			if ($?) {
 				$pc = 'false';
 			}
@@ -800,7 +800,7 @@ sub log_use_color {
 	}
 	return 0 if $dc eq 'never';
 	return 1 if $dc eq 'always';
-	chomp($dc = `git-repo-config --bool --get $dcvar`);
+	chomp($dc = `git-config --bool --get $dcvar`);
 	return ($dc eq 'true');
 }
 
@@ -919,7 +919,7 @@ sub complete_url_ls_init {
 	waitpid $pid, 0;
 	croak $? if $?;
 	my ($n) = ($switch =~ /^--(\w+)/);
-	command_noisy('repo-config', "svn.$n", $full_url);
+	command_noisy('config', "svn.$n", $full_url);
 }
 
 sub common_prefix {
@@ -1594,7 +1594,7 @@ sub init_vars {
 	%tree_map = ();
 }
 
-# convert GetOpt::Long specs for use by git-repo-config
+# convert GetOpt::Long specs for use by git-config
 sub read_repo_config {
 	return unless -d $GIT_DIR;
 	my $opts = shift;
@@ -1602,7 +1602,7 @@ sub read_repo_config {
 		my $v = $opts->{$o};
 		my ($key) = ($o =~ /^([a-z\-]+)/);
 		$key =~ s/-//g;
-		my $arg = 'git-repo-config';
+		my $arg = 'git-config';
 		$arg .= ' --int' if ($o =~ /[:=]i$/);
 		$arg .= ' --bool' if ($o !~ /[:=][sfi]$/);
 		if (ref $v eq 'ARRAY') {
diff --git a/git.c b/git.c
index 530e99f..ec91acd 100644
--- a/git.c
+++ b/git.c
@@ -224,6 +224,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
+		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff, RUN_SETUP | USE_PAGER },
@@ -254,7 +255,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
 		{ "reflog", cmd_reflog, RUN_SETUP },
-		{ "repo-config", cmd_repo_config },
+		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
diff --git a/gitk b/gitk
index 031c829..31d0aad 100755
--- a/gitk
+++ b/gitk
@@ -6193,7 +6193,7 @@ set wrcomcmd "git diff-tree --stdin -p --pretty"
 
 set gitencoding {}
 catch {
-    set gitencoding [exec git repo-config --get i18n.commitencoding]
+    set gitencoding [exec git config --get i18n.commitencoding]
 }
 if {$gitencoding == ""} {
     set gitencoding "utf-8"
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 88af2e6..b606c1d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -986,7 +986,7 @@ sub git_get_project_config {
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-	my @x = (git_cmd(), 'repo-config');
+	my @x = (git_cmd(), 'config');
 	if (defined $type) { push @x, $type; }
 	push @x, "--get";
 	push @x, "gitweb.$key";
diff --git a/ident.c b/ident.c
index 6ad8fed..92d34e0 100644
--- a/ident.c
+++ b/ident.c
@@ -160,8 +160,8 @@ static const char *env_hint =
 "\n"
 "Run\n"
 "\n"
-"  git repo-config user.email \"you@email.com\"\n"
-"  git repo-config user.name \"Your Name\"\n"
+"  git config user.email \"you@email.com\"\n"
+"  git config user.name \"Your Name\"\n"
 "\n"
 "To set the identity in this repository.\n"
 "Add --global to set your account\'s default\n"
diff --git a/perl/Git.pm b/perl/Git.pm
index c1729ba..5d1ccaa 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -482,14 +482,14 @@ sub wc_chdir {
 
 =item config ( VARIABLE )
 
-Retrieve the configuration C<VARIABLE> in the same manner as C<repo-config>
+Retrieve the configuration C<VARIABLE> in the same manner as C<config>
 does. In scalar context requires the variable to be set only one time
 (exception is thrown otherwise), in array context returns allows the
 variable to be set multiple times and returns all the values.
 
 Must be called on a repository instance.
 
-This currently wraps command('repo-config') so it is not so fast.
+This currently wraps command('config') so it is not so fast.
 
 =cut
 
@@ -500,9 +500,9 @@ sub config {
 
 	try {
 		if (wantarray) {
-			return $self->command('repo-config', '--get-all', $var);
+			return $self->command('config', '--get-all', $var);
 		} else {
-			return $self->command_oneline('repo-config', '--get', $var);
+			return $self->command_oneline('config', '--get', $var);
 		}
 	} catch Git::Error::Command with {
 		my $E = shift;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0e4f32d..49b5666 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -3,13 +3,13 @@
 # Copyright (c) 2005 Johannes Schindelin
 #
 
-test_description='Test git-repo-config in different settings'
+test_description='Test git-config in different settings'
 
 . ./test-lib.sh
 
 test -f .git/config && rm .git/config
 
-git-repo-config core.penguin "little blue"
+git-config core.penguin "little blue"
 
 cat > expect << EOF
 [core]
@@ -18,7 +18,7 @@ EOF
 
 test_expect_success 'initial' 'cmp .git/config expect'
 
-git-repo-config Core.Movie BadPhysics
+git-config Core.Movie BadPhysics
 
 cat > expect << EOF
 [core]
@@ -28,7 +28,7 @@ EOF
 
 test_expect_success 'mixed case' 'cmp .git/config expect'
 
-git-repo-config Cores.WhatEver Second
+git-config Cores.WhatEver Second
 
 cat > expect << EOF
 [core]
@@ -40,7 +40,7 @@ EOF
 
 test_expect_success 'similar section' 'cmp .git/config expect'
 
-git-repo-config CORE.UPPERCASE true
+git-config CORE.UPPERCASE true
 
 cat > expect << EOF
 [core]
@@ -54,10 +54,10 @@ EOF
 test_expect_success 'similar section' 'cmp .git/config expect'
 
 test_expect_success 'replace with non-match' \
-	'git-repo-config core.penguin kingpin !blue'
+	'git-config core.penguin kingpin !blue'
 
 test_expect_success 'replace with non-match (actually matching)' \
-	'git-repo-config core.penguin "very blue" !kingpin'
+	'git-config core.penguin "very blue" !kingpin'
 
 cat > expect << EOF
 [core]
@@ -86,7 +86,7 @@ EOF
 cp .git/config .git/config2
 
 test_expect_success 'multiple unset' \
-	'git-repo-config --unset-all beta.haha'
+	'git-config --unset-all beta.haha'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -102,7 +102,7 @@ test_expect_success 'multiple unset is correct' 'cmp .git/config expect'
 mv .git/config2 .git/config
 
 test_expect_success '--replace-all' \
-	'git-repo-config --replace-all beta.haha gamma'
+	'git-config --replace-all beta.haha gamma'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -116,7 +116,7 @@ EOF
 
 test_expect_success 'all replaced' 'cmp .git/config expect'
 
-git-repo-config beta.haha alpha
+git-config beta.haha alpha
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -130,7 +130,7 @@ EOF
 
 test_expect_success 'really mean test' 'cmp .git/config expect'
 
-git-repo-config nextsection.nonewline wow
+git-config nextsection.nonewline wow
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -145,8 +145,8 @@ EOF
 
 test_expect_success 'really really mean test' 'cmp .git/config expect'
 
-test_expect_success 'get value' 'test alpha = $(git-repo-config beta.haha)'
-git-repo-config --unset beta.haha
+test_expect_success 'get value' 'test alpha = $(git-config beta.haha)'
+git-config --unset beta.haha
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -160,7 +160,7 @@ EOF
 
 test_expect_success 'unset' 'cmp .git/config expect'
 
-git-repo-config nextsection.NoNewLine "wow2 for me" "for me$"
+git-config nextsection.NoNewLine "wow2 for me" "for me$"
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -176,18 +176,18 @@ EOF
 test_expect_success 'multivar' 'cmp .git/config expect'
 
 test_expect_success 'non-match' \
-	'git-repo-config --get nextsection.nonewline !for'
+	'git-config --get nextsection.nonewline !for'
 
 test_expect_success 'non-match value' \
-	'test wow = $(git-repo-config --get nextsection.nonewline !for)'
+	'test wow = $(git-config --get nextsection.nonewline !for)'
 
 test_expect_failure 'ambiguous get' \
-	'git-repo-config --get nextsection.nonewline'
+	'git-config --get nextsection.nonewline'
 
 test_expect_success 'get multivar' \
-	'git-repo-config --get-all nextsection.nonewline'
+	'git-config --get-all nextsection.nonewline'
 
-git-repo-config nextsection.nonewline "wow3" "wow$"
+git-config nextsection.nonewline "wow3" "wow$"
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -202,15 +202,15 @@ EOF
 
 test_expect_success 'multivar replace' 'cmp .git/config expect'
 
-test_expect_failure 'ambiguous value' 'git-repo-config nextsection.nonewline'
+test_expect_failure 'ambiguous value' 'git-config nextsection.nonewline'
 
 test_expect_failure 'ambiguous unset' \
-	'git-repo-config --unset nextsection.nonewline'
+	'git-config --unset nextsection.nonewline'
 
 test_expect_failure 'invalid unset' \
-	'git-repo-config --unset somesection.nonewline'
+	'git-config --unset somesection.nonewline'
 
-git-repo-config --unset nextsection.nonewline "wow3$"
+git-config --unset nextsection.nonewline "wow3$"
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -224,12 +224,12 @@ EOF
 
 test_expect_success 'multivar unset' 'cmp .git/config expect'
 
-test_expect_failure 'invalid key' 'git-repo-config inval.2key blabla'
+test_expect_failure 'invalid key' 'git-config inval.2key blabla'
 
-test_expect_success 'correct key' 'git-repo-config 123456.a123 987'
+test_expect_success 'correct key' 'git-config 123456.a123 987'
 
 test_expect_success 'hierarchical section' \
-	'git-repo-config Version.1.2.3eX.Alpha beta'
+	'git-config Version.1.2.3eX.Alpha beta'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -255,7 +255,7 @@ version.1.2.3eX.alpha=beta
 EOF
 
 test_expect_success 'working --list' \
-	'git-repo-config --list > output && cmp output expect'
+	'git-config --list > output && cmp output expect'
 
 cat > expect << EOF
 beta.noindent sillyValue
@@ -263,9 +263,9 @@ nextsection.nonewline wow2 for me
 EOF
 
 test_expect_success '--get-regexp' \
-	'git-repo-config --get-regexp in > output && cmp output expect'
+	'git-config --get-regexp in > output && cmp output expect'
 
-git-repo-config --add nextsection.nonewline "wow4 for you"
+git-config --add nextsection.nonewline "wow4 for you"
 
 cat > expect << EOF
 wow2 for me
@@ -273,7 +273,7 @@ wow4 for you
 EOF
 
 test_expect_success '--add' \
-	'git-repo-config --get-all nextsection.nonewline > output && cmp output expect'
+	'git-config --get-all nextsection.nonewline > output && cmp output expect'
 
 cat > .git/config << EOF
 [novalue]
@@ -281,9 +281,9 @@ cat > .git/config << EOF
 EOF
 
 test_expect_success 'get variable with no value' \
-	'git-repo-config --get novalue.variable ^$'
+	'git-config --get novalue.variable ^$'
 
-git-repo-config > output 2>&1
+git-config > output 2>&1
 
 test_expect_success 'no arguments, but no crash' \
 	"test $? = 129 && grep usage output"
@@ -293,7 +293,7 @@ cat > .git/config << EOF
 	c = d
 EOF
 
-git-repo-config a.x y
+git-config a.x y
 
 cat > expect << EOF
 [a.b]
@@ -304,8 +304,8 @@ EOF
 
 test_expect_success 'new section is partial match of another' 'cmp .git/config expect'
 
-git-repo-config b.x y
-git-repo-config a.b c
+git-config b.x y
+git-config a.b c
 
 cat > expect << EOF
 [a.b]
@@ -328,11 +328,11 @@ cat > expect << EOF
 ein.bahn=strasse
 EOF
 
-GIT_CONFIG=other-config git-repo-config -l > output
+GIT_CONFIG=other-config git-config -l > output
 
 test_expect_success 'alternative GIT_CONFIG' 'cmp output expect'
 
-GIT_CONFIG=other-config git-repo-config anwohner.park ausweis
+GIT_CONFIG=other-config git-config anwohner.park ausweis
 
 cat > expect << EOF
 [ein]
@@ -355,7 +355,7 @@ weird
 EOF
 
 test_expect_success "rename section" \
-	"git-repo-config --rename-section branch.eins branch.zwei"
+	"git-config --rename-section branch.eins branch.zwei"
 
 cat > expect << EOF
 # Hallo
@@ -371,12 +371,12 @@ EOF
 test_expect_success "rename succeeded" "diff -u expect .git/config"
 
 test_expect_failure "rename non-existing section" \
-	'git-repo-config --rename-section branch."world domination" branch.drei'
+	'git-config --rename-section branch."world domination" branch.drei'
 
 test_expect_success "rename succeeded" "diff -u expect .git/config"
 
 test_expect_success "rename another section" \
-	'git-repo-config --rename-section branch."1 234 blabl/a" branch.drei'
+	'git-config --rename-section branch."1 234 blabl/a" branch.drei'
 
 cat > expect << EOF
 # Hallo
@@ -393,20 +393,20 @@ test_expect_success "rename succeeded" "diff -u expect .git/config"
 
 test_expect_success numbers '
 
-	git-repo-config kilo.gram 1k &&
-	git-repo-config mega.ton 1m &&
-	k=$(git-repo-config --int --get kilo.gram) &&
+	git-config kilo.gram 1k &&
+	git-config mega.ton 1m &&
+	k=$(git-config --int --get kilo.gram) &&
 	test z1024 = "z$k" &&
-	m=$(git-repo-config --int --get mega.ton) &&
+	m=$(git-config --int --get mega.ton) &&
 	test z1048576 = "z$m"
 '
 
 rm .git/config
 
-git-repo-config quote.leading " test"
-git-repo-config quote.ending "test "
-git-repo-config quote.semicolon "test;test"
-git-repo-config quote.hash "test#test"
+git-config quote.leading " test"
+git-config quote.ending "test "
+git-config quote.semicolon "test;test"
+git-config quote.hash "test#test"
 
 cat > expect << EOF
 [quote]
@@ -418,10 +418,10 @@ EOF
 
 test_expect_success 'quoting' 'cmp .git/config expect'
 
-test_expect_failure 'key with newline' 'git repo-config key.with\\\
+test_expect_failure 'key with newline' 'git config key.with\\\
 newline 123'
 
-test_expect_success 'value with newline' 'git repo-config key.sub value.with\\\
+test_expect_success 'value with newline' 'git config key.sub value.with\\\
 newline'
 
 cat > .git/config <<\EOF
@@ -440,7 +440,7 @@ section.noncont=not continued
 section.quotecont=cont;inued
 EOF
 
-git repo-config --list > result
+git config --list > result
 
 test_expect_success 'value continued on next line' 'cmp result expect'
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e48e2b7..d0aba2c 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -93,8 +93,8 @@ rm -rf .git/$m .git/logs expect
 
 test_expect_success \
 	'enable core.logAllRefUpdates' \
-	'git-repo-config core.logAllRefUpdates true &&
-	 test true = $(git-repo-config --bool --get core.logAllRefUpdates)'
+	'git-config core.logAllRefUpdates true &&
+	 test true = $(git-config --bool --get core.logAllRefUpdates)'
 
 test_expect_success \
 	"create $m (logged by config)" \
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 8e8d526..47d1247 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -71,7 +71,7 @@ test_expect_success setup '
 	check_fsck &&
 
 	chmod +x C &&
-	( test "`git repo-config --bool core.filemode`" != false ||
+	( test "`git config --bool core.filemode`" != false ||
 	  echo executable >>C ) &&
 	git add C &&
 	test_tick && git commit -m dragon &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index bb80e42..5565c27 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -94,7 +94,7 @@ test_expect_failure \
          git-branch r &&
          git-branch -m q r/q'
 
-git-repo-config branch.s/s.dummy Hello
+git-config branch.s/s.dummy Hello
 
 test_expect_success \
     'git branch -m s/s s should work when s/t is deleted' \
@@ -107,8 +107,8 @@ test_expect_success \
         test -f .git/logs/refs/heads/s'
 
 test_expect_success 'config information was renamed, too' \
-	"test $(git-repo-config branch.s.dummy) = Hello &&
-	 ! git-repo-config branch.s/s/dummy"
+	"test $(git-config branch.s.dummy) = Hello &&
+	 ! git-config branch.s/s/dummy"
 
 test_expect_failure \
     'git-branch -m u v should fail when the reflog for u is a symlink' \
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index e98786d..caaab26 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -21,7 +21,7 @@ test_expect_success \
 
 test_expect_success \
 	'git-add: Test that executable bit is not used if core.filemode=0' \
-	'git repo-config core.filemode 0 &&
+	'git config core.filemode 0 &&
 	 echo foo >xfoo1 &&
 	 chmod 755 xfoo1 &&
 	 git-add xfoo1 &&
@@ -32,7 +32,7 @@ test_expect_success \
 
 test_expect_success \
 	'git-update-index --add: Test that executable bit is not used...' \
-	'git repo-config core.filemode 0 &&
+	'git config core.filemode 0 &&
 	 echo foo >xfoo2 &&
 	 chmod 755 xfoo2 &&
 	 git-update-index --add xfoo2 &&
@@ -43,7 +43,7 @@ test_expect_success \
 
 test_expect_success \
 	'git-update-index --add: Test that executable bit is not used...' \
-	'git repo-config core.filemode 0 &&
+	'git config core.filemode 0 &&
 	 ln -s xfoo2 xfoo3 &&
 	 git-update-index --add xfoo3 &&
 	 case "`git-ls-files --stage xfoo3`" in
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 6714b0d..e54fe0f 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -29,7 +29,7 @@ test_expect_success 'no encoding header for base case' '
 for H in ISO-8859-1 EUCJP ISO-2022-JP
 do
 	test_expect_success "$H setup" '
-		git-repo-config i18n.commitencoding $H &&
+		git-config i18n.commitencoding $H &&
 		git-checkout -b $H C0 &&
 		echo $H >F &&
 		git-commit -a -F ../t3900/$H.txt
@@ -44,16 +44,16 @@ do
 	'
 done
 
-test_expect_success 'repo-config to remove customization' '
-	git-repo-config --unset-all i18n.commitencoding &&
-	if Z=$(git-repo-config --get-all i18n.commitencoding)
+test_expect_success 'config to remove customization' '
+	git-config --unset-all i18n.commitencoding &&
+	if Z=$(git-config --get-all i18n.commitencoding)
 	then
 		echo Oops, should have failed.
 		false
 	else
 		test z = "z$Z"
 	fi &&
-	git-repo-config i18n.commitencoding utf-8
+	git-config i18n.commitencoding utf-8
 '
 
 test_expect_success 'ISO-8859-1 should be shown in UTF-8 now' '
@@ -67,9 +67,9 @@ do
 	'
 done
 
-test_expect_success 'repo-config to add customization' '
-	git-repo-config --unset-all i18n.commitencoding &&
-	if Z=$(git-repo-config --get-all i18n.commitencoding)
+test_expect_success 'config to add customization' '
+	git-config --unset-all i18n.commitencoding &&
+	if Z=$(git-config --get-all i18n.commitencoding)
 	then
 		echo Oops, should have failed.
 		false
@@ -81,13 +81,13 @@ test_expect_success 'repo-config to add customization' '
 for H in ISO-8859-1 EUCJP ISO-2022-JP
 do
 	test_expect_success "$H should be shown in itself now" '
-		git-repo-config i18n.commitencoding '$H' &&
+		git-config i18n.commitencoding '$H' &&
 		compare_with '$H' ../t3900/'$H'.txt
 	'
 done
 
-test_expect_success 'repo-config to tweak customization' '
-	git-repo-config i18n.logoutputencoding utf-8
+test_expect_success 'config to tweak customization' '
+	git-config i18n.logoutputencoding utf-8
 '
 
 test_expect_success 'ISO-8859-1 should be shown in UTF-8 now' '
@@ -103,7 +103,7 @@ done
 
 for J in EUCJP ISO-2022-JP
 do
-	git-repo-config i18n.logoutputencoding $J
+	git-config i18n.logoutputencoding $J
 	for H in EUCJP ISO-2022-JP
 	do
 		test_expect_success "$H should be shown in $J now" '
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index eda0e2d..a881797 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -31,7 +31,7 @@ check_encoding () {
 }
 
 test_expect_success setup '
-	git-repo-config i18n.commitencoding UTF-8 &&
+	git-config i18n.commitencoding UTF-8 &&
 
 	# use UTF-8 in author and committer name to match the
 	# i18n.commitencoding settings
@@ -55,7 +55,7 @@ test_expect_success setup '
 	git commit -s -m "Second on side" &&
 
 	# the second one on the side branch is ISO-8859-1
-	git-repo-config i18n.commitencoding ISO-8859-1 &&
+	git-config i18n.commitencoding ISO-8859-1 &&
 	# use author and committer name in ISO-8859-1 to match it.
 	. ../t3901-8859-1.txt &&
 	test_tick &&
@@ -64,11 +64,11 @@ test_expect_success setup '
 	git commit -s -m "Third on side" &&
 
 	# Back to default
-	git-repo-config i18n.commitencoding UTF-8
+	git-config i18n.commitencoding UTF-8
 '
 
 test_expect_success 'format-patch output (ISO-8859-1)' '
-	git-repo-config i18n.logoutputencoding ISO-8859-1 &&
+	git-config i18n.logoutputencoding ISO-8859-1 &&
 
 	git format-patch --stdout master..HEAD^ >out-l1 &&
 	git format-patch --stdout HEAD^ >out-l2 &&
@@ -79,7 +79,7 @@ test_expect_success 'format-patch output (ISO-8859-1)' '
 '
 
 test_expect_success 'format-patch output (UTF-8)' '
-	git repo-config i18n.logoutputencoding UTF-8 &&
+	git config i18n.logoutputencoding UTF-8 &&
 
 	git format-patch --stdout master..HEAD^ >out-u1 &&
 	git format-patch --stdout HEAD^ >out-u2 &&
@@ -91,13 +91,13 @@ test_expect_success 'format-patch output (UTF-8)' '
 
 test_expect_success 'rebase (U/U)' '
 	# We want the result of rebase in UTF-8
-	git-repo-config i18n.commitencoding UTF-8 &&
+	git-config i18n.commitencoding UTF-8 &&
 
 	# The test is about logoutputencoding not affecting the
 	# final outcome -- it is used internally to generate the
 	# patch and the log.
 
-	git repo-config i18n.logoutputencoding UTF-8 &&
+	git config i18n.logoutputencoding UTF-8 &&
 
 	# The result will be committed by GIT_COMMITTER_NAME --
 	# we want UTF-8 encoded name.
@@ -109,8 +109,8 @@ test_expect_success 'rebase (U/U)' '
 '
 
 test_expect_success 'rebase (U/L)' '
-	git-repo-config i18n.commitencoding UTF-8 &&
-	git repo-config i18n.logoutputencoding ISO-8859-1 &&
+	git-config i18n.commitencoding UTF-8 &&
+	git config i18n.logoutputencoding ISO-8859-1 &&
 	. ../t3901-utf8.txt &&
 
 	git reset --hard side &&
@@ -121,8 +121,8 @@ test_expect_success 'rebase (U/L)' '
 
 test_expect_success 'rebase (L/L)' '
 	# In this test we want ISO-8859-1 encoded commits as the result
-	git-repo-config i18n.commitencoding ISO-8859-1 &&
-	git repo-config i18n.logoutputencoding ISO-8859-1 &&
+	git-config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding ISO-8859-1 &&
 	. ../t3901-8859-1.txt &&
 
 	git reset --hard side &&
@@ -134,8 +134,8 @@ test_expect_success 'rebase (L/L)' '
 test_expect_success 'rebase (L/U)' '
 	# This is pathological -- use UTF-8 as intermediate form
 	# to get ISO-8859-1 results.
-	git-repo-config i18n.commitencoding ISO-8859-1 &&
-	git repo-config i18n.logoutputencoding UTF-8 &&
+	git-config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding UTF-8 &&
 	. ../t3901-8859-1.txt &&
 
 	git reset --hard side &&
@@ -147,8 +147,8 @@ test_expect_success 'rebase (L/U)' '
 test_expect_success 'cherry-pick(U/U)' '
 	# Both the commitencoding and logoutputencoding is set to UTF-8.
 
-	git-repo-config i18n.commitencoding UTF-8 &&
-	git repo-config i18n.logoutputencoding UTF-8 &&
+	git-config i18n.commitencoding UTF-8 &&
+	git config i18n.logoutputencoding UTF-8 &&
 	. ../t3901-utf8.txt &&
 
 	git reset --hard master &&
@@ -162,8 +162,8 @@ test_expect_success 'cherry-pick(U/U)' '
 test_expect_success 'cherry-pick(L/L)' '
 	# Both the commitencoding and logoutputencoding is set to ISO-8859-1
 
-	git-repo-config i18n.commitencoding ISO-8859-1 &&
-	git repo-config i18n.logoutputencoding ISO-8859-1 &&
+	git-config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding ISO-8859-1 &&
 	. ../t3901-8859-1.txt &&
 
 	git reset --hard master &&
@@ -177,8 +177,8 @@ test_expect_success 'cherry-pick(L/L)' '
 test_expect_success 'cherry-pick(U/L)' '
 	# Commitencoding is set to UTF-8 but logoutputencoding is ISO-8859-1
 
-	git-repo-config i18n.commitencoding UTF-8 &&
-	git repo-config i18n.logoutputencoding ISO-8859-1 &&
+	git-config i18n.commitencoding UTF-8 &&
+	git config i18n.logoutputencoding ISO-8859-1 &&
 	. ../t3901-utf8.txt &&
 
 	git reset --hard master &&
@@ -193,8 +193,8 @@ test_expect_success 'cherry-pick(L/U)' '
 	# Again, the commitencoding is set to ISO-8859-1 but
 	# logoutputencoding is set to UTF-8.
 
-	git-repo-config i18n.commitencoding ISO-8859-1 &&
-	git repo-config i18n.logoutputencoding UTF-8 &&
+	git-config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding UTF-8 &&
 	. ../t3901-8859-1.txt &&
 
 	git reset --hard master &&
@@ -206,8 +206,8 @@ test_expect_success 'cherry-pick(L/U)' '
 '
 
 test_expect_success 'rebase --merge (U/U)' '
-	git-repo-config i18n.commitencoding UTF-8 &&
-	git repo-config i18n.logoutputencoding UTF-8 &&
+	git-config i18n.commitencoding UTF-8 &&
+	git config i18n.logoutputencoding UTF-8 &&
 	. ../t3901-utf8.txt &&
 
 	git reset --hard side &&
@@ -217,8 +217,8 @@ test_expect_success 'rebase --merge (U/U)' '
 '
 
 test_expect_success 'rebase --merge (U/L)' '
-	git-repo-config i18n.commitencoding UTF-8 &&
-	git repo-config i18n.logoutputencoding ISO-8859-1 &&
+	git-config i18n.commitencoding UTF-8 &&
+	git config i18n.logoutputencoding ISO-8859-1 &&
 	. ../t3901-utf8.txt &&
 
 	git reset --hard side &&
@@ -229,8 +229,8 @@ test_expect_success 'rebase --merge (U/L)' '
 
 test_expect_success 'rebase --merge (L/L)' '
 	# In this test we want ISO-8859-1 encoded commits as the result
-	git-repo-config i18n.commitencoding ISO-8859-1 &&
-	git repo-config i18n.logoutputencoding ISO-8859-1 &&
+	git-config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding ISO-8859-1 &&
 	. ../t3901-8859-1.txt &&
 
 	git reset --hard side &&
@@ -242,8 +242,8 @@ test_expect_success 'rebase --merge (L/L)' '
 test_expect_success 'rebase --merge (L/U)' '
 	# This is pathological -- use UTF-8 as intermediate form
 	# to get ISO-8859-1 results.
-	git-repo-config i18n.commitencoding ISO-8859-1 &&
-	git repo-config i18n.logoutputencoding UTF-8 &&
+	git-config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.logoutputencoding UTF-8 &&
 	. ../t3901-8859-1.txt &&
 
 	git reset --hard side &&
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 67b9681..9c58d77 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -28,7 +28,7 @@ test_expect_success \
     'git-diff-files -p >current'
 
 # that's as far as it comes
-if [ "$(git repo-config --get core.filemode)" = false ]
+if [ "$(git config --get core.filemode)" = false ]
 then
 	say 'filemode disabled on the filesystem'
 	test_done
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 8ad69d1..ca342f4 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -15,7 +15,7 @@ test_expect_success \
      tree=`git-write-tree` &&
      echo $tree'
 
-if [ "$(git repo-config --get core.filemode)" = false ]
+if [ "$(git config --get core.filemode)" = false ]
 then
 	say 'filemode disabled on the filesystem, using update-index --chmod=+x'
 	test_expect_success \
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index ed37141..3d85cea 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -73,7 +73,7 @@ test_expect_success setup '
 	for i in 1 2; do echo $i; done >>dir/sub &&
 	git update-index file0 dir/sub &&
 
-	git repo-config log.showroot false &&
+	git config log.showroot false &&
 	git commit --amend &&
 	git show-branch
 '
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index 22da6a0..b4662b0 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -31,7 +31,7 @@ test_expect_success setup \
 test_expect_success apply \
     'git-apply --index --stat --summary --apply test-patch'
 
-if [ "$(git repo-config --get core.filemode)" = false ]
+if [ "$(git config --get core.filemode)" = false ]
 then
 	say 'filemode disabled on the filesystem'
 else
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 5a7232a..a6dbb04 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -30,19 +30,19 @@ test_expect_success \
 
 test_expect_success \
     'verify-pack -v, packedGitWindowSize == 1 page' \
-    'git-repo-config core.packedGitWindowSize 512 &&
+    'git-config core.packedGitWindowSize 512 &&
      git-verify-pack -v "$pack1"'
 
 test_expect_success \
     'verify-pack -v, packedGit{WindowSize,Limit} == 1 page' \
-    'git-repo-config core.packedGitWindowSize 512 &&
-     git-repo-config core.packedGitLimit 512 &&
+    'git-config core.packedGitWindowSize 512 &&
+     git-config core.packedGitLimit 512 &&
      git-verify-pack -v "$pack1"'
 
 test_expect_success \
     'repack -a -d, packedGit{WindowSize,Limit} == 1 page' \
-    'git-repo-config core.packedGitWindowSize 512 &&
-     git-repo-config core.packedGitLimit 512 &&
+    'git-config core.packedGitWindowSize 512 &&
+     git-config core.packedGitLimit 512 &&
      commit2=`git-commit-tree $tree -p $commit1 </dev/null` &&
      git-update-ref HEAD $commit2 &&
      git-repack -a -d &&
@@ -53,8 +53,8 @@ test_expect_success \
 
 test_expect_success \
     'verify-pack -v, defaults' \
-    'git-repo-config --unset core.packedGitWindowSize &&
-     git-repo-config --unset core.packedGitLimit &&
+    'git-config --unset core.packedGitWindowSize &&
+     git-config --unset core.packedGitLimit &&
      git-verify-pack -v "$pack2"'
 
 test_done
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 2c15191..7d93d0d 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -106,7 +106,7 @@ export HOME ;# this way we force the victim/.git/config to be used.
 test_expect_success \
         'pushing with --force should be denied with denyNonFastforwards' '
 	cd victim &&
-	git-repo-config receive.denyNonFastforwards true &&
+	git-config receive.denyNonFastforwards true &&
 	cd .. &&
 	git-update-ref refs/heads/master master^ &&
 	git-send-pack --force ./victim/.git/ master &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 058cce0..e35d60f 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -98,7 +98,7 @@ pull_to_client () {
 	mkdir client &&
 	cd client &&
 	git-init 2>> log2.txt &&
-	git repo-config transfer.unpacklimit 0
+	git config transfer.unpacklimit 0
 )
 
 add A1
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 3ce9446..50c6485 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -22,14 +22,14 @@ test_expect_success "clone and setup child repos" '
 	cd .. &&
 	git clone . two &&
 	cd two &&
-	git repo-config branch.master.remote one &&
-	git repo-config remote.one.url ../one/.git/ &&
-	git repo-config remote.one.fetch refs/heads/master:refs/heads/one &&
+	git config branch.master.remote one &&
+	git config remote.one.url ../one/.git/ &&
+	git config remote.one.fetch refs/heads/master:refs/heads/one &&
 	cd .. &&
 	git clone . three &&
 	cd three &&
-	git repo-config branch.master.remote two &&
-	git repo-config branch.master.merge refs/heads/one &&
+	git config branch.master.remote two &&
+	git config branch.master.merge refs/heads/one &&
 	mkdir -p .git/remotes &&
 	{
 		echo "URL: ../two/.git/"
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 63e49f3..ea14023 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -108,7 +108,7 @@ EOF
 
 test_expect_success 'merge-msg test #3' '
 
-	git repo-config merge.summary true &&
+	git config merge.summary true &&
 
 	git checkout master &&
 	setdate &&
@@ -138,7 +138,7 @@ EOF
 
 test_expect_success 'merge-msg test #4' '
 
-	git repo-config merge.summary true &&
+	git config merge.summary true &&
 
 	git checkout master &&
 	setdate &&
@@ -150,7 +150,7 @@ test_expect_success 'merge-msg test #4' '
 
 test_expect_success 'merge-msg test #5' '
 
-	git repo-config merge.summary yes &&
+	git config merge.summary yes &&
 
 	git checkout master &&
 	setdate &&
-- 
1.5.0.rc2.g5355
