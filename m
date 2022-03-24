Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69446C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350509AbiCXNkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350506AbiCXNkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 09:40:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3AFA776D
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648129139;
        bh=KChaXUQwU1LW34yEgTNPYhj5AUl2dRZa3BPqFVd6vkM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XC6ZdZ3tDPbMCmfDfGrQsAhed4FT3ae+Hl2IniEGC4C7v0CrXBQ+2gTt2ZfBW5J6b
         ziMTiMcNqwCB6txl13uzrhKlki4iwZ1+/V4ICXQPbPWHb7jPgSXdkCNd4nIRGNUaTQ
         cy2nJG1Rz/UWnR7qglIIe5n2Zj/NQnaonbEDgkqM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([213.196.212.0]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1nNicw2xwz-00AAv3; Thu, 24
 Mar 2022 14:38:59 +0100
Date:   Thu, 24 Mar 2022 14:38:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: have --immediate emit valid TAP on failure
In-Reply-To: <patch-1.1-47b236139e6-20220323T204410Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203241434360.388@tvgsbejvaqbjf.bet>
References: <patch-1.1-47b236139e6-20220323T204410Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-987454896-1648129139=:388"
X-Provags-ID: V03:K1:mgQ9ByJ3pbOj68+bRVde/8fcViO0ZVSya8Xt3DSt/6UoSyH51lr
 3VVIsHtdr2JCq1ntnwpTZhUI5psAzfgSc2Chr8lyi740WDKvML1q6IQHFGL7v8tMHc9fpS3
 KxWXpbAnC6QJ0SBngFdJlDgoEL01XTL7XogqeQmvmXRMgGpBHHurZ9uCE4ajtRm3qLMaCwC
 sQiPNIeOZ2iVZG4iSUCzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7NA/87VTJEA=:cGE0JNEXUdIIMpnpcr/HYd
 XTbYboq4G4CQvhcuyGd6ulkIfWOra2njB1tvIGkmQX1JOXtxvL4t3M6OKbHG4MHdOuhqmybxl
 z5wIY4aBsq3e+ejYf81RtHntaaCDIONsKgzLVCNswVFDG5LSh+pajSOApTTNxaxTYY+oV38M8
 OSfk0sQURo/bS0SwlmU8a5C+bpDPd2e/NvwplOpCNW6gbdA8P5XKVZFNfvloExdJQsqruC9HY
 DXFrIL/F2/oQHtIOrxFCVwH22DlxWfjIGbHB8KPyUx2uZWLzZmCZqap2TJxc567IfLOPvI/em
 evieIezXak/aXlSROBX/nISLCVcYLS0EfJSM3kTWalJRZBDb4fSdzCI0vcPnQmQYtXIpuX0iJ
 6cQGTik1HguMUK8StWjshSK041VIps/wXpJ+pSEcmN31XwHmp+qYuZd6M+KC1Lshq36/kHWiY
 YeIlcL6zd0Mk+Ey1pvmnk36Rq5yLXFJABzkbpy1jmN6OF+qKePoHqixeV0RMe7OD7AL6JriRO
 8YDI+XNLhs9WgUSXN2cSgzZgbiJ7XE36w/HLUpMf8ORR+P9bVIq3BDcHww6ENKMxoXi2zDTCF
 GUeUEcfgbJsBsjV8jtOFmBgVpCAA5ziOgepW8ErhZgJvqGJPXWs8svYB1QRELK7mwM1F2ImKK
 UacT7danyhm94/SWSyFaetCFKASlgW7QEudtb7UzN5Dt+7og0XU3yRXqLyah1vSoFfc+TX069
 op0GWUJnE7HFDnNlBTXwXj42pqlQa32fqLaH06J6x2jvorcNbB3w0TttwG5m6IvV7EXGLh4UF
 inIUnHqxX4Wf19v+q67gH7cXCHq2GRkrxl7SP0Ay2F0dQVFi6o7ZrA/6qF4Jv/k/0g5utD3xw
 8raxVJMV5Er5jayc5ArrzvZrvEpMsp7i/zx0xwNnRLengel2jtYvwVpco/QcD0ORobXdLWNgy
 rGu8e0fHe1A27y6Juze19H2kmNeNWW9RV7MwD/1ivHgQ81M6Yf1Zr+0YH4ooUQfVMut0noZfy
 KiknRnXg6dLkkNlc8sSW01BY3D9/BtVH5xPd7T97yV40KU4HWXS3vOUvZt5WloSfQ96KiRQW1
 EWiZ58oiEXYwA0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-987454896-1648129139=:388
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 23 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change the "--immediate" option so that it emits valid TAP on
> failure. Before this it would omit the required plan at the end,
> e.g. under SANITIZE=3Dleak we'd show a "No plan found in TAP output"
> error from "prove":
>
>     $ prove t0006-date.sh ::  --immediate
>     t0006-date.sh .. Dubious, test returned 1 (wstat 256, 0x100)
>     Failed 1/22 subtests
>
>     Test Summary Report
>     -------------------
>     t0006-date.sh (Wstat: 256 Tests: 22 Failed: 1)
>       Failed test:  22
>       Non-zero exit status: 1
>       Parse errors: No plan found in TAP output
>     Files=3D1, Tests=3D22,  0 wallclock secs ( 0.02 usr  0.01 sys +  0.1=
8 cusr  0.06 csys =3D  0.27 CPU)
>     Result: FAIL
>
> Now we'll emit output that doesn't result in TAP parsing failures:
>
>     $ prove t0006-date.sh ::  --immediate
>     t0006-date.sh .. Dubious, test returned 1 (wstat 256, 0x100)
>     Failed 1/22 subtests
>
>     Test Summary Report
>     -------------------
>     t0006-date.sh (Wstat: 256 Tests: 22 Failed: 1)
>       Failed test:  22
>       Non-zero exit status: 1
>     Files=3D1, Tests=3D22,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.1=
9 cusr  0.05 csys =3D  0.26 CPU)
>     Result: FAIL

