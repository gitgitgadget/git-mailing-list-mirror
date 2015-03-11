From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] *config.txt: stick to camelCase naming convention
Date: Wed, 11 Mar 2015 16:32:45 -0400
Message-ID: <20150311203245.GA20243@flurp.local>
References: <xmqqfv9cxwsm.fsf@gitster.dls.corp.google.com>
 <1426076418-13741-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:33:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVnJL-0003Oy-QA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 21:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbbCKUcz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2015 16:32:55 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:32848 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbCKUcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 16:32:53 -0400
Received: by iecvj10 with SMTP id vj10so5127491iec.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pKybMvuBxk2vuIDf8UCxO0ytWAMmg6IpFBWmd73E9s4=;
        b=XkeNeiwitoRnDRgoNn3GLM8u+hw9FreV6V6Qpn29Fs/uOQpG6eGI1usA+lMg0GlnRe
         /qM4+sXzC/d86tZGq/5uee6NJCtT4tMJYPJUScdi4n1K39hPKqw7i4n30VY0FilO40SO
         Ig2p/aXFCPcI+1+KnwFHF2sewuBZe+hfpte6JCdmWMozxn4orozOzHQ4NB6imDwXO1Mg
         4U7bwIgDXMeVhZhv9eBm2FIRk95mOE3IwBSHTXwXpJ/qJn9vdqmC928Ak099X9o1RQvz
         td8PL6VwpHzYJGuFfj3Lq1Nch3qazxwF7E0w6eTIy0B6KJZLhsMEMCXXcpNccyMtpJZi
         gRQg==
X-Received: by 10.43.2.68 with SMTP id nt4mr44226562icb.49.1426105972504;
        Wed, 11 Mar 2015 13:32:52 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g9sm9192642igg.1.2015.03.11.13.32.50
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 11 Mar 2015 13:32:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426076418-13741-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265336>

On Wed, Mar 11, 2015 at 07:20:18PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> This should improve readability. Compare "thislongname" and
> "thisLongName". The following keys are left in unchanged. We can
> decide what to do with them later.
>=20
>  - am.keepcr
>  - core.autocrlf .safecrlf .trustctime
>  - diff.dirstat .noprefix
>  - gitcvs.usecrlfattr
>  - gui.blamehistoryctx .trustmtime
>  - pull.twohead
>  - receive.autogc
>  - sendemail.signedoffbycc .smtpsslcertpath .suppresscc
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1530255..54ae0f6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -237,7 +237,7 @@ The default is false, except linkgit:git-clone[1]=
 or linkgit:git-init[1]
>  will probe and set core.ignorecase true if appropriate when the repo=
sitory
>  is created.
> =20
> -core.precomposeunicode::
> +core.precomposeUnicode::

There are numerous places in config.txt where a config variable is
mentioned in the description blurbs as well, so camel-casing it at just
the point of definition makes for an incomplete conversion.

>  	This option is only used by Mac OS implementation of Git.
>  	When core.precomposeunicode=3Dtrue, Git reverts the unicode decompo=
sition

Here is one such instance of the variable mentioned inline in a blurb.

These converted variables are also mentioned in a number of other
documentation files. Below is a more thorough conversion, covering all
instances. You may want to split it up for easier review.


--- 8< ---
=46rom: =3D?UTF-8?q?Nguy=3DE1=3DBB=3D85n=3D20Th=3DC3=3DA1i=3D20Ng=3DE1=3D=
BB=3D8Dc=3D20Duy?=3D <pclouds@gmail.com>
Subject: [PATCH] *config.txt: stick to camelCase naming convention

This should improve readability. Compare "thislongname" and
"thisLongName". The following keys are left in unchanged. We can
decide what to do with them later.

 - am.keepcr
 - core.autocrlf .safecrlf .trustctime
 - diff.dirstat .noprefix
 - gitcvs.usecrlfattr
 - gui.blamehistoryctx .trustmtime
 - pull.twohead
 - receive.autogc
 - sendemail.signedoffbycc .smtpsslcertpath .suppresscc

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/CodingGuidelines     |   2 +-
 Documentation/blame-options.txt    |   2 +-
 Documentation/config.txt           | 242 ++++++++++++++++++-----------=
--------
 Documentation/diff-config.txt      |  10 +-
 Documentation/diff-options.txt     |   4 +-
 Documentation/fetch-options.txt    |   2 +-
 Documentation/git-add.txt          |   4 +-
 Documentation/git-apply.txt        |   2 +-
 Documentation/git-branch.txt       |   6 +-
 Documentation/git-check-ignore.txt |   2 +-
 Documentation/git-checkout.txt     |   4 +-
 Documentation/git-commit-tree.txt  |   2 +-
 Documentation/git-commit.txt       |   2 +-
 Documentation/git-config.txt       |   2 +-
 Documentation/git-cvsserver.txt    |  22 ++--
 Documentation/git-fetch.txt        |   2 +-
 Documentation/git-format-patch.txt |   4 +-
 Documentation/git-gc.txt           |  12 +-
 Documentation/git-init.txt         |   2 +-
 Documentation/git-instaweb.txt     |   2 +-
 Documentation/git-log.txt          |   2 +-
 Documentation/git-merge.txt        |   4 +-
 Documentation/git-pull.txt         |   2 +-
 Documentation/git-rebase.txt       |   6 +-
 Documentation/git-receive-pack.txt |   2 +-
 Documentation/git-repack.txt       |   4 +-
 Documentation/git-rerere.txt       |   2 +-
 Documentation/git-send-email.txt   |  50 ++++----
 Documentation/git-status.txt       |   4 +-
 Documentation/git-tag.txt          |   2 +-
 Documentation/git.txt              |   2 +-
 Documentation/gitattributes.txt    |   2 +-
 Documentation/gitcredentials.txt   |   2 +-
 Documentation/gitignore.txt        |   4 +-
 Documentation/gitweb.conf.txt      |   2 +-
 Documentation/merge-config.txt     |   2 +-
 Documentation/user-manual.txt      |   2 +-
 37 files changed, 212 insertions(+), 212 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
index 7636199..376d5ec 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -526,7 +526,7 @@ Writing Documentation:
  `backticks around word phrases`, do so.
    `--pretty=3Doneline`
    `git rev-list`
-   `remote.pushdefault`
+   `remote.pushDefault`
=20
  Word phrases enclosed in `backtick characters` are rendered literally
  and will not be further expanded. The use of `backticks` to achieve t=
he
diff --git a/Documentation/blame-options.txt b/Documentation/blame-opti=
ons.txt
index 0cebc4f..b299b59 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -4,7 +4,7 @@
=20
 --root::
 	Do not treat root commits as boundaries.  This can also be
-	controlled via the `blame.showroot` config option.
+	controlled via the `blame.showRoot` config option.
=20
 --show-stats::
 	Include additional statistics at the end of blame output.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1530255..d4ca046 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -225,7 +225,7 @@ See linkgit:git-update-index[1].
 +
 The default is true (when core.filemode is not specified in the config=
 file).
=20
-core.ignorecase::
+core.ignoreCase::
 	If true, this option enables various workarounds to enable
 	Git to work better on filesystems that are not case sensitive,
 	like FAT. For example, if a directory listing finds
@@ -234,12 +234,12 @@ core.ignorecase::
 	"Makefile".
 +
 The default is false, except linkgit:git-clone[1] or linkgit:git-init[=
1]
-will probe and set core.ignorecase true if appropriate when the reposi=
tory
+will probe and set core.ignoreCase true if appropriate when the reposi=
tory
 is created.
=20
-core.precomposeunicode::
+core.precomposeUnicode::
 	This option is only used by Mac OS implementation of Git.
-	When core.precomposeunicode=3Dtrue, Git reverts the unicode decomposi=
tion
+	When core.precomposeUnicode=3Dtrue, Git reverts the unicode decomposi=
tion
 	of filenames done by Mac OS. This is useful when sharing a repository
 	between Mac OS and Linux or Windows.
 	(Git for Windows 1.7.10 or higher is needed, or Git under cygwin 1.7)=
=2E
@@ -264,13 +264,13 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
=20
-core.checkstat::
+core.checkStat::
 	Determines which stat fields to match between the index
 	and work tree. The user can set this to 'default' or
 	'minimal'. Default (or explicitly 'default'), is to check
 	all fields, including the sub-second part of mtime and ctime.
