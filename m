Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6ABC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiFBPS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiFBPS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 11:18:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F044526270F
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654183098;
        bh=c1RVpUguBlEVBfs8ia5uQRHPkSqFYSHDM8BDHKuYbIY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=flNrDOn/JWrtCNP5BbZLI1Qn0M86+6Q6g1ZfmjL2EmFNfwzDi2j2XfZeNX8DWe/o/
         edkXdPokTKZKnG/mLnr5U1um+S0the8tRKGAaGREYOWKjrnmVQrwzZV4xRARhVIgzO
         hfQtLT/jYMaEKs3GvLFd06aNP3IqeNsAaNDD4eu0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1nTVlf3zeg-00oCVq; Thu, 02
 Jun 2022 17:18:18 +0200
Date:   Thu, 2 Jun 2022 17:18:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH] ls-tree: test for the regression in 9c4d58ff2c3
In-Reply-To: <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet>
References: <xmqqee28spni.fsf@gitster.g> <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1960034853-1654183098=:349"
X-Provags-ID: V03:K1:rxh8JlGx4YWUwA/G3hEskGnETg3wrqqpg1VX+OP5MG9Ns7jtDDO
 4ZXJXtzXdP2vmjArWiLT/6hAv13ISAjqL9nyMYh3Mf0fK3CuE7oPBk7jCsNwnguca/2H4NO
 e3vle3gKolGiUkjrgvg94PymJbkf7e9G7IeyrOOAISUFmniH42Mk1MZ3OTxtqx65hLPwI6m
 z/l6KYKOMOVdTCQzCWCSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gfeqsn8vU7Y=:KiUpBt3IcZYxJTZiQZY1UZ
 G765nzY+M4tz3nNSpm/R907utPm/ZgW4/oOiqi08yO7gmfupAuBqAgJbSMVQGOHVtO543lufq
 nEASa4GnrHo7WfYtHKiMSAeSF68HhZ6IJPkzMW8JF3DVHQoxYiSNFu24hiC9S7cYHx7HoL4E7
 UyeuUdkqwoYxVltISqMBrAAOL5dPp+z+vMDi5kYDHU26AkyeTDNRoWdbumVglHGMEXfBbj+G7
 KmZlZS2H5HGCsPK8kOiAsAnMLg70mC9TWMPm8QTjn+LEWgQ5qZwmvK/3knKIXDirY99R+Dwcy
 vNTUsQw92Z4pql/v8oOvNY3Sb6nh5Y80sBAxabK4GfKxpSPo8o+/BLgEhCAP6fTf71EC/kRNS
 /eh76rmmjamVXjKNYEuYbgkSfcHxLafFBJnwGGxJFgo4LT4KzrCj3DUIFdp0kIEK4BvFuiJb8
 yLP7PsXgZdkXA8h+XmXG3NGmtk2tL05DbtIKHyWx3maFxE8qexuTtapwRHSqLqaZV78MzncIc
 nEjqo7KZ5pXmZVwcwRqEvreUqJsXZFngaX7rsAfcQTA7W95m2ltGS96x4W1bp/o03x2YbPz0I
 duJEbIKLVy4vf8vG+oClEFysZO4xL0oyQRmcmbBu7GmTWb1K++oMk8ma7vROqWEPZ3yODfUk8
 9aOpIL4JQfN20c+raaWH4++LBmqNyhlVMGAsrvbhNo8PIF9D2qQToiP6UBdLcJEWdlhYPnVDe
 /SVvTdazPOJTnhytFHVZoDMjxZpov1cC3m90FqlWMqwvp+wQoqjMkaBqOhP+cBg8BhC6Ph1Pk
 8gMyH59SZIp3Qi70EqzAqpnLmiyYaxXjCCX/Isi++bXvNt1XB6dX9dC2cRDocTc7rLw/OliDz
 bB1YGh095RTUvHXMnn1moONYuuVma4kkllogWgtwQHVPwWsy1PgWcPG4Aen6DNWj8TEEbzDNZ
 yBv7w78cbx1szfD1hDFci1t8UEVYuHv9B0WbWQQP2UVNP2C5xwMOohxsN4oeyPo9nY+uO9pia
 YisNwassiq/H/rcvvctl6wm7+vTVe87rgFoa43IBZQ0GmaxPuGDfc3Ty44lSZl3Ssd0fZYUqP
 l/je9K/3ZZLpurP9So1fHwY434Fx3GIN0UyNdkaPeXakEn3NoxwZu61Pw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1960034853-1654183098=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 31 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Add a test for the regression introduced in my 9c4d58ff2c3 (ls-tree:
> split up "fast path" callbacks, 2022-03-23) and fixed in
> 350296cc789 (ls-tree: `-l` should not imply recursive listing,
> 2022-04-04), and test for the test of ls-tree option/mode combinations
> to make sure we don't have other blind spots.

