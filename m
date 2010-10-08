From: "=?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?=" 
	<stepan.nemec@gmail.com>
Subject: [PATCH 1/6] Use angles for placeholders consistently
Date: Fri,  8 Oct 2010 19:31:15 +0200
Message-ID: <1286559080-27257-2-git-send-email-stepnem@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 19:35:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Gql-0000hg-Gy
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759199Ab0JHReZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 13:34:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46375 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757925Ab0JHRd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 13:33:57 -0400
Received: by bwz15 with SMTP id 15so456728bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+gV4lGOQbQYaw9sHc6NRC2Cer8ihLzlkJ4jUXysx7G0=;
        b=TY9VYJ93wmgYCeMrBXo9iZ60Ur6Y6KvkH3ooXgFFJNgeIj1TAFRHUoRBR1I96K+gku
         Rr+Jdlqu03nL8e6CSG2YHcisDedWYIMs3q8LN3QQy5iDIEJSj7xiqvtLN8xtgtVbdjT6
         +YRgfdI7lFcqIgSxGmmFpm9szB07z2R1aEJkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aQ99SQUv0j/zI8n8EY6R5O6Za7x91X96iioMeGIU3mqY15ePft6bzgpFRsoFzs0ETA
         cZKjTwrkcMTyDQtiZp1iQcG4cPwZMssyhht4fNpzGSESH0QvWvHKkrctujK/rQT3fET3
         N/zDAbZ7tbBvO690bWKNbNhypQPMc2y4FyaKU=
Received: by 10.204.179.9 with SMTP id bo9mr2341935bkb.80.1286559235421;
        Fri, 08 Oct 2010 10:33:55 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id 4sm44574bki.13.2010.10.08.10.33.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:33:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f.dirty
In-Reply-To: <87fwwhszsf.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158513>


Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 Documentation/diff-options.txt     |   10 +++---
 Documentation/git-apply.txt        |    4 +-
 Documentation/git-archive.txt      |    4 +-
 Documentation/git-bundle.txt       |    6 ++--
 Documentation/git-daemon.txt       |   48 ++++++++++++++++++----------=
--------
 Documentation/git-fast-export.txt  |    2 +-
 Documentation/git-index-pack.txt   |    4 +-
 Documentation/git-ls-tree.txt      |   10 +++---
 Documentation/git-pack-objects.txt |   14 +++++-----
 Documentation/git-remote.txt       |    2 +-
 Documentation/git-repack.txt       |   12 ++++----
 Documentation/git-rev-list.txt     |   16 ++++++------
 Documentation/git-web--browse.txt  |   16 ++++++------
 Documentation/git.txt              |   12 ++++----
 Documentation/merge-strategies.txt |    2 +-
 Documentation/rev-list-options.txt |   16 ++++++------
 archive.c                          |    4 +-
 builtin/bundle.c                   |    4 +-
 builtin/grep.c                     |    2 +-
 builtin/ls-tree.c                  |    2 +-
 builtin/pack-objects.c             |    6 ++--
 builtin/remote.c                   |    2 +-
 builtin/rev-list.c                 |    8 +++---
 daemon.c                           |   18 ++++++------
 fast-import.c                      |    2 +-
 git.c                              |    8 +++---
 upload-pack.c                      |    2 +-
 27 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index f77a0f8..cbf3c92 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -48,9 +48,9 @@ endif::git-format-patch[]
 --patience::
 	Generate a diff using the "patience diff" algorithm.
=20
---stat[=3Dwidth[,name-width]]::
+--stat[=3D<width>[,<name-width>]]::
 	Generate a diffstat.  You can override the default
-	output width for 80-column terminal by `--stat=3Dwidth`.
+	output width for 80-column terminal by `--stat=3D<width>`.
 	The width of the filename part can be controlled by
 	giving another width to it separated by a comma.
=20
@@ -66,14 +66,14 @@ endif::git-format-patch[]
 	number of modified files, as well as number of added and deleted
 	lines.