=20
-core.quotepath::
+core.quotePath::
 	The commands that output paths (e.g. 'ls-files',
 	'diff'), when not given the `-z` option, will quote
 	"unusual" characters in the pathname by enclosing the
@@ -474,9 +474,9 @@ core.compression::
 	-1 is the zlib default. 0 means no compression,
 	and 1..9 are various speed/size tradeoffs, 9 being slowest.
 	If set, this provides a default to other compression variables,
-	such as 'core.loosecompression' and 'pack.compression'.
+	such as 'core.looseCompression' and 'pack.compression'.
=20
-core.loosecompression::
+core.looseCompression::
 	An integer -1..9, indicating the compression level for objects that
 	are not in a pack file. -1 is the zlib default. 0 means no
 	compression, and 1..9 are various speed/size tradeoffs, 9 being
@@ -537,7 +537,7 @@ be delta compressed, but larger binary media files =
won't be.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
=20
-core.excludesfile::
+core.excludesFile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', Git looks into this file for patterns
 	of files which are not meant to be tracked.  "`~/`" is expanded
@@ -546,7 +546,7 @@ core.excludesfile::
 	If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/ign=
ore
 	is used instead. See linkgit:gitignore[5].
=20
-core.askpass::
+core.askPass::
 	Some commands (e.g. svn and http interfaces) that interactively
 	ask for a password can be told to use an external program given
 	via the value of this variable. Can be overridden by the 'GIT_ASKPASS=
'
@@ -555,11 +555,11 @@ core.askpass::
 	prompt. The external program shall be given a suitable prompt as
 	command-line argument and write the password on its STDOUT.
=20
-core.attributesfile::
+core.attributesFile::
 	In addition to '.gitattributes' (per-directory) and
 	'.git/info/attributes', Git looks into this file for attributes
 	(see linkgit:gitattributes[5]). Path expansions are made the same
-	way as for `core.excludesfile`. Its default value is
+	way as for `core.excludesFile`. Its default value is
 	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
 	set or empty, $HOME/.config/git/attributes is used instead.
=20
@@ -569,7 +569,7 @@ core.editor::
 	variable when it is set, and the environment variable
 	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
=20
-core.commentchar::
+core.commentChar::
 	Commands such as `commit` and `tag` that lets you edit
 	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
@@ -638,7 +638,7 @@ core.whitespace::
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-ind=
ent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
=20
-core.fsyncobjectfiles::
+core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
 +
 This is a total waste of time and effort on a filesystem that orders
@@ -646,7 +646,7 @@ data writes properly, but can be useful for filesys=
tems that do not use
 journalling (traditional UNIX filesystems) or that only journal metada=
ta
 and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwriteba=
ck").
=20
-core.preloadindex::
+core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
 +
 This can speed up operations like 'git diff' and 'git status' especial=
ly
@@ -717,7 +717,7 @@ am.keepcr::
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
=20
-apply.ignorewhitespace::
+apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
 	option.
@@ -729,7 +729,7 @@ apply.whitespace::
 	Tells 'git apply' how to handle whitespaces, in the same way
 	as the '--whitespace' option. See linkgit:git-apply[1].
=20
-branch.autosetupmerge::
+branch.autoSetupMerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
 	starting point branch. Note that even if this option is not set,
@@ -741,7 +741,7 @@ branch.autosetupmerge::
 	local branch or remote-tracking
 	branch. This option defaults to true.
=20
-branch.autosetuprebase::
+branch.autoSetupRebase::
 	When a new branch is created with 'git branch' or 'git checkout'
 	that tracks another branch, this variable tells Git to set
 	up pull to rebase instead of merge (see "branch.<name>.rebase").
@@ -752,27 +752,27 @@ branch.autosetuprebase::
 	remote-tracking branches.
 	When `always`, rebase will be set to true for all tracking
 	branches.
-	See "branch.autosetupmerge" for details on how to set up a
+	See "branch.autoSetupMerge" for details on how to set up a
 	branch to track another branch.
 	This option defaults to never.
=20
 branch.<name>.remote::
 	When on branch <name>, it tells 'git fetch' and 'git push'
 	which remote to fetch from/push to.  The remote to push to
-	may be overridden with `remote.pushdefault` (for all branches).
+	may be overridden with `remote.pushDefault` (for all branches).
 	The remote to push to, for the current branch, may be further
-	overridden by `branch.<name>.pushremote`.  If no remote is
+	overridden by `branch.<name>.pushRemote`.  If no remote is
 	configured, or if you are not on any branch, it defaults to
-	`origin` for fetching and `remote.pushdefault` for pushing.
+	`origin` for fetching and `remote.pushDefault` for pushing.
 	Additionally, `.` (a period) is the current local repository
 	(a dot-repository), see `branch.<name>.merge`'s final note below.
=20
-branch.<name>.pushremote::
+branch.<name>.pushRemote::
 	When on branch <name>, it overrides `branch.<name>.remote` for
-	pushing.  It also overrides `remote.pushdefault` for pushing
+	pushing.  It also overrides `remote.pushDefault` for pushing
 	from branch <name>.  When you pull from one place (e.g. your
 	upstream) and push to another place (e.g. your own publishing
-	repository), you would want to set `remote.pushdefault` to
+	repository), you would want to set `remote.pushDefault` to
 	specify the remote to push to for all branches, and use this
 	option to override it for a specific branch.
=20
@@ -794,7 +794,7 @@ branch.<name>.merge::
 	branch.<name>.merge to the desired branch, and use the relative path
 	setting `.` (a period) for branch.<name>.remote.
=20
-branch.<name>.mergeoptions::
+branch.<name>.mergeOptions::
 	Sets default options for merging into branch <name>. The syntax and
 	supported options are the same as those of linkgit:git-merge[1], but
 	option values containing whitespace characters are currently not
@@ -938,7 +938,7 @@ color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
=20
-color.showbranch::
+color.showBranch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-show-branch[1]. May be set to `always`,
 	`false` (or `never`) or `auto` (or `true`), in which case colors are =
used
@@ -1038,7 +1038,7 @@ commit.cleanup::
 	have to remove the help lines that begin with `#` in the commit log
 	template yourself, if you do this).
=20
-commit.gpgsign::
+commit.gpgSign::
=20
 	A boolean to specify whether all commits should be GPG signed.
 	Use of this option when doing operations such as rebase can
@@ -1151,7 +1151,7 @@ format.cc::
 	by mail.  See the --to and --cc options in
 	linkgit:git-format-patch[1].
=20
-format.subjectprefix::
+format.subjectPrefix::
 	The default for format-patch is to output files with the '[PATCH]'
 	subject prefix. Use this variable to change that prefix.
=20
@@ -1161,7 +1161,7 @@ format.signature::
 	Set this variable to the empty string ("") to suppress
 	signature generation.
=20
-format.signaturefile::
+format.signatureFile::
 	Works just like format.signature except the contents of the
 	file specified by this variable will be used as the signature.
=20
@@ -1185,7 +1185,7 @@ format.thread::
 	A true boolean value is the same as `shallow`, and a false
 	value disables threading.
=20
-format.signoff::
+format.signOff::
 	A boolean value which lets you enable the `-s/--signoff` option of
 	format-patch by default. *Note:* Adding the Signed-off-by: line to a
 	patch should be a conscious act and means that you certify you have
@@ -1224,17 +1224,17 @@ gc.auto::
 	light-weight garbage collection from time to time.  The
 	default value is 6700.  Setting this to 0 disables it.
=20
-gc.autopacklimit::
+gc.autoPackLimit::
 	When there are more than this many packs that are not
 	marked with `*.keep` file in the repository, `git gc
 	--auto` consolidates them into one larger pack.  The
 	default	value is 50.  Setting this to 0 disables it.
=20
-gc.autodetach::
+gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
=20
-gc.packrefs::
+gc.packRefs::
 	Running `git pack-refs` in a repository renders it
 	unclonable by Git versions prior to 1.5.1.2 over dumb
 	transports such as HTTP.  This variable determines whether
@@ -1242,38 +1242,38 @@ gc.packrefs::
 	to enable it within all non-bare repos or it can be set to a
 	boolean value.  The default is `true`.
