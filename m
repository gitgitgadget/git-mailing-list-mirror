Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BA0C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 13:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D172C2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 13:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Li728QOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgEYNQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 09:16:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:37753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388756AbgEYNQx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 09:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590412610;
        bh=scomIOYEBaT9LZJpT2NT5Zma5z9RQByzCpJRHR1lamY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Li728QOmSWL0gqGbAd9Vgj5vxrEccYuBeGqVe/kdBZV64pF24q53iZz/X5RDlYanj
         7Bo0Jc4wuc16B/sL0+v2JgCf9SJOS11dFvn+2vcTmlYQp8bz7VwkEjaduV+JF5EuyA
         BBre0DvkUOUjUI5xYp+PaKiSuOY9OLdb5lGS4+zU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.52]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5eR-1jMMNQ3Int-00J2cR; Mon, 25
 May 2020 15:16:49 +0200
Date:   Mon, 25 May 2020 01:00:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hook: add list command
In-Reply-To: <20200521185414.43760-4-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2005250055180.56@tvgsbejvaqbjf.bet>
References: <20200521185414.43760-1-emilyshaffer@google.com> <20200521185414.43760-4-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vE7mYgeqxqy9aQEDGDq0IUhbsUncLDjvNRDswS1hL3ddWmoqFMk
 r3AgFBCEyjF1QnF6jEkrDvfGwFOFqqMgRl4aj6AuxmFKIrooaIDi6mdiGtgA65dDlwaanLl
 ASocXCsEro2SNN17bqkr8heMuqdWjGpl7OvkIwZwqzyuq+IMjOD57QH3WkuJ1kzRlq3KQf5
 iWI/3O6UCyAZ84GMKC+rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:skfHkLq7MPo=:VvgLjcPN6XoxqQkSOAc7tq
 b8QOyZVYa5a/FJKL3gEt1hT5YaJQYDSwrIhmitcTu/t7OJwWwKdy6bvjnZ8D5qpGuW2ip5f/Y
 515CQHSrw/OAqYxB+bMJ//ws5TpnQPJkYtykMPrnswZfYFNRn+SCvbafqkp+IhJundjiPra5K
 +gjinTdZ5q5fxVBsoZl40hYJViN8nP2vr3OJKr4h0oWlGNv0Ab3glug4Z6o1UG0HgrELMPLMU
 vq3s2phgzv7UTKuwkzBQRH6/m1cYEVo9SBZvM6WIxXnsuLDFyaKRlsy9cWaRYddSq8i9nLQLY
 0QiL6cUrGF5VEEAKvoxCJcFZHp9BI37cWSgKQv14kD+Uhpl2P/0cJzU43XMVAassnpLcCqUgl
 erETZKYe9GS9JL4Tv2dA5cxq2jinqHkoVRM6Q8MVErAzmcMedIt2S8S60eO7vHdS7SGmmt6oa
 fw36Btphohxzh1yZb2XCbbXh0JAuKlZN/ZV/xrKZ7MjTc7vz4ozTSDcCP8z385PHoVdDkoQSw
 5eh09eiMPw7jn6qQmuMlXGL4LGre4W5hzcJMKc60RaXcYB7f193HcjLRdBkdovev/mKZvWfIT
 D7FHLkBUPDvCSNN/gOhy4VPyDjCQpONU+giBxYahDTijPtvRjptbxLHVV+0vnbgDAMmgNsU8a
 6gdPGSad/zkyMNUstJNScFDmr2UPOk+bPp0qFBcln9tkIuUpF1z0Inj3ZytGwiJ6csCl6vy/E
 ERfehyLDepe76B2DMmAlP0zTpkswv5wQLqnoyHbT1EZhRurG0TfZNxy7wbO8LBnn7EYfscMRj
 Q31DRVIuoOkUxVpvvoCYzN8+6OCxI8Ch7TFyAea4eUOpnDjcW2pSCnxl2djQxedS33cbfgAWW
 kePIYjAWzvXhFeVmURbLyA03CiZjQreT/EffcvvsXRHOhNZyZ7Bhd0FHqWRVLk2bGbuydXPpX
 uWbm1F+I+a4XEtT3ow9kGhCUKqAHiIll3vjQJRTRRNv3hjkeIyHezeVv2WzwMH5+BA3U3E3uY
 IVfeVDpnF5NRxjXNdiJYRJcEwbE0DCtWpStvN1SGDVNWBtcRJIJltBwDPgctkHjq9QswgKHT6
 CIGfnHJnfbL5l60UCPGG88ecNpGDrCJOIt9Yqg3lWSk/JQApYCcwzLx3fB81g13Fb6vuk7Zd8
 TxE6vXArBZ9xRBzNzC4C8xXKE+kYl+ssOVcKauh7fzR829UfvoBdi01XbM09MbrgRCuk0UldC
 V6OaawRIUnI+N9wy7
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 21 May 2020, Emily Shaffer wrote:

> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.=
sh
> index 34b0df5216..4e46d7dd4e 100755
> --- a/t/t1360-config-based-hooks.sh
> +++ b/t/t1360-config-based-hooks.sh
> @@ -4,8 +4,55 @@ test_description=3D'config-managed multihooks, includin=
g git-hook command'
>
>  . ./test-lib.sh
>
> -test_expect_success 'git hook command does not crash' '
> -	git hook
> +test_expect_success 'git hook rejects commands without a mode' '
> +	test_must_fail git hook pre-commit
> +'
> +
> +
> +test_expect_success 'git hook rejects commands without a hookname' '
> +	test_must_fail git hook list
> +'
> +
> +test_expect_success 'setup hooks in global, and local' '
> +	git config --add --local hook.pre-commit.command "/path/ghi" &&
> +	git config --add --global hook.pre-commit.command "/path/def"
> +'
> +
> +test_expect_success 'git hook list orders by config order' '
> +	cat >expected <<-\EOF &&
> +	global:	/path/def
> +	local:	/path/ghi
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual

This, as well as the next two test cases, won't work on Windows, as you
almost certainly realized from looking at the failed GitHub workflow run
of your branch.

The reason is that Unix-like absolute paths like `/path/def` do _not_ do
what you think on Windows: they are relative to the MSYS2 root (because
the shell script runs in an MSYS2 Bash). The Git executable, however, has
not the slightest idea about MSYS2 and does not handle those. To remedy
that, the MSYS2 Bash prefixes those paths with the absolute
_Windows-style_ path when passing them to `git.exe` (in your case,
actually in the `setup hooks` test case above).

So you will need to squash this (or an equivalent fix) into your patch:

=2D- snip --
=46rom f2568d47509130a9c35590d907797d2eb813ac0d Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 25 May 2020 15:03:16 +0200
Subject: [PATCH] fixup??? hook: add list command

This is needed to make the tests pass on Windows, where Unix-like
absolute paths are not what you think they are.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t1360-config-based-hooks.sh | 39 +++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 3296d8af4587..c862655fd4d9 100755
=2D-- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -18,10 +18,19 @@ test_expect_success 'setup hooks in global, and local'=
 '
 	git config --add --global hook.pre-commit.command "/path/def"
 '

+ROOT=3D
+if test_have_prereq MINGW
+then
+	# In Git for Windows, Unix-like paths work only in shell scripts;
+	# `git.exe`, however, will prefix them with the pseudo root directory
+	# (of the Unix shell). Let's accommodate for that.
+	ROOT=3D"$(cd / && pwd)"
+fi
+
 test_expect_success 'git hook list orders by config order' '
-	cat >expected <<-\EOF &&
-	global:	/path/def
-	local:	/path/ghi
+	cat >expected <<-EOF &&
+	global:	$ROOT/path/def
+	local:	$ROOT/path/ghi
 	EOF

 	git hook list pre-commit >actual &&
@@ -32,10 +41,10 @@ test_expect_success 'git hook list dereferences a hook=
cmd' '
 	git config --add --local hook.pre-commit.command "abc" &&
 	git config --add --global hookcmd.abc.command "/path/abc" &&

-	cat >expected <<-\EOF &&
-	global:	/path/def
-	local:	/path/ghi
-	local:	/path/abc
+	cat >expected <<-EOF &&
+	global:	$ROOT/path/def
+	local:	$ROOT/path/ghi
+	local:	$ROOT/path/abc
 	EOF

 	git hook list pre-commit >actual &&
@@ -45,10 +54,10 @@ test_expect_success 'git hook list dereferences a hook=
cmd' '
 test_expect_success 'git hook list reorders on duplicate commands' '
 	git config --add --local hook.pre-commit.command "/path/def" &&

-	cat >expected <<-\EOF &&
-	local:	/path/ghi
-	local:	/path/abc
-	local:	/path/def
+	cat >expected <<-EOF &&
+	local:	$ROOT/path/ghi
+	local:	$ROOT/path/abc
+	local:	$ROOT/path/def
 	EOF

 	git hook list pre-commit >actual &&
@@ -56,10 +65,10 @@ test_expect_success 'git hook list reorders on duplica=
te commands' '
 '

 test_expect_success 'git hook list --porcelain prints just the command' '
-	cat >expected <<-\EOF &&
-	/path/ghi
-	/path/abc
-	/path/def
+	cat >expected <<-EOF &&
+	$ROOT/path/ghi
+	$ROOT/path/abc
+	$ROOT/path/def
 	EOF

 	git hook list --porcelain pre-commit >actual &&
=2D-
2.27.0.rc1.windows.1

=2D- snap --

Ciao,
Dscho

> +'
> +
> +test_expect_success 'git hook list dereferences a hookcmd' '
> +	git config --add --local hook.pre-commit.command "abc" &&
> +	git config --add --global hookcmd.abc.command "/path/abc" &&
> +
> +	cat >expected <<-\EOF &&
> +	global:	/path/def
> +	local:	/path/ghi
> +	local:	/path/abc
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git hook list reorders on duplicate commands' '
> +	git config --add --local hook.pre-commit.command "/path/def" &&
> +
> +	cat >expected <<-\EOF &&
> +	local:	/path/ghi
> +	local:	/path/abc
> +	local:	/path/def
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
>  '
>
>  test_done
> --
> 2.27.0.rc0.183.gde8f92d652-goog
>
>
>