=20
---dirstat[=3Dlimit]::
+--dirstat[=3D<limit>]::
 	Output the distribution of relative amount of changes (number of line=
s added or
 	removed) for each sub-directory. Directories with changes below
 	a cut-off percent (3% by default) are not shown. The cut-off percent
-	can be set with `--dirstat=3Dlimit`. Changes in a child directory is =
not
+	can be set with `--dirstat=3D<limit>`. Changes in a child directory a=
re not
 	counted for the parent directory, unless `--cumulative` is used.
=20
---dirstat-by-file[=3Dlimit]::
+--dirstat-by-file[=3D<limit>]::
 	Same as `--dirstat`, but counts changed files instead of lines.
=20
 --summary::
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4a74b23..08bf6e7 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -12,10 +12,10 @@ SYNOPSIS
 'git apply' [--stat] [--numstat] [--summary] [--check] [--index]
 	  [--apply] [--no-add] [--build-fake-ancestor=3D<file>] [-R | --rever=
se]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
-	  [-pNUM] [-CNUM] [--inaccurate-eof] [--recount] [--cached]
+	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
 	  [--ignore-space-change | --ignore-whitespace ]
 	  [--whitespace=3D<nowarn|warn|fix|error|error-all>]
-	  [--exclude=3DPATH] [--include=3DPATH] [--directory=3D<root>]
+	  [--exclude=3D<path>] [--include=3D<path>] [--directory=3D<root>]
 	  [--verbose] [<patch>...]
=20
 DESCRIPTION
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index 8d3e666..4163a1b 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [<ext=
ra>]
 	      [-o | --output=3D<file>] [--worktree-attributes]
 	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
-	      [path...]
+	      [<path>...]
=20
 DESCRIPTION
 -----------
@@ -73,7 +73,7 @@ OPTIONS
 <tree-ish>::
 	The tree or commit to produce an archive for.
=20
-path::
+<path>::
 	Without an optional path parameter, all files and subdirectories
 	of the current working directory are included in the archive.
 	If one or more paths are specified, only these are included.
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.tx=
t
index 38e59af..6266a3a 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 [verse]
 'git bundle' create <file> <git-rev-list-args>
 'git bundle' verify <file>
-'git bundle' list-heads <file> [refname...]
-'git bundle' unbundle <file> [refname...]
+'git bundle' list-heads <file> [<refname>...]
+'git bundle' unbundle <file> [<refname>...]
=20
 DESCRIPTION
 -----------
@@ -68,7 +68,7 @@ unbundle <file>::
 	packaged.
=20
=20
-[refname...]::
+[<refname>...]::
 	A list of references used to limit the references reported as
 	available. This is principally of use to 'git fetch', which
 	expects to receive only those references asked for and not
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.tx=
t
index 01c9f8e..2f0ddf6 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -9,15 +9,15 @@ SYNOPSIS
 --------
 [verse]
 'git daemon' [--verbose] [--syslog] [--export-all]