=20
-gc.pruneexpire::
+gc.pruneExpire::
 	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
 	Override the grace period with this config variable.  The value
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
=20
-gc.reflogexpire::
-gc.<pattern>.reflogexpire::
+gc.reflogExpire::
+gc.<pattern>.reflogExpire::
 	'git reflog expire' removes reflog entries older than
 	this time; defaults to 90 days.  With "<pattern>" (e.g.
 	"refs/stash") in the middle the setting applies only to
 	the refs that match the <pattern>.
=20
-gc.reflogexpireunreachable::
-gc.<ref>.reflogexpireunreachable::
+gc.reflogExpireUnreachable::
+gc.<ref>.reflogExpireUnreachable::
 	'git reflog expire' removes reflog entries older than
 	this time and are not reachable from the current tip;
 	defaults to 30 days.  With "<pattern>" (e.g. "refs/stash")
 	in the middle, the setting applies only to the refs that
 	match the <pattern>.
=20
-gc.rerereresolved::
+gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
 	The default is 60 days.  See linkgit:git-rerere[1].
=20
-gc.rerereunresolved::
+gc.rerereUnresolved::
 	Records of conflicted merge you have not resolved are
 	kept for this many days when 'git rerere gc' is run.
 	The default is 15 days.  See linkgit:git-rerere[1].
=20
-gitcvs.commitmsgannotation::
+gitcvs.commitMsgAnnotation::
 	Append this string to each commit message. Set to empty string
 	to disable this feature. Defaults to "via git-CVS emulator".
=20
@@ -1281,7 +1281,7 @@ gitcvs.enabled::
 	Whether the CVS server interface is enabled for this repository.
 	See linkgit:git-cvsserver[1].
=20
-gitcvs.logfile::
+gitcvs.logFile::
 	Path to a log file where the CVS server interface well... logs
 	various stuff. See linkgit:git-cvsserver[1].
=20
@@ -1293,10 +1293,10 @@ gitcvs.usecrlfattr::
 	treat it as text. If they suppress text conversion, the file
 	will be set with '-kb' mode, which suppresses any newline munging
 	the client might otherwise do. If the attributes do not allow
-	the file type to be determined, then 'gitcvs.allbinary' is
+	the file type to be determined, then 'gitcvs.allBinary' is
 	used. See linkgit:gitattributes[5].
=20
-gitcvs.allbinary::
+gitcvs.allBinary::
 	This is used if 'gitcvs.usecrlfattr' does not resolve
 	the correct '-kb' mode to use. If true, all
 	unresolved files are sent to the client in
@@ -1306,7 +1306,7 @@ gitcvs.allbinary::
 	then the contents of the file are examined to decide if
 	it is binary, similar to 'core.autocrlf'.
=20
-gitcvs.dbname::
+gitcvs.dbName::
 	Database used by git-cvsserver to cache revision information
 	derived from the Git repository. The exact meaning depends on the
 	used database driver, for SQLite (which is the default driver) this
@@ -1314,7 +1314,7 @@ gitcvs.dbname::
 	linkgit:git-cvsserver[1] for details). May not contain semicolons (`;=
`).
 	Default: '%Ggitcvs.%m.sqlite'
=20
-gitcvs.dbdriver::
+gitcvs.dbDriver::
 	Used Perl DBI driver. You can specify any available driver
 	for this here, but it might not work. git-cvsserver is tested
 	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
@@ -1322,10 +1322,10 @@ gitcvs.dbdriver::
 	May not contain double colons (`:`). Default: 'SQLite'.
 	See linkgit:git-cvsserver[1].
=20
-gitcvs.dbuser, gitcvs.dbpass::
-	Database user and password. Only useful if setting 'gitcvs.dbdriver',
+gitcvs.dbUser, gitcvs.dbPass::
+	Database user and password. Only useful if setting 'gitcvs.dbDriver',
 	since SQLite has no concept of database users and/or passwords.
-	'gitcvs.dbuser' supports variable substitution (see
+	'gitcvs.dbUser' supports variable substitution (see
 	linkgit:git-cvsserver[1] for details).
=20
 gitcvs.dbTableNamePrefix::
@@ -1336,7 +1336,7 @@ gitcvs.dbTableNamePrefix::
 	characters will be replaced with underscores.
=20
 All gitcvs variables except for 'gitcvs.usecrlfattr' and
-'gitcvs.allbinary' can also be specified as
+'gitcvs.allBinary' can also be specified as
 'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
@@ -1354,7 +1354,7 @@ gitweb.highlight::
 gitweb.patches::
 gitweb.pickaxe::
 gitweb.remote_heads::
-gitweb.showsizes::
+gitweb.showSizes::
 gitweb.snapshot::
 	See linkgit:gitweb.conf[5] for description.
=20
@@ -1383,15 +1383,15 @@ gpg.program::
 	signed, and the program is expected to send the result to its
 	standard output.
=20
-gui.commitmsgwidth::
+gui.commitMsgWidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
=20
-gui.diffcontext::
+gui.diffContext::
 	Specifies how many context lines should be used in calls to diff
 	made by the linkgit:git-gui[1]. The default is "5".
=20
-gui.displayuntracked::
+gui.displayUntracked::
 	Determines if linkgit::git-gui[1] shows untracked files
 	in the file list. The default is "true".
=20
@@ -1403,16 +1403,16 @@ gui.encoding::
 	If this option is not set, the tools default to the
 	locale encoding.
=20
-gui.matchtrackingbranch::
+gui.matchTrackingBranch::
 	Determines if new branches created with linkgit:git-gui[1] should
 	default to tracking remote branches with matching names or
 	not. Default: "false".
=20
-gui.newbranchtemplate::
+gui.newBranchTemplate::
 	Is used as suggested name when creating new branches using the
 	linkgit:git-gui[1].
=20
-gui.pruneduringfetch::
+gui.pruneDuringFetch::
 	"true" if linkgit:git-gui[1] should prune remote-tracking branches wh=
en
 	performing a fetch. The default value is "false".
=20
@@ -1420,17 +1420,17 @@ gui.trustmtime::
 	Determines if linkgit:git-gui[1] should trust the file modification
 	timestamp or not. By default the timestamps are not trusted.
=20
-gui.spellingdictionary::
+gui.spellingDictionary::
 	Specifies the dictionary used for spell checking commit messages in
 	the linkgit:git-gui[1]. When set to "none" spell checking is turned
 	off.
=20
-gui.fastcopyblame::
+gui.fastCopyBlame::
 	If true, 'git gui blame' uses `-C` instead of `-C -C` for original
 	location detection. It makes blame significantly faster on huge
 	repositories at the expense of less thorough copy detection.
=20
-gui.copyblamethreshold::
+gui.copyBlameThreshold::
 	Specifies the threshold to use in 'git gui blame' original location
 	detection, measured in alphanumeric characters. See the
 	linkgit:git-blame[1] manual for more information on copy detection.
@@ -1450,22 +1450,22 @@ guitool.<name>.cmd::
 	'FILENAME', and the name of the current branch as 'CUR_BRANCH' (if
 	the head is detached, 'CUR_BRANCH' is empty).
=20
-guitool.<name>.needsfile::
+guitool.<name>.needsFile::
 	Run the tool only if a diff is selected in the GUI. It guarantees
 	that 'FILENAME' is not empty.
=20
-guitool.<name>.noconsole::
+guitool.<name>.noConsole::
 	Run the command silently, without creating a window to display its
 	output.
=20
-guitool.<name>.norescan::
+guitool.<name>.noRescan::
 	Don't rescan the working directory for changes after the tool
 	finishes execution.
=20
 guitool.<name>.confirm::
 	Show a confirmation dialog before actually running the tool.
=20
-guitool.<name>.argprompt::
+guitool.<name>.argPrompt::
 	Request a string argument from the user, and pass it to the tool
 	through the 'ARGS' environment variable. Since requesting an
 	argument implies confirmation, the 'confirm' option has no effect
@@ -1473,13 +1473,13 @@ guitool.<name>.argprompt::
 	the dialog uses a built-in generic prompt; otherwise the exact
 	value of the variable is used.
=20
-guitool.<name>.revprompt::
+guitool.<name>.revPrompt::
 	Request a single valid revision from the user, and set the
 	'REVISION' environment variable. In other aspects this option
-	is similar to 'argprompt', and can be used together with it.
+	is similar to 'argPrompt', and can be used together with it.
=20
-guitool.<name>.revunmerged::
-	Show only unmerged branches in the 'revprompt' subdialog.
+guitool.<name>.revUnmerged::
+	Show only unmerged branches in the 'revPrompt' subdialog.
 	This is useful for tools similar to merge or rebase, but not
 	for things like checkout or reset.
=20
@@ -1489,7 +1489,7 @@ guitool.<name>.title::
=20
 guitool.<name>.prompt::
 	Specifies the general prompt string to display at the top of
-	the dialog, before subsections for 'argprompt' and 'revprompt'.
+	the dialog, before subsections for 'argPrompt' and 'revPrompt'.
 	The default value includes the actual command.
=20
 help.browser::
@@ -1501,7 +1501,7 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
=20
-help.autocorrect::
+help.autoCorrect::
 	Automatically correct and execute mistyped commands after
 	waiting for the given number of deciseconds (0.1 sec). If more
 	than one command can be deduced from the entered text, nothing
@@ -1510,7 +1510,7 @@ help.autocorrect::
 	value is 0 - the command will be just shown but not executed.
 	This is the default.
=20
-help.htmlpath::
+help.htmlPath::
 	Specify the path where the HTML documentation resides. File system pa=
ths
 	and URLs are supported. HTML pages will be prefixed with this path wh=
en
 	help is displayed in the 'web' format. This defaults to the documenta=
tion
@@ -1522,17 +1522,17 @@ http.proxy::
 	`curl(1)`).  This can be overridden on a per-remote basis; see
 	remote.<name>.proxy
