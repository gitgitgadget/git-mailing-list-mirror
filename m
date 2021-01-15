Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE90C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 16:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB43238EB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 16:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbhAOQPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 11:15:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:57395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbhAOQPE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 11:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610727205;
        bh=iOY139CeixYIPeUDl3mOBKEgQ1dfx92G6lVRbKufosg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Mz5XH4R4Y4R5kSBwv+ZyoAXfgfxHopZYRj6LdL5b4LMJpiE1bpOnTBh0C9yu/MV6r
         iE9RghLcXsECVnR0cAVeyirq7N67uGYfeRQC5PJtOHu+Pja0OS3R4+vkiRchxxuITW
         rt+BdzDb2aIHRZelzbAcbSJXe2pLKdCVknKDycZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.215.22]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS5A-1ll0kI482k-00kuMP; Fri, 15
 Jan 2021 17:13:25 +0100
Date:   Fri, 15 Jan 2021 17:13:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/11] [RFH] Introduce support for GETTEXT_POISON=rot13
In-Reply-To: <87mtxe5lhj.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101151648230.52@tvgsbejvaqbjf.bet>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com> <87mtxe5lhj.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1511489999-1610727207=:52"
X-Provags-ID: V03:K1:jCnvihgELDeG5YMUmSCQg4bxjqtdl2WYU2Hif4NbUMaTfxrRExq
 zN6T2nWm8SX0r6M/1ehdR2/1yO8LuReuEPbniIruogbXCyFJoNbAmg4fXv9XOyAQO7474Mu
 dwqvgm4GH/FplAlI6ArCM7+/cIrsdBT7Jf9AQm2Ph6LU1vOhm8gjDwDz6oeB9WKjYy8e4nT
 Kkx6YzNV4PFjmeJWiUZ6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJe8LN2ykcQ=:BvImDaAObWWz0LLrwCSa1M
 UCKD5I3c9PzlpDLnaWTOHE/BAfxde0+VMXvnKzuOGkOCRLH00Uae3zk8OGCZHGpgC9PmSrsWW
 zK8F8R9QDvo5pk6+IusfMbnc9YWdR1XOPpVxsEa2+qT9VuR8fjbQmbip9fKTEx/xGa68jZ1WH
 0sZBFlXFDdYuN3rTSTHheE0DinHXDxT8cWblnUji2WR8ig7dK57O0UJRTUUbTmHm7oIhclvXS
 j8Kur2n1J9+aBeCK2KrV7dLH4Dycblyn2NVBis9Xqx3NagNaVDJpcntA1Z3ngkjEc/0ivKSdu
 iAuDpY5cq9BjblLaCOKse2KTPARgfcKqR6f5BnOKxm1IPS1T4GiJJpD4yZ+wHbbdPDAUit4Bq
 HzG7wWmtjfyUMz0RPVcs0KizYfiyPVxs+9YRV5TJ1UMU65GbkynLxePZFoOtPUc60JvcthPdN
 wziAEOGNVgjQtwDVBDS6hG0ttUGH7BDQrKqk9D7FgTyjCcCZtpveLIc6Gog4SG5XJpkH3X3G9
 wKin2o+pMsgBtLMErHRknX34tEs8yriWKsD7YjdgHiwAlAo24FcfKrPTC/q3/KCSelXhIUoUI
 Ix+PS9348cXhBX6rSCw+HwY4HNX+nw8f+CYn5HFmX+B70Exezzt7p5y8Fn6dE9nYuZ5OyzkNx
 q/v8Ue6Gezn/+CXeKtgfvGUe/FMo3QF5mi14kShmqKSiPlT096krD9Pu1BgWMgMG72sjpR6/F
 8gZ7mng6aL5vPGkmB6XpgYYGzNchmwsYJUwyIcRe3MNFgFDaGyHqXJx7/KoqPbgvZbcQ9Pemk
 sZubmFCSTyPacaLj/Fvy53q+iv52XbVM/qkacPLgsKrq8R+OUsRQqfD0QvPVP8eYdzZjfX90Q
 EZgm6+Xmn110+KmlzgQq0jsbQG6wvhZu8GOmb311M=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1511489999-1610727207=:52
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,


On Tue, 12 Jan 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Jan 12 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > I implemented a GETTEXT_POISON=3Drot13 mode and ran the test suite to
> > see whether we erroneously expect translated messages where they
> > aren't, and related problems.
>
> I agree that rot13ing it makes it much more useful in the sense that
> before we could over-tag things with test_i18n* and we'd just "return 0"
> there in the poison mode, now we actually check if the string is
> poisoned.

