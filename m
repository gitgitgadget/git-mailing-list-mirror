From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Mon, 10 Dec 2007 14:51:23 +0000
Message-ID: <20071210145123.7c34af6d@pc09.procura.nl>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 15:52:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1jzq-0007lE-0D
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 15:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbXLJOvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 09:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbXLJOvt
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 09:51:49 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:3645 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbXLJOvs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 09:51:48 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBAEpNOd066091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Dec 2007 15:51:23 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vve7e49or.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.1.0cvs51 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67718>

On Tue, 04 Dec 2007 10:05:40 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > On Tue, 4 Dec 2007 15:39:47 +0000 (GMT), Johannes Schindelin
> > ...
> > I found it! unset returns false
> > ...
> > I must leave now.
> 
> Thanks, you two.
> 
> I do not see "unset VAR... &&" outside t0001 test, but there are
> instances of "unset VAR... &&" in git-submodule implementations as well.
> 
> In short, not too many places to fix.

I took the snapshot from 10-12-2007 and applied the patch below

Summary of the changes:

1 Added a section for HP-UX in the Makefile. Note that this will
  cover most of HP-UX, but might need several changes for both
  newer HP-UX versions and 64bit environments. Will come to that
  once I've got it all running

2 HP-UX does not have <sys/select.h>. I mentioned this before

