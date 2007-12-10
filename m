From: Jakub Narebski <jnareb@gmail.com>
Subject: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 10 Dec 2007 13:57:48 +0100
Message-ID: <200712101357.49325.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Shlomi Fish <shlomif@iglu.org.il>
X-From: git-owner@vger.kernel.org Mon Dec 10 13:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1iD7-0002eo-U8
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 13:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbXLJM5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 07:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbXLJM5w
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 07:57:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:60459 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbXLJM5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 07:57:50 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1002010nfb
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 04:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=trlKYFhFdTckHyd3THxq8AU2yegasxfRuHNiB4nxNSc=;
        b=dObtjPY7JfPND0Xrrz1jer6EUsqKaoa/yJ+yibcvMI7ggvZ35AaOe3Ls1ydMcGc3bNWGYLCrqJsutLIo7nunLqm8djjFKU7i3FUHtjQNSPyHSrZI+DOvop2sNQvCrcwbDW9PnpeRFNxNHRgBW+Ch4x9EWWNmCpogiFmx2Nj+E78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M2G5p0uRdW0dM6/KlmEMOYCKCDcLMV5NMH9gcNcqnQ89CIlTeriLwYMF07NyIaZOFlljbOdG4PjsBgWxxmqOX61FQe3knVwFwfdreu9zMn+GPll5SiV4kkxnHXopSQwvqa6YMMG5CVieILycguLWXIF5W3CUpTwYNuiln8ta7FQ=
Received: by 10.86.78.4 with SMTP id a4mr5537581fgb.1197291468062;
        Mon, 10 Dec 2007 04:57:48 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.16])
        by mx.google.com with ESMTPS id e20sm342322fga.2007.12.10.04.57.45
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Dec 2007 04:57:46 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67708>

I have noticed that your SCM comparison at "Better SCM Initiative"
website
  http://better-scm.berlios.de/comparison/comparison.html
misses one of the Git, version control system which is used to manage
Linux kernel, and one of the main open source (distributed) version
control systems (among Mercurial, Bazaar-NG, Monotone and Darcs).

Git used to be "stupid content tracker", something to build
user-friendly SCM interface on (e.g. Cogito) but it evolved into fully
fledged SCM since.

Git was created by Linus Torvalds in response to the change of BitKeeper 
licensing, as a tool to manage Linux kernel sources. It is based on 
three years of Linus experience with BitKeeper, and inspired by 
Monotone architecture.  It was designed for Linux kernel, and is used
by various projects, including X.Org, various Freedesktop projects,
WINE, OLPC (One Laptop Per Child), Samba.

<blurb src="http://git-scm.org">
Git  is  a  popular version control system designed to handle very large
projects with speed and  efficiency; it is used mainly for various open
source projects, most notably the Linux kernel.

Git  falls in the category of distributed source code management tools,
similar to e.g. GNU Arch or Monotone (or BitKeeper in the proprietary
world). Every Git working  directory is a full-fledged repository with
full revision tracking capabilities, not dependent on network access or
a central server.

Git is an Open Source project covered by the GNU General Public License v2.
It was originally written by Linus Torvalds and is currently maintained
by Junio C Hamano.
</blurb>

Below there is (slightly doctored) patch to the sources for the site.


BTW. when asking about updating GIT info for comparison, please CC
git mailing list, git@vger.kernel.org


Index: src/comparison/scm-comparison.xml
===================================================================
--- src/comparison/scm-comparison.xml   (revision 290)
+++ src/comparison/scm-comparison.xml   (working copy)
@@ -38,6 +38,9 @@ <implementations>
             <impl id="darcs">
                 <name>Darcs</name>
             </impl>
+            <impl id="git">
+                <name>Git</name>
+            </impl>
             <impl id="mercurial">
                 <name>Mercurial</name>
             </impl>
@@ -106,6 +109,7 @@ <title>Atomic Commits</title>
                 <s id="svk">Commits are atomic.</s>
                 <s id="aegis">Commits are atomic.</s>
                 <s id="bitkeeper">Yes (but need to verify)</s>
+                <s id="git">Yes.</s>
                 <s id="mercurial">Yes.</s>
                 <s id="monotone">Yes.</s>
                 <s id="opencm">Yes. Commits are atomic.</s>
@@ -142,6 +146,13 @@ <title>Files and Directories Moves or Renames</title>
                 <s id="darcs">Yes. Renames are supported.</s>
                 <s id="bitkeeper">Yes. Renames are supported.</s>
                 <s id="aegis">Yes. Renames are supported.</s>
