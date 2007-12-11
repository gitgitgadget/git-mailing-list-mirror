From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 11 Dec 2007 14:33:23 +0100
Message-ID: <20071211143323.27c860db@pc09.procura.nl>
References: <20071204130922.731c407a@pc09.procura.nl>
	<Pine.LNX.4.64.0712041343040.27959@racer.site>
	<20071204140326.14d9e7a0@pc09.procura.nl>
	<Pine.LNX.4.64.0712041439590.27959@racer.site>
	<20071204150102.7f3ec3e9@pc09.procura.nl>
	<47556EE2.6040105@op5.se>
	<20071204152240.6cb6018e@pc09.procura.nl>
	<Pine.LNX.4.64.0712041536180.27959@racer.site>
	<20071204155655.053f4fb4@pc09.procura.nl>
	<7vve7e49or.fsf@gitster.siamese.dyndns.org>
	<20071210145123.7c34af6d@pc09.procura.nl>
	<7vfxy9fxh3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, arjen@yaph.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 14:34:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J25Fw-0008UK-H0
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 14:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbXLKNeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 08:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXLKNeA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 08:34:00 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:1047 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbXLKNd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 08:33:59 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBBDXOnH078869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 14:33:24 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vfxy9fxh3.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.1.0cvs70 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67853>

On Tue, 11 Dec 2007 00:26:48 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > Summary of the changes:
> >
> > 1 Added a section for HP-UX in the Makefile. Note that this will
> >   cover most of HP-UX, but might need several changes for both
> >   newer HP-UX versions and 64bit environments. Will come to that
> >   once I've got it all running
> >
> > 2 HP-UX does not have <sys/select.h>. I mentioned this before
> 
> Unfortunate.  It is even in POSIX.

The *include* file, or the function? HP-UX has the function, but
not the include file.

> But nothing "make -DNO_SYS_SELECT=Unfortunately" cannot fix.

I didn't see any #ifdef/#ifndef around the include, otherwise I
would have found that already I think.

> > 3 I am willing to believe that HP_UX' vsnprintf () is broken, or
> >   at least does not conform to the expectations in the GNU world,
> >   but chickening out like the way strbuf_addf () does is maybe a
> >   bit too rude, so I forced a minimum of 64bytes available. That
> >   fixes a lot!
> >
> >   but it still breaks t4013 :(
> 
> I think Shawn had something similar for Solaris, and if it is a small
> cost to help portability, it does not feel so bad.

:)

> > 4 'tr' doesn't like '\0', but wants '\000' instead.
> > 5 'tr' cannot deal with character classes
> 
> Ok, that's odd (and not old fashioned, which makes even odder), but
> "\000" is not too bad (unless we have to do that million places).

> perl -MFile::Find -e'find(sub{m/\.sh$/ or return;local@ARGV=($_);while(<>){/\btr\b.*\\\d(?\!\d\d)/&&print"$File::Find::name\t$.\t$_"}},".")'
./git-filter-branch.sh  293                     git diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
./test-sha1.sh  13                              tr '[\0]' '[g]'
./test-sha1.sh  58                              tr '[\0]' '[g]'
./t/diff-lib.sh 24          tr '\0' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
./t/diff-lib.sh 25          tr '\0' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
./t/t2001-checkout-cache-clash.sh       33              sed -e 's/^\([0-9]*\)   [^ ]*   [0-9a-f]*       /tr: \1 /'
./t/t3300-funny-names.sh        57              'git ls-files -z | tr \\0 \\012 >current &&
./t/t3300-funny-names.sh        86              'git diff-index -z --name-status $t0 | tr \\0 \\012 >current &&
./t/t3300-funny-names.sh        90              'git diff-tree -z --name-status $t0 $t1 | tr \\0 \\012 >current &&
./t/t4020-diff-external.sh      102     echo NULZbetweenZwords | tr Z '\0' > file
./t/t4103-apply-binary.sh       27      tr 'x' '\0' <file1 >file3
./t/t4103-apply-binary.sh       30      tr '\0' 'v' <file3 >file1
./t/t4116-apply-reverse.sh      15              tr "[ijk]" '\''[\0\1\2]'\'' <file1 >file2 &&
./t/t4116-apply-reverse.sh      22              tr "[mon]" '\''[\0\1\2]'\'' <file1 >file2 &&
./t/t4200-rerere.sh     132     echo "$sha1     a1" | tr '\012' '\0' > .git/rr-cache/MERGE_RR
./t/t5300-pack-object.sh        18                   dd if=/dev/zero bs=4k count=1 | tr "\\0" $i >$i &&

