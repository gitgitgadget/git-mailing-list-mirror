Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5BEC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359203AbiBHNlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357113AbiBHNlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 08:41:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4095AC03FECE
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 05:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644327659;
        bh=qOr/Ls3D7C1+GFQChNoIA85mBmh93XW3zviRTM/0N54=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bNpfKuciLI2bsC0Il5YKB2tfZSxenAYWJJFG9+tpeQDZFdkWM1Io+JlFrBwZaRz0o
         wF3RB2KlrJKSXw8c3Ca/seGPFDZLMBR85Km7CekqYN96hTl05/fZtO+odkrOCEW0tP
         YyZqk0uW4YSRwvrTWpEl5IdBkVwHYMV4QtgPgo7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.212.206]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1nTmfG2p5x-00CSka; Tue, 08
 Feb 2022 14:40:59 +0100
Date:   Tue, 8 Feb 2022 14:40:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] t0051: use "skip_all" under !MINGW in single-test
 file
In-Reply-To: <patch-v2-1.1-1bc93bcba4b-20220204T134208Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202081437450.347@tvgsbejvaqbjf.bet>
References: <patch-1.1-34ff968dcb8-20220201T203428Z-avarab@gmail.com> <patch-v2-1.1-1bc93bcba4b-20220204T134208Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-262443756-1644327659=:347"
X-Provags-ID: V03:K1:RSbsk0pNDH7OzAGz/UZcdsL7hx5i7yK6jSw+TXU4iJOcSMajKgR
 KeG+v4YTTgpTFDo4rBRoWSLxm719i9g1SARn7K289VhlzGR3b9dKmzr5N5ZcbcWj1JqUbDM
 KOSvJav8TZJbg7HJC7RBsVv/v0AbrhaKcBodwyqMfQvp05O1BmO5sJ5JUh+UnHZTgavnKAQ
 0YaOM4CKI8O3wDgR71d2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eOPac7HfvQk=:2aQ8aeQZu92WEmRMvzbwWq
 bCcylmGXDYSfHP3to6c4wPT9sGdHAQfaz8jBccUTydCrKbMtpyVJUw0vPwNFkpJMOGHGrj2/y
 CWZzk9sKxfymjLLkwdGsI1ZClwZUpgNFluFTjE5a8wm35l4xtzgaqb/vNrNmoSxnEDPTFPwOG
 oe6Vtw3ml+iLGiGQar1lAyGTmb87KHi6YieIDbzKe8vU3NRQHXQjPadN+i80mStfjUqO5bNyi
 XUtW/uDQD/jlHkeI1g8OmKApe1SUy6Z7ENmxi6L7dVJITcl72nYwuuw9o8E+eRpfdDD9oeDkF
 3llrVrabGHrj2m2KLUhUlMYSazKrPwcl3mzRrFnRJldRppFkZtI///JLKn0XLOCT3vK2kURkh
 5YODeIDn3i+9BHnswFzIeTAge612J+0qgdp7jDYdVcjSxBUNonKlFbbC9TduFzZkPZzN+kR3w
 IitFPoKrMTXeRreMR2FO8RwGlm+EZdHNaKKIn3KW/Z7TQodHsqZVWgm6eGkLh+bURGeRllS1X
 GSo9tny+vcpuNwUpWqni7pjmFgXmaZJXHJUtMCxLbDP0HnL7dmrdyD2I4zbU9I5VZmtaFV/7X
 yZ+F+GV3oJA8zcWiE3vytkQ1DTbFolXB/izav56Ty65XeUtVGLrm+B/Qt03w4WsDpYdVlL/96
 h56HYB3EAVDWjzbkYOuqMA7HwJuVcM8SRiJz5XhMlYrBd6sAfQVMm9hJOKXU1oKNw3N+HaK9S
 YUYY4BjwnxGCrgINoMtuOcrlXvuqdbZH1cvgL2hJkiuo+QHKavVhIAuZkZKSqKaPRF2ORtgG6
 uONA1199QG8ThTNgwCKpbrJrViikF5UASOkI6RB4NXLqYBDz5yWkcFjeZVGGx9h1f0KLIGrHL
 DL0/4Ecwrl+N75tECaKb2CLABiJUE/xrMkaBf4dfzGmJnb/ow6on0PrRfMPZfi2lgNFpBldyT
 VL26Nl7zgEBA0aUTzxB25VEKmFIkshWfhoVnAM4/hnRN1of2IhTwwKT4uLEpY5105wN3BDKpZ
 EmWRXrhG17INBC1BBuLBTpRdGn9PoVUtW+y9R5nAdGFvArblzStpa0g3386PJonjHr+s7Z7T9
 4PYEvG44BtAO3M=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-262443756-1644327659=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 4 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Have this file added in 06ba9d03e34 (t0051: test GIT_TRACE to a
> windows named pipe, 2018-09-11) use the same "skip_all" pattern as an
> existing Windows-only test added in 0e218f91c29 (mingw: unset PERL5LIB
> by default, 2018-10-30) uses.

