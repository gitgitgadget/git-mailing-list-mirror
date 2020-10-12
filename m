Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE10C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58B62145D
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZFult6+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbgJLLye (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 07:54:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:43745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388255AbgJLLye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 07:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602503374;
        bh=3rZAu33qgURWJ8+0Tx1daYBaOM0iHsElO1nS+OEVt88=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZFult6+cVn3h8LeqRhrQYzk612dMJZxgcMsPUrRFcGU6zsdTj2I/YN31Wlj2nl0qv
         9rwwE8CeVDQm4s69KCm2Dc11C7A2pLP2ohwa4VdAa/EIx7osqnxIt+m7PKR+QRM45R
         6WXx4zvNdkKf48IW+2fgq/RnLMxOTFGQ/ixxBJVU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.146]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1k7F6w2m4K-00puBA; Mon, 12
 Oct 2020 13:49:34 +0200
Date:   Mon, 12 Oct 2020 13:49:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add -I<regex> tests
In-Reply-To: <20201012091751.19594-4-michal@isc.org>
Message-ID: <nycvar.QRO.7.76.6.2010121320190.50@tvgsbejvaqbjf.bet>
References: <20201001120606.25773-1-michal@isc.org> <20201012091751.19594-1-michal@isc.org> <20201012091751.19594-4-michal@isc.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-591424238-1602503374=:50"
X-Provags-ID: V03:K1:jaWNWoICS6fxdYMfnTa/fVkUFYTQ/A/414fK9E8PqepfxaFnLkr
 bZalIjM02UVN8jWdzx1GM/2NakXGFj2IBspADiRHIrSVx2T15boCK8QdD6FBvjkrimzIdBZ
 manNqLgPuFsZN8qA7BNX40a1Ne57bRQ0Qk4Bn8waQdOY/BHAiuodGTZ9psZm4p6q/8rokhP
 gvhmFiY8A3N1cNOxhHrnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehonx+KN+7Q=:d4SdEjXhKkegC3eU2s75HB
 f58Cxofa0u2ya5rJ+i4nEbj38MX6H8euzyPRZsFKt5LJjCJXOs+E2ZJ72Q743BVALPENoXKnp
 KplQGyRwt2ZjahfPeFxB1l7Y29nZwBtoWL2He8hhiws+Zzaa6OXkbjBVmRjpt3RTg6W0VUENN
 pGmVleZjkADgVnEhT8CHUnZlob1MbZfZuJUNq+1JfZ1EpsZUbj5dmdQ9o+My3YuqeQ2XFlYf3
 PWwy/TkD2cJr3UPtcMhGCwTeB7F0RZQ8z8TqcF+yE5uInlNooiz9vLA2ghl+0c1KfU/5mqsCK
 yrWzgaFKSpWBGRDLMDFZDO0jvJP8BJzSMm9W/P7FZ0C0QNpAlW4UlD8QgJPJkhDbi+KyIrQtY
 cP4ZTV0T8M5sgM0i2PMa6XITwVBHDZxzN6NxOiL0iVUS5KG+haPCuaQqM4pxqGp9jiOg0amiq
 +ofe7KLROZtPYUnjzjcGBaQ+T7KK54/5sw61Tc68jNvPoWcCvydH8+7w4GMw2EKGgRR7rji45
 jw6TylSJkTaaRzjY1qM4UG1HJ9WZ9nsdkfogBWs18TIIOactLGHACE0xTrfpz0dDsPF1vsyqQ
 YSjSIerl7wXdxS9+ZpIaJn4ci/NEXFXHQs+SYhjDqhN7HcJrZW+EF4OnWQD9LGjjgj56np+vr
 bXgifQKFxwDqfh+1COsODsAFsfENtVUUqi3RP8j6iHHTl/deW9IV0t95HFTzlZZEU30jLs0kx
 wy6jez9Yw5aS+Jv1V7ppX+v987OElLXksY6VP7pqAjthnexf9h0E9iYBeKUSHbieTXAFi1/fD
 x0BqdXuc9o6noVWGukp/3cMkEazMVR6f0GkRyJ9R5G/KB6ExgBXbHDo/cjLqcWCFShdoZGhxa
 VAZ7wyGeHhA1opydBLRPRJFjd+cCxgnS47uspaqSfup6FglsBQpgkKq9G/CzN/9FGnNSBszsm
 U2sdB8CM3ciDjePlRCoz6CsXUeZAFQJV2ZEOtTKIrXgMlfTsesUN+H0j+TwgmWVqbtjPfZhJG
 KzKvkARFhMxybwn9B2iqMv+Z/QmLpQ5ovjM7NiwFN7nur86d+mbANn8s7AiqTPRyJ7SQ6PPSw
 zgRk5o+OVCuxUztBU2L86MlVAHabXWrZyUxtZeNG8asBsFFOJ/4f9fDgbs+EoapMNYE3fpWhX
 lhfmNKcibpObnyLn01394Pj5OBBE6E80nKFihRdhHNYmkooJE4+eNryNEt33DVXq8d1r2XJoZ
 VJfwtu8pUYnccGsDjok3FD5PGjZqr/Lr8E0LZ4Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-591424238-1602503374=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Micha=C5=82,