Precisely.

> In our off-list discussion you maintained that
> "GIT_TEST_GETTEXT_POISON=3Dfalse <cmd>" was an anti-pattern. Was it
> because you thought "test_i18n*" et al was actually doing some "is
> poison?" [...]

I maintain this view because the whole point of having a GETTEXT_POISON
job is to have the entire test suite run in that mode. Using this
anti-pattern says to me "the author could not make this work correctly in
GETTEXT_POISON mode".

Even more, _iff_ we expect certain validations to be skipped in the
GETTEXT_POISON job, using `GIT_TEST_GETTEXT_POISON=3Dfalse` opens the
possibility that this job fails when it never should have failed.

> > And the experiment delivered. It is just a demonstration (I only addre=
ssed a
> > handful of the test suite failures, 124 test scripts still need to be
> > inspected to find out why they fail), of course. Yet I think that find=
ing
> > e.g. the missing translations of sha1dc-cb and parse-options show that=
 it
> > would be very useful to complete this patch series and then use the ro=
t13
> > mode in our CI jobs (instead of the current GETTEXT_POISON=3Dtrue mode=
, which
> > really is less useful).
>
> The following patch on top cuts down on the failures by more than half:

Interesting! I forgot the shell half... Curious that the scripted parts
_still_ affect so much of our test suite :-(

> -----------------
> diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
> index 8eef60b43f..f9239d2917 100644
> --- a/git-sh-i18n.sh
> +++ b/git-sh-i18n.sh
> @@ -17,7 +17,10 @@ export TEXTDOMAINDIR
>
>  # First decide what scheme to use...
>  GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
> -if test -n "$GIT_TEST_GETTEXT_POISON" &&
> +if test -n "$GIT_TEST_GETTEXT_POISON" -a "$GIT_TEST_GETTEXT_POISON" =3D=
 "rot13"
> +then
> +	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Drot13poison
> +elif  test -n "$GIT_TEST_GETTEXT_POISON" &&
>  	    git env--helper --type=3Dbool --default=3D0 --exit-code \
>  		GIT_TEST_GETTEXT_POISON
>  then
> @@ -63,6 +66,21 @@ gettext_without_eval_gettext)
>  		)
>  	}
>  	;;
> +rot13poison)
> +	# Emit garbage so that tests that incorrectly rely on translatable
> +	# strings will fail.
> +	gettext () {
> +		printf "%s" "# SHELL GETTEXT POISON #"
> +	}
> +
> +	eval_gettext () {
> +		printf "%s" "# SHELL GETTEXT POISON #"
> +	}
> +
> +	eval_ngettext () {
> +		printf "%s" "# SHELL GETTEXT POISON #"
> +	}

Right, and for that, I'd rather use the `test-tool i18n` helper (it is
appropriate to expect `test-tool` to be in the `PATH` in GETTEXT_POISON
mode, right?)

