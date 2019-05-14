Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FBE1F461
	for <e@80x24.org>; Tue, 14 May 2019 08:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENIyV (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 04:54:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:39615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENIyV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 04:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557824051;
        bh=6ecQRlXH8u9e3fVfDuyeRtrET+Rdaamcu5XJYil6loI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PH0hKQoxMFmJEWcfFAjhrjUnlKSf4QHGYvvfE/LRMc/8qMd7se3MwWyTUcywIYBtW
         HSHbnViJYE3i+Y8DC3GaQl91aJo3vS9gWr8G/D4Pg4AfOQMoM8bN01/+2tmgThZEzm
         4iybQGc3ZQfO9fZEPSfQRT84mbJuxRYD843YrUcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXq3L-1hEDf22N8x-00WjbW; Tue, 14
 May 2019 10:54:11 +0200
Date:   Tue, 14 May 2019 10:53:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH] tests: add a special setup where prerequisites fail
In-Reply-To: <20190513183242.10600-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905140945220.44@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet> <20190513183242.10600-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1431833609-1557824051=:44"
X-Provags-ID: V03:K1:QCsc1ErF+f8FUiXDlntdStCxA8Nh1Pg6eMm/TQRiIGPocJSgn81
 Zn4iCKAGENrNEHmuvFBQe2/7NbLY8SCWbgTSt2Xw3BlhsrKXY6+mSp6wXkM4MEkPUcomruF
 saM4mZK52OfiPMBAkThhhxnLeBzswQMRCVgxRUsHtJUMQTMTAliJNUnX4OL/sbl4BTbezx6
 MSHIXLV8SbKksJSDwKj5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FAYYuwbL3Xg=:cL7vHmAp0HJEVeiMKwP7qj
 vuiOlpzpfAMB46juio07tF9MH5n8vnHnNncwurJ1yA+M41S5vdQXM9d2nu+qNC2tIMM94UOMM
 /Wcx3d7KitqDB+wCLkIcjNfQ+Upw2TlpDn3Hrel1jmjOwWQkZzOZwVdxl09bSgRBPNSR7rmBA
 hYvUXMtBfCorTsY6a9T7aeZgcvNMZDa9tSRVgkyoZkuU0+LqNivD04EcQdYViaIWudfhsvqdi
 tLzVAmJMa68ImCYAt82XvhEHy3fREMqeTdHKLlArqvhvQHhmYrtNVh3ePqoGi8B1KehGmdqXh
 XFZyz9Py27wN2s+7EDULE9PK9wY5r2mwrSaq0s1Ehk3j9/8kdHzCEMase7ehe+nk7wx7FSWLm
 DxZO8N65OBgHQQf55zd1Ygc6cA0ooi0+RngZVYvWTP06EwII73mz+pRmNBvPzOJmtZdOaHTBv
 p0JBuQXTOD82+N+h8kKdu6z0hsddmTdVUG+J16+gNB1c6R+P1XBQBLayWoDX36ENGuVpgi5Rp
 5fn/AS6+BrRN/+i1BLmubqKLSvCUHbL02y0diCHxIMDdC6SwQOFpoiYt7Aj3d5JSYwe0h8srd
 g/T2mVQOHas8qK6Xj0KlZIJnSNNpVQDERkffBzyDCURvuTVXAbFKoZOH006zcyEpiDZporhe0
 hNPSQgLBFPQpnZcNaUt8YUCaYP4t9ABbETb40h3ukxQTs3KyywhaYMLvBLA+yj94m2Zw1Il+j
 Tue7nLCc7LYTSYCoZk/ay4bmppC4IzaO4iuKT6rZ6Ye/BBN3S2rL96aNyfDZZpWHvfqPCXK6N
 2zvZTDNz7f2kJkdh1fV76G8jmkwWu8pw54sozOzXwF4Wh5/J4z5fLqWnZns3QQJGN4a5KoIOM
 /kJXlan7XvissynDvOij1WBnbPrV4qSAT2SuEFYp20uxAHBLYCKdU2iFnwgjytcUjPYWYnc78
 U+UFyc8p0eQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1431833609-1557824051=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 13 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> As discussed in [1] there's a regression in the "pu" branch now
