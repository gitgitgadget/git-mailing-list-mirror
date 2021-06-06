Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C3C4743D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 20:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EC26139A
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 20:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFFUIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 16:08:16 -0400
Received: from mout.web.de ([212.227.17.12]:53347 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhFFUIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 16:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623009974;
        bh=KAjhYvN9E6JVjNZnQ1N6+KEUHS8sy4182kAPvgzkfJ4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OOZw7ShAqlsimQPOh//KMlRKr6PLP8CaBWIbbsyxVMcuyQnm1Xmm1DUGRX7FYyVQE
         5ufZOup9PNvKrFCz27Mdq1TMSpMUZox4R3LKMJ2e/BhS129H5wQKrT/zNOsbTA5Wlp
         izdteJD79KqHFtnPz8ArfdTxOIS9YlKubXX3FIyY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MORiL-1lkEOx0nor-005tiK; Sun, 06
 Jun 2021 22:06:14 +0200
Date:   Sun, 6 Jun 2021 22:06:13 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <ttaylorr@github.com>,
        Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] t: use user-specific utf-8 locale for testing
Message-ID: <20210606200613.muanikoqgpjsgk66@tb-raspi4>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
 <20210606163316.8630-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210606163316.8630-1-congdanhqx@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:RscTYx0LK9ec020lwTHqjJYsKDHGHpS8qCOG1/yQ4veThHNoQl3
 BjJvD/sy4pipM/bCxyz5m89S9gveDYlp6A90LgYh/dCRElbPiEwyOp41Iil4wq8b8VnXS10
 MYOxq7qK3jOoNCxB376BtD+TuwHQ4S8Top3kCU2UkspK0xWlWHD7f3poQ1+MhLoYjjN1XkM
 BEZ+8xFaA7SWTRKsbFq5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oc+qKrzx94w=:YIeYznblhYYPjSg2qS7sNZ
 ojKut4Vp4CE8iLmUK4faRyB7l+yGKAm8A0bqHK2o+iKkSoOAqZWmkSbaPu/m3bBewWu/U5RE0
 CTf+Onotosmugv2ERwSjeQ9/hGaM4mIZMqmjl1UxBUHpQrbRYkwR5Va1vrAIY7fiUij5sObh3
 s50SOTvsd0aOSHzRhYpvlN+VcP/R1ywEXpFBEuVHISkv5IDhgUv6WrUJXMRApzVRMaTY+DDgH
 M8emRNmPkGYfJwbq7toPU8+SRCpE6cOL3BJCx2QEK3OjbF/4Zzozatm+7Y6N3b4bhPmXmIzQk
 lNRo8jY0WonP5duMs0t+CNhucdAV+rqNyVl2Kt8N40aWVoWhoPlGV1/0CiBkfQf8R2AJpjN+l
 zY0yIt1jUiQlPfUfOi2xRIARjdxrBvQ/An7tECtIOyX9H2cDbUsoXhSYpSTzvs8ifaLA/dkV1
 06v1k9y/tf622uCh6JK4jFkOKVDV8DP1yKxB3ZLPXXUJ1Ho3gt/v6MEDU1zbjDBUDSOti1Y/9
 EH4cTVmrjW0UF5lMBT8eRQ+QZ29U137ape426LBw/FxKWqCHCmRC2y4kW2Vj3ueEQBO4zdd4u
 4Hmkz/vEaR2xFieJRhvp/JxdvLfy0F9PkNb48mUTwxhqY6khQ0eX3Gm4w7ZMyEg9HIlGeRNYn
 DTLVHKhb7wGRuWZwTDrGFJNW40b8MEWVeP3T1EnN9x9DSlHCWV6iY1RExT9T0WQc748k/owcu
 vti6err5r0ElCoKB8nEAKRD07ak3uCGgQkBrrI7G1ICacXp+K4yR9vCl47IByHWSV9FhPNCd3
 xddXGiZe9z3W0icwgN7yXPjovyymxfDpCPtuvl00bWpsHpm1jzB6Q3Ure7F8c5Cj15w4mFDi9
 D2xMIpJ4YipsIAPeLkdps4cnO+nQMXhhbAVZPtOl0xfgeDt9CgPGXM3uPUIjxpDMOYfBeaThB
 IyRuSUUIsTQ7WxNKZyNPa3fMpXHbco0yIzUUlq8pm58GARRqJyiyptYY2vw4weI/w6Gpmmhiq
 Y0YR0Be3+FPt8MfylOdlwi0d+1xcg3J6S8KYD0/TPumiJwX3lgcn4Zd8PmYZiMeQLiecRoBlz
 VdHoY6MFk6iZdqD6RjHBwIL2KSXg6i4EQ3i
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This all looks good.
Some suggestions about the commit message are inline.

