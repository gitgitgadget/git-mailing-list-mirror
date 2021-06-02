Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0DFC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19F160724
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFBLmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:42:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:55781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhFBLma (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622634045;
        bh=29LWWZI7nmRGc7cLf3qgHynk4ksSSueUL5ymrTE8viY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HK2WoLajHJ4yb8IIK/jf/OyekrzePx3dUIOANq6C5yuj7lgb54BKfVtwkrVr+Vl1i
         geuEcUSvukWsCQnZcAqx3dMmFzkTlFbJhLc4XAlmcr6tOpQfsy0Phc48zD4NoVcBjK
         jpSpmT5lmTjGmjY4i7hrUDoBAUoFhVUV2OOIOqYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.8.58] ([89.1.215.222]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wuk-1liv3R2uU0-005axK; Wed, 02
 Jun 2021 13:40:45 +0200
Date:   Wed, 2 Jun 2021 13:40:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t9001-send-email.sh: fix expected absolute paths on
 Windows
In-Reply-To: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.2106021330470.55@tvgsbejvaqbjf.bet>
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-851272454-1622634045=:55"
X-Provags-ID: V03:K1:s15KoPwmQRLV2E3eioTcKXSCljeqnD4I7+PaF8ZXhEY5uEZg1SU
 Ay133rumxYjlmjofCCjW8L43PIH5qpHKq62K5wkGpgKDQlw3mSNGK9R9OpHHm2V+fT/PK6+
 b5BGRNOSq1QLc85nSVTtE/8i0q+e5zw0bhKUJRy2JxSwlKLCA9tZqfO3qFv51Sp5bToEbzh
 uSTLZQJZvzFivfvD8sVkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bdLmHN0w3FI=:pfnSaczwpIs569MLYCRMV5
 7xnp/DC6q+R7rt+CjkjUHaggfdwR8Z9v4tXYeQc6pcCWzwWcdN3fyJ426Q5keeyyn2ZeBLjZY
 2oKAdbiGILpSAH38NJhiqLcbffKbnYC+mdyVZFp4eRxtfVDk5IhHmY3Ewe1UbFGzanIUhpxye
 Lu0e4Gqlxuc6MWaJRSVXC/4tA+O1Nz+NZI4pqq6AkXZ0U1VefSnZccYaxvpTM+pvquOXE5LD8
 JoV+kI08zvGDhLlK1V3J3Mgg6KgS/+wwEhNcEemkEnhSbUPVmhsyKoCgDgoAGwAInCyNKshhT
 rhPsvBeHRKAXe8XMlcDoXzyvv0/ksKnsZqYnqD9wyzbUi1lb0S+8jrbFR0B66IAecqiDVZNkR
 3+Ktsu6wqCps0MkKZdldAXeFtRDPGrE6T/whAn2FbCpHg2t1ebAEEXhMCLKXExfZiKnaiVkt0
 vazXYJo/YO60e1dAJRpq+ZJnNNH2phEcBCv216hVkghAr3KER8nEYLNPtjonWR+mPC8vWUV6h
 jYP/YWI9qqhVZo8iiI+UMfDGoiuHecIXh5Ty1azD2pykzNC3auw/z+yhjJmFGeugTCr1wZdHR
 TQSZGU79jmvXiM9rORNm5q2tMhrqT3XEKeJQHbubRaQ8GAvZ27skf9J1Wauy2TtOjbU2rMEIL
 A55vGwoCs3p4X7qZXxRDGXad27v9S32qufGR7QrYMJqS1L1TK0CNfVkUFvT9WWQX2XDGTUOFN
 2xB28jf8OW88HE8z7u3uJJcONZSazm6HdkvCDcO+k4EujFz2yFNeFv8PlADlFBaBcBY9ku0bN
 Fc8tGRI6s3JmuI7MANStceeVryWIARO8D3A+o+ePtJL80z7k/aCMhUNxNpVubYQXBsEDu0iB+
 Ws25FafoSNk03ChLQDXuk9rdNWZYaYLiKbD6ljvbt1oiC+ciVn7tkkfheRAnwXMALE//Jfg8u
 rELDAvBKp93R0fA4s9ZtwmgeZPXLvg5tnpnRRCArtplQ2yeyhQWpe8OLLmNY61wZyhlNMdEkZ
 nowksUxv+zZNXrs4GL3EAAp4XXLivGUANRoMzudRrEFgzWc4j8iJv60rukguKMCvWNRjzms5k
 uh/UKlzQqMq3bO2J4RWcjNiGDGF+CtV7j3A13Lt+EK7I0/bA7Ty7hI0ag==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-851272454-1622634045=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Mon, 24 May 2021, Johannes Sixt wrote:

> Git for Windows is a native Windows program that works with native
> absolute paths in the drive letter style C:\dir. The auxiliary
> infrastructure is based on MSYS2, which uses POSIX style /C/dir.

As far as I remember, VMS is also POSIX, and it has a different path
style. Therefore I would probably use the term "Unix style" here instead
of "POSIX style".

But that has nothing to do with the validity of your point: it is still
a correct and important observation.

> When we test for output of absolute paths produced by git.exe, we
> usally have to expect C:\dir style paths. To produce such expected
> paths, we have to use $(pwd) in the test scripts; the alternative,
> $PWD, produces a POSIX style path. ($PWD is a shell variable, and the
> shell is bash, an MSYS2 program, and operates in the POSIX realm.)
>
> There are two recently added tests that were written to expect C:\dir
> paths. The output that is tested is produced by `git send-email`, but
> behind the scenes, this is a Perl script, which also works in the
> POSIX realm and produces /C/dir style output.
>
> In the first test case that is changed here, replace $(pwd) by $PWD
> so that the expected path is constructed using /C/dir style.
>
> The second test case sets core.hooksPath to an absolute path. Since
> the test script talks to native git.exe, it is supposed to place a
> C:/dir style path into the configuration; therefore, keep $(pwd).
> When this configuration value is consumed by the Perl script, it is
> transformed to /C/dir style by the MSYS2 layer and echoed back in
> this form in the error message. Hence, do use $PWD for the expected
> value.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  When I say "the configuration is transformed to /C/dir style", I am
>  actually hand-waving: I can observe that a transformation must
>  happen somewhere, but I actually do not know where the conversion
>  really happens. "The MSYS2 layer" is my best qualified guess.

Indeed, it is the MSYS2 runtime that performs this conversion. Concretely,
whenever you call a non-MSYS2 program from within MSYS2, command-line
arguments that look like Unix paths are converted by replacing forward
slashes with backslashes and by prefixing absolute paths with MSYS2' root
directory (as a Windows style path, of course).

However, in this instance, it is a different problem, I think.

Perl cannot handle Windows style paths. At least _Git's_ Perl scripts
cannot.

For example, the `PATH` variable is assumed to contain colon-separated
directory paths in our scripts. But that is not true on Windows: the colon
already separates the drive letter from the rest of the path, and
therefore the separator used in `PATH` is a _semicolon_.

To help with this, the MSYS2 runtime converts the command-line arguments
and environment variables that look like path lists (such as `PATH`) and
paths (such as `SYSTEMROOT`) from Windows style to Unix style when it
detects that, say, MSYS2's Perl is started from a non-MSYS2 program such
as `git.exe`.

Which means that the Perl code executed in =C3=86var's tests spits out Uni=
x
style paths.

Happily for us, the MSYS2 Bash with which Git's test suite is expected to
be executed on Windows understands those Unix style paths very well! All
we need to do is to use them here, and that is what your patch does,
therefore:

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you,
Dscho

>
>  t/t9001-send-email.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 65b3035371..68bebc505b 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -539,15 +539,14 @@ test_expect_success $PREREQ "--validate respects r=
elative core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'$(pwd)/my-hooks/sendemail-validate'"'"' died with =
exit code 1
> +	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with ex=
it code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
>  '
>
>  test_expect_success $PREREQ "--validate respects absolute core.hooksPat=
h path" '
> -	hooks_path=3D"$(pwd)/my-hooks" &&
> -	test_config core.hooksPath "$hooks_path" &&
> +	test_config core.hooksPath "$(pwd)/my-hooks" &&
>  	test_when_finished "rm my-hooks.ran" &&
>  	test_must_fail git send-email \
>  		--from=3D"Example <nobody@example.com>" \
> @@ -558,7 +557,7 @@ test_expect_success $PREREQ "--validate respects abs=
olute core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit=
 code 1
> +	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with ex=
it code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
> --
> 2.31.0.152.g120726e270
>
>

--8323328-851272454-1622634045=:55--