This is not a nit, even if I won't insist on changing it in this instance:
This sentence is unnecessarily convoluted and therefore harder to read
than it has to be. Please pay attention to readability next time you craft
a commit message.

The rest of the commit message as well as the diff look good to me.

Thanks,
Johannes

>
> This way TAP consumers like "prove" will show a nice summary when the
> test is skipped. Instead of:
>
>     $ prove t0051-windows-named-pipe.sh
>     [...]
>     t0051-windows-named-pipe.sh .. ok
>     [...]
>
> We will prominently show a "skipped" notice:
>
>     $ prove t0051-windows-named-pipe.sh
>     [...]
>     t0051-windows-named-pipe.sh ... skipped: skipping Windows-specific t=
ests
>     [...]
>
> This is because we are now making use of the right TAP-y way to
> communicate this to the consumer. I.e. skipping the whole test file,
> v.s. skipping individual tests (in this case there's only one test).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> Range-diff against v1:
> 1:  34ff968dcb8 ! 1:  1bc93bcba4b t0051: use "skip_all" under !MINGW in =
single-test file
>     @@ Commit message
>          by default, 2018-10-30) uses.
>
>          This way TAP consumers like "prove" will show a nice summary wh=
en the
>     -    test is skipped, e.g.:
>     +    test is skipped. Instead of:
>     +
>     +        $ prove t0051-windows-named-pipe.sh
>     +        [...]
>     +        t0051-windows-named-pipe.sh .. ok
>     +        [...]
>     +
>     +    We will prominently show a "skipped" notice:
>
>              $ prove t0051-windows-named-pipe.sh
>              [...]
>              t0051-windows-named-pipe.sh ... skipped: skipping Windows-s=
pecific tests
>              [...]
>
>     +    This is because we are now making use of the right TAP-y way to
>     +    communicate this to the consumer. I.e. skipping the whole test =
file,
>     +    v.s. skipping individual tests (in this case there's only one t=
est).
>     +
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
>
>       ## t/t0051-windows-named-pipe.sh ##
>
>  t/t0051-windows-named-pipe.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0051-windows-named-pipe.sh b/t/t0051-windows-named-pipe.=
sh
> index 10ac92d2250..412f413360d 100755
> --- a/t/t0051-windows-named-pipe.sh
> +++ b/t/t0051-windows-named-pipe.sh
> @@ -3,8 +3,13 @@
>  test_description=3D'Windows named pipes'
>
>  . ./test-lib.sh
> +if ! test_have_prereq MINGW
> +then
> +	skip_all=3D'skipping Windows-specific tests'
> +	test_done
> +fi
>
> -test_expect_success MINGW 'o_append write to named pipe' '
> +test_expect_success 'o_append write to named pipe' '
>  	GIT_TRACE=3D"$(pwd)/expect" git status >/dev/null 2>&1 &&
>  	{ test-tool windows-named-pipe t0051 >actual 2>&1 & } &&
>  	pid=3D$! &&
> --
> 2.35.1.940.ge7a5b4b05f2
>
>

--8323328-262443756-1644327659=:347--