On Sun, Jun 06, 2021 at 11:33:16PM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=
=B4ng Danh wrote:
> In some test-cases, utf-8 locale is required. To find such locale,
> we're using the first available UTF-8 locale that returned by
> "locale -a".

Good explanation.
I think that in generaral "utf-8" as a specification/specifier is better
written as "UTF-8", with uppercase.
"utf-8" or utf8 may be used inside the code, depending on the language.

>
> Despite being required by POSIX, locale(1) is unavailable in some
> systems, e.g. Linux with musl libc.  Some of those systems support
> utf-8 locale out of the box.
This reads a little bit harsh (the first sentence) and it is not
fully clear which systems do what (the second sentence).
Or are 2 things mentioned - the locale(1) utility and the support
of one UTF-8 locale "out of the box" ?
Does Linux with musl libs support an UTF-8 locale, but not
the locale(1) untility ?
Git itself supports many systems, that are not POSIX compliant,
strictly speaking. But if avaliable, the functions defined in POSIX
are used, whenever available.

Could we write:
However, the locale(1) utility is unavailable on some systems,
e.g. Linux with musl libc.

>
> However, without "locale -a", we can't guess provided UTF-8 locale.
>
> Let's give users of those systems an option to have better test
> coverage.

Add a Makefile knob GIT_TEST_UTF8_LOCALE and activate it for linux-musl

>
> This change also rename t/lib-git-svn.sh:prepare_a_utf8_locale to
> prepare_utf8_locale, since we no longer prepare the variable named
> "a_utf8_locale" but set up a fallback value for GIT_TEST_UTF8_LOCALE
> instead.  The fallback will be LC_ALL, LANG environment variable,
> or the first utf-8 locale from output of "locale -a", in that order.

rename -> renames, may be drop "This change", like this ?
Rename t/lib-git-svn.sh:prepare_a_utf8_locale into prepare_utf8_locale,
since we no longer prepare the variable named "a_utf8_locale",
but set up a fallback value for GIT_TEST_UTF8_LOCALE instead.
The fallback will be LC_ALL, LANG environment variable,
or the first UTF-8 locale from output of "locale -a", in that order.