-	     [--timeout=3Dn] [--init-timeout=3Dn] [--max-connections=3Dn]
-	     [--strict-paths] [--base-path=3Dpath] [--base-path-relaxed]
-	     [--user-path | --user-path=3Dpath]
-	     [--interpolated-path=3Dpathtemplate]
-	     [--reuseaddr] [--detach] [--pid-file=3Dfile]
-	     [--enable=3Dservice] [--disable=3Dservice]
-	     [--allow-override=3Dservice] [--forbid-override=3Dservice]
-	     [--inetd | [--listen=3Dhost_or_ipaddr] [--port=3Dn] [--user=3Dus=
er [--group=3Dgroup]]
-	     [directory...]
+	     [--timeout=3D<n>] [--init-timeout=3D<n>] [--max-connections=3D<n=
>]
+	     [--strict-paths] [--base-path=3D<path>] [--base-path-relaxed]
+	     [--user-path | --user-path=3D<path>]
+	     [--interpolated-path=3D<pathtemplate>]
+	     [--reuseaddr] [--detach] [--pid-file=3D<file>]
+	     [--enable=3D<service>] [--disable=3D<service>]
+	     [--allow-override=3D<service>] [--forbid-override=3D<service>]
+	     [--inetd | [--listen=3D<host_or_ipaddr>] [--port=3D<n>] [--user=3D=
<user> [--group=3D<group>]]
+	     [<directory>...]
=20
 DESCRIPTION
 -----------
@@ -48,7 +48,7 @@ OPTIONS
 	'git daemon' will refuse to start when this option is enabled and no
 	whitelist is specified.
=20
---base-path=3Dpath::
+--base-path=3D<path>::
 	Remap all the path requests as relative to the given path.
 	This is sort of "GIT root" - if you run 'git daemon' with
 	'--base-path=3D/srv/git' on example.com, then if you later try to pul=
l
@@ -61,7 +61,7 @@ OPTIONS
 	This is useful for switching to --base-path usage, while still
 	allowing the old paths.
=20
---interpolated-path=3Dpathtemplate::
+--interpolated-path=3D<pathtemplate>::
 	To support virtual hosting, an interpolated path template can be
 	used to dynamically construct alternate paths.  The template
 	supports %H for the target hostname as supplied by the client but
@@ -80,27 +80,27 @@ OPTIONS
 	Have the server run as an inetd service. Implies --syslog.
 	Incompatible with --port, --listen, --user and --group options.
=20
---listen=3Dhost_or_ipaddr::
+--listen=3D<host_or_ipaddr>::
 	Listen on a specific IP address or hostname.  IP addresses can
 	be either an IPv4 address or an IPv6 address if supported.  If IPv6
 	is not supported, then --listen=3Dhostname is also not supported and
 	--listen must be given an IPv4 address.
 	Incompatible with '--inetd' option.
=20
---port=3Dn::
+--port=3D<n>::
 	Listen on an alternative port.  Incompatible with '--inetd' option.
=20
---init-timeout=3Dn::
+--init-timeout=3D<n>::
 	Timeout between the moment the connection is established and the
 	client request is received (typically a rather low value, since
 	that should be basically immediate).
=20
---timeout=3Dn::
+--timeout=3D<n>::
 	Timeout for specific client sub-requests. This includes the time
 	it takes for the server to process the sub-request and the time spent
 	waiting for the next client's request.
=20
---max-connections=3Dn::
+--max-connections=3D<n>::
 	Maximum number of concurrent clients, defaults to 32.  Set it to
 	zero for no limit.
=20
@@ -109,7 +109,7 @@ OPTIONS
 	--verbose, thus by default only error conditions will be logged.
=20
 --user-path::
---user-path=3Dpath::
+--user-path=3D<path>::
 	Allow {tilde}user notation to be used in requests.  When
 	specified with no parameter, requests to
 	git://host/{tilde}alice/foo is taken as a request to access
@@ -129,12 +129,12 @@ OPTIONS
 --detach::
 	Detach from the shell. Implies --syslog.
=20
---pid-file=3Dfile::
+--pid-file=3D<file>::
 	Save the process id in 'file'.  Ignored when the daemon
 	is run under `--inetd`.
=20
---user=3Duser::
---group=3Dgroup::
+--user=3D<user>::
+--group=3D<group>::
 	Change daemon's uid and gid before entering the service loop.
 	When only `--user` is given without `--group`, the
 	primary group ID for the user is used.  The values of
@@ -145,16 +145,16 @@ Giving these options is an error when used with `=
--inetd`; use
 the facility of inet daemon to achieve the same before spawning
 'git daemon' if needed.
=20
---enable=3Dservice::
---disable=3Dservice::
+--enable=3D<service>::
+--disable=3D<service>::
 	Enable/disable the service site-wide per default.  Note
 	that a service disabled site-wide can still be enabled
 	per repository if it is marked overridable and the
 	repository enables the service with a configuration
 	item.
=20
---allow-override=3Dservice::
---forbid-override=3Dservice::
+--allow-override=3D<service>::
+--forbid-override=3D<service>::
 	Allow/forbid overriding the site-wide default with per
 	repository configuration.  By default, all the services
 	are overridable.
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast=
-export.txt
index fcad113..e05b686 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -96,7 +96,7 @@ marks the same across runs.
 	in the commit (as opposed to just listing the files which are
 	different from the commit's first parent).
=20
-[git-rev-list-args...]::
+[<git-rev-list-args>...]::
        A list of arguments, acceptable to 'git rev-parse' and
        'git rev-list', that specifies the specific objects and referen=
ces
        to export.  For example, `master{tilde}10..master` causes the
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index=
-pack.txt
index f3ccc72..c2bb810 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -59,10 +59,10 @@ OPTIONS
 	the newly constructed pack and index before refs can be
 	updated to use objects contained in the pack.
=20
---keep=3D'why'::
+--keep=3D<msg>::
 	Like --keep create a .keep file before moving the index into
 	its final destination, but rather than creating an empty file
-	place 'why' followed by an LF into the .keep file.  The 'why'
+	place '<msg>' followed by an LF into the .keep file.  The '<msg>'
 	message can later be searched for within all .keep files to
 	locate any which have outlived their usefulness.
=20
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.=
txt
index 1f89d36..76ed625 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbr=
ev=3D[<n>]]
-	    <tree-ish> [paths...]
+	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbr=
ev[=3D<n>]]
+	    <tree-ish> [<path>...]
=20
 DESCRIPTION
 -----------
@@ -19,11 +19,11 @@ Lists the contents of a given tree object, like wha=
t "/bin/ls -a" does
 in the current working directory.  Note that:
=20
  - the behaviour is slightly different from that of "/bin/ls" in that =
the
-   'paths' denote just a list of patterns to match, e.g. so specifying
+   '<path>' denotes just a list of patterns to match, e.g. so specifyi=
ng
    directory name (without '-r') will behave differently, and order of=
 the
    arguments does not matter.
=20
- - the behaviour is similar to that of "/bin/ls" in that the 'paths' i=
s
+ - the behaviour is similar to that of "/bin/ls" in that the '<path>' =
is
    taken as relative to the current working directory.  E.g. when you =
are
    in a directory 'sub' that has a directory 'dir', you can run 'git
    ls-tree -r HEAD dir' to list the contents of the tree (that is
@@ -72,7 +72,7 @@ OPTIONS
 	Do not limit the listing to the current working directory.
 	Implies --full-name.
=20
-paths::
+[<path>...]::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
 	implicitly uses the root level of the tree as the sole path argument.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pac=
k-objects.txt
index 8ed09c0..a1dd3e9 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-=
implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
-	[--local] [--incremental] [--window=3DN] [--depth=3DN]
+	[--local] [--incremental] [--window=3D<n>] [--depth=3D<n>]
 	[--revs [--unpacked | --all]*] [--stdout | base-name]
 	[--keep-true-parents] < object-list
=20
@@ -82,8 +82,8 @@ base-name::
 	reference was included in the resulting packfile.  This
 	can be useful to send new tags to native git clients.
=20
---window=3D[N]::
---depth=3D[N]::
+--window=3D<n>::
+--depth=3D<n>::
 	These two options affect how the objects contained in
 	the pack are stored using delta compression.  The
 	objects are first internally sorted by type, size and
@@ -95,10 +95,10 @@ base-name::
 	times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
=20
---window-memory=3D[N]::
+--window-memory=3D<n>::
 	This option provides an additional limit on top of `--window`;
 	the window size will dynamically scale down so as to not take
-	up more than N bytes in memory.  This is useful in
+	up more than '<n>' bytes in memory.  This is useful in
 	repositories with a mix of large and small objects to not run
 	out of memory with a large window, but still be able to take
 	advantage of the large window for the smaller objects.  The
@@ -106,7 +106,7 @@ base-name::
 	`--window-memory=3D0` makes memory usage unlimited, which is the
 	default.
=20
---max-pack-size=3D[N]::
+--max-pack-size=3D<n>::
 	Maximum size of each output pack file. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
 	If specified,  multiple packfiles may be created.
@@ -171,7 +171,7 @@ base-name::
 	wholesale enforcement of a different compression level on the
 	packed data is desired.
=20
---compression=3D[N]::
+--compression=3D<n>::
 	Specifies compression level for newly-compressed data in the
 	generated pack.  If not specified,  pack compression level is
 	determined first by pack.compression,  then by core.compression,
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index aa021b0..b317086 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 'git remote set-url --delete' [--push] <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
-'git remote' [-v | --verbose] 'update' [-p | --prune] [group | remote]=
=2E..
+'git remote' [-v | --verbose] 'update' [-p | --prune] [<group> | <remo=
te>]...
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.tx=
t
index 9566727..27f7865 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -8,7 +8,7 @@ git-repack - Pack unpacked objects in a repository
=20
 SYNOPSIS
 --------
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=3DN] [-=
-depth=3DN]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=3D<n>] =
[--depth=3D<n>]
=20
 DESCRIPTION
 -----------