=20
-http.cookiefile::
+http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
-	NOTE that the file specified with http.cookiefile is only used as
+	NOTE that the file specified with http.cookieFile is only used as
 	input unless http.saveCookies is set.
=20
-http.savecookies::
+http.saveCookies::
 	If set, store cookies received during requests to the file specified =
by
-	http.cookiefile. Has no effect if http.cookiefile is unset.
+	http.cookieFile. Has no effect if http.cookieFile is unset.
=20
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
@@ -1603,7 +1603,7 @@ http.noEPSV::
 	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
 	environment variable. Default is false (curl will use EPSV).
=20
-http.useragent::
+http.userAgent::
 	The HTTP USER_AGENT string presented to an HTTP server.  The default
 	value represents the version of the client Git such as git/1.7.1.
 	This option allows you to override this value to a more common value
@@ -1676,7 +1676,7 @@ index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
=20
-init.templatedir::
+init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
=20
@@ -1692,7 +1692,7 @@ instaweb.local::
 	If true the web server started by linkgit:git-instaweb[1] will
 	be bound to the local IP (127.0.0.1).
=20
-instaweb.modulepath::
+instaweb.modulePath::
 	The default module path for linkgit:git-instaweb[1] to use
 	instead of /usr/lib/apache2/modules.  Only used if httpd
 	is Apache.
@@ -1701,7 +1701,7 @@ instaweb.port::
 	The port number to bind the gitweb httpd to. See
 	linkgit:git-instaweb[1].
=20
-interactive.singlekey::
+interactive.singleKey::
 	In interactive commands, allow the user to provide one-letter
 	input with a single key (i.e., without hitting enter).
 	Currently this is used by the `--patch` mode of
@@ -1729,7 +1729,7 @@ log.decorate::
 	specified, the full ref name (including prefix) will be printed.
 	This is the same as the log commands '--decorate' option.
=20
-log.showroot::
+log.showRoot::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
@@ -1966,7 +1966,7 @@ pack.useBitmaps::
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
=20
-pack.writebitmaps (deprecated)::
+pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
=20
 pack.writeBitmapHashCache::
@@ -2089,10 +2089,10 @@ rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
=20
-rebase.autosquash::
+rebase.autoSquash::
 	If set to true enable '--autosquash' option by default.
=20
-rebase.autostash::
+rebase.autoStash::
 	When set to true, automatically create a temporary stash
 	before the operation begins, and apply it after the operation
 	ends.  This means that you can run rebase on a dirty worktree.
@@ -2100,7 +2100,7 @@ rebase.autostash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
=20
-receive.advertiseatomic::
+receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
 	capability to its clients. If you don't want to this capability
 	to be advertised, set this variable to false.
@@ -2110,13 +2110,13 @@ receive.autogc::
 	receiving data from git-push and updating refs.  You can stop
 	it by setting this variable to false.
=20
-receive.certnonceseed::
+receive.certNonceSeed::
 	By setting this variable to a string, `git receive-pack`
 	will accept a `git push --signed` and verifies it by using
 	a "nonce" protected by HMAC using this string as a secret
 	key.
=20
-receive.certnonceslop::
+receive.certNonceSlop::
 	When a `git push --signed` sent a push certificate with a
 	"nonce" that was issued by a receive-pack serving the same
 	repository within this many seconds, export the "nonce"
@@ -2180,7 +2180,7 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
=20
-receive.hiderefs::
+receive.hideRefs::
 	String(s) `receive-pack` uses to decide which refs to omit
 	from its initial advertisement.  Use more than one
 	definitions to specify multiple prefix strings. A ref that
@@ -2189,18 +2189,18 @@ receive.hiderefs::
 	push`, and an attempt to update or delete a hidden ref by
 	`git push` is rejected.
=20
-receive.updateserverinfo::
+receive.updateServerInfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
=20
-receive.shallowupdate::
+receive.shallowUpdate::
 	If set to true, .git/shallow can be updated when new refs
 	require new shallow roots. Otherwise those refs are rejected.
=20
-remote.pushdefault::
+remote.pushDefault::
 	The remote to push to by default.  Overrides
 	`branch.<name>.remote` for all branches, and is overridden by
-	`branch.<name>.pushremote` for specific branches.
+	`branch.<name>.pushRemote` for specific branches.
=20
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
@@ -2244,7 +2244,7 @@ remote.<name>.uploadpack::
 	The default program to execute on the remote side when fetching.  See
 	option \--upload-pack of linkgit:git-fetch-pack[1].
=20
-remote.<name>.tagopt::
+remote.<name>.tagOpt::
 	Setting this value to \--no-tags disables automatic tag following whe=
n
 	fetching from remote <name>. Setting it to \--tags will fetch every
 	tag from remote <name>, even if they are not reachable from remote
@@ -2266,7 +2266,7 @@ remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
=20
-repack.usedeltabaseoffset::
+repack.useDeltaBaseOffset::
 	By default, linkgit:git-repack[1] creates packs that use
 	delta-base offset. If you need to share your repository with
 	Git older than version 1.4.4, either directly or via a dumb
@@ -2289,7 +2289,7 @@ repack.writeBitmaps::
 	space and extra time spent on the initial repack.  Defaults to
 	false.
=20
-rerere.autoupdate::
+rerere.autoUpdate::
 	When set to true, `git-rerere` updates the index with the
 	resulting contents after it cleanly resolves conflicts using
 	previously recorded resolution.  Defaults to false.
@@ -2308,12 +2308,12 @@ sendemail.identity::
 	values in the 'sendemail' section. The default identity is
 	the value of 'sendemail.identity'.
=20
-sendemail.smtpencryption::
+sendemail.smtpEncryption::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
=20
 sendemail.smtpssl (deprecated)::
-	Deprecated alias for 'sendemail.smtpencryption =3D ssl'.
+	Deprecated alias for 'sendemail.smtpEncryption =3D ssl'.
=20
 sendemail.smtpsslcertpath::
 	Path to ca-certificates (either a directory or a single file).
@@ -2325,29 +2325,29 @@ sendemail.<identity>.*::
 	identity is selected, through command-line or
 	'sendemail.identity'.
=20
-sendemail.aliasesfile::
-sendemail.aliasfiletype::
+sendemail.aliasesFile::
+sendemail.aliasFileType::
 sendemail.annotate::
 sendemail.bcc::
 sendemail.cc::
-sendemail.cccmd::
-sendemail.chainreplyto::
+sendemail.ccCmd::
+sendemail.chainReplyTo::
 sendemail.confirm::
-sendemail.envelopesender::
+sendemail.envelopeSender::
 sendemail.from::
-sendemail.multiedit::
+sendemail.multiEdit::
 sendemail.signedoffbycc::
-sendemail.smtppass::
+sendemail.smtpPass::
 sendemail.suppresscc::
-sendemail.suppressfrom::
+sendemail.suppressFrom::
 sendemail.to::
-sendemail.smtpdomain::
-sendemail.smtpserver::
-sendemail.smtpserverport::
-sendemail.smtpserveroption::
-sendemail.smtpuser::
+sendemail.smtpDomain::
+sendemail.smtpServer::
+sendemail.smtpServerPort::
+sendemail.smtpServerOption::
+sendemail.smtpUser::
 sendemail.thread::
-sendemail.transferencoding::
+sendemail.transferEncoding::
 sendemail.validate::
 sendemail.xmailer::
 	See linkgit:git-send-email[1] for description.
@@ -2399,7 +2399,7 @@ If this variable is not specified, it defaults to=
 'normal'.
 This variable can be overridden with the -u|--untracked-files option
 of linkgit:git-status[1] and linkgit:git-commit[1].
=20
-status.submodulesummary::
+status.submoduleSummary::
 	Defaults to false.
 	If this is set to a non zero number or true (identical to -1 or an
 	unlimited number), the submodule summary will be enabled and a
@@ -2474,9 +2474,9 @@ transfer.fsckObjects::
 	not set, the value of this variable is used instead.
 	Defaults to false.
=20
-transfer.hiderefs::
-	This variable can be used to set both `receive.hiderefs`
-	and `uploadpack.hiderefs` at the same time to the same
+transfer.hideRefs::
+	This variable can be used to set both `receive.hideRefs`
+	and `uploadpack.hideRefs` at the same time to the same
 	values.  See entries for these other variables.
=20
 transfer.unpackLimit::
@@ -2491,7 +2491,7 @@ uploadarchive.allowUnreachable::
 	linkgit:git-upload-archive[1] for more details. Defaults to
 	`false`.
=20
-uploadpack.hiderefs::
+uploadpack.hideRefs::
 	String(s) `upload-pack` uses to decide which refs to omit
 	from its initial advertisement.  Use more than one
 	definitions to specify multiple prefix strings. A ref that
@@ -2501,12 +2501,12 @@ uploadpack.hiderefs::
 	fetch` will fail.  See also `uploadpack.allowtipsha1inwant`.
