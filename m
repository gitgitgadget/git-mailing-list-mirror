From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [fyi] patches used by git distributors
Date: Thu, 10 Nov 2011 13:07:10 +0100
Message-ID: <CABPQNSbUTrckA+ZEmY6ge8C8bvOGbNXb3E+8VtH9xjc3GLpAug@mail.gmail.com>
References: <20111108090251.GB17954@elie.hsd1.il.comcast.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 13:07:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROTQE-0006yO-3x
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 13:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395Ab1KJMHx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 07:07:53 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:49992 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab1KJMHv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2011 07:07:51 -0500
Received: by pzk36 with SMTP id 36so970439pzk.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 04:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=60AZN0eQPWM0dmOmPUnngbfdn0mi5yGopHa+OuNYwCE=;
        b=H7QLgNZ2H8rA1XM1+NnFvkJPKBMo9KJIDFyjvs6oEZqH2N9Qtk+2fVgEzr+86jqlUq
         tilFPRzIN14C7DVodDdILB4dc5+5lKSBwOiZk7iPUQnFSQFc4dmR4WOtji0cifWnE3O3
         bwM5wJcnX7c0a/SZye4uhBLry2f627c6MJrYI=
Received: by 10.68.72.104 with SMTP id c8mr14345539pbv.34.1320926871074; Thu,
 10 Nov 2011 04:07:51 -0800 (PST)
Received: by 10.68.71.135 with HTTP; Thu, 10 Nov 2011 04:07:10 -0800 (PST)
In-Reply-To: <20111108090251.GB17954@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185225>

On Tue, Nov 8, 2011 at 10:02 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> In an ideal world, each patch applied by downstream distributors woul=
d
> fall into one of two categories: (a) adapting the package to some
> esoteric distro-specific requirement (i.e., special-interest patches)
> or (b) in the process of being generalized and reviewed for eventual
> application upstream, so everyone can benefit from it. =A0Unfortunate=
ly
> that takes time. =A0I should do better --- sorry about that.
>
> As an experiment, here's a quick summary of the patches being used
> in Debian, for people curious about that and for people interested in
> grabbing useful patches to polish and not knowing where to start.
>
> (Links point to relevant discussion, not necessarily the patch used):
>
> Fr=E9d=E9ric Bri=E8re (1):
> =A0 =A0 =A0gitk: Skip over AUTHOR/COMMIT_DATE when searching all fiel=
ds [1]
>
> Gerrit Pape (1):
> =A0 =A0 =A0bug#506445: hooks/post-receive-email: set encoding to utf-=
8 [2]
>
> Jonathan Nieder (12):
> =A0 =A0 =A0remove shebang line from shell libraries [3]
> =A0 =A0 =A0pre-rebase hook: capture documentation in a <<here documen=
t [4]
> =A0 =A0 =A0gitk: use symbolic font names "sans" and "monospace"
> =A0 =A0 =A0transport: expose git_tcp_connect and friends in new tcp.h=
 [5]
> =A0 =A0 =A0daemon: make host resolution into a separate function [5]
> =A0 =A0 =A0daemon: move locate_host to tcp.c [5]
> =A0 =A0 =A0tcp: unify ipv4 and ipv6 code paths [5]
> =A0 =A0 =A0daemon: check for errors retrieving IP address [5]
> =A0 =A0 =A0tcp: make dns_resolve return an error code [5]
> =A0 =A0 =A0transport: optionally honor DNS SRV records [5]
> =A0 =A0 =A0srv: make errors less quiet [5]
> =A0 =A0 =A0Makefile: add a knob to turn off hardlinks within same dir=
ectory [6]
>
> The patches listed above are on the candidate+patches branch of [7].
> Questions and improvements can go to git@packages.debian.org.
>
> A few other packaging projects:
>
> =A0- git://pkgs.fedoraproject.org/git.git master --- 3 patches (using
> =A0 SERVER_NAME for home link, reviving vc-git.el, compatibility with
> =A0 newer cvsps)
> =A0- http://www.freebsd.org/cgi/cvsweb.cgi/ports/devel/git/files/ ---
> =A0 1 patch (capping individual reads and writes at INT_MAX chars)
> =A0- https://build.opensuse.org/package/files?package=3Dgit&project=3D=
devel%3Atools%3Ascm
> =A0 --- 4 patches (a python build fix, making gitweb::prevent_xss
> =A0 default to true, turning off hardlinks for builtins at installati=
on
> =A0 time, protecting COMP_WORDBREAKS from mangling in the completion
> =A0 script)
> =A0- http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/dev-vcs/=
git/files/
> =A0 --- 1 patch (a NO_CVS knob for the makefile). =A0Very nice.
> =A0- http://cvsweb.netbsd.org/bsdweb.cgi/pkgsrc/devel/scmgit-base/pat=
ches/
> =A0 --- 3 patches (putting CFLAGS at the end of ALL_CFLAGS so it can
> =A0 override BASIC_CFLAGS, setting INSTALLDIRS=3Dvendor in perl makef=
ile,
> =A0 improving tk support on Darwin 8)
> =A0- http://www.openbsd.org/cgi-bin/cvsweb/ports/devel/git/patches/ -=
--
> =A0 8 patches (updating OpenBSD makefile defaults, using raw perlio i=
n
> =A0 gitweb blob view, removing "set -e" in t9117, passing --text [wel=
l,
> =A0 -a] to grep in t9200, avoiding nonportable regex \+ in t9400)
> =A0- ftp://ftp.cygwin.org/pub/cygwin/release/git/git-1.7.5.1-1-src.ta=
r.bz2
> =A0 --- 3 patches (tcl 8.4.1 support, updating Cygwin makefile defaul=
ts,
> =A0 case-insensitive path comparison in makefile, special Windows-spe=
cific
> =A0 wish script preamble)
>