>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gm=
ail.com>
> ---
> Range-diff against v1:
> 1:  d242ce64c4 ! 1:  f299ae2239 t: use user-specific utf-8 locale for te=
sting
>     @@ Commit message
>          Let's give users of those systems an option to have better test
>          coverage.
>
>     +    This change also rename t/lib-git-svn.sh:prepare_a_utf8_locale =
to
>     +    prepare_utf8_locale, since we no longer prepare the variable na=
med
>     +    "a_utf8_locale" but set up a fallback value for GIT_TEST_UTF8_L=
OCALE
>     +    instead.  The fallback will be LC_ALL, LANG environment variabl=
e,
>     +    or the first utf-8 locale from output of "locale -a", in that o=
rder.
>     +
>          Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <cong=
danhqx@gmail.com>
>
>       ## Makefile ##
>     @@ Makefile: all::
>       # with a different indexfile format version.  If it isn't set the =
index
>       # file format used is index-v[23].
>       #
>     -+# Define GIT_TEST_UTF8_LOCALE to prefered utf-8 locale for testing=
.
>     -+# If it isn't set, use the first utf-8 locale returned by "locale =
-a".
>     ++# Define GIT_TEST_UTF8_LOCALE to preferred utf-8 locale for testin=
g.
>     ++# If it isn't set, fallback to $LC_ALL, $LANG or use the first utf=
-8
>     ++# locale returned by "locale -a".
>      +#
>       # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
>       #
>     @@ Makefile: ifdef GIT_TEST_CMP
>       	@echo NO_GETTEXT=3D\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)=
))'\' >>$@+
>       ifdef GIT_PERF_REPEAT_COUNT
>
>     + ## ci/lib.sh ##
>     +@@ ci/lib.sh: linux-musl)
>     + 	CC=3Dgcc
>     + 	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/python3 USE_LIBPCR=
E2=3DYes"
>     + 	MAKEFLAGS=3D"$MAKEFLAGS NO_REGEX=3DYes ICONV_OMITS_BOM=3DYes"
>     ++	MAKEFLAGS=3D"$MAKEFLAGS GIT_TEST_UTF8_LOCALE=3DC.UTF-8"
>     + 	;;
>     + esac
>     +
>     +
>       ## t/lib-git-svn.sh ##
>      @@ t/lib-git-svn.sh: start_svnserve () {
>       		 --listen-host 127.0.0.1 &
>     @@ t/lib-git-svn.sh: start_svnserve () {
>      -}')
>      -	if test -n "$a_utf8_locale"
>      +prepare_utf8_locale () {
>     -+	if test -z "$GIT_TEST_UTF8_LOCALE"
>     ++	if test -n "$GIT_TEST_UTF8_LOCALE"
>     ++	then
>     ++		: test_set_prereq UTF8
>     ++	elif test -n "${LC_ALL:-$LANG}"
>      +	then
>     ++		case "${LC_ALL:-$LANG}" in
>     ++		*.[Uu][Tt][Ff]8 | *.[Uu][Tt][Ff]-8)
>     ++			GIT_TEST_UTF8_LOCALE=3D"${LC_ALL:-$LANG}"
>     ++			;;
>     ++		esac
>     ++	else
>      +		GIT_TEST_UTF8_LOCALE=3D$(locale -a | sed -n '/\.[uU][tT][fF]-*8$=
/{
>      +		p
>      +		q
>
>  Makefile                                 |  7 +++++++
>  ci/lib.sh                                |  1 +
>  t/lib-git-svn.sh                         | 24 ++++++++++++++++++------
>  t/t9100-git-svn-basic.sh                 | 14 +++-----------
>  t/t9115-git-svn-dcommit-funky-renames.sh |  6 +++---
>  t/t9129-git-svn-i18n-commitencoding.sh   |  4 ++--
>  6 files changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c3565fc0f8..502e0c9a81 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -398,6 +398,10 @@ all::
>  # with a different indexfile format version.  If it isn't set the index
>  # file format used is index-v[23].
>  #
> +# Define GIT_TEST_UTF8_LOCALE to preferred utf-8 locale for testing.
> +# If it isn't set, fallback to $LC_ALL, $LANG or use the first utf-8
> +# locale returned by "locale -a".
> +#
>  # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
>  #
>  # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
> @@ -2801,6 +2805,9 @@ ifdef GIT_TEST_CMP
>  endif
>  ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
>  	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=3DYesPlease >>$@+
> +endif
> +ifdef GIT_TEST_UTF8_LOCALE
> +	@echo GIT_TEST_UTF8_LOCALE=3D\''$(subst ','\'',$(subst ','\'',$(GIT_TE=
ST_UTF8_LOCALE)))'\' >>$@+
>  endif
>  	@echo NO_GETTEXT=3D\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\'=
 >>$@+
>  ifdef GIT_PERF_REPEAT_COUNT
> diff --git a/ci/lib.sh b/ci/lib.sh
> index d848c036c5..476c3f369f 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -229,6 +229,7 @@ linux-musl)
>  	CC=3Dgcc
>  	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/python3 USE_LIBPCRE2=3D=
Yes"
>  	MAKEFLAGS=3D"$MAKEFLAGS NO_REGEX=3DYes ICONV_OMITS_BOM=3DYes"
> +	MAKEFLAGS=3D"$MAKEFLAGS GIT_TEST_UTF8_LOCALE=3DC.UTF-8"
>  	;;
>  esac
>
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 547eb3c31a..83efc17661 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -121,12 +121,24 @@ start_svnserve () {
>  		 --listen-host 127.0.0.1 &
>  }
>
> -prepare_a_utf8_locale () {
> -	a_utf8_locale=3D$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
> -	p
> -	q
> -}')
> -	if test -n "$a_utf8_locale"
> +prepare_utf8_locale () {
> +	if test -n "$GIT_TEST_UTF8_LOCALE"
> +	then
> +		: test_set_prereq UTF8
> +	elif test -n "${LC_ALL:-$LANG}"
> +	then
> +		case "${LC_ALL:-$LANG}" in
> +		*.[Uu][Tt][Ff]8 | *.[Uu][Tt][Ff]-8)
> +			GIT_TEST_UTF8_LOCALE=3D"${LC_ALL:-$LANG}"
> +			;;
> +		esac
> +	else
> +		GIT_TEST_UTF8_LOCALE=3D$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
> +		p
> +		q
> +	}')
> +	fi
> +	if test -n "$GIT_TEST_UTF8_LOCALE"
>  	then
>  		test_set_prereq UTF8
>  	else
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index 1d3fdcc997..d5563ec35f 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -4,21 +4,13 @@
>  #
>
>  test_description=3D'git svn basic tests'
> -GIT_SVN_LC_ALL=3D${LC_ALL:-$LANG}
>
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>  . ./lib-git-svn.sh
>
> -case "$GIT_SVN_LC_ALL" in
> -*.UTF-8)
> -	test_set_prereq UTF8
> -	;;
> -*)
> -	say "# UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
> -	;;
> -esac
> +prepare_utf8_locale
>
>  test_expect_success 'git svn --version works anywhere' '
>  	nongit git svn --version
> @@ -187,8 +179,8 @@ test_expect_success POSIXPERM,SYMLINKS "$name" '
>  	test ! -h "$SVN_TREE"/exec-2.sh &&
>  	test_cmp help "$SVN_TREE"/exec-2.sh'
>
> -name=3D"commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
> -LC_ALL=3D"$GIT_SVN_LC_ALL"
> +name=3D"commit with UTF-8 message: locale: $GIT_TEST_UTF8_LOCALE"
> +LC_ALL=3D"$GIT_TEST_UTF8_LOCALE"
>  export LC_ALL
>  # This test relies on the previous test, hence requires POSIXPERM,SYMLI=
NKS
>  test_expect_success UTF8,POSIXPERM,SYMLINKS "$name" "
> diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-=
dcommit-funky-renames.sh
> index 9b44a44bc1..743fbe1fe4 100755
> --- a/t/t9115-git-svn-dcommit-funky-renames.sh
> +++ b/t/t9115-git-svn-dcommit-funky-renames.sh
> @@ -93,9 +93,9 @@ test_expect_success 'git svn rebase works inside a fre=
sh-cloned repository' '
>  # > ... All of the above characters, except for the backslash, are conv=
erted
>  # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
>  # > "Private use area") when creating or accessing files.
> -prepare_a_utf8_locale
> +prepare_utf8_locale
>  test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=
=3Dcp932 new file on dcommit' '
> -	LC_ALL=3D$a_utf8_locale &&
> +	LC_ALL=3D$GIT_TEST_UTF8_LOCALE &&
>  	export LC_ALL &&
>  	neq=3D$(printf "\201\202") &&
>  	git config svn.pathnameencoding cp932 &&
> @@ -107,7 +107,7 @@ test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'sv=
n.pathnameencoding=3Dcp932 new
>
>  # See the comment on the above test for setting of LC_ALL.
>  test_expect_success !MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=3Dcp9=
32 rename on dcommit' '
> -	LC_ALL=3D$a_utf8_locale &&
> +	LC_ALL=3D$GIT_TEST_UTF8_LOCALE &&
>  	export LC_ALL &&
>  	inf=3D$(printf "\201\207") &&
>  	git config svn.pathnameencoding cp932 &&
> diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i1=
8n-commitencoding.sh
> index 2c213ae654..01e1e8a8f7 100755
> --- a/t/t9129-git-svn-i18n-commitencoding.sh
> +++ b/t/t9129-git-svn-i18n-commitencoding.sh
> @@ -14,12 +14,12 @@ compare_git_head_with () {
>  	test_cmp current "$1"
>  }
>
> -prepare_a_utf8_locale
> +prepare_utf8_locale
>
>  compare_svn_head_with () {
>  	# extract just the log message and strip out committer info.
>  	# don't use --limit here since svn 1.1.x doesn't have it,
> -	LC_ALL=3D"$a_utf8_locale" svn log $(git svn info --url) | perl -w -e '
> +	LC_ALL=3D"$GIT_TEST_UTF8_LOCALE" svn log $(git svn info --url) | perl =
-w -e '
>  		use bytes;
>  		$/ =3D ("-"x72) . "\n";
>  		my @x =3D <STDIN>;
> --
> 2.32.0.rc3.5.gf3d78db977
>