=20
 uploadpack.allowtipsha1inwant::
-	When `uploadpack.hiderefs` is in effect, allow `upload-pack`
+	When `uploadpack.hideRefs` is in effect, allow `upload-pack`
 	to accept a fetch request that asks for an object at the tip
 	of a hidden ref (by default, such a request is rejected).
-	see also `uploadpack.hiderefs`.
+	see also `uploadpack.hideRefs`.
=20
-uploadpack.keepalive::
+uploadpack.keepAlive::
 	When `upload-pack` has started `pack-objects`, there may be a
 	quiet period while `pack-objects` prepares the pack. Normally
 	it would output progress information, but if `--quiet` was used
@@ -2514,7 +2514,7 @@ uploadpack.keepalive::
 	the pack data begins. Some clients and networks may consider
 	the server to be hung and give up. Setting this option instructs
 	`upload-pack` to send an empty keepalive packet every
-	`uploadpack.keepalive` seconds. Setting this option to 0
+	`uploadpack.keepAlive` seconds. Setting this option to 0
 	disables keepalive packets entirely. The default is 5 seconds.
=20
 url.<base>.insteadOf::
@@ -2551,7 +2551,7 @@ user.name::
 	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
 	environment variables.  See linkgit:git-commit-tree[1].
=20
-user.signingkey::
+user.signingKey::
 	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
 	key you want it to automatically when creating a signed tag or
 	commit, you can override the default selection with this variable.
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.=
txt
index b001779..6eaa452 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -1,4 +1,4 @@
-diff.autorefreshindex::
+diff.autoRefreshIndex::
 	When using 'git diff' to compare with work tree
 	files, do not consider stat-only change as changed.
 	Instead, silently run `git update-index --refresh` to
@@ -75,11 +75,11 @@ diff.ignoreSubmodules::
 	commands such as 'git diff-files'. 'git checkout' also honors
 	this setting when reporting uncommitted changes. Setting it to
 	'all' disables the submodule summary normally shown by 'git commit'
-	and 'git status' when 'status.submodulesummary' is set unless it is
+	and 'git status' when 'status.submoduleSummary' is set unless it is
 	overridden by using the --ignore-submodules command-line option.
 	The 'git submodule' commands are not affected by this setting.
=20
-diff.mnemonicprefix::
+diff.mnemonicPrefix::
 	If set, 'git diff' uses a prefix pair that is different from the
 	standard "a/" and "b/" depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
@@ -98,7 +98,7 @@ diff.mnemonicprefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
=20
-diff.orderfile::
+diff.orderFile::
 	File indicating how to order files within a diff, using
 	one shell glob pattern per line.
 	Can be overridden by the '-O' option to linkgit:git-diff[1].
@@ -148,7 +148,7 @@ diff.<driver>.textconv::
 	conversion is used to generate a human-readable diff.  See
 	linkgit:gitattributes[5] for details.
=20
-diff.<driver>.wordregex::
+diff.<driver>.wordRegex::
 	The regular expression that the diff driver should use to
 	split words in a line.  See linkgit:gitattributes[5] for
 	details.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 6cb083a..ccd4998 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -432,8 +432,8 @@ endif::git-format-patch[]
 -O<orderfile>::
 	Output the patch in the order specified in the
 	<orderfile>, which has one shell glob pattern per line.
-	This overrides the `diff.orderfile` configuration variable
-	(see linkgit:git-config[1]).  To cancel `diff.orderfile`,
+	This overrides the `diff.orderFile` configuration variable
+	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
 	use `-O/dev/null`.
=20
 ifndef::git-format-patch[]
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index b09a783..45583d8 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -68,7 +68,7 @@ endif::git-pull[]
 	By default, tags that point at objects that are downloaded
 	from the remote repository are fetched and stored locally.
 	This option disables this automatic tag following. The default
-	behavior for a remote may be specified with the remote.<name>.tagopt
+	behavior for a remote may be specified with the remote.<name>.tagOpt
 	setting. See linkgit:git-config[1].
=20
 ifndef::git-pull[]
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 1c74907..f2eb907 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -173,7 +173,7 @@ for "git add --no-all <pathspec>...", i.e. ignored =
removed files.
 Configuration
 -------------
=20
-The optional configuration variable `core.excludesfile` indicates a pa=
th to a
+The optional configuration variable `core.excludesFile` indicates a pa=
th to a
 file containing patterns of file names to exclude from git-add, simila=
r to
 $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addit=
ion to
 those in info/exclude.  See linkgit:gitignore[5].
@@ -317,7 +317,7 @@ After deciding the fate for all hunks, if there is =
any hunk
 that was chosen, the index is updated with the selected hunks.
 +
 You can omit having to type return here, by setting the configuration
-variable `interactive.singlekey` to `true`.
+variable `interactive.singleKey` to `true`.
=20
 diff::
=20
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 9489664..d9ed6a1 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -242,7 +242,7 @@ has no effect when `--index` or `--cached` is in us=
e.
 Configuration
 -------------
=20
-apply.ignorewhitespace::
+apply.ignoreWhitespace::
 	Set to 'change' if you want changes in whitespace to be ignored by de=
fault.
 	Set to one of: no, none, never, false if you want changes in
 	whitespace to be significant.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 311b336..359619b 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -51,7 +51,7 @@ When a local branch is started off a remote-tracking =
branch, Git sets up the
 branch (specifically the `branch.<name>.remote` and `branch.<name>.mer=
ge`
 configuration entries) so that 'git pull' will appropriately merge fro=
m
 the remote-tracking branch. This behavior may be changed via the globa=
l
-`branch.autosetupmerge` configuration flag. That setting can be
+`branch.autoSetupMerge` configuration flag. That setting can be
 overridden by using the `--track` and `--no-track` options, and
 changed later using `git branch --set-upstream-to`.
=20
@@ -166,14 +166,14 @@ This option is only applicable in non-verbose mod=
e.
 	upstream when the new branch is checked out.
 +
 This behavior is the default when the start point is a remote-tracking=
 branch.
-Set the branch.autosetupmerge configuration variable to `false` if you
+Set the branch.autoSetupMerge configuration variable to `false` if you
 want `git checkout` and `git branch` to always behave as if '--no-trac=
