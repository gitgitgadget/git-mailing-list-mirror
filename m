Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39940C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 11:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiFRLzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 07:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiFRLzb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 07:55:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0751DDFEB
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655553327;
        bh=5N5a1LZdaJ6n3K6Vz+ISciyO5zevF0Ge/v9almNaBWo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GLMaaL5UiqC0AX3lssiebtAlEJWJXHPsgW4Qs7cqszRdCvYTdlYmdXKwyKlpSz6IA
         cuM7CfFFVH84fXSXxQojQzwfzYiwASJf7Y2J6x5JVA9LBf69rGudzC+dZHe6NbWvFL
         hnWVBIt9Qd3ox5LrHBjWQbgHlmGoPaYbcl+bMaF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.234] ([89.1.215.185]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1nNdqk3lTA-00nh62; Sat, 18
 Jun 2022 13:55:27 +0200
Date:   Sat, 18 Jun 2022 13:55:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Michael J Gruber <git@grubix.eu>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] t3701: two subtests are fixed
In-Reply-To: <165537087609.19905.821171947957640468.git@grubix.eu>
Message-ID: <nycvar.QRO.7.76.6.2206181342200.349@tvgsbejvaqbjf.bet>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu> <nycvar.QRO.7.76.6.2206151649030.349@tvgsbejvaqbjf.bet> <165537087609.19905.821171947957640468.git@grubix.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1688576404-1655553327=:349"
X-Provags-ID: V03:K1:6XrsiRzFd8/JhRfvLV+6I0LgxNVMH/GX4jXwnqXqgKl3bWrZX9/
 9TzZQOnCcwE1ls85i2ZK41T77gtLKnYUK95QFOygSshjV+zzfHXf2DkTZgc9GwHPrkIi3DS
 gdW6uZCqDTv8Bv7+6+Q0OQgzDb9BL1PQdWZJX3kkQp0Kvt8UXfXvXRfrR+4+lDkRXHimNoG
 PRydxpe9NQhuHJTB0bqjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j0ZLKCvc/VY=:hmZErOwfW9i/RAsy1+ytv8
 D05LEpya8O0FGFghfdc/iA39KcjVVO/ouYUz7TlRk/Iq12v6B3mgHdKT8BKc5gI4Co53yqJkl
 pwf1QSZ3PwJPG9PhDbekSDfn2YXG0MU+ndHA4dK/9GN5EWt+tWYLmDHsJYh3RkWyrE45KxfOu
 1Zxh7AZeHqUZFlLklhMzpmpUKHCTYYjOyF3+EUfmFpkB+A+97tH/KkVgVc4df27wyR7AKaQNn
 3eTEWJ5xhlw/HR41brZ2nJ5CZ1zP0hjUXZ/lytNKJh2Gi+InxR1v//bAbkO82FPz39+9IJRXE
 EPlQr7qC0zDtLtPBQ6z2pMNJ3DdqbnSH8b/QDFdZsjuExifmpzvAn1BefwmaPt1xgwcBmqjx6
 YA6VT0owQymNGA3HeUniaFrI58YZx9BexN1RmgV1ZHMCvXPtbfjFV/cfvS/EU+YH/xnXfPVF2
 kXCG0qkXkH3mx5fK2WDNHJxYs5fqBe3K4sFT00snVfmUn40y3x/1nIdM9TUNPKvsrmYEQI9xS
 fgNp//jRicFPS+Kobo+cBeVWKfiUbkd0hFDa6NqOjjIm4LQz+YKpldEpwMHA5HPW/CyyLn2do
 UxvDSNYLxX/tIgEWabNf4c46VKIX/gyb6fwkSsXNU+rYXoVNukzX4zdr2bL+fhn0PiAVJqCuO
 FcnW+zWizEKE+Tb/e+bmGY9nb9Vl/Pl91A6SxgrLOOqXf/q9cZmdhr0lZSKFcXhT1m0/3jx7O
 TQtZVpkHgkQf3q00nnGxaYokCPU2bLpEZHK8il4hA1LJsSqvKGaRBvaYwQzLMsjpx8l+DfEkN
 +E3yYfQnpL5sZPaDzB4cpUdXnnjSLXjci+lonPF3GGUsoRNgqDCO8Pdn7pqsOQhPjUmqgUXm/
 ZT97cnJ4DpunJZxyjLXAK09qDF7vmtUTekQReYcxevW8F3Ug4V62G/HXzuodFkq7GwjcRI+Cm
 beebBru3jT7lKomo0nns/qgEL/J7dL0sv7IDQWykzeOLiVq+gZq+DNiI7aU4HXEWuU2mGXcVK
 Ck3KBT0L94E3KTYTquBla/EpHPiYgelDOK1bP6ciyfTWrY8AM+BNM2rpuBsqzqxIc2Wh+zrVm
 6hHvTgRxnzaKW6F+9JII4UhmVc75j3oHeg2DoM8dy/Kh8Otye4SsuztYw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1688576404-1655553327=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, 16 Jun 2022, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 2022-06-15 16:50:40:
>
> > On Tue, 14 Jun 2022, Michael J Gruber wrote:
> >
> > > 0527ccb1b5 ("add -i: default to the built-in implementation", 2021-1=
1-30)
> > > switched to the implementation which fixed to subtest. Mark them as
> > > expect_success now.
> >
> > Good catch!
>
> I'm no list regular anymore, but still a "next+ regular". While
> experimenting with my own patch I noticed something got fixed
> unexpectedly. That goes to show that these unexpected successes
> (from expect_failure) go unnoticed too easily. I had missed this on my
> regular rebuilds.

Makes sense.

> > However... that commit specifically contains this change:
> >
> >         diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-test=
s.sh
> >         index cc62616d806..660ebe8d108 100755
> >         --- a/ci/run-build-and-tests.sh
> >         +++ b/ci/run-build-and-tests.sh
> >         @@ -29,7 +29,7 @@ linux-gcc)
> >                 export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D1
> >                 export GIT_TEST_MULTI_PACK_INDEX=3D1
> >                 export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=3D1
> >         -       export GIT_TEST_ADD_I_USE_BUILTIN=3D1
> >         +       export GIT_TEST_ADD_I_USE_BUILTIN=3D0
> >                 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
> >                 export GIT_TEST_WRITE_REV_INDEX=3D1
> >                 export GIT_TEST_CHECKOUT_WORKERS=3D2
> >
> > The intention is to have t3701 be run with the non-built-in version of
> > `git add -i` in the `linux-gcc` job, and I am surprised that those two
> > tests do not fail for you in that case.
> >
> > Did you run this through the CI builds?
>
> That's why I mentioned "no list regular" - I didn't know about that knob
> nor the intention to have the test suite run with either implementation
> (rather than switching to the new one for good).
>
> I do local builds, usually with
>
> ```
> DEVELOPER=3D1 (which I had to disable during the bisect run; gcc12...)
> DEFAULT_TEST_TARGET=3Dprove
> GIT_PROVE_OPTS=3D--jobs 4
> GIT_TEST_OPTS=3D--root=3D/dev/shm/t --chain-lint
> SHELL_PATH=3D/bin/dash
> SKIP_DASHED_BUILT_INS=3Dy
> ```
>
> in config.mak. Nothing else strikes me as potentially relevant.
>
> =C3=86var noticed this and has a better version of my patch, I think.

So you did not find it utterly rude and presumptuous that somebody sent a
new iteration of your patch without even so much as consulting with you
whether you're okay with this? I salute your forbearance, then.

Besides, it is not really a better version of your patch. That would have
been:

=2D- snip --
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 94537a6b40a..6d1032fe8ae 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -538,7 +538,9 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	! grep "^+15" actual
 '

-test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
+test_lazy_prereq BUILTIN_ADD_I 'test_bool_env GIT_TEST_ADD_I_USE_BUILTIN =
true'
+
+test_expect_success BUILTIN_ADD_I 'split hunk "add -p (no, yes, edit)"' '
 	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
 	git reset &&
 	# test sequence is s(plit), n(o), y(es), e(dit)
@@ -562,7 +564,7 @@ test_expect_success 'split hunk with incomplete line a=
t end' '
 	test_must_fail git grep --cached before
 '

-test_expect_failure 'edit, adding lines to the first hunk' '
+test_expect_failure BUILTIN_ADD_I 'edit, adding lines to the first hunk' =
'
 	test_write_lines 10 11 20 30 40 50 51 60 >test &&
 	git reset &&
 	tr _ " " >patch <<-EOF &&
=2D- snap --

As you can see, this is _actually_ building on your work rather than
replacing it.

But since that replacement made it into -rc1, I will stop spending brain
cycles on it.

Thank you for your contribution, I am glad that you keep sending patches
to the Git mailing list!
Dscho

--8323328-1688576404-1655553327=:349--