On Mon, 12 Oct 2020, Micha=C5=82 K=C4=99pie=C5=84 wrote:

> Exercise the new -I<regex> diff option in various scenarios to ensure it
> behaves as expected.

Excellent. I was actually looking for a test in patch 2/3 and almost
commented about that.

>
> Signed-off-by: Micha=C5=82 K=C4=99pie=C5=84 <michal@isc.org>
> ---
>  t/t4069-diff-ignore-regex.sh | 426 +++++++++++++++++++++++++++++++++++

Hmm. I wonder whether we could do with a much more concise test script.
The test suite already takes a quite long time to run, which is not a
laughing matter: we had issues in the past where contributors would skip
running it because it took too long, and this test is sure to exacerbate
that problem.

I could imagine, for example, that it would be plenty enough to do
something like this instead:

=2D- snip --
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5c7b0122b4f..bf158be137f 100755
=2D-- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -6,6 +6,7 @@
 test_description=3D'Various diff formatting options'

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh

 test_expect_success setup '

@@ -473,4 +474,24 @@ test_expect_success 'diff-tree --stdin with log forma=
tting' '
 	test_cmp expect actual
 '

+test_expect_success '-I<regex>' '
+	seq 50 >I.txt &&
+	sed -e "s/13/ten and three/" -e "/7\$/d" <I.txt >J.txt &&
+	test_must_fail git diff --no-index -I"ten.*e" -I"^[124-9]" I.txt J.txt >=
actual &&
+	cat >expect <<-\EOF &&
+	diff --git a/I.txt b/J.txt
+	--- a/I.txt
+	+++ b/J.txt
+	@@ -34,7 +31,6 @@
+	 34
+	 35
+	 36
+	-37
+	 38
+	 39
+	 40
+	EOF
+	compare_diff_patch expect actual
+'
+
 test_done
=2D- snap --

Note how it tests various things in one go?

Thanks,
Dscho

P.S.: My main interest in the `-I` option is its use case for `git
range-diff` in Git's own context: if you want to compare your patches to
what entered the `seen` branch, there will _always_ be a difference
because Junio adds their DCO. Something like this can help that:

git range-diff \
	-I'^    Signed-off-by: Junio C Hamano <gitster@pobox.com>$' \
	<my-patch-range> <the-equivalent-in-seen>