k'
 were given. Set it to `always` if you want this behavior when the
 start-point is either a local or remote-tracking branch.
=20
 --no-track::
 	Do not set up "upstream" configuration, even if the
-	branch.autosetupmerge configuration variable is true.
+	branch.autoSetupMerge configuration variable is true.
=20
 --set-upstream::
 	If specified branch does not exist yet or if `--force` has been
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-che=
ck-ignore.txt
index 788a011..e35cd04 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -72,7 +72,7 @@ matching pattern, <source> is the pattern's source fi=
le, and <linenum>
 is the line number of the pattern within that source.  If the pattern
 contained a `!` prefix or `/` suffix, it will be preserved in the
 output.  <source> will be an absolute path when referring to the file
-configured by `core.excludesfile`, or relative to the repository root
+configured by `core.excludesFile`, or relative to the repository root
 when referring to `.git/info/exclude` or a per-directory exclude file.
=20
 If `-z` is specified, the pathnames in the output are delimited by the
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 33ad2ad..d504108 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -144,7 +144,7 @@ explicitly give a name with '-b' in such a case.
=20
 --no-track::
 	Do not set up "upstream" configuration, even if the
-	branch.autosetupmerge configuration variable is true.
+	branch.autoSetupMerge configuration variable is true.
=20
 -l::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
@@ -210,7 +210,7 @@ the conflicted merge in the specified paths.
 --conflict=3D<style>::
 	The same as --merge option above, but changes the way the
 	conflicting hunks are presented, overriding the
-	merge.conflictstyle configuration variable.  Possible values are
+	merge.conflictStyle configuration variable.  Possible values are
 	"merge" (default) and "diff3" (in addition to what is shown by
 	"merge" style, shows the original contents).
=20
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-comm=
it-tree.txt
index a469eab..f5f2a8d 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -59,7 +59,7 @@ OPTIONS
 	GPG-sign commit.
=20
 --no-gpg-sign::
-	Countermand `commit.gpgsign` configuration variable that is
+	Countermand `commit.gpgSign` configuration variable that is
 	set to force each and every commit to be signed.
=20
=20
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 1e74b75..b75a122 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -310,7 +310,7 @@ configuration variable documented in linkgit:git-co=
nfig[1].
 	GPG-sign commit.
=20
 --no-gpg-sign::
-	Countermand `commit.gpgsign` configuration variable that is
+	Countermand `commit.gpgSign` configuration variable that is
 	set to force each and every commit to be signed.
=20
 \--::
diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
index 9dfa1a5..02ec096 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -405,7 +405,7 @@ true
 % git config --bool --get-urlmatch http.sslverify https://weak.example=
=2Ecom
 false
 % git config --get-urlmatch http https://weak.example.com
-http.cookiefile /tmp/cookie.txt
+http.cookieFile /tmp/cookie.txt
 http.sslverify false
 ------------
=20
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsser=
ver.txt
index 4961f1a..2a24864 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -154,7 +154,7 @@ with CVS_SERVER (and shouldn't) as 'git-shell' unde=
rstands `cvs` to mean
    [gitcvs]
         enabled=3D1
         # optional for debugging
-        logfile=3D/path/to/logfile
+        logFile=3D/path/to/logfile
=20
 ------
 Note: you need to ensure each user that is going to invoke 'git-cvsser=
ver' has
@@ -254,14 +254,14 @@ Configuring database backend
 its documentation if changing these variables, especially
 about `DBI->connect()`.
=20
-gitcvs.dbname::
+gitcvs.dbName::
 	Database name. The exact meaning depends on the
 	selected database driver, for SQLite this is a filename.
 	Supports variable substitution (see below). May
 	not contain semicolons (`;`).
 	Default: '%Ggitcvs.%m.sqlite'
=20
-gitcvs.dbdriver::
+gitcvs.dbDriver::
 	Used DBI driver. You can specify any available driver
 	for this here, but it might not work. cvsserver is tested
 	with 'DBD::SQLite', reported to work with
@@ -271,12 +271,12 @@ gitcvs.dbdriver::
 	Default: 'SQLite'
=20
 gitcvs.dbuser::
-	Database user. Only useful if setting `dbdriver`, since
+	Database user. Only useful if setting `dbDriver`, since
 	SQLite has no concept of database users. Supports variable
 	substitution (see below).
=20
-gitcvs.dbpass::
-	Database password.  Only useful if setting `dbdriver`, since
+gitcvs.dbPass::
+	Database password.  Only useful if setting `dbDriver`, since
 	SQLite has no concept of database passwords.
=20
 gitcvs.dbTableNamePrefix::
@@ -288,7 +288,7 @@ All variables can also be set per access method, se=
e <<configaccessmethod,above>
=20
 Variable substitution
 ^^^^^^^^^^^^^^^^^^^^^
-In `dbdriver` and `dbuser` you can use the following variables:
+In `dbDriver` and `dbUser` you can use the following variables:
=20
 %G::
 	Git directory name
@@ -413,16 +413,16 @@ about end-of-line conversion.
=20
 Alternatively, if `gitcvs.usecrlfattr` config is not enabled
 or the attributes do not allow automatic detection for a filename, the=
n
-the server uses the `gitcvs.allbinary` config for the default setting.
-If `gitcvs.allbinary` is set, then file not otherwise
+the server uses the `gitcvs.allBinary` config for the default setting.
+If `gitcvs.allBinary` is set, then file not otherwise
 specified will default to '-kb' mode. Otherwise the '-k' mode
-is left blank. But if `gitcvs.allbinary` is set to "guess", then
+is left blank. But if `gitcvs.allBinary` is set to "guess", then
 the correct '-k' mode will be guessed based on the contents of
 the file.
=20
 For best consistency with 'cvs', it is probably best to override the
 defaults by setting `gitcvs.usecrlfattr` to true,
-and `gitcvs.allbinary` to "guess".
+and `gitcvs.allBinary` to "guess".
=20
 Dependencies
 ------------
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 8deb614..e62d9a0 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -26,7 +26,7 @@ By default, any tag that points into the histories be=
ing fetched is
 also fetched; the effect is to fetch tags that
 point at branches that you are interested in.  This default behavior
 can be changed by using the --tags or --no-tags options or by
-configuring remote.<name>.tagopt.  By using a refspec that fetches tag=
s
+configuring remote.<name>.tagOpt.  By using a refspec that fetches tag=
s
 explicitly, you can fetch tags that do not point into branches you
 are interested in as well.
=20
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index c0fd470..bb3ea93 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -273,13 +273,13 @@ attachments, and sign off patches with configurat=
ion variables.
 ------------
 [format]
 	headers =3D "Organization: git-foo\n"
-	subjectprefix =3D CHANGE
+	subjectPrefix =3D CHANGE
 	suffix =3D .txt
 	numbered =3D auto
 	to =3D <email>
 	cc =3D <email>
 	attach [ =3D mime-boundary-string ]
-	signoff =3D true
+	signOff =3D true
 	coverletter =3D auto
 ------------
=20
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 273c466..5223498 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -54,10 +54,10 @@ all loose objects are combined into a single pack u=
sing
 `git repack -d -l`.  Setting the value of `gc.auto` to 0
 disables automatic packing of loose objects.
 +
-If the number of packs exceeds the value of `gc.autopacklimit`,
+If the number of packs exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file)
 are consolidated into a single pack by using the `-A` option of
-'git repack'. Setting `gc.autopacklimit` to 0 disables
+'git repack'. Setting `gc.autoPackLimit` to 0 disables
 automatic consolidation of packs.
=20
 --prune=3D<date>::
@@ -101,18 +101,18 @@ branches:
 ------------
 [gc "refs/remotes/*"]
 	reflogExpire =3D never
-	reflogexpireUnreachable =3D 3 days
+	reflogExpireUnreachable =3D 3 days
 ------------
=20
-The optional configuration variable 'gc.rerereresolved' indicates
+The optional configuration variable 'gc.rerereResolved' indicates
 how long records of conflicted merge you resolved earlier are
 kept.  This defaults to 60 days.
=20
-The optional configuration variable 'gc.rerereunresolved' indicates
+The optional configuration variable 'gc.rerereUnresolved' indicates
 how long records of conflicted merge you have not resolved are
 kept.  This defaults to 15 days.
