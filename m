From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Wed, 18 Feb 2015 17:00:07 +0100
Message-ID: <20150218170007.784be6aa@pc09.procura.nl>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/pPE8tcDG+65jAGQ4CeKbdJN"; protocol="application/pgp-signature"
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 17:07:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO7A5-0007vb-2X
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 17:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbbBRQHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 11:07:36 -0500
Received: from lb3-smtp-cloud6.xs4all.net ([194.109.24.31]:44671 "EHLO
	lb3-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751596AbbBRQHf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2015 11:07:35 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Feb 2015 11:07:34 EST
Received: from pc09.procura.nl ([82.95.216.30])
	by smtp-cloud6.xs4all.net with ESMTP
	id ts0H1p0020fvp4J01s0JnJ; Wed, 18 Feb 2015 17:00:18 +0100
In-Reply-To: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.11.1-76-gc8fc78 (GTK+ 2.24.23; x86_64-suse-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264026>

--Sig_/pPE8tcDG+65jAGQ4CeKbdJN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Dec 2014 23:46:25 -0800, Junio C Hamano <gitster@pobox.com>
wrote:

> Hello, all.
>=20
> H. Merijn Brand runs a few HP-UX boxes to help perl5 and other open
> source communities, wants help porting more recent Git on these
> boxes, running HP-UX 10.20, 11.00, and 11.23, and looking for a
> volunteer.  Please contact him directly if you are interested.

No-one. Disappointing :(

I started to work on 2.3.0 on HP-UX 11.23/63 ia64


Did *anyone* ever test with NO_ICONV?
Too many tests fail without iconv

It is *very* hard to decide from the current status if all
remaining failures are related to (Asian) locale failures and (thus)
can be safely ignored (in my environment).


Specifics at the end


FAILures from scratch with no iconv:
---------------------------------------------------------------------------=
-----
t3513-revert-submodule.sh       Tests: 14 Failed:  5 Failed tests: 1-2, 4, =
6-7                   TODO passed:   10-11
t3900-i18n-commit.sh            Tests: 34 Failed:  8 Failed tests: 15-17, 2=
3-25, 27-28
t3901-i18n-patch.sh             Tests: 15 Failed:  8 Failed tests: 2-3, 6-7=
, 9, 11, 14-15
t4041-diff-submodule-option.sh  Tests: 44 Failed:  5 Failed tests: 5-7, 9-10
t4201-shortlog.sh               Tests: 11 Failed:  1 Failed tests: 9
t4204-patch-id.sh               Tests: 15 Failed:  3 Failed tests: 7, 10, 13
t4205-log-pretty-formats.sh     Tests: 46 Failed: 20 Failed tests: 12-14, 1=
7, 19, 21, 23-29, 31, 33, 35, 37 39, 41-42
t4210-log-i18n.sh               Tests:  5 Failed:  4 Failed tests: 2-5
t5100-mailinfo.sh               Tests: 35 Failed: 11 Failed tests: 20-30
t5570-git-daemon.sh             Tests: 12 Failed:  2 Failed tests: 4-5     =
 Parse errors: No plan found in TAP output
t6006-rev-list-format.sh        Tests: 54 Failed: 11 Failed tests: 9-10, 12=
, 25-27, 30-34
t6041-bisect-submodule.sh       Tests: 14 Failed:  9 Failed tests: 1-2, 4-7=
, 12-14               TODO passed:   10-11
t7001-mv.sh                     Tests: 46 Failed:  2 Failed tests: 38-39
t7102-reset.sh                  Tests: 30 Failed:  1 Failed tests: 2
t7610-mergetool.sh              Tests: 18 Failed:  1 Failed tests: 18
t7800-difftool.sh               Tests: 56 Failed:  1 Failed tests: 49
t8005-blame-i18n.sh             Tests:  5 Failed:  3 Failed tests: 2-4
t9350-fast-export.sh            Tests: 34 Failed:  1 Failed tests: 4
Files=3D687, Tests=3D12091

FAILures from scratch with iconv:
---------------------------------------------------------------------------=
-----
t3513-revert-submodule.sh       Tests: 14 Failed:  5 Failed tests: 1-2, 4, =
6-7                   TODO passed:   10-11
t3900-i18n-commit.sh            Tests: 34 Failed:  6 Failed tests: 16-17, 2=
4-25, 27-28
t4204-patch-id.sh               Tests: 15 Failed:  3 Failed tests: 7, 10, 13
t4210-log-i18n.sh               Tests:  5 Failed:  4 Failed tests: 2-5
t5100-mailinfo.sh               Tests: 35 Failed:  2 Failed tests: 20, 23
t5536-fetch-conflicts.sh        Tests:  7 Failed:  3 Failed tests: 3, 6-7
t5570-git-daemon.sh             Tests: 12 Failed:  2 Failed tests: 4-5     =
 Parse errors: No plan found in TAP output
t6041-bisect-submodule.sh       Tests: 14 Failed:  9 Failed tests: 1-2, 4-7=
, 12-14               TODO passed:   10-11
t7001-mv.sh                     Tests: 46 Failed:  2 Failed tests: 38-39
t7610-mergetool.sh              Tests: 18 Failed:  1 Failed tests: 18
t7800-difftool.sh               Tests: 56 Failed:  1 Failed tests: 49
t8005-blame-i18n.sh             Tests:  5 Failed:  3 Failed tests: 2-4
Files=3D687, Tests=3D12091
Result: FAIL

running =C2=ABsh t****.sh -x -i=C2=BB


t/t7001-mv.t
------------
cp uses -P flag, which is unknown to HP's (non-GNU) version of cp

Changing the two occurrences from

		cp -R -P -p ../.git/modules/sub .git &&
to
		rsync -aHl ../.git/modules/sub/ .git/ &&

make the tests pass (on those systems that have a working rsync)

t/t3513-revert-submodule.sh
---------------------------
tar uses z flag, which is unknown to HP's (non-GNU) version of tar
config.mak.uname defines TAR =3D gtar, but that obviously does not help

putting GNU-tar temporary in from of my $PATH makes the test pass
/me thinks the z in not required in that test at all

	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
and
	tar xf "$TRASH_DIRECTORY/tmp.tar" &&

work just as well and prevent the breakage

t/t3900-i18n-commit.sh
----------------------
As my HP boxes have *NO* JP or other space eating asian locale stuff
installed, it is highly likely that *anything* dealing with asian
locales will fail. On modern Linux hardware, disk space is cheap. On
most HP-UX boxes disk space is expensive and when having nothing to do
with Asian languages, removing all Asian-related packages is a fast and
cheap way to regain disk space.

Changing compare_with to

compare_with () {
    case "$1$2$3" in
	*eucJP*|*ISO-2022-JP*) true ;;
	*)
	    git show -s $1 | sed -e '1,/^$/d' -e 's/^    //' >current &&
	    case "$3" in
		'')
		    test_cmp "$2" current ;;
		?*)
		    iconv -f "$3" -t UTF-8 >current.utf8 <current &&
		    iconv -f "$3" -t UTF-8 >expect.utf8 <"$2" &&
		    test_cmp expect.utf8 current.utf8
		    ;;
		esac
	    ;;
	esac
    }