+                <s id="git">
+                    Yes (or no depending on interpretation). Git detects
+                    renames based on content regardless of whether the
+                    committer indicated the fact.
+                    You can follow history of file across renames using
+                    'git log -M --follow'.
+                </s>
                 <s id="mercurial">Yes. Renames are supported.</s>
                 <s id="monotone">Yes. Renames are supported.</s>
                 <s id="opencm">Yes. Renames are supported</s>
@@ -214,6 +225,13 @@ <title>File and Directories Copies</title>
                     Yes. Copies are supported.
                 </s>
                 <s id="aegis">No. Copies are not supported.</s>
+                <s id="git">
+                    Yes (or no depending on interpretation). Git detects
+                    copies (when requested) based on content regardless
+                    of whether the committer indicated the fact.
+                    You can follow history of file across copies using
+                    'git log -C -C --follow'.
+                </s>
                 <s id="mercurial">Yes. Copies are supported</s>
                 <s id="monotone">Yes. Copies are supported</s>
                 <s id="opencm">No. Copies are not supported.</s>
@@ -267,6 +285,7 @@ <title>Remote Repository Replication</title>
                 <s id="darcs">Yes.</s>
                 <s id="bitkeeper">Yes.</s>
                 <s id="aegis">Yes.</s>
+                <s id="git">Yes.</s>
                 <s id="mercurial">Yes.</s>
                 <s id="monotone">Yes.</s>
                 <s id="opencm">No.</s>
@@ -313,6 +332,7 @@ <title>Propagating Changes to Parent Repositories</title>
                 <s id="darcs">Yes.</s>
                 <s id="bitkeeper">Yes.</s>
                 <s id="aegis">Yes.</s>
+                <s id="git">Yes.</s>
                 <s id="mercurial">Yes.</s>
                 <s id="monotone">Yes.</s>
                 <s id="opencm">No.</s>
@@ -373,6 +393,10 @@ <title>Repository Permissions</title>
                 <s id="svk">
                     Same as subversion.
                 </s>
+                <s id="git">
+                    Partial (?). It is possible to lock down repository
+                    (access to branches and tags) using hooks.
+                </s>
                 <s id="mercurial">
                     Yes. It is possible to lock down repositories,
                     subdirectories, or files using hooks.
@@ -455,6 +479,13 @@ <title>Changesets' Support</title>
                 <s id="darcs">
                     Yes. Changesets are supported.
                 </s>
+                <s id="git">
+                    Yes. Changesets are supported.<br />
+                    Actually Git is snapshot based which means Git records
+                    the full state in every commit.  This means that any two
+                    commits can be compared directly very quickly, although the
+                    repository is typically browsed as a series of changesets.
+                </s>
                 <s id="mercurial">
                     Yes. Changesets are supported.
                 </s>
@@ -509,6 +540,11 @@ <title>Tracking Line-wise File History</title>
                 <s id="arch">Not in the command line client, but ViewARCH,
                 a web-interface for Arch, has it.</s>
                 <s id="darcs">Yes. (darcs annotate)</s>
+                <s id="git">
+                    Yes. (git blame, git gui blame).
+                    It can also detect the origin of copied and moved source
+                    lines, and can ignore whitespace changes.
+                </s>
                 <s id="mercurial">Yes. (hg annotate)</s>
                 <s id="monotone">Yes, as of version 0.19.</s>
                 <s id="aegis">Yes. aeannotate</s>
@@ -570,6 +606,11 @@ <title>Ability to Work only on One Directory...</title>
                     whole.
                 </s>
                 <s id="aegis">No. All changes are made repository-wide.</s>
+                <s id="git">
+                    No. All changes are made repository-wide.  However
+                    it is possible to commit only selected changes in the
+                    working tree rather than everything.  You can also
+                    use submodules (subproject) support.</s>
                 <s id="mercurial">
                     It is possible to commit changes only in a subset of the
                     tree. There are plans for partial checkouts.
@@ -636,6 +677,10 @@ <title>Tracking Uncommited Changes</title>
                     Yes, using "darcs whatsnew".
                 </s>
                 <s id="aegis">Yes. Using aediff</s>
+                <s id="git">
+                    Yes, of course. Using git diff.
+                    Note that git uses staging area for commits (index).
+                </s>
                 <s id="mercurial">Yes. Using hg diff.</s>
                 <s id="monotone">Yes. In a similar fashion to CVS.</s>
                 <s id="opencm">Yes. Using cm diff</s>
@@ -681,6 +726,11 @@ <title>Per-File Commit Messages</title>
                 <s id="darcs">
                     No.
                 </s>
+                <s id="git">
+                    No.  The message applies to the commit as a whole.
+                    But you can tag (with description) given contents
+                    of a file (blob).
+                </s>
                 <s id="mercurial">
                     No.
                 </s>