=20
-The optional configuration variable 'gc.packrefs' determines if
+The optional configuration variable 'gc.packRefs' determines if
 'git gc' runs 'git pack-refs'. This can be set to "notbare" to enable
 it within all non-bare repos or it can be set to a boolean value.
 This defaults to true.
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 369f889..8174d27 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -125,7 +125,7 @@ The template directory will be one of the following=
 (in order):
=20
  - the contents of the `$GIT_TEMPLATE_DIR` environment variable;
=20
- - the `init.templatedir` configuration variable; or
+ - the `init.templateDir` configuration variable; or
=20
  - the default template directory: `/usr/share/git-core/templates`.
=20
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instawe=
b.txt
index f3eef51..cc75b25 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -76,7 +76,7 @@ You may specify configuration in your .git/config
 	httpd =3D apache2 -f
 	port =3D 4321
 	browser =3D konqueror
-	modulepath =3D /usr/lib/apache2/modules
+	modulePath =3D /usr/lib/apache2/modules
=20
 ----------------------------------------------------------------------=
-
=20
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1f7bc67..18bc716 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -184,7 +184,7 @@ log.date::
 	`--date` option.)  Defaults to "default", which means to write
 	dates like `Sat May 8 19:35:34 2010 -0500`.
=20
-log.showroot::
+log.showRoot::
 	If `false`, `git log` and related commands will not treat the
 	initial commit as a big creation event.  Any root commits in
 	`git log -p` output would be shown without a diff attached.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index cf2c374..1f94908 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -232,7 +232,7 @@ Barbie's remark on your side.  The only thing you c=
an tell is that your
 side wants to say it is hard and you'd prefer to go shopping, while th=
e
 other side wants to claim it is easy.
=20
-An alternative style can be used by setting the "merge.conflictstyle"
+An alternative style can be used by setting the "merge.conflictStyle"
 configuration variable to "diff3".  In "diff3" style, the above confli=
ct
 may look like this:
=20
@@ -329,7 +329,7 @@ CONFIGURATION
 -------------
 include::merge-config.txt[]
=20
-branch.<name>.mergeoptions::
+branch.<name>.mergeOptions::
 	Sets default options for merging into branch <name>. The syntax and
 	supported options are the same as those of 'git merge', but option
 	values containing whitespace characters are currently not supported.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 200eb22..d3d236c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -117,7 +117,7 @@ locally created merge commits will not be flattened=
=2E
 +
 When false, merge the current branch into the upstream branch.
 +
-See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase`=
 in
+See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase`=
 in
 linkgit:git-config[1] if you want to make `git pull` always use
 `--rebase` instead of merging.
 +
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 924827d..d728030 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -207,10 +207,10 @@ rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
=20
-rebase.autosquash::
+rebase.autoSquash::
 	If set to true enable '--autosquash' option by default.
=20
-rebase.autostash::
+rebase.autoStash::
 	If set to true enable '--autostash' option by default.
=20
 OPTIONS
@@ -414,7 +414,7 @@ squash/fixup series.
 This option is only valid when the '--interactive' option is used.
 +
 If the '--autosquash' option is enabled by default using the
-configuration variable `rebase.autosquash`, this option can be
+configuration variable `rebase.autoSquash`, this option can be
 used to override and disable this setting.
=20
 --[no-]autostash::
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-rec=
eive-pack.txt
index 9016960..000ee8d 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -100,7 +100,7 @@ the following environment variables:
 	starting time is different by this many seconds from the
 	current session.  Only meaningful when
 	`GIT_PUSH_CERT_NONCE_STATUS` says `SLOP`.
-	Also read about `receive.certnonceslop` variable in
+	Also read about `receive.certNonceSlop` variable in
 	linkgit:git-config[1].
=20
 This hook is called before any refname is updated and before any
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.tx=
t
index 4786a78..0e0bd36 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -115,7 +115,7 @@ other objects in that pack they already have locall=
y.
 	Write a reachability bitmap index as part of the repack. This
 	only makes sense when used with `-a` or `-A`, as the bitmaps
 	must be able to refer to all reachable objects. This option
-	overrides the setting of `pack.writebitmaps`.
+	overrides the setting of `pack.writeBitmaps`.
=20
 --pack-kept-objects::
 	Include objects in `.keep` files when repacking.  Note that we
@@ -123,7 +123,7 @@ other objects in that pack they already have locall=
y.
 	This means that we may duplicate objects, but this makes the
 	option safe to use when there are concurrent pushes or fetches.
 	This option is generally only useful if you are writing bitmaps
-	with `-b` or `pack.writebitmaps`, as it ensures that the
+	with `-b` or `pack.writeBitmaps`, as it ensures that the
 	bitmapped packfile has the necessary objects.
=20
 Configuration
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.tx=
t
index a62227f..9ee083c 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -69,7 +69,7 @@ Prune records of conflicted merges that
 occurred a long time ago.  By default, unresolved conflicts older
 than 15 days and resolved conflicts older than 60
 days are pruned.  These defaults are controlled via the
-`gc.rerereunresolved` and `gc.rerereresolved` configuration
+`gc.rerereUnresolved` and `gc.rerereResolved` configuration
 variables respectively.
=20
=20
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index f248a86..8045546 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -47,7 +47,7 @@ Composing
 --annotate::
 	Review and edit each patch you're about to send. Default is the value
 	of 'sendemail.annotate'. See the CONFIGURATION section for
-	'sendemail.multiedit'.
+	'sendemail.multiEdit'.
=20
 --bcc=3D<address>::
 	Specify a "Bcc:" value for each email. Default is the value of
@@ -73,7 +73,7 @@ and In-Reply-To headers will be used unless they are =
removed.
 +
 Missing From or In-Reply-To headers will be prompted for.
 +
-See the CONFIGURATION section for 'sendemail.multiedit'.
+See the CONFIGURATION section for 'sendemail.multiEdit'.
=20
 --from=3D<address>::
 	Specify the sender of the emails.  If not specified on the command li=
ne,
@@ -156,31 +156,31 @@ Sending
 	subscribed to a list. In order to use the 'From' address, set the
 	value to "auto". If you use the sendmail binary, you must have
 	suitable privileges for the -f parameter.  Default is the value of th=
e
-	'sendemail.envelopesender' configuration variable; if that is
+	'sendemail.envelopeSender' configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
=20
 --smtp-encryption=3D<encryption>::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
 	value reverts to plain SMTP.  Default is the value of
-	'sendemail.smtpencryption'.
+	'sendemail.smtpEncryption'.
=20
 --smtp-domain=3D<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
 	FQDN to match your IP address.  If not set, git send-email attempts
 	to determine your FQDN automatically.  Default is the value of
-	'sendemail.smtpdomain'.
+	'sendemail.smtpDomain'.
=20
 --smtp-pass[=3D<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
-	the password. Default is the value of 'sendemail.smtppass',
+	the password. Default is the value of 'sendemail.smtpPass',
 	however '--smtp-pass' always overrides this value.
 +
 Furthermore, passwords need not be specified in configuration files
 or on the command line. If a username has been specified (with
-'--smtp-user' or a 'sendemail.smtpuser'), but no password has been
-specified (with '--smtp-pass' or 'sendemail.smtppass'), then
+'--smtp-user' or a 'sendemail.smtpUser'), but no password has been
+specified (with '--smtp-pass' or 'sendemail.smtpPass'), then
 a password is obtained using 'git-credential'.
=20
 --smtp-server=3D<host>::
@@ -188,7 +188,7 @@ a password is obtained using 'git-credential'.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
 	specify a full pathname of a sendmail-like program instead;
 	the program must support the `-i` option.  Default value can
-	be specified by the 'sendemail.smtpserver' configuration
+	be specified by the 'sendemail.smtpServer' configuration
 	option; the built-in default is `/usr/sbin/sendmail` or
 	`/usr/lib/sendmail` if such program is available, or
 	`localhost` otherwise.
@@ -199,11 +199,11 @@ a password is obtained using 'git-credential'.
 	submission port 587, or the common SSL smtp port 465);
 	symbolic port names (e.g. "submission" instead of 587)
 	are also accepted. The port can also be set with the
-	'sendemail.smtpserverport' configuration variable.
+	'sendemail.smtpServerPort' configuration variable.
=20
 --smtp-server-option=3D<option>::
 	If set, specifies the outgoing SMTP server option to use.
