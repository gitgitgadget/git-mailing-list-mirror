Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDD8C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiHHN0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbiHHN0O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:26:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D702AE56
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659965167;
        bh=S/nmrLb39eu32EKB8NfzAdbrmPru/VdX4pQKEoBeb+8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=djjVStViHszhN0wF6SRs+Lh1kUO5Xs1uYAEwc1iwSzA3f0C0jbIkQugB3s9avqt42
         l2O81O/jP5kzFU95sN7+4vS5wPt/uCcbj5SGd187WN6JS97zJ+RMtnXiTovKTlZD5/
         L50aL+Q3IC+PykDVjiQhvsCoR4r1wQHkokVqtLQQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.182.192] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpSb-1njWA33tJx-00gJjJ; Mon, 08
 Aug 2022 15:26:06 +0200
Date:   Mon, 8 Aug 2022 15:26:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Rub=C3=A9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        rjusto <rjusto@gmail.com>
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous
 branch"
In-Reply-To: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
Message-ID: <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr>
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1205832110-1659965181=:226"
X-Provags-ID: V03:K1:GSv/2kH8sMZPIQ0LYjffZltOwaeTp6ynFcPaVg82o61Ogv9aLmF
 +ZL7MJVgnS2AZEnGQ+42/D60Izo3IY3FWAAq9KDjja6o329wglXkv0t5jADuVvw1Q0X+jKq
 2nrxXqLhSYF/pL6KuIA2XESiD2IdHFTUi9aIkxhJYpwt58Etvxgajm6tlwNI0bTazBc3/Rz
 yjMpDba/RI9Etu+bS5XpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VC2RJRNJWlM=:4n67vnqNE8sR5149GeiVOj
 PnZuw6VQsgYz2j54rgnU8LScgKHZrIG9OqgDlRy4NFfYMhbQyJxpFc+cJ2LzJhHVePoYQHQV3
 YdeJVVeAog8rQDdzy+JCxROwVCs51UX/BVd7VwXhHQkcrngiQPbNRIfZPCRSFLopw/7skF1xQ
 HYuuru4qH0Wo3UxFJC0ZmxkE6cNTWxCZ0BNFjbCgVL2QEkxzXsGQUzbudVUEm1deauwXAKJqd
 vHVY3je5lGbDAJzIcGA6DaMVdB4JmTMMz5Ezm6lZhH/SadzUJdWrhu+Js8FQTnh0Ac2YnoUdT
 9coyduNwmnfBDMAfKnPZiHyuqaHw62VmGclYT2fA72/0nF6szRWQ0tU+dzmL6DkmfiMmW0APw
 mqHJr3c02w2eljeYELQPc9dKB03iaV3nxiw58O1eZodOLygfWe/oeyOIDPw18wocLBf052zxl
 7ISj2gYaL6p1770iZz86G5kiYY2vIz0u8kVRZaSbM1/ava6hqy/0nyCIkot5/9e78i4vREFbs
 6vte1XXMB/WR/c9WgnI/K6S6D3//3XuKZ3mVW70A40HlKyWqaHn+VwQiB9ZRN87vU04/2W0qI
 ychiD54Ur2ljK02RjKcGA9WqQcoLdw0eN0vrdVa3FQ/vuM8oApfxdkcQbbJtPyKXwJKaHZXs9
 R2cZxUQlP67ZTVIWlJjVZW/4huzNwhHkm7x7C4YgUKOf2WdD3LetouNp0/LntUVGuYdVtm2S6
 0Yqjbqc555kLRj/d9X1qMwMGOsLuwohT3CRAmAAutsCEXCV/twOn/RfqLp1FJuXSOSKZbfsYO
 w1/eh4M4VeDND6pIdHcctD2281oybG189VaFzh/0+Vj7UErK1sWBPrjfssHztO/YWvms+3SRS
 5tYeO1srjgfjvZWedbiH3+gyZNeeW+ctFQJIKYi41v1523+BU+Rn4O9y2QIMySOUq09V+F4YT
 cEyWd74j8BkbgKFOap8Vv0C9ppJ3kx4KGFVVGMfErRVp9D0btPRv4/04mjGFdRAYDXQ5F3vFa
 fI20rDdEIbpjJENxjhFjfNJ9xWWUEzQDOsKqqXK0tCh6ecbYC9LVXL6HgSL2NAI2YARfjTgR3
 39mnFLReGNcJHN972YCg2PqDEmo8YHKMKijHtsla9+T5Ib9r/eK/q9KhA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1205832110-1659965181=:226
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rub=C3=A9n,

On Sun, 7 Aug 2022, Rub=C3=A9n Justo via GitGitGadget wrote:

> From: rjusto <rjusto@gmail.com>
>
> Align "branch" with the intuitive use of "-" as a short-hand
> for "@{-1}", like in "checkout" and "merge" commands.
>
> $ git branch -d -      # short-hand for: "git branch -d @{-1}"
> $ git branch -D -      # short-hand for: "git branch -D @{-1}"

A valuable goal!

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 55cd9a6e998..59c19f38d2e 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -241,6 +241,10 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,

Touching only the `delete_branches()` function suggests that other
commands are left as before, e.g. `git branch --unset-upstream -` would
probably fail.

That's fine, but the commit message claims that the `"-"` special-casing
is introduced for the `git branch` command, not just for `git branch -d`.

>  			die(_("Couldn't look up commit object for HEAD"));
>  	}

At this stage, we already handled the `--remotes` flag, therefore I think
that this patch does not do the intended thing for this command-line:

	git branch -d --remotes -

>
> +	if ((argc =3D=3D 1) && !strcmp(argv[0], "-")) {
> +		argv[0] =3D "@{-1}";
> +	}

This means that we only handle `git branch -d -`, but not `git branch -d
some-branch - some-other-branch`.

Could you fix that?

My thinking is that this probably should be a sibling of the `@{-1}`
handling, most likely somewhat like this (I only compile-tested this
patch, please take it from here):

=2D- snip --
diff --git a/object-name.c b/object-name.c
index 4d2746574cd..ae6c2ed7b83 100644
=2D-- a/object-name.c
+++ b/object-name.c
@@ -1420,6 +1420,12 @@ static int interpret_nth_prior_checkout(struct repo=
sitory *r,
 	const char *brace;
 	char *num_end;

+	if (namelen =3D=3D 1 && *name =3D=3D '-') {
+		brace =3D name;
+		nth =3D 1;
+		goto find_nth_checkout;
+	}
+
 	if (namelen < 4)
 		return -1;
 	if (name[0] !=3D '@' || name[1] !=3D '{' || name[2] !=3D '-')
@@ -1432,6 +1438,8 @@ static int interpret_nth_prior_checkout(struct repos=
itory *r,
 		return -1;
 	if (nth <=3D 0)
 		return -1;
+
+find_nth_checkout:
 	cb.remaining =3D nth;
 	cb.sb =3D buf;

=2D- snap --

Naturally, this has much bigger ramifications than just `git branch -d -`,
and might even obsolete some `-` special-casing elsewhere; I have not
looked to see if there is any such special-casing, and would like to ask
you to see whether you can find those and remove them in separate commits
after implementing (and testing) the above
`interpret_nth_prior_checkout()` approach.

Thanks,
Johannes

> +
>  	for (i =3D 0; i < argc; i++, strbuf_reset(&bname)) {
>  		char *target =3D NULL;
>  		int flags =3D 0;
>
> base-commit: 679aad9e82d0dfd8ef3d1f98fa4629665496cec9
> --
> gitgitgadget
>

--8323328-1205832110-1659965181=:226--