@@ -782,6 +832,15 @@ <title>Documentation</title>
                     and the client contains a help tool that offers
                     an integrated help system.
                 </s>
+                <s id="git">
+                    Good. There's Git User's Manual, manpages, some
+                    technical documentation and some howtos.  All
+                    documentation is also available
+                    <a href="http://www.kernel.org/pub/software/scm/git/docs">online</a>
+                    in HTML format; there is additional information (including
+                    beginnings of FAQ) on a
+                    <a href="http://git-scm.org/gitwiki">git wiki</a>.
+                </s>
                 <s id="mercurial">
                     Very good. There's an overview and tutorial on the
                     web site, and integrated help for every command.
@@ -894,6 +953,16 @@ <title>Ease of Deployment</title>
                     to install the subversion perl bindings and a few modules
                     from CPAN.
                 </s>
+                <s id="git">
+                    Very good.  Install from RPM or deb on Linux; use
+                    msysGit or Cygwin install on Windows.  Git requires
+                    zlib; also POSIX shell and utilities and Perl for some
+                    commands.
+                    Installing from sources is easy: Makefile has ready
+                    configuration for many OS, you can also use autoconf
+                    to generate Makefile configuration.  Compiling docs
+                    requires asciidoc toolchain, but you can use prebuild.
+                </s>
                 <s id="mercurial">
                     Excellent.  Binary packages are available for all
                     popular platforms.  Building from source requires
@@ -1006,6 +1075,13 @@ <title>Command Set</title>
                     but since the model is different most commands are
                     unique.
                 </s>
+                <s id="git">
+                    Tries to follow CVS conventions, but deviates where there
+                    is a different design (following BitKeeper for DVCS).
+                    Large command set (~140) is divided into plumbing commands
+                    (low lewel, to be used in scripts) and porcelain (high level).
+                    It is easy to add new commands as scripts, or as git aliases.
+                </s>
                 <s id="mercurial">
                     Tries to follow CVS conventions, but deviates where there
                     is a different design.
@@ -1106,6 +1182,13 @@ <title>Networking Support</title>
                     There exists some HTTP-functionality, but it is quite
                     limited.
                 </s>
+                <s id="git">
+                    Excellent.  Uses HTTPS (with WebDAV) or ssh for push
+                    (to publish changes to server) and HTTP, FTP, ssh or custom
+                    "git" protocol for fetch (read from server).  There is also
+                    git-bundle for offline transport, and tools to exchange
+                    (create and apply) patches via email.
+                </s>
                 <s id="mercurial">
                     Excellent.  Uses HTTP or ssh.  Remote access also
                     works safely without locks over read-only network
@@ -1203,6 +1286,11 @@ <title>Portability</title>
                     Very good. Supports many UNIXes, Mac OS X, and Windows,
                     and is written in a portable language.
                 </s>
+                <s id="git">
+                    Good to very good.  Portable across all POSIX systems.
+                    There exists Win32 binary using MinGW (msysGit),
+                    or you can use binary provided by Cygwin.
+                </s>
                 <s id="mercurial">
                     Excellent. Runs on all platforms supported by
                     Python.  Repositories are portable across CPU
@@ -1300,6 +1388,10 @@ <title>Web Interface</title>
                     is included in the distribution.
                 </s>
                 <s id="aegis">Yes.</s>
+                <s id="git">
+                    Yes, gitweb is included in git since version 1.4.0.
+                    Other web interfaces exists: cgit, wit, git-php
+                </s>
                 <s id="mercurial">Yes.  The web interface is a bundled component.</s>
                 <s id="monotone">No.</s>
                 <s id="opencm">No.</s>
@@ -1373,6 +1464,12 @@ <title>Availability of Graphical User-Interfaces.</title>
                 <s id="aegis">
                     There is tkaegis.
                 </s>
+                <s id="git">
+                    There is history viewer 'gitk' and commit tool 'git-gui';
+                    both in Tcl/Tk.  There also exists a number of third-party
+                    GUIs, including: qgit (Qt), GitView (GTK+), Giggle (GTK+),
+                    tig (ncurses).
+                </s>
                 <s id="mercurial">
                     History viewing available with hgit extension;
                     check-in extension (hgct) makes committing easier.
@@ -1453,6 +1550,7 @@ <title>License</title>
                 GNU GPL (open-source)
             </s>
             <s id="svk">Perl License. (open source)</s>
+            <s id="git">GNU GPL v2 (open source)</s>
             <s id="mercurial">GNU GPL (open source)</s>
             <s id="monotone">GNU GPL (open source)</s>
             <s id="opencm">