Here's what we have for msysGit (the commits themselves can be found
in git://github.com/msysgit/git.git devel):

$ git log --no-merges --first-parent --oneline 319312f..origin/devel
9e47e31 Unicode console: fix font warning on Vista and Win7
778774d MSVC: require pton and ntop emulation
a49c818 MSVC: fix winansi.c compile errors
9ca8039 MSVC: fix poll-related macro redefines
0a6d148 MSVC: Remove unneeded header stubs
18f5b9e Compile fix for MSVC: Include <io.h>
fd6f6aa Compile fix for MSVC: Do not include sys/resources.h
ae69aaf Handle the branch.<name>.rebase value 'interactive'
5d1168b Teach 'git pull' to handle --rebase=3Dinteractive
5d6f1d9 Windows: define S_ISUID properly
5084033 Fixed wrong path delimiter in exe finding
77a30da gitweb (SyntaxHighlighter): interpret #l<line-number>
4654bdd Only switch on the line number toggle when highlighting is acti=
vated
3efcd98 Gitweb: add support for Alex Gorbatchev's SyntaxHighlighter in
Javascript
1d9ac66 MinGW: disable CRT command line globbing
e0f2492 Win32: move main macro to a function
8258c82 Win32: fix potential multi-threading issue
c45b052 Win32 dirent: improve dirent implementation
ab7ab7a Win32 dirent: clarify #include directives
9d46513 Win32 dirent: change FILENAME_MAX to MAX_PATH
18cf321 Win32 dirent: remove unused dirent.d_reclen member
2741409 Win32 dirent: remove unused dirent.d_ino member
a27af5c Revert "MinGW: Add missing file mode bit defines"
3e4b790 submodule: Fix t7400, t7405, t7406 for msysGit
f72cc9a t5407: Fix line-ending dependency in post-rewrite.args
77de716 submodule: Use cat instead of echo to avoid DOS line-endings
fece0cb t3102: Windows filesystems may not use a literal asterisk in fi=
lenames.
d3abd84 Disable test on MinGW that challenges its bash quoting
3f65607 MinGW: Skip test redirecting to fd 4
2e1f250 mingw: do not hide bare repositories
8089c85c Git.pm: Use stream-like writing in cat_blob()
d3d677e Amend "git grep -O -i: if the pager is 'less', pass the '-i' op=
tion"
ed7b275 git grep -O -i: if the pager is 'less', pass the '-i' option
30d3f9e Handle new t1501 test case properly with MinGW
64f7bec Do not compile compat/**/*.c with -Wold-style-definition
68acf50 Fix old-style function declaration
aa1c11f Make CFLAGS more strict
c592e94 grep -I: do not bother to read known-binary files
352f3d0 Let deny.currentBranch=3DupdateInstead ignore submodules
5cf00b3 add -e: ignore dirty submodules
bf239f8 Handle http.* config variables pointing to files gracefully on =
Windows
621a958 Gitweb: make line number toggling work for Firefox and Safari
ff19df4 gitweb: Allow line number toggling with Javascript
feab003 Give commit message reencoding for output on MinGW a chance
6f86c3e Warn if the Windows console font doesn't support Unicode
bfcdc94 Detect console streams more reliably on Windows
9b505ab Support Unicode console output on Windows
e3356ac Enable color output in Windows cmd.exe
3bef266 Fix another invocation of git from gitk with an overly long com=
mand-line
d0a4bbe git gui: set GIT_ASKPASS=3Dgit-gui--askpass if not set yet
7602e52 Make mingw_offset_1st_component() behave consistently for all p=
aths.
1c072a6 config.c: trivial fix for compile-time warning
1f3a4f8 Allow using UNC path for git repository
3d08379 work around misdetection of stdin attached to a tty
fef92f8 git am: ignore dirty submodules
d23ce6f t7602: cope with CR/LF
3649391 Add a Windows-specific fallback to getenv("HOME");
ede54b1 send-email: handle Windows paths for display just like we do
for processing
32eefc4 send-email: accept absolute path even on Windows
6274596 Add a few more values for receive.denyCurrentBranch
2afff36 Work around funny CR issue
b81e593 mingw: add tests for the hidden attribute on the git directory
f9445e4 Work around the command line limit on Windows
59e0e60 git-gui: provide question helper for retry fallback on Windows
9e89381 Revert "git-gui: set GIT_DIR and GIT_WORK_TREE after setup"
40e6ef7 criss cross rename failure workaround
d24ec01 When initializing .git/, record the current setting of core.hid=
eDotFiles
c40046b core.hidedotfiles: hide '.git' dir by default
73afc46 MinGW: Add missing file mode bit defines

Some of these might be useful for upstream as well...