makes all my tests pass

t/t4204-patch-id.sh
-------------------

No idea yet

+ test_patch_id_file_order irrelevant --stable --stable
Already on 'same'
cmp: patch-id_ordered-ordered-order---stable-irrelevant: No such file or di=
rectory

$ find * | grep 4204 | grep stable
trash directory.t4204-patch-id/patch-id_order---stable-irrelevant
trash directory.t4204-patch-id/patch-id_ordered-order---stable-irrelevant

t/t4210-log-i18n
----------------

$ dump "trash directory.t4210-log-i18n/actual"
00000000  75 74 66 38 0A                                      utf8.
$ dump "trash directory.t4210-log-i18n/expect"
00000000  6C 61 74 69 6E 31 0A 75  74 66 38 0A                latin1.utf8.
$ dump "trash directory.t4210-log-i18n/msg"
00000000  6C 61 74 69 6E 31 0A 0A  74 E9 73 74 0A             latin1..t.st.

t/t5100-mailinfo.sh
-------------------
+ git mailinfo -u rfc2047/0001-msg rfc2047/0001-patch
+ 0< rfc2047/0001 1> rfc2047/0001-info
fatal: cannot convert from US-ASCII to UTF-8
error: last command exited with $?=3D128

t/t5536-fetch-conflicts.sh
--------------------------
+ setup_repository ccc +refs/heads/branch1:refs/remotes/origin/branch1 +ref=
s/heads/branch2:refs/remotes/origin/branch1
Initialized empty Git repository in /pro/3gl/LINUX/git-2.3.0p/t/trash direc=
tory.t5536-fetch-conflicts/ccc/.git/
+ cd ccc
+ test_must_fail git fetch origin
+ 2> error
+ verify_stderr
+ 0< /var/tmp/sh6096.2
cmp: EOF on actual
error: last command exited with $?=3D1
not ok 3 - fetch conflict: config vs. config