@@ -80,8 +80,8 @@ other objects in that pack they already have locally.
 	this repository (or a direct copy of it)
 	over HTTP or FTP.  See linkgit:git-update-server-info[1].
=20
---window=3D[N]::
---depth=3D[N]::
+--window=3D<n>::
+--depth=3D<n>::
 	These two options affect how the objects contained in the pack are
 	stored using delta compression. The objects are first internally
 	sorted by type, size and optionally names and compared against the
@@ -91,10 +91,10 @@ other objects in that pack they already have locall=
y.
 	to be applied that many times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
=20
---window-memory=3D[N]::
+--window-memory=3D<n>::
 	This option provides an additional limit on top of `--window`;
 	the window size will dynamically scale down so as to not take
-	up more than N bytes in memory.  This is useful in
+	up more than '<n>' bytes in memory.  This is useful in
 	repositories with a mix of large and small objects to not run
 	out of memory with a large window, but still be able to take
 	advantage of the large window for the smaller objects.  The
@@ -102,7 +102,7 @@ other objects in that pack they already have locall=
y.
 	`--window-memory=3D0` makes memory usage unlimited, which is the
 	default.
=20
---max-pack-size=3D[N]::
+--max-pack-size=3D<n>::
 	Maximum size of each output pack file. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
 	If specified,  multiple packfiles may be created.
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-lis=
t.txt
index 173f3fc..cfb1d21 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,10 +9,10 @@ git-rev-list - Lists commit objects in reverse chrono=
logical order
 SYNOPSIS
 --------
 [verse]