The commit message is strong on the what, very strong in giving verbose
output that might or might not clarify the intention, and a little weak in
the why and the greater context.

In the broader story arc, I wonder why we're even bothering with TAP
anymore because it seems that the world has moved on to more powerful file
formats to represent test output, such as JUnit XML, that can be parsed,
rendered and analyzed by powerful special-purpose applications.

Apart from taking reviewer time away from such more powerful avenues to
make sense of our failing tests, the diff does not really hurt, so I have
no objections against integrating this patch.

Ciao,
Johannes

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 9dcbf518a78..17a268ccd1b 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -101,6 +101,19 @@ test_expect_success 'subtest: 2/3 tests passing' '
>  	EOF
>  '
>
> +test_expect_success 'subtest: --immediate' '
> +	run_sub_test_lib_test_err partial-pass \
> +		--immediate &&
> +	check_sub_test_lib_test_err partial-pass \
> +		<<-\EOF_OUT 3<<-EOF_ERR
> +	> ok 1 - passing test #1
> +	> not ok 2 - failing test #2
> +	> #	false
> +	> 1..2
> +	EOF_OUT
> +	EOF_ERR
> +'
> +
>  test_expect_success 'subtest: a failing TODO test' '
>  	write_and_run_sub_test_lib_test failing-todo <<-\EOF &&
>  	test_expect_success "passing test" "true"
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 515b1af7ed4..4373f7d70b5 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -806,7 +806,11 @@ test_failure_ () {
>  	say_color error "not ok $test_count - $1"
>  	shift
>  	printf '%s\n' "$*" | sed -e 's/^/#	/'
> -	test "$immediate" =3D "" || _error_exit
> +	if test -n "$immediate"
> +	then
> +		say_color error "1..$test_count"
> +		_error_exit
> +	fi
>  }
>
>  test_known_broken_ok_ () {
> --
> 2.35.1.1452.ga7cfc89151f
>
>

--8323328-987454896-1648129139=:388--