>  1 file changed, 426 insertions(+)
>  create mode 100755 t/t4069-diff-ignore-regex.sh
>
> diff --git a/t/t4069-diff-ignore-regex.sh b/t/t4069-diff-ignore-regex.sh
> new file mode 100755
> index 0000000000..4ddf5c67ae
> --- /dev/null
> +++ b/t/t4069-diff-ignore-regex.sh
> @@ -0,0 +1,426 @@
> +#!/bin/sh
> +
> +test_description=3D'Test diff -I<regex>'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/diff-lib.sh
> +
> +test_expect_success setup '
> +	test_seq 20 >x &&
> +	git update-index --add x
> +'
> +
> +test_expect_success 'one line changed' '
> +	test_seq 20 | sed "s/10/100/" >x &&
> +
> +	# Get plain diff
> +	git diff >plain &&
> +	cat >expected <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -7,7 +7,7 @@
> +	 7
> +	 8
> +	 9
> +	-10
> +	+100
> +	 11
> +	 12
> +	 13
> +	EOF
> +	compare_diff_patch expected plain &&
> +
> +	# Both old and new line match regex - ignore change
> +	git diff -I "^10" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Both old and new line match some regex - ignore change
> +	git diff -I "^10\$" -I "^100" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Only old line matches regex - do not ignore change
> +	git diff -I "^10\$" >actual &&
> +	compare_diff_patch plain actual &&
> +
> +	# Only new line matches regex - do not ignore change
> +	git diff -I "^100" >actual &&
> +	compare_diff_patch plain actual &&
> +
> +	# Only old line matches some regex - do not ignore change
> +	git diff -I "^10\$" -I "^101" >actual &&
> +	compare_diff_patch plain actual &&
> +
> +	# Only new line matches some regex - do not ignore change
> +	git diff -I "^11\$" -I "^100" >actual &&
> +	compare_diff_patch plain actual
> +'
> +
> +test_expect_success 'one line removed' '
> +	test_seq 20 | sed "10d" >x &&
> +
> +	# Get plain diff
> +	git diff >plain &&
> +	cat >expected <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -7,7 +7,6 @@
> +	 7
> +	 8
> +	 9
> +	-10
> +	 11
> +	 12
> +	 13
> +	EOF
> +	compare_diff_patch expected plain &&
> +
> +	# Removed line matches regex - ignore change
> +	git diff -I "^10" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Removed line matches some regex - ignore change
> +	git diff -I "^10" -I "^100" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Removed line does not match regex - do not ignore change
> +	git diff -I "^101" >actual &&
> +	compare_diff_patch plain actual &&
> +
> +	# Removed line does not match any regex - do not ignore change
> +	git diff -I "^100" -I "^101" >actual &&
> +	compare_diff_patch plain actual
> +'
> +
> +test_expect_success 'one line added' '
> +	test_seq 21 >x &&
> +
> +	# Get plain diff
> +	git diff >plain &&
> +	cat >expected <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -18,3 +18,4 @@
> +	 18
> +	 19
> +	 20
> +	+21
> +	EOF
> +	compare_diff_patch expected plain &&
> +
> +	# Added line matches regex - ignore change
> +	git diff -I "^21" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Added line matches some regex - ignore change
> +	git diff -I "^21" -I "^22" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Added line does not match regex - do not ignore change
> +	git diff -I "^212" >actual &&
> +	compare_diff_patch plain actual &&
> +
> +	# Added line does not match any regex - do not ignore change
> +	git diff -I "^211" -I "^212" >actual &&
> +	compare_diff_patch plain actual
> +'
> +
> +test_expect_success 'last two lines changed' '
> +	test_seq 20 | sed "s/19/21/; s/20/22/" >x &&
> +
> +	# Get plain diff
> +	git diff >plain &&
> +	cat >expected <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -16,5 +16,5 @@
> +	 16
> +	 17
> +	 18
> +	-19
> +	-20
> +	+21
> +	+22
> +	EOF
> +	compare_diff_patch expected plain &&
> +
> +	# All changed lines match regex - ignore change
> +	git diff -I "^[12]" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# All changed lines match some regex - ignore change
> +	git diff -I "^1" -I "^2" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Not all changed lines match regex - do not ignore change
> +	git diff -I "^2" >actual &&
> +	compare_diff_patch plain actual &&
> +
> +	# Not all changed lines match some regex - do not ignore change
> +	git diff -I "^2" -I "^3" >actual &&
> +	compare_diff_patch plain actual
> +'
> +
> +test_expect_success 'two non-adjacent lines removed in the same hunk' '
> +	test_seq 20 | sed "1d; 3d" >x &&
> +
> +	# Get plain diff
> +	git diff >plain &&
> +	cat >expected <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -1,6 +1,4 @@
> +	-1
> +	 2
> +	-3
> +	 4
> +	 5
> +	 6
> +	EOF
> +	compare_diff_patch expected plain &&
> +
> +	# Both removed lines match regex - ignore hunk
> +	git diff -I "^[1-3]" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Both removed lines match some regex - ignore hunk
> +	git diff -I "^1" -I "^3" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# First removed line does not match regex - do not ignore hunk
> +	git diff -I "^[2-3]" >actual &&
> +	compare_diff_patch plain actual &&
> +
> +	# First removed line does not match any regex - do not ignore hunk
> +	git diff -I "^2" -I "^3" >actual &&
> +	compare_diff_patch plain actual &&
> +
> +	# Second removed line does not match regex - do not ignore hunk
> +	git diff -I "^[1-2]" >actual &&
> +	compare_diff_patch plain actual &&
> +
> +	# Second removed line does not match any regex - do not ignore hunk
> +	git diff -I "^1" -I "^2" >actual &&
> +	compare_diff_patch plain actual
> +'
> +
> +test_expect_success 'two non-adjacent lines removed in the same hunk, w=
ith -U1' '
> +	test_seq 20 | sed "1d; 3d" >x &&
> +
> +	# Get plain diff
> +	git diff -U1 >plain &&
> +	cat >expected <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -1,4 +1,2 @@
> +	-1
> +	 2
> +	-3
> +	 4
> +	EOF
> +	compare_diff_patch expected plain &&
> +
> +	# Both removed lines match regex - ignore hunk
> +	git diff -U1 -I "^[1-3]" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Both removed lines match some regex - ignore hunk
> +	git diff -U1 -I "^1" -I "^3" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# First removed line does not match regex, but is out of context - ign=
ore second change
> +	git diff -U1 -I "^[2-3]" >actual &&
> +	cat >second-change-ignored <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -1,2 +1 @@
> +	-1
> +	 2
> +	EOF
> +	compare_diff_patch second-change-ignored actual &&
> +
> +	# First removed line does not match any regex, but is out of context -=
 ignore second change