> because a new test implicitly assumed that a previous test guarded by
> a prerequisite had been run. Add a "GIT_TEST_FAIL_PREREQS" special
> test setup where we'll skip (nearly) all tests guarded by
> prerequisites, allowing us to easily emulate those platform where we
> don't run these tests.
>
> As noted in the documentation I'm adding I'm whitelisting the SYMLINKS
> prerequisite for now. A lot of tests started failing if we lied about
> not supporting symlinks. It's also unlikely that we'll have a failing
> test due to a hard dependency on symlinks without that being the
> obvious cause, so for now it's not worth the effort to make it work.

I don't know... In Git for Windows, the SYMLINKS prereq is not met.

(Side note: Windows 10 already supports symlinks for quite some time, even
for non-admin developers, but the fact that Git's test suite is
implemented in shell script bites us yet one more time: MSYS2 has a
completely different idea what symlinks are. It uses the "system file" bit
that only exists on Windows, and if that is set, reads the beginning of
the file, and if that reads "!<symlink>" (interpreted as ASCII), then the
rest of that system file is interpreted as the symlink target.)

So it makes me worry if you say that you had to exclude the SYMLINK
prereq. Maybe all the dependent tests have different prereqs that just so
happen *also* not to be met on Windows?

> 1. https://public-inbox.org/git/nycvar.QRO.7.76.6.1905131531000.44@tvgsb=
ejvaqbjf.bet/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> On Mon, May 13 2019, Johannes Schindelin wrote:
>
> > [...]
> > Namely, when test cases 51 and 52 are skipped because of a missing GPG
> > prerequisite [*1*], and those two are obviously required to run for th=
e
> > `git merge to fail in your test case, as you can very easily verify by
> > downloading the artifact containing the `trash directory.t7600-merge`
> > directory and re-running the last steps on Linux (where the `git -c
> > rerere.enabled=3Dtrue merge master` *succeeds*).
> >
> > In fact, you can very, very easily emulate the whole situation on your=
 box
> > by running:
> >
> > 	sh t7600-merge.sh -i -v -x --run=3D1-50,53-59
> >
> > And then you can fix your test case so that it does not need to rely o=
n
> > test cases that may, or may not, have run previously.
>
> I think it would be better to more pro-actively spot this sort of
> thing in the future, so here's a patch to do that. It passes on
> "master", but fails on "pu" due to the issue with the one test being
> discussed here.

It does drive me nuts that the `--run=3D<N>` option exists (thank you,
Slavica, for teaching me!) and is so poorly supported by our test suite.

For example, if t7600.59 fails, it would make a ton of sense to run

	sh t7600-merge.sh -i -v -x --run=3D59

right?

Except that we frequently have at least one "test case" whose only purpose
is to set things up.

But we never declare explicitly "test case 59 requires test case 51 to run
first".

We do not even declare the test cases: we execute them immediately. So we
would not even be able to juggle them about, e.g. run them in reverse
(which would otherwise be the easiest way to get rid of almost all side
effects).

I think in the long run, we'll have to drag Git's test suite into the 21st
century (kicking and screaming, I'm sure), to have a more declarative
style, with those features that one might know from Mocha, Jest, JUnit,
xUnit.NET, etc.

Back to your patch: it only catches prereq problems. But the `--run=3D59`
thing would still not be addressed.

What would you think about a mode where random test cases are skipped? It
would have to make sure to provide a way to recreate the problem, e.g.
giving a string that defines exactly which test cases were skipped.

I am *sure* that tons of test scripts would fail with that, and we would
probably have to special-case the `setup` "test cases", and we would have
to clean up quite a few scripts to *not* execute random stuff outside of
`test_expect_*`...

> diff --git a/t/README b/t/README
> index 6404f33e19..9747971d58 100644
> --- a/t/README
> +++ b/t/README
> @@ -334,6 +334,15 @@ that cannot be easily covered by a few specific tes=
t cases. These
>  could be enabled by running the test suite with correct GIT_TEST_
>  environment set.
>
> +GIT_TEST_FAIL_PREREQS<non-empty?> fails all prerequisites. This is

Did you mean to insert `=3D` after `GIT_TEST_FAIL_PREREQS`?

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 819c24d10e..c20209324c 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -352,7 +352,7 @@ test_expect_success 'log with grep.patternType confi=
guration and command line' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success 'log with various grep.patternType configurations &=
 command-lines' '
> +test_expect_success !FAIL_PREREQS 'log with various grep.patternType co=
nfigurations & command-lines' '

Is this an indication of a bug in this test case?

>  	git init pattern-type &&
>  	(
>  		cd pattern-type &&
> diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
> index 7855bd8648..aa33978ed2 100755
> --- a/t/t7405-submodule-merge.sh
> +++ b/t/t7405-submodule-merge.sh
> @@ -417,7 +417,7 @@ test_expect_failure 'directory/submodule conflict; k=
eep submodule clean' '
>  	)
>  '
>
> -test_expect_failure 'directory/submodule conflict; should not treat sub=
module files as untracked or in the way' '
> +test_expect_failure !FAIL_PREREQS 'directory/submodule conflict; should=
 not treat submodule files as untracked or in the way' '

Same here?

>  	test_when_finished "git -C directory-submodule/path reset --hard" &&
>  	test_when_finished "git -C directory-submodule reset --hard" &&
>  	(
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 2e1bb61b41..7d7b396c23 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -412,7 +412,7 @@ do
>  		test_cmp expected actual
>  	'
>
> -	test_expect_success !PCRE "grep $L with grep.patterntype=3Dperl errors=
 without PCRE" '
> +	test_expect_success !FAIL_PREREQS,!PCRE "grep $L with grep.patterntype=
=3Dperl errors without PCRE" '

And here?

>  		test_must_fail git -c grep.patterntype=3Dperl grep "foo.*bar"
>  	'
>
> @@ -1234,7 +1234,7 @@ test_expect_success PCRE 'grep --perl-regexp patte=
rn' '
>  	test_cmp expected actual
>  '
>
> -test_expect_success !PCRE 'grep --perl-regexp pattern errors without PC=
RE' '
> +test_expect_success !FAIL_PREREQS,!PCRE 'grep --perl-regexp pattern err=
ors without PCRE' '

And here?

>  	test_must_fail git grep --perl-regexp "foo.*bar"
>  '
>
> @@ -1249,7 +1249,7 @@ test_expect_success LIBPCRE2 "grep -P with (*NO_JI=
T) doesn't error out" '
>
>  '
>
> -test_expect_success !PCRE 'grep -P pattern errors without PCRE' '
> +test_expect_success !FAIL_PREREQS,!PCRE 'grep -P pattern errors without=
 PCRE' '

And here?

>  	test_must_fail git grep -P "foo.*bar"
>  '
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 8270de74be..0367cec5fd 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -309,6 +309,26 @@ test_unset_prereq () {
>  }
>
>  test_set_prereq () {
> +	if test -n "$GIT_TEST_FAIL_PREREQS"
> +	then
> +		case "$1" in
> +		# The "!" case is handled below with
> +		# test_unset_prereq()
> +		!*)
> +			;;
> +		# (Temporary?) whitelist of things we can't easily
> +		# pretend not to support
> +		SYMLINKS)
> +			;;
> +		# Inspecting whether GIT_TEST_FAIL_PREREQS is on
> +		# should be unaffected.
> +		FAIL_PREREQS)
> +			;;
> +		*)
> +			return
> +		esac
> +	fi
> +

I would probably have done that on the reading side rather than the
writing side ;-)

Thanks for starting this!
Dscho

>  	case "$1" in
>  	!*)
>  		test_unset_prereq "${1#!}"
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 908ddb9c46..6fabafebb3 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1607,3 +1607,7 @@ test_lazy_prereq SHA1 '
>  test_lazy_prereq REBASE_P '
>  	test -z "$GIT_TEST_SKIP_REBASE_P"
>  '
> +
> +test_lazy_prereq FAIL_PREREQS '
> +	test -n "$GIT_TEST_FAIL_PREREQS"
> +'
> --
> 2.21.0.1020.gf2820cf01a
>
>

--8323328-1431833609-1557824051=:44--