3 I am willing to believe that HP_UX' vsnprintf () is broken, or
  at least does not conform to the expectations in the GNU world,
  but chickening out like the way strbuf_addf () does is maybe a
  bit too rude, so I forced a minimum of 64bytes available. That
  fixes a lot!

  but it still breaks t4013 :(

4 'tr' doesn't like '\0', but wants '\000' instead.

5 'tr' cannot deal with character classes

6 I don't know how to attack another HP specific problem: HP has
  a system command called 'patch' and it is *very* incompatible
  with GNU patch. Very. On all my systems I have GNU patch as
  'npatch', but I also know of people that have it as 'gpatch'.
  In whatever case, HP's patch will fail, so you'd have to ask
  if the poor user does have a GNU patch lying around. In t4109
  I changed the three calls to patch to calls to npatch, but did
  not include this in the patch below. Same for the single call
  in t4110.

7 What do you expect for LOCALE's? below is the first failure for
  locale testing, but there are more, like

  *** t4201-shortlog.sh ***
  t4201-shortlog.sh[22]: Invalid multibyte character.

  and somewhere inside t5100-mailinfo.sh:
  fatal: cannot convert from iso-2022-jp to utf-8

After working my way down, I stopped after hitting this:

+ git-index-pack -o tmp.idx test-2-7f8ead892057e78576c0329a70cc83afb113f117.pack
fatal: serious inflate inconsistency

inside t5300-pack-object.sh

# make configure
:
# env CC=gcc configure --prefix=/pro/local --disable-nls --without-iconv \
  --with-perl=/pro/bin/perl
:
# make
:
# make test
:
:
*** t3900-i18n-commit.sh ***
*   ok 1: setup
*   ok 2: no encoding header for base case
*   ok 3: ISO-8859-1 setup
*   ok 4: EUCJP setup
*   ok 5: ISO-2022-JP setup
*   ok 6: check encoding header for ISO-8859-1
*   ok 7: check encoding header for EUCJP
*   ok 8: check encoding header for ISO-2022-JP
*   ok 9: config to remove customization
* FAIL 10: ISO-8859-1 should be shown in UTF-8 now

                compare_with ISO-8859-1 ../t3900/1-UTF-8.txt

* FAIL 11: EUCJP should be shown in UTF-8 now

                        compare_with EUCJP ../t3900/2-UTF-8.txt

* FAIL 12: ISO-2022-JP should be shown in UTF-8 now

                        compare_with ISO-2022-JP ../t3900/2-UTF-8.txt

*   ok 13: config to add customization
*   ok 14: ISO-8859-1 should be shown in itself now
*   ok 15: EUCJP should be shown in itself now
*   ok 16: ISO-2022-JP should be shown in itself now
*   ok 17: config to tweak customization
* FAIL 18: ISO-8859-1 should be shown in UTF-8 now

                compare_with ISO-8859-1 ../t3900/1-UTF-8.txt

* FAIL 19: EUCJP should be shown in UTF-8 now

                        compare_with EUCJP ../t3900/2-UTF-8.txt

* FAIL 20: ISO-2022-JP should be shown in UTF-8 now

                        compare_with ISO-2022-JP ../t3900/2-UTF-8.txt

*   ok 21: EUCJP should be shown in EUCJP now
* FAIL 22: ISO-2022-JP should be shown in EUCJP now

                                compare_with ISO-2022-JP ../t3900/EUCJP.txt

* FAIL 23: EUCJP should be shown in ISO-2022-JP now

                                compare_with EUCJP ../t3900/ISO-2022-JP.txt

*   ok 24: ISO-2022-JP should be shown in ISO-2022-JP now
*   ok 25: No conversion with ISO-8859-1
*   ok 26: No conversion with EUCJP
*   ok 27: No conversion with ISO-2022-JP
* failed 8 among 27 test(s)
make[1]: *** [t3900-i18n-commit.sh] Error 1

# locale -a
C
POSIX
C.iso88591
C.utf8
univ.utf8
nl_NL.iso88591
nl_NL.roman8
en_GB.iso88591
en_GB.roman8
en_US.iso88591
en_US.roman8
C.iso885915
nl_NL.iso885915@euro
en_GB.iso885915@euro

--8<--- git-hpux.diff
diff -pur git-2007-12-10_01/Makefile git-2007-12-10/Makefile
--- git-2007-12-10_01/Makefile  2007-12-09 10:23:48 +0100
+++ git-2007-12-10/Makefile     2007-12-10 13:41:39 +0100
@@ -398,6 +398,18 @@ EXTLIBS =
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...

+ifeq ($(uname_S),HP-UX)
+       # HP-UX
+       BASIC_LDFLAGS += -L/usr/local/ssl/lib -L/usr/local/lib
+       #EXTLIBS += -lc_r -lgcc
+       NO_HSTRERROR = YesPlease
+       NO_ICONV = YesPlease
+       NO_INET_NTOP = YesPlease
+       NO_INET_PTON = YesPlease
+       NO_UNSETENV = YesPlease
+       NO_STRTOULL = YesPlease
+       NO_STRTOUMAX = YesPlease
+endif
 ifeq ($(uname_S),Linux)
        NO_STRLCPY = YesPlease
 endif
diff -pur git-2007-12-10_01/git-compat-util.h git-2007-12-10/git-compat-util.h
--- git-2007-12-10_01/git-compat-util.h 2007-12-09 10:23:48 +0100
+++ git-2007-12-10/git-compat-util.h    2007-12-10 14:25:26 +0100
@@ -68,7 +68,9 @@
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#ifndef _HPUX_SOURCE
 #include <sys/select.h>
+#endif
 #include <assert.h>
 #include <regex.h>
 #include <netinet/in.h>
diff -pur git-2007-12-10_01/strbuf.c git-2007-12-10/strbuf.c
--- git-2007-12-10_01/strbuf.c  2007-12-09 10:23:48 +0100
+++ git-2007-12-10/strbuf.c     2007-12-10 15:19:46 +0100
@@ -12,7 +12,7 @@ void strbuf_init(struct strbuf *sb, size
        sb->alloc = sb->len = 0;
        sb->buf = strbuf_slopbuf;
        if (hint)
-               strbuf_grow(sb, hint);
+           strbuf_grow(sb, hint);
 }

 void strbuf_release(struct strbuf *sb)
@@ -118,7 +118,7 @@ void strbuf_addf(struct strbuf *sb, cons
        int len;
        va_list ap;

-       if (!strbuf_avail(sb))
+       if (strbuf_avail(sb) < 64)
                strbuf_grow(sb, 64);
        va_start(ap, fmt);
        len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
diff -pur git-2007-12-10_01/t/t0020-crlf.sh git-2007-12-10/t/t0020-crlf.sh
--- git-2007-12-10_01/t/t0020-crlf.sh   2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t0020-crlf.sh      2007-12-10 14:25:58 +0100
@@ -5,7 +5,7 @@ test_description='CRLF conversion'
 . ./test-lib.sh

 q_to_nul () {
-       tr Q '\0'
+       tr Q '\000'
 }

 append_cr () {
diff -pur git-2007-12-10_01/t/t1300-repo-config.sh git-2007-12-10/t/t1300-repo-config.sh
--- git-2007-12-10_01/t/t1300-repo-config.sh    2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t1300-repo-config.sh       2007-12-10 09:49:48 +0100
@@ -591,12 +591,12 @@ Qsection.sub=section.val4
 Qsection.sub=section.val5Q
 EOF

-git config --null --list | tr '[\000]' 'Q' > result
+git config --null --list | tr '\000' 'Q' > result
 echo >>result

 test_expect_success '--null --list' 'cmp result expect'

-git config --null --get-regexp 'val[0-9]' | tr '[\000]' 'Q' > result
+git config --null --get-regexp 'val[0-9]' | tr '\000' 'Q' > result
 echo >>result

 test_expect_success '--null --get-regexp' 'cmp result expect'
-->8--- git-hpux.diff

Can I put the ball back in your court now?


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