-	Default value can be specified by the 'sendemail.smtpserveroption'
+	Default value can be specified by the 'sendemail.smtpServerOption'
 	configuration option.
 +
 The --smtp-server-option option must be repeated for each option you w=
ant
@@ -225,8 +225,8 @@ must be used for each option.
 	be the best choice on most platforms).
=20
 --smtp-user=3D<user>::
-	Username for SMTP-AUTH. Default is the value of 'sendemail.smtpuser';
-	if a username is not specified (with '--smtp-user' or 'sendemail.smtp=
user'),
+	Username for SMTP-AUTH. Default is the value of 'sendemail.smtpUser';
+	if a username is not specified (with '--smtp-user' or 'sendemail.smtp=
User'),
 	then authentication is not attempted.
=20
 --smtp-debug=3D0|1::
@@ -247,14 +247,14 @@ Automating
 	Specify a command to execute once per patch file which
 	should generate patch file specific "Cc:" entries.
 	Output of this command must be single email address per line.
-	Default is the value of 'sendemail.cccmd' configuration value.
+	Default is the value of 'sendemail.ccCmd' configuration value.
=20
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When usin=
g
 	this, it is recommended that the first file given be an overview of t=
he
-	entire patch series. Disabled by default, but the 'sendemail.chainrep=
lyto'
+	entire patch series. Disabled by default, but the 'sendemail.chainRep=
lyTo'
 	configuration variable can be used to enable it.
=20
 --identity=3D<identity>::
@@ -304,7 +304,7 @@ specified, as well as 'body' if --no-signed-off-cc =
is specified.
=20
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
-	Default is the value of 'sendemail.suppressfrom' configuration
+	Default is the value of 'sendemail.suppressFrom' configuration
 	value; if that is unspecified, default to --no-suppress-from.
=20
 --[no-]thread::
@@ -377,15 +377,15 @@ default to '--validate'.
 CONFIGURATION
 -------------
=20
-sendemail.aliasesfile::
+sendemail.aliasesFile::
 	To avoid typing long email addresses, point this to one or more
-	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
+	email aliases files.  You must also supply 'sendemail.aliasFileType'.
=20
-sendemail.aliasfiletype::
-	Format of the file(s) specified in sendemail.aliasesfile. Must be
+sendemail.aliasFileType::
+	Format of the file(s) specified in sendemail.aliasesFile. Must be
 	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
=20
-sendemail.multiedit::
+sendemail.multiEdit::
 	If true (default), a single editor instance will be spawned to edit
 	files you have to edit (patches when '--annotate' is used, and the
 	summary when '--compose' is used). If false, files will be edited one
@@ -404,10 +404,10 @@ To use 'git send-email' to send your patches thro=
ugh the GMail SMTP server,
 edit ~/.gitconfig to specify your account settings:
=20
 	[sendemail]
-		smtpencryption =3D tls
-		smtpserver =3D smtp.gmail.com
-		smtpuser =3D yourname@gmail.com
-		smtpserverport =3D 587
+		smtpEncryption =3D tls
+		smtpServer =3D smtp.gmail.com
+		smtpUser =3D yourname@gmail.com
+		smtpServerPort =3D 587
=20
 Once your commits are ready to be sent to the mailing list, run the
 following commands:
diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index 4d8d530..b3319f7 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -77,7 +77,7 @@ configuration variable documented in linkgit:git-conf=
ig[1].
 	only changes to the commits stored in the superproject are shown (thi=
s was
 	the behavior before 1.7.0). Using "all" hides all changes to submodul=
es
 	(and suppresses the output of submodule summaries when the config opt=
ion
-	`status.submodulesummary` is set).
+	`status.submoduleSummary` is set).
=20
 --ignored::
 	Show ignored files as well.
@@ -207,7 +207,7 @@ If the config variable `status.relativePaths` is se=
t to false, then all
 paths shown are relative to the repository root, not to the current
 directory.
=20
-If `status.submodulesummary` is set to a non zero number or true (iden=
tical
+If `status.submoduleSummary` is set to a non zero number or true (iden=
tical
 to -1 or an unlimited number), the submodule summary will be enabled f=
or
 the long format and a summary of commits for modified submodules will =
be
 shown (see --summary-limit option of linkgit:git-submodule[1]). Please=
 note
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index e953ba4..bfba4ef 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -161,7 +161,7 @@ it in the repository configuration as follows:
=20
 -------------------------------------
 [user]
-    signingkey =3D <gpg-key-id>
+    signingKey =3D <gpg-key-id>
 -------------------------------------
=20
=20
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 52c4d2a..4269907 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -918,7 +918,7 @@ for further details.
 	If this environment variable is set, then Git commands which need to
 	acquire passwords or passphrases (e.g. for HTTP or IMAP authenticatio=
n)
 	will call this program with a suitable prompt as command-line argumen=
t
-	and read the password from its STDOUT. See also the 'core.askpass'
+	and read the password from its STDOUT. See also the 'core.askPass'
 	option in linkgit:git-config[1].
=20
 'GIT_TERMINAL_PROMPT'::
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index c892ffa..70899b3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -80,7 +80,7 @@ Attributes which should be version-controlled and dis=
tributed to other
 repositories (i.e., attributes of interest to all users) should go int=
o
 `.gitattributes` files. Attributes that should affect all repositories
 for a single user should be placed in a file specified by the
-`core.attributesfile` configuration option (see linkgit:git-config[1])=
=2E
+`core.attributesFile` configuration option (see linkgit:git-config[1])=
=2E
 Its default value is $XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_H=
OME
 is either not set or empty, $HOME/.config/git/attributes is used inste=
ad.
 Attributes for all users on a system should be placed in the
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcreden=
tials.txt
index 47576be..1c75be0 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -32,7 +32,7 @@ strategies to ask the user for usernames and password=
s:
    to the program on the command line, and the user's input is read
    from its standard output.
=20
-2. Otherwise, if the `core.askpass` configuration variable is set, its
+2. Otherwise, if the `core.askPass` configuration variable is set, its
    value is used as above.
=20
 3. Otherwise, if the `SSH_ASKPASS` environment variable is set, its
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 4fd0442..473623d 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -38,7 +38,7 @@ precedence, the last matching pattern decides the out=
come):
  * Patterns read from `$GIT_DIR/info/exclude`.
=20
  * Patterns read from the file specified by the configuration
-   variable 'core.excludesfile'.
+   variable 'core.excludesFile'.
=20
 Which file to place a pattern in depends on how the pattern is meant t=
o
 be used.
@@ -56,7 +56,7 @@ be used.
  * Patterns which a user wants Git to
    ignore in all situations (e.g., backup or temporary files generated=
 by
    the user's editor of choice) generally go into a file specified by
-   `core.excludesfile` in the user's `~/.gitconfig`. Its default value=
 is
+   `core.excludesFile` in the user's `~/.gitconfig`. Its default value=
 is
    $XDG_CONFIG_HOME/git/ignore. If $XDG_CONFIG_HOME is either not set =
or
    empty, $HOME/.config/git/ignore is used instead.
=20
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
index ebe7a6c..0506f07 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -706,7 +706,7 @@ show-sizes::
 	I/O.  Enabled by default.
 +
 This feature can be configured on a per-repository basis via
-repository's `gitweb.showsizes` configuration variable (boolean).
+repository's `gitweb.showSizes` configuration variable (boolean).
=20
 patches::
 	Enable and configure "patches" view, which displays list of commits i=
n email
diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index d78d6d8..8a0e52f 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,4 +1,4 @@
-merge.conflictstyle::
+merge.conflictStyle::
 	Specify the style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
 	shows a `<<<<<<<` conflict marker, changes made by one side,
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 7330d88..68978f5 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1200,7 +1200,7 @@ for other users who clone your repository.
 If you wish the exclude patterns to affect only certain repositories
 (instead of every repository for a given project), you may instead put
 them in a file in your repository named `.git/info/exclude`, or in any
-file specified by the `core.excludesfile` configuration variable.
+file specified by the `core.excludesFile` configuration variable.
 Some Git commands can also take exclude patterns directly on the
 command line.  See linkgit:gitignore[5] for the details.
=20
--=20
2.3.2.360.g1f807f9
