Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3E6C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 13:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379803AbiEENs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbiEENs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 09:48:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EC557983
        for <git@vger.kernel.org>; Thu,  5 May 2022 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651758275;
        bh=8cBK/KKCmqvmEtIGW3QRG8tvgmY59xbuYGc1f46jNZ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bVYSZJdLxmWrMfcSvrdQAeEzSQ1whdBXHyTICtAhx5Ao7+zmiMj1inJ6mJUM6k+hk
         jnywRA07VIoGwMwdv0t7aoPucbDcyZLSNaod/a1dC21DHOoxFt5Egzrx0do5ORZPqD
         IdkLtpz438ub/u7wcWOWf/A1TGSh/53mPM2UWIKo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.146.35] ([213.196.213.50]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1nxAao2OZV-012DsB; Thu, 05
 May 2022 15:44:35 +0200
Date:   Thu, 5 May 2022 15:44:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        phillip.wood123@gmail.com,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
In-Reply-To: <20220503065442.95699-2-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com> <20220503065442.95699-2-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-418470288-1651758275=:355"
X-Provags-ID: V03:K1:1vEyJUlwe+pMdNbKnJjz78AWj9wrvpRnMxP2FRY8BNz8ixmJQGj
 S0yagSUNtFylrsIoTviwCkO5wZwhrreNIZx8W6iiV0+OkM/rN/cW0J3bvLZmUY9mU6AX7v1
 +iXKRnhiINKkkXu5l5wnjdCqBdKhdrPhLFbDE6OmESj117wuR8i9hK6vt/HcPWz3ZisYgjV
 AxNNQkt6roXijSfaCC/MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nabjwb2+FmY=:zfyn686l7om8M2m+HX7b47
 Syt9R378uIB3NvYg4QR/+OVBc4y8dFkClUBAsiqYv7QfIrKpuYEHG1+kS6SBn36lFmb6k1wyo
 xS1kDDMtN9bwLcwIOuP9LO+l92tqLpl1Dj4mcHirKglnTNU1X598ElQGJP2o4OidRDImuru8z
 KZa10C2YBlslmwPB72zB4Gs0vFdOVp0L6O36dLRlWedzNiDGq4k+GBdgJ28827CYZAABAQ5c0
 sjoLKkZjNmQ0/8cpIaSAWwNT48fwvxNy0wNsUTxSLmwQ19gGIxSdch1p4HB6K/PXWXtO/Uubc
 LZL+9VxBoYffRGMQCYAs/QDkzv0PkmBjODyDovi26O1C1g5o0JC/Xv9RNdqAHcuhXnXWgpx6M
 ttUasZAyFhTQknxzAptneVxb2WmGZ3gsbysUF9Z+H1U2BnPkF+stZjH0bmsPj78in/9d8KUy8
 d2Jfm+iHGzzR7frD7xkz3AaAr2yak+eVd/LZd7XibP+RuO4zQKcZeRQyItc5Fa7irvQnaVrtd
 FB0kLkC97uzbIfZJTo2zczAWaNlHABjcN04SJGazcFuH87PGG4bFewuCfbNlmX63kd3WbhCi2
 YcoBI68azfQmRYgtg3OPhxCrNdNFUI/EGYBIdIc+oI28BvxLGUhk6pHmohfAQqL0FlXFPrcSS
 SYKUfHAXOE7j/ZP9FxlDIWA9+eoBDDSLJBg1eSege/tIHZKWbtvTZ5lCFrnJ8+JAVHl2aw/wj
 DxN5BZd5hHiSO0aswzbclVxObvpkzWDIpcE9T63DuNcsvawEFUsMMcCWfVhqKuM54nKVXCTUS
 rMXE75n6tivufMJNUb/b8HMTgzK4u1bGUvtMSkbodjZsIvMWAzsDGyolDrf0lnqJSaUyTwelP
 VxTIS8+DIOw7CNRQ7UX1sK2eMfJJV5h528MHTsE2Qp/XDbkJbaSgQ4duEvuaKR3I1fJB92PYm
 hr9jojmmRk0J+gAPLS7bTxbgSpA200PoESAvfJgyXgrUFwlp17ole4tcY8FKEsPlfMaK2eBvM
 T2jQ10LGcl9FfXlmZGbTqxWyPd8P4k4a0YKoGa3lFL5vsMRrTeUesBlxxVGVGkRY8/+6Hb3VS
 Ho3y+gb4qGgpto=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-418470288-1651758275=:355
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 2 May 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Originally reported after release of v2.35.2 (and other maint branches)
> for CVE-2022-24765 and blocking otherwise harmless commands that were
> done using sudo in a repository that was owned by the user.
>
> Add a new test script with very basic support to allow running git
> commands through sudo, so a reproduction could be implemented and that
> uses only `git status` as a proxy of the issue reported.
>
> Note that because of the way sudo interacts with the system, a much
> more complete integration with the test framework will require a lot
> more work and that was therefore intentionally punted for now.
>
> The current implementation requires the execution of a special cleanup
> function which should always be kept as the last "test" or otherwise
> the standard cleanup functions will fail because they can't remove
> the root owned directories that are used.  This also means that if
> failures are found while running the specifics of the failure might
> not be kept for further debugging and if the test was interrupted, it
> will be necessary to clean the working directory manually before
> restarting by running:
>
>   $ sudo rm -rf trash\ directory.t0034-root-safe-directory/
>
> The test file also uses at least one initial "setup" test that creates
> a parallel execution directory, while ignoring the repository created
> by the test framework, and special care should be taken when invoking
> commands through sudo, since the environment is otherwise independent
> from what the test framework expects.  Indeed `git status` was used
> as a proxy because it doesn't even require commits in the repository
> to work.
>
> A new SUDO prerequisite is provided that does some sanity checking
> to make sure the sudo command that will be used allows for passwordless
> execution as root and doesn't mess with git execution paths, but
> otherwise additional work will be required to ensure additional
> commands behave as expected and that will be addressed in a later patch.
>
> Most of those characteristics make this test mostly suitable only for
> CI, but it could be executed locally if special care is taken to provide
> for some of them in the local configuration and maybe making use of the
> sudo credential cache by first invoking sudo, entering your password if
> needed, and then invoking the test by doing:
>
>   $ IKNOWWHATIAMDOING=3DYES ./t0034-root-safe-directory.sh

Hmm. I would like to suggest that we can side-step all of these issues
(and the ones I outline below) by considering a similar approach to the
one Stolee took in t0033: use one or more `GIT_TEST_*` environment
variables to pretend the exact scenario we want to test for.

>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t0034-root-safe-directory.sh | 49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100755 t/t0034-root-safe-directory.sh
>
> diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-director=
y.sh
> new file mode 100755
> index 00000000000..6dac7a05cfd
> --- /dev/null
> +++ b/t/t0034-root-safe-directory.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description=3D'verify safe.directory checks while running as root'
> +
> +. ./test-lib.sh
> +
> +if [ "$IKNOWWHATIAMDOING" !=3D "YES" ]
> +then
> +	skip_all=3D"You must set env var IKNOWWHATIAMDOING=3DYES in order to r=
un this test"
> +	test_done
> +fi
> +
> +# this prerequisite should be added to all the tests, it not only preve=
nts
> +# the test from failing but also warms up any authentication cache sudo
> +# might need to avoid asking for a password
> +test_lazy_prereq SUDO '
> +	sudo -n id -u >u &&
> +	id -u root >r &&
> +	test_cmp u r &&
> +	command -v git >u &&
> +	sudo command -v git >r &&

In my Ubuntu setup, `/bin/sh` is a symbolic link to `/bin/dash`, which
does not understand the `command`. It might make more sense to use `type`
here, but it is quite possible that `type git` uses a different output
format than `sudo type git` if they use different shells.

Another complication is that the `/etc/sudoers` I have over here specifies
a `secure_path`, which prevents the directory with the just-built `git`
executable from being left in `PATH`. I had to edit `/etc/sudoers` _and_
change the script to using `sudo -sE` to fix these woes.

It took me a good chunk of time to figure out how to run these tests, and
I will have to remember to revert the temporary edit of `/etc/sudoers`
file. This is definitely not something I plan on doing often, so I wonder
how these regression tests can guarantee that no regressions are
introduced if they are so hard to run ;-)

> +	test_cmp u r
> +'
> +
> +test_expect_success SUDO 'setup' '
> +	sudo rm -rf root &&
> +	mkdir -p root/r &&
> +	sudo chown root root &&
> +	(
> +		cd root/r &&
> +		git init
> +	)
> +'
> +
> +test_expect_failure SUDO 'sudo git status as original owner' '
> +	(
> +		cd root/r &&
> +		git status &&
> +		sudo git status
> +	)
> +'
> +
> +# this MUST be always the last test, if used more than once, the next
> +# test should do a full setup again.
> +test_expect_success SUDO 'cleanup' '
> +	sudo rm -rf root

This would be more canonical as `test_when_finished "sudo rm -rf root"` in
the preceding test cases.

But as I said above, I would prefer it if we could figure out a way to
pretend a specific scenario via `GIT_TEST_*`. That would ensure not only
that those tests are easy to run, but also that they run whenever the test
suite runs.

Thank you for working on this!
Dscho

> +'
> +
> +test_done
> --
> 2.36.0.352.g0cd7feaf86f
>
>

--8323328-418470288-1651758275=:355--