> +	git diff -U1 -I "^2" -I "^3" >actual &&
> +	compare_diff_patch second-change-ignored actual &&
> +
> +	# Second removed line does not match regex, but is out of context - ig=
nore first change
> +	git diff -U1 -I "^[1-2]" >actual &&
> +	cat >first-change-ignored <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -2,3 +1,2 @@
> +	 2
> +	-3
> +	 4
> +	EOF
> +	compare_diff_patch first-change-ignored actual &&
> +
> +	# Second removed line does not match any regex, but is out of context =
- ignore first change
> +	git diff -U1 -I "^1" -I "^2" >actual &&
> +	compare_diff_patch first-change-ignored actual
> +'
> +
> +test_expect_success 'multiple hunks' '
> +	test_seq 20 | sed "1d; 20d" >x &&
> +
> +	# Get plain diff
> +	git diff >plain &&
> +	cat >expected <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -1,4 +1,3 @@
> +	-1
> +	 2
> +	 3
> +	 4
> +	@@ -17,4 +16,3 @@
> +	 17
> +	 18
> +	 19
> +	-20
> +	EOF
> +	compare_diff_patch expected plain &&
> +
> +	# Ignore both hunks (single regex)
> +	git diff -I "^[12]" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Ignore both hunks (multiple regexes)
> +	git diff -I "^1" -I "^2" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Only ignore first hunk (single regex)
> +	git diff -I "^1" >actual &&
> +	cat >first-hunk-ignored <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -17,4 +16,3 @@
> +	 17
> +	 18
> +	 19
> +	-20
> +	EOF
> +	compare_diff_patch first-hunk-ignored actual &&
> +
> +	# Only ignore first hunk (multiple regexes)
> +	git diff -I "^0" -I "^1" >actual &&
> +	compare_diff_patch first-hunk-ignored actual &&
> +
> +	# Only ignore second hunk (single regex)
> +	git diff -I "^2" >actual &&
> +	cat >second-hunk-ignored <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -1,4 +1,3 @@
> +	-1
> +	 2
> +	 3
> +	 4
> +	EOF
> +	compare_diff_patch second-hunk-ignored actual &&
> +
> +	# Only ignore second hunk (multiple regexes)
> +	git diff -I "^2" -I "^3" >actual &&
> +	compare_diff_patch second-hunk-ignored actual
> +'
> +
> +test_expect_success 'multiple hunks, with --ignore-blank-lines' '
> +	echo >x &&
> +	test_seq 21 >>x &&
> +
> +	# Get plain diff
> +	git diff >plain &&
> +	cat >expected <<-EOF &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -1,3 +1,4 @@
> +	+
> +	 1
> +	 2
> +	 3
> +	@@ -18,3 +19,4 @@
> +	 18
> +	 19
> +	 20
> +	+21
> +	EOF
> +	compare_diff_patch expected plain &&
> +
> +	# -I does not override --ignore-blank-lines - ignore both hunks (singl=
e regex)
> +	git diff --ignore-blank-lines -I "^21" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# -I does not override --ignore-blank-lines - ignore both hunks (multi=
ple regexes)
> +	git diff --ignore-blank-lines -I "^21" -I "^12" >actual &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success 'diffstat' '
> +	test_seq 20 | sed "s/^5/0/p; s/^15/10/; 16d" >x &&
> +
> +	# Get plain diffstat
> +	git diff --stat >actual &&
> +	cat >expected <<-EOF &&
> +	 x | 6 +++---
> +	 1 file changed, 3 insertions(+), 3 deletions(-)
> +	EOF
> +	test_cmp expected actual &&
> +
> +	# Ignore both hunks (single regex)
> +	git diff --stat -I "^[0-5]" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Ignore both hunks (multiple regexes)
> +	git diff --stat -I "^0" -I "^1" -I "^5" >actual &&
> +	test_must_be_empty actual &&
> +
> +	# Only ignore first hunk (single regex)
> +	git diff --stat -I "^[05]" >actual &&
> +	cat >expected <<-EOF &&
> +	 x | 3 +--
> +	 1 file changed, 1 insertion(+), 2 deletions(-)
> +	EOF
> +	test_cmp expected actual &&
> +
> +	# Only ignore first hunk (multiple regexes)
> +	git diff --stat -I "^0" -I "^5" >actual &&
> +	test_cmp expected actual &&
> +
> +	# Only ignore second hunk (single regex)
> +	git diff --stat -I "^1" >actual &&
> +	cat >expected <<-EOF &&
> +	 x | 3 ++-
> +	 1 file changed, 2 insertions(+), 1 deletion(-)
> +	EOF
> +	test_cmp expected actual &&
> +
> +	# Only ignore second hunk (multiple regexes)
> +	git diff --stat -I "^1" -I "^2" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'invalid regexes' '
> +	>x &&
> +
> +	# Single invalid regex
> +	git diff -I "^[1" 2>&1 | grep "invalid regex: " &&
> +
> +	# Two regexes: first invalid, second valid
> +	git diff -I "^[1" -I "^1" 2>&1 | grep "invalid regex: " &&
> +
> +	# Two invalid regexes
> +	git diff -I "^[1" -I "^[2" 2>&1 | grep "invalid regex: "
> +'
> +
> +test_done
> --
> 2.28.0
>
>

--8323328-591424238-1602503374=:50--