-'git rev-list' [ \--max-count=3Dnumber ]
-	     [ \--skip=3Dnumber ]
-	     [ \--max-age=3Dtimestamp ]
-	     [ \--min-age=3Dtimestamp ]
+'git rev-list' [ \--max-count=3D<number> ]
+	     [ \--skip=3D<number> ]
+	     [ \--max-age=3D<timestamp> ]
+	     [ \--min-age=3D<timestamp> ]
 	     [ \--sparse ]
 	     [ \--merges ]
 	     [ \--no-merges ]
@@ -21,10 +21,10 @@ SYNOPSIS
 	     [ \--full-history ]
 	     [ \--not ]
 	     [ \--all ]
-	     [ \--branches[=3Dpattern] ]
-	     [ \--tags[=3Dpattern] ]
-	     [ \--remotes[=3Dpattern] ]
-	     [ \--glob=3Dglob-pattern ]
+	     [ \--branches[=3D<pattern>] ]
+	     [ \--tags[=3D<pattern>] ]
+	     [ \--remotes[=3D<pattern>] ]
+	     [ \--glob=3D<glob-pattern> ]
 	     [ \--stdin ]
 	     [ \--quiet ]
 	     [ \--topo-order ]
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web-=
-browse.txt
index e1586c7..51e8e0a 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -32,19 +32,19 @@ Custom commands may also be specified.
=20
 OPTIONS
 -------
--b BROWSER::
---browser=3DBROWSER::
-	Use the specified BROWSER. It must be in the list of supported
+-b <browser>::
+--browser=3D<browser>::
+	Use the specified browser. It must be in the list of supported
 	browsers.
=20
--t BROWSER::
---tool=3DBROWSER::
+-t <browser>::
+--tool=3D<browser>::
 	Same as above.