> +	;;
>  poison)
>  	# Emit garbage so that tests that incorrectly rely on translatable
>  	# strings will fail.
> diff --git a/t/helper/test-i18n.c b/t/helper/test-i18n.c
> index 82efc66f1f..1f0fa3d041 100644
> --- a/t/helper/test-i18n.c
> +++ b/t/helper/test-i18n.c
> @@ -1,6 +1,8 @@
>  #include "test-tool.h"
>  #include "cache.h"
>  #include "grep.h"
> +#include "config.h"
>
>  static const char *usage_msg =3D "\n"
>  "  test-tool i18n cmp <file1> <file2>\n"
> @@ -34,8 +36,12 @@ static size_t unrot13(char *buf)
>
>  		p +=3D strlen("<rot13>");
>  		end =3D strstr(p, "</rot13>");
> -		if (!end)
> -			BUG("could not find </rot13> in\n%s", buf);
> +		if (!end) {
> +			if (git_env_bool("GIT_TEST_GETTEXT_POISON_PEDANTIC", 0))
> +				BUG("could not find </rot13> in\n%s", buf);
> +			else
> +				break;
> +		}
>
>  		while (p !=3D end)
>  			*(q++) =3D do_rot13(*(p++));
> @@ -67,8 +73,12 @@ static int i18n_cmp(const char **argv)
>
>  	if (strbuf_read_file(&a, path1, 0) < 0)
>  		die_errno("could not read %s", path1);
> +	if (strstr(a.buf, "# SHELL GETTEXT POISON #"))
> +		return 0;
>  	if (strbuf_read_file(&b, path2, 0) < 0)
>  		die_errno("could not read %s", path2);
> +	if (strstr(b.buf, "# SHELL GETTEXT POISON #"))
> +		return 0;
>  	unrot13_strbuf(&b);
>
>  	if (a.len !=3D b.len || memcmp(a.buf, b.buf, a.len))
> @@ -79,7 +89,6 @@ static int i18n_cmp(const char **argv)
>
>  static int i18n_grep(const char **argv)
>  {
> -	int dont_match =3D 0;
>  	const char *pattern, *path;
>
>  	struct grep_opt opt;
> @@ -87,11 +96,6 @@ static int i18n_grep(const char **argv)
>  	struct strbuf buf =3D STRBUF_INIT;
>  	int hit;
>
> -	if (*argv && !strcmp("!", *argv)) {
> -		dont_match =3D 1;
> -		argv++;
> -	}
> -
>  	pattern =3D *(argv++);
>  	path =3D *(argv++);
>
> @@ -104,13 +108,15 @@ static int i18n_grep(const char **argv)
>
>  	if (strbuf_read_file(&buf, path, 0) < 0)
>  		die_errno("could not read %s", path);
> +	if (strstr(buf.buf, "# SHELL GETTEXT POISON #"))
> +		return 0;
>  	unrot13_strbuf(&buf);
>  	grep_source_init(&source, GREP_SOURCE_BUF, path, path, path);
>  	source.buf =3D buf.buf;
>  	source.size =3D buf.len;
>  	hit =3D grep_source(&opt, &source);
>  	strbuf_release(&buf);
> -	return dont_match ^ !hit;
> +	return !hit;
>  }
>
>  int cmd__i18n(int argc, const char **argv)
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 394fd2ef5b..6c580a3000 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1019,14 +1019,12 @@ test_i18ngrep () {
>  		BUG "too few parameters to test_i18ngrep"
>  	fi
>
> -	if test_have_prereq !C_LOCALE_OUTPUT
> +	grep_cmd=3Dgrep
> +	if test "$GIT_TEST_GETTEXT_POISON" =3D=3D "rot13"
> +	then
> +		grep_cmd=3D"test-tool i18n grep"
> +	elif test_have_prereq !C_LOCALE_OUTPUT
>  	then
> -		if test rot13 =3D "$GIT_TEST_GETTEXT_POISON"
> -		then
> -			test-tool i18n grep "$@"
> -			return $?
> -		fi
> -
>  		# pretend success
>  		return 0
>  	fi
> @@ -1034,13 +1032,13 @@ test_i18ngrep () {
>  	if test "x!" =3D "x$1"
>  	then
>  		shift
> -		! grep "$@" && return 0
> +		! $grep_cmd "$@" && return 0
>
> -		echo >&4 "error: '! grep $@' did find a match in:"
> +		echo >&4 "error: '! $grep_cmd $@' did find a match in:"
>  	else
> -		grep "$@" && return 0
> +		$grep_cmd "$@" && return 0
>
> -		echo >&4 "error: 'grep $@' didn't find a match in:"
> +		echo >&4 "error: '$grep_cmd $@' didn't find a match in:"
>  	fi
>
>  	if test -s "$last_arg"
> -----------------
>
> I.e. most of this was because you didn't add any support for this to the
> shellscript translations.
>
> We still punt on that here, it should ideally preserve the shell
> variables like the format specifiers, but I think that's not worth the
> effort with us actively cutting down our shell code to nothing.

I'm not sure how fast we'll get there, what with `git submodule` being
slow to get over the finish line, and with `mergetool`/`difftool` still
being scripted, and probably for a long time, too.

> We still have failures e.g. due to "test_i18ngrep -F fixed file" not
> being supported. Wouldn't a better/simpler approach be to just have a
> light rot13 helper, and then call the actual "cmp"/"grep" with the
> munged input/output?

Hmm. I hoped that this work would open the door to introducing more C
helpers in the test suite, thereby accelerating it on Windows.

We could also potentially move the `cmp`/`grep` parts into separate
helpers that give more useful output in case of a failure. (Right now, if
anything fails in CI involving `grep` or `cmp`, the user investigating
this pretty much _has_ to try to reproduce the issue locally because the
output is so not helpful, and reproducing it might be a challenge e.g.
when the failure is macOS-specific and the developer does not have access
to a macOS setup).

Ciao,
Dscho

--8323328-1511489999-1610727207=:52--