That's adding a lot of new test cases, which is not free of cost.

> Range-diff:
> [... 433 lines, essentially a rewrite...]

Pasting 443 lines of range-diff also is not free of cost.

> diff --git a/t/t3105-ls-tree-output.sh b/t/t3105-ls-tree-output.sh
> new file mode 100755
> index 00000000000..29511d9331b
> --- /dev/null
> +++ b/t/t3105-ls-tree-output.sh
> @@ -0,0 +1,192 @@
> +#!/bin/sh
> +
> +test_description=3D'ls-tree output'
> +
> [...]
> +'
> +
> +test_ls_tree_format_mode_output () {
> +	local opts=3D$1 &&

This line does not quote `$1`, but...

> +	shift &&
> +	cat >expect &&
> +
> +	while test $# -gt 0
> +	do
> +		local mode=3D"$1" &&
> +		shift &&
> +
> +		test_expect_success "'ls-tree $opts${mode:+ $mode}' output" '
> +			git ls-tree ${mode:+$mode }$opts HEAD >actual &&
> +			test_cmp expect actual
> +		'
> +
> +		case "$opts" in
> +		--full-tree)
> +			test_expect_success "'ls-tree $opts${mode:+ $mode}' output (via subd=
ir, fails)" '
> +				test_must_fail git -C dir ls-tree --full-name ${mode:+$mode }$opts =
HEAD -- ../
> +			'
> +			;;
> +		*)
> +			test_expect_success "'ls-tree $opts${mode:+ $mode}' output (via subd=
ir)" '
> +				git -C dir ls-tree --full-name ${mode:+$mode }$opts HEAD -- ../ >ac=
tual &&
> +				test_cmp expect actual
> +			'
> +			;;
> +		esac
> +	done
> +}
> +
> [...]
> +## opt =3D --object-only --abbrev
> +test_expect_success 'setup: HEAD_short_* variables' '
> +	HEAD_short_gitmodules=3D$(git rev-parse --short HEAD:.gitmodules) &&
> +	HEAD_short_dir=3D$(git rev-parse --short HEAD:dir) &&
> +	HEAD_short_top_file=3D$(git rev-parse --short HEAD:top-file.t) &&
> +	HEAD_short_submodule=3D$(git rev-parse --short HEAD:submodule) &&
> +	HEAD_short_dir_sub_file=3D$(git rev-parse --short HEAD:dir/sub-file.t)
> +'
> +test_ls_tree_format_mode_output "--object-only --abbrev" "" "-t" <<-EOF

... this line passes a first argument that contains spaces. Hence the
tests fail in CI:
https://github.com/git/git/runs/6703333447?check_suite_focus=3Dtrue

Further, since this failure is outside of any `test_expect_success` or
`test_expect_failure`, the error message about this is not even included
in the weblogs (but of course it is included in the full logs that are
included in the build artifacts). For the record, here is the error
message:

	[...]

	ok 35 - 'ls-tree --object-only -r' output (via subdir)
	+ git rev-parse --short HEAD:.gitmodules
	+ HEAD_short_gitmodules=3D6da7993
	+ git rev-parse --short HEAD:dir
	+ HEAD_short_dir=3Daba57e0
	+ git rev-parse --short HEAD:top-file.t
	+ HEAD_short_top_file=3D02dad95
	+ git rev-parse --short HEAD:submodule
	+ HEAD_short_submodule=3D61a63ac
	+ git rev-parse --short HEAD:dir/sub-file.t
	+ HEAD_short_dir_sub_file=3Da150abd

	ok 36 - setup: HEAD_short_* variables
	t3105-ls-tree-output.sh: 20: local: --abbrev: bad variable name
	FATAL: Unexpected exit with code 2

Note: I am only pointing out why the CI/PR run fails, I have not formed
any opinion on the actual code other than noticing a lot of what might be
repetitive lines and suspecting that adding this many new test cases
increases the runtime of the test suite and thereby adds to developer
friction and the benefit (namely, to catch future regressions) might not
justify that. But again, I have not fully formed an opinion about this
patch.

Ciao,
Johannes

--8323328-1960034853-1654183098=:349--