=20
--c CONF.VAR::
---config=3DCONF.VAR::
+-c <conf.var>::
+--config=3D<conf.var>::
 	CONF.VAR is looked up in the git config files. If it's set,
-	then its value specify the browser that should be used.
+	then its value specifies the browser that should be used.
=20
 CONFIGURATION VARIABLES
 -----------------------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index dd57bdc..8de8617 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,11 +9,11 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--exec-path[=3DGIT_EXEC_PATH]] [--html-path]
+'git' [--version] [--exec-path[=3D<path>]] [--html-path]
     [-p|--paginate|--no-pager] [--no-replace-objects]
-    [--bare] [--git-dir=3DGIT_DIR] [--work-tree=3DGIT_WORK_TREE]
-    [-c name=3Dvalue]
-    [--help] COMMAND [ARGS]
+    [--bare] [--git-dir=3D<path>] [--work-tree=3D<path>]
+    [-c <name>=3D<value>]
+    [--help] <command> [<args>]
=20
 DESCRIPTION
 -----------
@@ -28,7 +28,7 @@ also want to read linkgit:gitcvs-migration[7].  See
 the link:user-manual.html[Git User's Manual] for a more in-depth
 introduction.
=20
-The COMMAND is either a name of a Git command (see below) or an alias
+The '<command>' is either a name of a Git command (see below) or an al=
ias
 as defined in the configuration file (see linkgit:git-config[1]).
=20
 Formatted and hyperlinked version of the latest git
@@ -252,7 +252,7 @@ help ...`.
 	The <name> is expected in the same format as listed by
 	'git config' (subkeys separated by dots).
=20
---exec-path::
+--exec-path[=3D<path>]::
 	Path to wherever your core git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
 	environment variable. If no path is given, 'git' will print
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-s=
trategies.txt
index 049313d..8676e26 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -52,7 +52,7 @@ no-renormalize;;
 	Disables the `renormalize` option.  This overrides the
 	`merge.renormalize` configuration variable.
=20
-subtree[=3Dpath];;
+subtree[=3D<path>];;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
 	match with each other when merging.  Instead, the specified path
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index ebc0108..1b13c1f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -246,29 +246,29 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `refs/` are listed on the
 	command line as '<commit>'.
=20
---branches[=3Dpattern]::
+--branches[=3D<pattern>]::
=20
 	Pretend as if all the refs in `refs/heads` are listed
-	on the command line as '<commit>'. If `pattern` is given, limit
+	on the command line as '<commit>'. If '<pattern>' is given, limit
 	branches to ones matching given shell glob. If pattern lacks '?',
 	'*', or '[', '/*' at the end is implied.
=20
---tags[=3Dpattern]::
+--tags[=3D<pattern>]::
=20
 	Pretend as if all the refs in `refs/tags` are listed
-	on the command line as '<commit>'. If `pattern` is given, limit
+	on the command line as '<commit>'. If '<pattern>' is given, limit
 	tags to ones matching given shell glob. If pattern lacks '?', '*',
 	or '[', '/*' at the end is implied.
=20
---remotes[=3Dpattern]::
+--remotes[=3D<pattern>]::
=20
 	Pretend as if all the refs in `refs/remotes` are listed
-	on the command line as '<commit>'. If `pattern`is given, limit
+	on the command line as '<commit>'. If '<pattern>' is given, limit
 	remote tracking branches to ones matching given shell glob.
 	If pattern lacks '?', '*', or '[', '/*' at the end is implied.
=20
---glob=3Dglob-pattern::
-	Pretend as if all the refs matching shell glob `glob-pattern`
+--glob=3D<glob-pattern>::
+	Pretend as if all the refs matching shell glob '<glob-pattern>'
 	are listed on the command line as '<commit>'. Leading 'refs/',
 	is automatically prepended if missing. If pattern lacks '?', '*',
 	or '[', '/*' at the end is implied.
diff --git a/archive.c b/archive.c
index edd6853..f59afda 100644
--- a/archive.c
+++ b/archive.c
@@ -7,9 +7,9 @@
 #include "unpack-trees.h"
=20
 static char const * const archive_usage[] =3D {
-	"git archive [options] <tree-ish> [path...]",
+	"git archive [options] <tree-ish> [<path>...]",
 	"git archive --list",
-	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [pat=
h...]",
+	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<pa=
th>...]",
 	"git archive --remote <repo> [--exec <cmd>] --list",
 	NULL
 };
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 80649ba..9b87fb9 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,8 +12,8 @@
 static const char builtin_bundle_usage[] =3D
   "git bundle create <file> <git-rev-list args>\n"
   "   or: git bundle verify <file>\n"
-  "   or: git bundle list-heads <file> [refname...]\n"
-  "   or: git bundle unbundle <file> [refname...]";
+  "   or: git bundle list-heads <file> [<refname>...]\n"
+  "   or: git bundle unbundle <file> [<refname>...]";
=20
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/grep.c b/builtin/grep.c
index da32f3d..3d5f6ac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -24,7 +24,7 @@
 #endif
=20
 static char const * const grep_usage[] =3D {
-	"git grep [options] [-e] <pattern> [<rev>...] [[--] path...]",
+	"git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]",
 	NULL
 };
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index a818756..f73e6bd 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -24,7 +24,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
=20
 static const  char * const ls_tree_usage[] =3D {
-	"git ls-tree [<options>] <tree-ish> [path...]",
+	"git ls-tree [<options>] <tree-ish> [<path>...]",
 	NULL
 };
=20
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d5a8db1..1e4c386 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -25,10 +25,10 @@
 static const char pack_usage[] =3D
   "git pack-objects [{ -q | --progress | --all-progress }]\n"
   "        [--all-progress-implied]\n"
-  "        [--max-pack-size=3DN] [--local] [--incremental]\n"
-  "        [--window=3DN] [--window-memory=3DN] [--depth=3DN]\n"
+  "        [--max-pack-size=3D<n>] [--local] [--incremental]\n"
+  "        [--window=3D<n>] [--window-memory=3D<n>] [--depth=3D<n>]\n"
   "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset=
]\n"
-  "        [--threads=3DN] [--non-empty] [--revs [--unpacked | --all]*=
]\n"
+  "        [--threads=3D<n>] [--non-empty] [--revs [--unpacked | --all=
]]\n"
   "        [--reflog] [--stdout | base-name] [--include-tag]\n"
   "        [--keep-unreachable | --unpack-unreachable]\n"
   "        [<ref-list | <object-list]";
diff --git a/builtin/remote.c b/builtin/remote.c
index 48e0a6b..c0198fc 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -15,7 +15,7 @@ static const char * const builtin_remote_usage[] =3D =
{
 	"git remote set-head <name> (-a | -d | <branch>)",
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [group | remote]",
+	"git remote [-v | --verbose] update [-p | --prune] [<group> | <remote=
>]",
 	"git remote set-branches <name> [--add] <branch>...",
 	"git remote set-url <name> <newurl> [<oldurl>]",
 	"git remote set-url --add <name> <newurl>",
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index efe9360..158ce11 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -11,9 +11,9 @@
 static const char rev_list_usage[] =3D
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
 "  limiting output:\n"
-"    --max-count=3Dnr\n"
-"    --max-age=3Depoch\n"
-"    --min-age=3Depoch\n"
+"    --max-count=3D<n>\n"
+"    --max-age=3D<epoch>\n"
+"    --min-age=3D<epoch>\n"
 "    --sparse\n"
 "    --no-merges\n"
 "    --remove-empty\n"
@@ -33,7 +33,7 @@ static const char rev_list_usage[] =3D
 "    --objects | --objects-edge\n"
 "    --unpacked\n"
 "    --header | --pretty\n"
-"    --abbrev=3Dnr | --no-abbrev\n"
+"    --abbrev=3D<n> | --no-abbrev\n"
 "    --abbrev-commit\n"
 "    --left-right\n"
 "  special purpose:\n"
diff --git a/daemon.c b/daemon.c
index e22a2b7..9326d3a 100644
--- a/daemon.c
+++ b/daemon.c
@@ -20,15 +20,15 @@ static int reuseaddr;
=20
 static const char daemon_usage[] =3D
 "git daemon [--verbose] [--syslog] [--export-all]\n"
-"           [--timeout=3Dn] [--init-timeout=3Dn] [--max-connections=3D=
n]\n"
-"           [--strict-paths] [--base-path=3Dpath] [--base-path-relaxed=
]\n"
-"           [--user-path | --user-path=3Dpath]\n"
-"           [--interpolated-path=3Dpath]\n"
-"           [--reuseaddr] [--detach] [--pid-file=3Dfile]\n"
-"           [--[enable|disable|allow-override|forbid-override]=3Dservi=
ce]\n"
-"           [--inetd | [--listen=3Dhost_or_ipaddr] [--port=3Dn]\n"
-"                      [--user=3Duser [--group=3Dgroup]]\n"
-"           [directory...]";
+"           [--timeout=3D<n>] [--init-timeout=3D<n>] [--max-connection=
s=3D<n>]\n"
+"           [--strict-paths] [--base-path=3D<path>] [--base-path-relax=
ed]\n"
+"           [--user-path | --user-path=3D<path>]\n"
+"           [--interpolated-path=3D<path>]\n"
+"           [--reuseaddr] [--detach] [--pid-file=3D<file>]\n"
+"           [--(enable|disable|allow-override|forbid-override)=3D<serv=
ice>]\n"
+"           [--inetd | [--listen=3D<host_or_ipaddr>] [--port=3D<n>]\n"
+"                      [--user=3D<user> [--group=3D<group>]]\n"
+"           [<directory>...]";
=20
 /* List of acceptable pathname prefixes */
 static char **ok_paths;
diff --git a/fast-import.c b/fast-import.c
index 2317b0f..eab68d5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2884,7 +2884,7 @@ static int git_pack_config(const char *k, const c=
har *v, void *cb)
 }
=20
 static const char fast_import_usage[] =3D
-"git fast-import [--date-format=3Df] [--max-pack-size=3Dn] [--big-file=
-threshold=3Dn] [--depth=3Dn] [--active-branches=3Dn] [--export-marks=3D=
marks.file]";
+"git fast-import [--date-format=3D<f>] [--max-pack-size=3D<n>] [--big-=
file-threshold=3D<n>] [--depth=3D<n>] [--active-branches=3D<n>] [--expo=
rt-marks=3D<marks.file>]";
=20
 static void parse_argv(void)
 {
diff --git a/git.c b/git.c
index 50a1401..0409ac9 100644
--- a/git.c
+++ b/git.c
@@ -6,14 +6,14 @@
 #include "run-command.h"
=20
 const char git_usage_string[] =3D
-	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [--html-path]\n"
+	"git [--version] [--exec-path[=3D<path>]] [--html-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects]\n"
-	"           [--bare] [--git-dir=3DGIT_DIR] [--work-tree=3DGIT_WORK_TR=
EE]\n"
+	"           [--bare] [--git-dir=3D<path>] [--work-tree=3D<path>]\n"
 	"           [-c name=3Dvalue] [--help]\n"
-	"           COMMAND [ARGS]";
+	"           <command> [<args>]";
=20
 const char git_more_info_string[] =3D
-	"See 'git help COMMAND' for more information on a specific command.";
+	"See 'git help <command>' for more information on a specific command.=
";
=20
 static struct startup_info git_startup_info;
 static int use_pager =3D -1;
diff --git a/upload-pack.c b/upload-pack.c
index 92f9530..f05e422 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -11,7 +11,7 @@
 #include "list-objects.h"
 #include "run-command.h"
=20
-static const char upload_pack_usage[] =3D "git upload-pack [--strict] =
[--timeout=3Dnn] <dir>";
+static const char upload_pack_usage[] =3D "git upload-pack [--strict] =
[--timeout=3D<n>] <dir>";
=20
 /* bits #0..7 in revision.h, #8..10 in commit.c */
 #define THEY_HAVE	(1u << 11)
--=20
1.7.3.rc2.221.gbf93f.dirty
