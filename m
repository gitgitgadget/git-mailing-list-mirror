Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCA01F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfFYJFt (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:05:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:36461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbfFYJFt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561453542;
        bh=UJvt2SOGu/6bYYAAzQn79Z7aGMVt5OdwjS7SfpqKXPs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=STIZNQqgYySOOIWbRAG2i3ASX6F22s/dig8azbK2A6fVBzzLHpKIZON9m2l+JkeSb
         A7fPvzYhMbxwjvhxHw1lBI+MNxrZA4An6eULCyzZSslQpFSUGcLG3ajxEAbw6gUmt0
         88DkdoD7H8Ft3WVKfc9NFCyFTEhEtpagEZvK4vGE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdebB-1iETyu2FHt-00Zcd0; Tue, 25
 Jun 2019 11:05:41 +0200
Date:   Tue, 25 Jun 2019 11:06:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/5] t3404: modernize here doc style
In-Reply-To: <20190624181318.17388-2-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906251104300.44@tvgsbejvaqbjf.bet>
References: <20190611130320.18499-1-szeder.dev@gmail.com> <20190624181318.17388-1-szeder.dev@gmail.com> <20190624181318.17388-2-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1252390739-1561453562=:44"
X-Provags-ID: V03:K1:AK3tOGZCQPgngDboWymP/nsG7F9bn6SO7ttOx5EH3Lj/DKzVh5/
 TKqZdkO3wStoxWR5tvL4qPF0Bb2DVN8q3kozwwabWW4ZB86lUtidCYOa2+1PLiWqRVs8V8Y
 OcQ+8atm/1y9d4GQVJHO71pyv8V+G7ta5x53WD++wUWovEm+Mor7U0NI/ZB7lWOpYW2VKxm
 v0cJftUeagUyOGsHLWgvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8gp+6QXk14o=:Um9A//lD9l+i+9JxYvAWOO
 ox2Q4J4KNh7hpxqFR/yg8nmTViAC6R9Fmib1jnGAFc5pzFkTwCbc3oNEru2qT0120SZZHm8IA
 O2PKOCn56uMwOFCsFbLtwZxgv/HK0tnK7WL5ZZy8IqSXEr5E9QuYzqOq5a9Ph8fRJ9wSVBddj
 8IYZ+8E8mMXROPdeqK3Cz9AEE+oLtGs7hbkLb3nTyLUKhECZg9HBDhnpeevIXbR0Ut+wGtTWg
 VU/TkSbonsY5XQ5Vo35WM8EgOZ1sAKLQtN1Da28xS+1qTTbCZCL8PVabRv3VvJN9SHTs30zVi
 2ROIDZeKSXCWeGuljRMB6+H5wZKJPRqezS1Tj9+smIisCl9/mPXjCYrpsxNEaBsNfp/QTahOS
 sR7MIcgCwrVrcUNSrXhx+DJId3ikTwCbkl4HOf52/zzs0A+yOMDU5NKqj4wPBuui7kjUeSuSQ
 4yLyKoSMk6hMkYpwg6l6WgsZjDBJvl6kXuhjhGt2WNIO7wBFQIrnmPC/6Py2rmOC8W20tfN0u
 GOtQAjx61R4Ew03wQu8wvF6vlEpGSYy2VCuU6pQC2Hd1btjLD7A63/YTPMyldTR6UNEb4rI++
 19tOxosHEkxiqUd3+1+W2Ma7FoKx0uRq7DbHXpg+fP8LFiFIcXHlFTtytB7CG5/EUBT2BxuOs
 dc7W8Q9wZZfrWgSitSkiYQC/blGcEWt398ZLDO04UT8wPGP1CHt/FFetMD9jn5kaKWT3LyXGX
 xabjbcDAtzTkgKRG15vHs2oMbpsWY6XdOxd6tcctz58EyK+4GLuWfRHAg27a+S1X6Q5wLmTEf
 sVFkcoEvXLN0H+hUsH3MhVI+300aY7xDCTpI3hAF3oat5L5TXj/BHWcBwSr4H5n5kYlULAI7c
 FJbv81GPnALDOq/+X6wAwAZabeMvkgkfOKO4V3q7EU7tvQL5cfy/xFMW/6jYrA+RHKZzF/Vqg
 XdKgt8ofHIepvo/SXdVCUp2RvfSB60DuuH5KUEPJMuF0/3q4O9r3E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1252390739-1561453562=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 24 Jun 2019, SZEDER G=C3=A1bor wrote:

> In 't3404-rebase-interactive.sh' the expected output of several tests
> is prepared from here documents, which are outside of
> 'test_expect_success' blocks and have spaces around redirection
> operators.
>
> Move these here documents into the corresponding 'test_expect_success'
> block and avoid spaces between filename and redition operators.
> Furthermore, quote the here docs' delimiter word to prevent parameter
> expansions and what not, where applicable.

Makes sense. I did not really look at it in detail (it's a bit tough to
read, and `--patience` would have made it only _slightly_ easier),
trusting that you used `git diff -w --color-moved` to verify the moves.

Thanks,
Dscho

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 123 ++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 65 deletions(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.=
sh
> index 1723e1a858..9146f9d47b 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -75,11 +75,10 @@ test_expect_success 'rebase --keep-empty' '
>  	test_line_count =3D 6 actual
>  '
>
> -cat > expect <<EOF
> -error: nothing to do
> -EOF
> -
>  test_expect_success 'rebase -i with empty HEAD' '
> +	cat >expect <<-\EOF &&
> +	error: nothing to do
> +	EOF
>  	set_fake_editor &&
>  	test_must_fail env FAKE_LINES=3D"1 exec_true" git rebase -i HEAD^ >act=
ual 2>&1 &&
>  	test_i18ncmp expect actual
> @@ -237,25 +236,23 @@ test_expect_success 'exchange two commits' '
>  	test G =3D $(git cat-file commit HEAD | sed -ne \$p)
>  '
>
> -cat > expect << EOF
> -diff --git a/file1 b/file1
> -index f70f10e..fd79235 100644
> ---- a/file1
> -+++ b/file1
> -@@ -1 +1 @@
> --A
> -+G
> -EOF
> -
> -cat > expect2 << EOF
> -<<<<<<< HEAD
> -D
> -=3D=3D=3D=3D=3D=3D=3D
> -G
> ->>>>>>> 5d18e54... G
> -EOF
> -
>  test_expect_success 'stop on conflicting pick' '
> +	cat >expect <<-\EOF &&
> +	diff --git a/file1 b/file1
> +	index f70f10e..fd79235 100644
> +	--- a/file1
> +	+++ b/file1
> +	@@ -1 +1 @@
> +	-A
> +	+G
> +	EOF
> +	cat >expect2 <<-\EOF &&
> +	<<<<<<< HEAD
> +	D
> +	=3D=3D=3D=3D=3D=3D=3D
> +	G
> +	>>>>>>> 5d18e54... G
> +	EOF
>  	git tag new-branch1 &&
>  	set_fake_editor &&
>  	test_must_fail git rebase -i master &&
> @@ -495,15 +492,14 @@ test_expect_success 'commit message retained after=
 conflict' '
>  	git branch -D conflict-squash
>  '
>
> -cat > expect-squash-fixup << EOF
> -B
> -
> -D
> +test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct =
log messages' '
> +	cat >expect-squash-fixup <<-\EOF &&
> +	B
>
> -ONCE
> -EOF
> +	D
>
> -test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct =
log messages' '
> +	ONCE
> +	EOF
>  	git checkout -b squash-fixup E &&
>  	base=3D$(git rev-parse HEAD~4) &&
>  	set_fake_editor &&
> @@ -799,13 +795,12 @@ test_expect_success 'rebase -i can copy notes' '
>  	test "a note" =3D "$(git notes show HEAD)"
>  '
>
> -cat >expect <<EOF
> -an earlier note
> -
> -a note
> -EOF
> -
>  test_expect_success 'rebase -i can copy notes over a fixup' '
> +	cat >expect <<-\EOF &&
> +	an earlier note
> +
> +	a note
> +	EOF
>  	git reset --hard n3 &&
>  	git notes add -m"an earlier note" n2 &&
>  	set_fake_editor &&
> @@ -1304,27 +1299,26 @@ test_expect_success 'rebase -i respects rebase.m=
issingCommitsCheck =3D ignore' '
>  		actual
>  '
>
> -cat >expect <<EOF
> -Warning: some commits may have been dropped accidentally.
> -Dropped commits (newer to older):
> - - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
> -To avoid this message, use "drop" to explicitly remove a commit.
> -
> -Use 'git config rebase.missingCommitsCheck' to change the level of warn=
ings.
> -The possible behaviours are: ignore, warn, error.
> -
> -Rebasing (1/4)
> -Rebasing (2/4)
> -Rebasing (3/4)
> -Rebasing (4/4)
> -Successfully rebased and updated refs/heads/missing-commit.
> -EOF
> -
>  cr_to_nl () {
>  	tr '\015' '\012'
>  }
>
>  test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D =
warn' '
> +	cat >expect <<-EOF &&
> +	Warning: some commits may have been dropped accidentally.
> +	Dropped commits (newer to older):
> +	 - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
> +	To avoid this message, use "drop" to explicitly remove a commit.
> +
> +	Use '\''git config rebase.missingCommitsCheck'\'' to change the level =
of warnings.
> +	The possible behaviours are: ignore, warn, error.
> +
> +	Rebasing (1/4)
> +	Rebasing (2/4)
> +	Rebasing (3/4)
> +	Rebasing (4/4)
> +	Successfully rebased and updated refs/heads/missing-commit.
> +	EOF
>  	test_config rebase.missingCommitsCheck warn &&
>  	rebase_setup_and_clean missing-commit &&
>  	set_fake_editor &&
> @@ -1335,21 +1329,20 @@ test_expect_success 'rebase -i respects rebase.m=
issingCommitsCheck =3D warn' '
>  	test D =3D $(git cat-file commit HEAD | sed -ne \$p)
>  '
>
> -cat >expect <<EOF
> -Warning: some commits may have been dropped accidentally.
> -Dropped commits (newer to older):
> - - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
> - - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master~2)
> -To avoid this message, use "drop" to explicitly remove a commit.
> -
> -Use 'git config rebase.missingCommitsCheck' to change the level of warn=
ings.
> -The possible behaviours are: ignore, warn, error.
> -
> -You can fix this with 'git rebase --edit-todo' and then run 'git rebase=
 --continue'.
> -Or you can abort the rebase with 'git rebase --abort'.
> -EOF
> -
>  test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D =
error' '
> +	cat >expect <<-EOF &&
> +	Warning: some commits may have been dropped accidentally.
> +	Dropped commits (newer to older):
> +	 - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
> +	 - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master~2)
> +	To avoid this message, use "drop" to explicitly remove a commit.
> +
> +	Use '\''git config rebase.missingCommitsCheck'\'' to change the level =
of warnings.
> +	The possible behaviours are: ignore, warn, error.
> +
> +	You can fix this with '\''git rebase --edit-todo'\'' and then run '\''=
git rebase --continue'\''.
> +	Or you can abort the rebase with '\''git rebase --abort'\''.
> +	EOF
>  	test_config rebase.missingCommitsCheck error &&
>  	rebase_setup_and_clean missing-commit &&
>  	set_fake_editor &&
> --
> 2.22.0.589.g5bd7971b91
>
>

--8323328-1252390739-1561453562=:44--
