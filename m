Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D231F462
	for <e@80x24.org>; Wed, 12 Jun 2019 19:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfFLTvt (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 15:51:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:36749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfFLTvs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 15:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560369094;
        bh=3YOsD3TrzJvce07Ux2mO/vwzg3wrE92V0tEl+Cd547w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RZ8zxeUy5jFywslRAx6lkTLdwPNGqFxOzXrqwLhWzn9wheKEtywuu3tna3If4xNnI
         tKrtVVfhzX3gVlWc37UXZoRHVMqogZUGhX2dzzsgBOWQe96VI2YoPUKi/Ne0l/XWI3
         PbpnULKqbDmTT5CIoC5IjUabdVzB2BqfVxM+qpBg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1iSYqa1m0A-00rZWE; Wed, 12
 Jun 2019 21:51:34 +0200
Date:   Wed, 12 Jun 2019 21:51:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     Matthew DeVore <matvore@google.com>
cc:     git@vger.kernel.org, avarab@gmail.com, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        gitster@pobox.com, karthik.188@gmail.com, pclouds@gmail.com,
        sunshine@sunshineco.com, emilyshaffer@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 1/1] ref-filter: sort detached HEAD lines firstly
In-Reply-To: <cf0246a5cce6cbd9b4a1fd1eefa0f5cbc2cfcaf0.1560277373.git.matvore@google.com>
Message-ID: <nycvar.QRO.7.76.6.1906122118380.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com> <cover.1560277373.git.matvore@google.com> <cf0246a5cce6cbd9b4a1fd1eefa0f5cbc2cfcaf0.1560277373.git.matvore@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-980173506-1560369095=:789"
X-Provags-ID: V03:K1:Jtv39jKorPkEYwR5BU0z84kZPhOQtG5qNL+XezvFG7mxnlWo6yg
 xww/WuzZdvEKtika3TNgR6H8vi3LXFStc+y2UDGrB6xCq1UHoDD48/N3pTMTWF1I807I7/8
 19Vak64xa4JVJKaIem38gumP0JV01O9sEEjzqDI7UPnFxJTI9zQfYu8me3BieCgh0ovIY3f
 K1PVWOH0Rbf92IMgej6eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/0GgZD3khiw=:rC+OmhJIQ/pkMa730vw7Jh
 I0ro6TUI71s00Dz0f8d/YFNqyBkPtRcLE0lFNI+CBE7yFyFDPYKMRmqyogoCkwjZA0MG/MSq8
 sEbUTDWr+fDKkOnC/957TNDGz2A6U4HZObTR3YkTsPxUjXNgGZSUb7RoJfdNfdyQlcvz0fMzD
 rfuQl2XaxsqHp3W/M4i0CrCiyDztycvdaJi7HGsrYE2qh8TRlSrVG/Z9isoK8vIsKBn/ZLzDk
 Nn5PH0KA8UwGA4WBHVvXVTNXfF+KylwOUrRYp7I/gUoKyEqNijmol7sirOC8TcIZU2XwYTkyA
 exAw5LIBdtx+o7ULEvafhsp1PPJuUIUBMIFi6UfIn0L8Yf/iRwtu/d8sqQ9rmxGhH0qlYySaz
 uTL0+cs/lvaA5z3qUCy8WR9wawIBXsG9jYDxDqqtJcyPLWY/BARgoYhLL5MKIqM+mDTtyzRvg
 30JqKTgwjBa147yTZunJwpubuuOR/7paUWBqWyxFy08LiJDueN2pztVZxUl4nD9aToq0LN3Ta
 2Vr2mk/Xzjs/Pb5f3QSghfRsIcYUeTTcxjAgV6g9oPYbV25TjKc74CJbSblnNYjAHkjNNlfE9
 cysBSaYXQcPjrtv5wC5po4ukpTlK2CdeycaogXLKxFEE+LhvhLDru816GymSXZiIuyPoGsbm1
 +fNPBq0ISqdFbZ2dL2k7kQSwoy/GntTeC0zVFG7DmnMBe42nnkRL/+rvUc/f35QzyTDRZ4KKJ
 uy82hkTp/ro674xDMavGoZqNa7aGgIkvZqm1TCS5RR+Iqafqbs9Waqh8H8K4gM/mOqcK8gxyN
 YgpUnwpvW35UOxZAMeye7sKAIc3Q5YIpgs6bJdKMp5GV0ihZwnHFjQLKvFt5rYVcxpdGRuD38
 qUDiZEZ4mqxFQEZftkj0eQBZnb7rO2wXvy6vj4IxPv2Sj4m56z/1RT4HO3AQiKv6aY2YdNosd
 3Y6wTpJ8GiAPLHETIg/7l/qTN905CC7ELBIz4tbBp5fqsMaK9qmNY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-980173506-1560369095=:789
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Tue, 11 Jun 2019, Matthew DeVore wrote:

> diff --git a/ref-filter.c b/ref-filter.c
> index 8500671bc6..056d21d666 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2157,25 +2157,37 @@ static int cmp_ref_sorting(struct ref_sorting *s=
, struct ref_array_item *a, stru
>  	cmp_type cmp_type =3D used_atom[s->atom].type;
>  	int (*cmp_fn)(const char *, const char *);
>  	struct strbuf err =3D STRBUF_INIT;
>
>  	if (get_ref_atom_value(a, s->atom, &va, &err))
>  		die("%s", err.buf);
>  	if (get_ref_atom_value(b, s->atom, &vb, &err))
>  		die("%s", err.buf);
>  	strbuf_release(&err);
>  	cmp_fn =3D s->ignore_case ? strcasecmp : strcmp;
> -	if (s->version)
> +	if (s->version) {
>  		cmp =3D versioncmp(va->s, vb->s);
> -	else if (cmp_type =3D=3D FIELD_STR)
> -		cmp =3D cmp_fn(va->s, vb->s);
> -	else {
> +	} else if (cmp_type =3D=3D FIELD_STR) {

I still think that this slipped-in `{` makes this patch harder to read
than necessary.

Your argument that you introduce the first curlies in an `else` block does
not hold, as the removed `else {` line above demonstrates quite clearly.

But you seem dead set to do it nevertheless, so I'll save my breath.

> +		const int a_detached =3D a->kind & FILTER_REFS_DETACHED_HEAD;
> +
> +		/*
> +		 * When sorting by name, we should put "detached" head lines,
> +		 * which are all the lines in parenthesis, before all others.
> +		 * This usually is automatic, since "(" is before "refs/" and
> +		 * "remotes/", but this does not hold for zh_CN, which uses
> +		 * full-width parenthesis, so make the ordering explicit.
> +		 */
> +		if (a_detached !=3D (b->kind & FILTER_REFS_DETACHED_HEAD))
> +			cmp =3D a_detached ? -1 : 1;
> +		else
> +			cmp =3D cmp_fn(va->s, vb->s);
> +	} else {
>  		if (va->value < vb->value)
>  			cmp =3D -1;
>  		else if (va->value =3D=3D vb->value)
>  			cmp =3D cmp_fn(a->refname, b->refname);
>  		else
>  			cmp =3D 1;
>  	}
>
>  	return (s->reverse) ? -cmp : cmp;
>  }
> diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
> index 2139b427ca..1adf1d4c31 100644
> --- a/t/lib-gettext.sh
> +++ b/t/lib-gettext.sh
> @@ -25,23 +25,29 @@ then
>  		p
>  		q
>  	}')
>  	# is_IS.ISO8859-1 on Solaris and FreeBSD, is_IS.iso88591 on Debian
>  	is_IS_iso_locale=3D$(locale -a 2>/dev/null |
>  		sed -n '/^is_IS\.[iI][sS][oO]8859-*1$/{
>  		p
>  		q
>  	}')
>
> -	# Export them as an environment variable so the t0202/test.pl Perl
> -	# test can use it too
> -	export is_IS_locale is_IS_iso_locale
> +	zh_CN_locale=3D$(locale -a 2>/dev/null |
> +		sed -n '/^zh_CN\.[uU][tT][fF]-*8$/{
> +		p
> +		q
> +	}')
> +
> +	# Export them as environment variables so other tests can use them
> +	# too
> +	export is_IS_locale is_IS_iso_locale zh_CN_locale
>
>  	if test -n "$is_IS_locale" &&
>  		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
>  	then
>  		# Some of the tests need the reference Icelandic locale
>  		test_set_prereq GETTEXT_LOCALE
>
>  		# Exporting for t0202/test.pl
>  		GETTEXT_LOCALE=3D1
>  		export GETTEXT_LOCALE
> @@ -53,11 +59,21 @@ then
>  	if test -n "$is_IS_iso_locale" &&
>  		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
>  	then
>  		# Some of the tests need the reference Icelandic locale
>  		test_set_prereq GETTEXT_ISO_LOCALE
>
>  		say "# lib-gettext: Found '$is_IS_iso_locale' as an is_IS ISO-8859-1 =
locale"
>  	else
>  		say "# lib-gettext: No is_IS ISO-8859-1 locale available"
>  	fi
> +
> +	if test -n "$zh_CN_locale" &&
> +		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
> +	then
> +		test_set_prereq GETTEXT_ZH_LOCALE
> +
> +		say "# lib-gettext: Found '$zh_CN_locale' as a zh_CN UTF-8 locale"
> +	else
> +		say "# lib-gettext: No zh_CN UTF-8 locale available"
> +	fi
>  fi
> diff --git a/t/t3207-branch-intl.sh b/t/t3207-branch-intl.sh
> new file mode 100755
> index 0000000000..a46538188c
> --- /dev/null
> +++ b/t/t3207-branch-intl.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +
> +test_description=3D'git branch internationalization tests'
> +
> +. ./lib-gettext.sh
> +
> +test_expect_success 'init repo' '
> +	git init r1 &&
> +	test_commit -C r1 first
> +'