t/t5570-git-daemon.sh
---------------------
I will ignore this myself, as I have no intention of using HP-UX as a
git server. We already have a dedicated Linux box doing so.

+ test_cmp file clone/file
ok 3 - clone git repository

expecting success:
        echo content >>file &&
        git commit -a -m two &&
        git push public &&
        (cd clone && git pull) &&
        test_cmp file clone/file

+ echo content
+ 1>> file
+ git commit -a -m two

arg sulong failed. 0, 0x9fffffffbffff058

 Setup args failed.

Pid 6238 was killed due to failure in writing to user register stack - poss=
ible stack overflow.
[master bca99f0] two
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
+ git push public

t/t6041-bisect-submodule.sh
---------------------------
config.mak.uname defines TAR =3D gtar, but that obviously does not help

+ git_bisect add_sub1
tar: z: unknown option
tar: usage  tar [-]{txruc}[eONvVwAfblhm{op}][0-7[lmh]] [tapefile] [blocksiz=
e] [[-C directory] file] ...

changing my $PATH to have a GNU tar in front makes all tests pass


t/t7610-mergetool.sh
--------------------
HP-UX' mktemp obviously is not compatible with GNU mktemp (which I have
not installed/available on HP-UX)

 SYNOPSIS
      mktemp [-c] [-d directory_name] [-p prefix]

Resolved 'subdir/file3' using previous resolution.
Automatic merge failed; fix conflicts and then commit the result.
+ git mergetool --no-prompt --tool myecho -- both
+ 1> actual
error: mktemp is needed when 'mergetool.writeToTemp' is true
error: last command exited with $?=3D1
not ok 18 - temporary filenames are used with mergetool.writeToTemp


t/t7800-difftool.sh
-------------------
HP-UX doesn't have readlink

+ git difftool --dir-diff --symlink --extcmd ./.git/CHECK_SYMLINKS branch H=
EAD
./.git/CHECK_SYMLINKS: line 5: readlink: command not found
./.git/CHECK_SYMLINKS: line 5: readlink: command not found
./.git/CHECK_SYMLINKS: line 5: readlink: command not found
/pro/3gl/LINUX/git-2.3.0p/git-difftool line 472: No such file or directory
fatal: 'difftool' appears to be a git command, but we were not
able to execute it. Maybe git-difftool is broken?
error: last command exited with $?=3D128
not ok 49 - difftool --dir-diff --symlink without unstaged changes


t/t8005-blame-i18n.sh
---------------------
SJIS again, I DO NOT CARE!

+ 1> actual
+ test_cmp actual expected
actual expected differ: char 56, line 3
error: last command exited with $?=3D1
not ok 2 - blame respects i18n.commitencoding

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.21   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/pPE8tcDG+65jAGQ4CeKbdJN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJU5LcMAAoJEAOhR6E+XcCYLXwIAJH26lrsnJseNgdvkEDQ7IoS
wyYgq+0EnNEyYp0Ek61f5HWSK57ZRv3gW+kBQ4E3IXB8Rpjadupk0qh56Wu2GBkP
97AF7glSHVY8Esc1iKnURpsON59boZGMVwlDFLQp6xtUN7jnWmEVNSRInHIzPnLv
HuohMmderNb5Rc/+S140HWbrVu7HdVxky/YTIttQvKODAacR4T+70ISTfS4BWZOY
Y9nwtYplScpCZzDUhDtN+bESwwSXts8W3uOHOkjzdjPTgkMxSihb3oD0ZqSqXvBi
8MISV2sVjzF5nhhEHafn30edj9xngXr+RjK1PbPzIsadFQ1JIDPOU1PWzP7w/8M=
=Hos6
-----END PGP SIGNATURE-----

--Sig_/pPE8tcDG+65jAGQ4CeKbdJN--