So with the recent history in the back of my mind, I'd expect all tr commands
with character class like notations to fail. Patch below.

> > 6 I don't know how to attack another HP specific problem: HP has
> >   a system command called 'patch' and it is *very* incompatible
> >   with GNU patch. Very.
> 
> I do not think there is any reason for us to rely on "GNU patch"
> anymore.  4109 can have precomputed test vector instead of comparing our
> output with what GNU patch of the day happens to do.

\o/

> > 7 What do you expect for LOCALE's?
> 
> I am not opposed to a change that makes these tests to conditionally
> skip on systems (not necessarily "platforms" but individual
> "installations") that do not have locales necessary to run tests
> installed, just like cvs or svn tests are skipped when they are not
> installed.  Especially you are not using iconv...

\o/

BTW it is rather unlikely to find Tcl and/or Tk on most HP-UX systems.
Having perl already required, would you cheer an attempt to rewrite
git-gui to Perl/Tk? (I didn't have a look at it yet, but that should
make git-gui an awful lot more portable and when used on windows with
ActivePerl, Tk is already available in all builds)


I have put the output of

% make -i test | & perl -ne'm/^\*\s+ok\s+\d+:/ or print' > git-make-test.log

on http://www.xs4all.nl/~procura/git-make-test.log

which leaves only the following tests as failures:

t3901-i18n-patch.sh        t4201-shortlog.sh            t5100-mailinfo.sh
t5405-send-pack-rewind.sh  t5500-fetch-pack.sh          t5505-remote.sh
t5510-fetch.sh             t5515-fetch-merge-logic.sh   t5516-fetch-push.sh
t5520-pull.sh              t5600-clone-fail-cleanup.sh  t5700-clone-reference.sh
t5701-clone-local.sh       t6002-rev-list-bisect.sh     t6003-rev-list-topo-order.sh
t6022-merge-rename.sh      t6026-merge-attr.sh          t6200-fmt-merge-msg.sh
t7003-filter-branch.sh     t9300-fast-import.sh         t9301-fast-export.sh
t9500-gitweb-standalone-no-errors.sh

How close am I to success?



--8<--- git-tr.diff
--- git-2007-12-10_01/git-filter-branch.sh      2007-12-09 10:23:48 +0100
+++ git-2007-12-10/git-filter-branch.sh 2007-12-11 13:39:02 +0100
@@ -290,7 +290,7 @@ while read commit parents; do
                eval "$filter_tree" < /dev/null ||
                        die "tree filter failed: $filter_tree"

-               git diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
+               git diff-index -r $commit | cut -f 2- | tr '\n' '\000' | \
                        xargs -0 git update-index --add --replace --remove
                git ls-files -z --others | \
                        xargs -0 git update-index --add --replace --remove
--- git-2007-12-10_01/test-sha1.sh      2007-12-09 10:23:48 +0100
+++ git-2007-12-10/test-sha1.sh 2007-12-11 13:39:29 +0100
@@ -10,7 +10,7 @@ do
                {
                        test -z "$pfx" || echo "$pfx"
                        dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-                       tr '[\0]' '[g]'
+                       tr '\000' 'g'
                } | ./test-sha1 $cnt
        `
        if test "$expect" = "$actual"
@@ -55,7 +55,7 @@ do
                {
                        test -z "$pfx" || echo "$pfx"
                        dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-                       tr '[\0]' '[g]'
+                       tr '\000' 'g'
                } | sha1sum |
                sed -e 's/ .*//'
        `
--- git-2007-12-10_01/t/diff-lib.sh     2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/diff-lib.sh        2007-12-11 13:39:56 +0100
@@ -21,8 +21,8 @@ compare_diff_raw_z () {
     # Also we do not check SHA1 hash generation in this test, which
     # is a job for t0000-basic.sh

-    tr '\0' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
-    tr '\0' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
+    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
+    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
     git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }

--- git-2007-12-10_01/t/t3300-funny-names.sh    2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t3300-funny-names.sh       2007-12-11 13:40:32 +0100
@@ -54,7 +54,7 @@ echo 'just space
 no-funny
 tabs   ," (dq) and spaces' >expected
 test_expect_success 'git ls-files -z with-funny' \
-       'git ls-files -z | tr \\0 \\012 >current &&
+       'git ls-files -z | tr \\000 \\012 >current &&
        git diff expected current'

 t1=`git write-tree`
@@ -83,11 +83,11 @@ test_expect_success 'git diff-tree with-
 echo 'A
 tabs   ," (dq) and spaces' >expected
 test_expect_success 'git diff-index -z with-funny' \
-       'git diff-index -z --name-status $t0 | tr \\0 \\012 >current &&
+       'git diff-index -z --name-status $t0 | tr \\000 \\012 >current &&
        git diff expected current'

 test_expect_success 'git diff-tree -z with-funny' \
-       'git diff-tree -z --name-status $t0 $t1 | tr \\0 \\012 >current &&
+       'git diff-tree -z --name-status $t0 $t1 | tr \\000 \\012 >current &&
        git diff expected current'

 cat > expected <<\EOF
--- git-2007-12-10_01/t/t4020-diff-external.sh  2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t4020-diff-external.sh     2007-12-11 13:40:44 +0100
@@ -99,7 +99,7 @@ test_expect_success 'no diff with -diff'
        git diff | grep Binary
 '

-echo NULZbetweenZwords | tr Z '\0' > file
+echo NULZbetweenZwords | tr Z '\000' > file

 test_expect_success 'force diff with "diff"' '
        echo >.gitattributes "file diff" &&
--- git-2007-12-10_01/t/t4103-apply-binary.sh   2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t4103-apply-binary.sh      2007-12-11 13:40:57 +0100
@@ -24,10 +24,10 @@ git update-index --add --remove file1 fi
 git-commit -m 'Initial Version' 2>/dev/null

 git-checkout -b binary
-tr 'x' '\0' <file1 >file3
+tr 'x' '\000' <file1 >file3
 cat file3 >file4
 git add file2
-tr '\0' 'v' <file3 >file1
+tr '\000' 'v' <file3 >file1
 rm -f file2
 git update-index --add --remove file1 file2 file3 file4
 git-commit -m 'Second Version'
--- git-2007-12-10_01/t/t4116-apply-reverse.sh  2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t4116-apply-reverse.sh     2007-12-11 13:42:13 +0100
@@ -12,14 +12,14 @@ test_description='git apply in reverse
 test_expect_success setup '

        for i in a b c d e f g h i j k l m n; do echo $i; done >file1 &&
-       tr "[ijk]" '\''[\0\1\2]'\'' <file1 >file2 &&
+       tr "ijk" '\''\000\001\002'\'' <file1 >file2 &&

        git add file1 file2 &&
        git commit -m initial &&
        git tag initial &&

        for i in a b c g h i J K L m o n p q; do echo $i; done >file1 &&
-       tr "[mon]" '\''[\0\1\2]'\'' <file1 >file2 &&
+       tr "mon" '\''\000\001\002'\'' <file1 >file2 &&

        git commit -a -m second &&
        git tag second &&
--- git-2007-12-10_01/t/t4200-rerere.sh 2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t4200-rerere.sh    2007-12-11 13:42:28 +0100
@@ -129,7 +129,7 @@ test_expect_success 'rerere kicked in' "
 test_expect_success 'rerere prefers first change' 'git diff a1 expect'

 rm $rr/postimage
-echo "$sha1    a1" | tr '\012' '\0' > .git/rr-cache/MERGE_RR
+echo "$sha1    a1" | tr '\012' '\000' > .git/rr-cache/MERGE_RR

 test_expect_success 'rerere clear' 'git rerere clear'

--- git-2007-12-10_01/t/t5300-pack-object.sh    2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t5300-pack-object.sh       2007-12-11 13:42:46 +0100
@@ -15,7 +15,7 @@ test_expect_success \
     'rm -f .git/index*
      for i in a b c
      do
-            dd if=/dev/zero bs=4k count=1 | tr "\\0" $i >$i &&
+            dd if=/dev/zero bs=4k count=1 | tr "\\000" $i >$i &&
             git update-index --add $i || return 1
      done &&
      cat c >d && echo foo >>d && git update-index --add d &&
-->8--- git-tr.diff


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