I still see absolutely no need for initializing `r1`. Every test script in
Git's test suite starts out with a fully initialized repository, no `git
init` necessary. Therefore, this test case seems to have an unnecessary
`git init` and multiple unnecessary `-C r1` options that make the script
quite noisy.

I mean, you initialize that `r1`, work on it exclusively, and completely
ignore the repository that has been initialized in `.git` for you.

> +test_expect_success GETTEXT_ZH_LOCALE 'detached head sorts before branc=
hes' '
> +	# Ref sorting logic should put detached heads before the other
> +	# branches, but this is not automatic when a branch name sorts
> +	# lexically before "(" or the full-width "(" (Unicode codepoint FF08).
> +	# The latter case is nearly guaranteed for the Chinese locale.
> +
> +	test_when_finished "git -C r1 checkout master" &&
> +
> +	git -C r1 checkout HEAD^{} -- &&

`HEAD^0` is a much more canonical way to say this. However, if you want
your test case to be easy to understand (and that is your goal, too,
right, not only mine?), you will instead use

	git checkout --detach

> +	LC_ALL=3D$zh_CN_locale LC_MESSAGES=3D$zh_CN_locale \
> +		git -C r1 branch >actual &&
> +
> +	head -n 1 actual >first &&
> +	# The first line should be enclosed by full-width parenthesis.
> +	grep "=EF=BC=88.*=EF=BC=89" first &&

I wonder whether it is a good idea to pretend that we can pass arbitrary
byte sequences to `grep`, independent of the current locale. On Windows,
this does not hold true, for example.

It would probably make more sense to store a support file in t/t3207/,
much like it is done in t3900.

And once you do that, you can simply `test_cmp t3207/first first`. No
need to `grep` for `master` in addition:

> +	grep master actual
> +'
> +
> +test_expect_success 'detached head honors reverse sorting' '
> +	test_when_finished "git -C r1 checkout master" &&

Hmm. I see you also did that in the previous test case, but since you
immediately detach the HEAD, I have to ask:

- why? Why do you insist on switching back to `master` after the test case
  finished?
- Why even bother to call `git checkout --detach` in anything but the very
  first test case, whose purpose it is to set things up for the subsequent
  test cases, after all?

> +
> +	git -C r1 checkout HEAD^{} -- &&
> +	git -C r1 branch --sort=3D-refname >actual &&
> +
> +	head -n 1 actual >first &&
> +	grep master first &&
> +	test_i18ngrep "HEAD detached" actual

Funny, reading the test case's title, I would have expected to read
instead:

	echo "* HEAD detached" >expect &&
	tail -n 1 actual >last &&
	test_cmp expect last

In all, the test script should read more like this:

	test_expect_success 'setup' '
		test_commit first &&
		git checkout --detach
	'

	# [... long comment here, does not need to be hidden and indented
	# inside...]
	test_expect_success GETTEXT_ZH_LOCALE 'detached HEAD sorts first' '
		LC_ALL=3D$zh_CN_locale LC_MESSAGES=3D$zh_CN_locale git branch >actual &&

		head -n 1 <actual >first &&
		test_cmp "$TEST_DIRECTORY/../t3207/first" first
	'

	test_expect_success 'detached HEAD reverse-sorts last' '
		git branch --sort=3D-refname >actual &&

		echo "* HEAD detached" >expect &&
		tail -n 1 actual >last &&
		test_cmp expect last
	'

It is quite possible that this can be simplified even further, i.e. made
even easier to understand for developers in the unfortunate situation of
having to debug a regression (which is the entire goal of a well-written
regression test: to help, rather than just to force, developers to debug
regressions).

Granted, the simpler form might look like it took less effort to write
than the complicated one. People with some experience in software
development will understand the opposite to be true, though.

Ciao,
Dscho

> +'
> +
> +test_done
> --
> 2.21.0
>
>

--8323329-980173506-1560369095=:789--
