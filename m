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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5051B1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfFYJKn (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:10:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:34629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbfFYJKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561453837;
        bh=totpb6Gz+KRwQGDJ5oYmB4lkqtn4u1KjkXPAje7DY/8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K+V1IzqEUbyySlqz80sFoyBNmrsAxcbzdSpkM3CJ449QZshnYhVSxNKbrWjAx5zLV
         75MgK09rK2CDI/0Y6TNq+T+in/mDfa8brJQewjf0YAroah6dpJJYI3yTneEWcfr4ME
         7lKWwu91cReOhS44S762pmZ61mF7VAVJsLsLSva0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5HZD-1iVUNW1Ucx-00zYNS; Tue, 25
 Jun 2019 11:10:37 +0200
Date:   Tue, 25 Jun 2019 11:10:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] progress: use term_clear_line()
In-Reply-To: <20190624181318.17388-6-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906251110160.44@tvgsbejvaqbjf.bet>
References: <20190611130320.18499-1-szeder.dev@gmail.com> <20190624181318.17388-1-szeder.dev@gmail.com> <20190624181318.17388-6-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-243009304-1561453858=:44"
X-Provags-ID: V03:K1:x+FgnHr/2//xPtZd+49cV4r6qmBoTevzf1nZgBUd7PWX7Y3q6MY
 L7jk/SDt96iaerPGc31sQ1LMLKTrkEZGXIxuU/d7DTKlOe4NpBxFMgjpTdVVIHQ7iQgloeu
 bvGdzyxw8WqKET4VlLeZxwUU7aLMfMYBgkC3nLqQy9W9NJwU29ZeYtWHG+g6oXbA/WBd2Q8
 /Aemhmutpjj4u3T/IAXpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wti28zrBhqQ=:7gcJ7pp0mcQ4YJ8fVXvKa+
 XDL/5dHFaeKaujqY2yb0lL/yvMeaGgy0o9GIWmKS1V8syExua6wKW2utad1grivZaA5Wfa1Xp
 l+yDCc1XZRa5zN/aE8/ivMKWUCAHUCswZAWGByeY8ZAn5YIxQFsTf1Kx2zsL+zGjbk0dOuEt7
 LpV91cCFewsJfBbLOyUOiOMW8LpFHPofgrY/raqDKgYSNfGHtAm8PAEPCZD2C0t7GRtVO34sG
 vaap/gUC2Uqu8cGCg2MC7qS33CraIUl39buekvd6eR0Dy7pybV5S/ybLOC0YnZmcqiVFv2raC
 VrU0c1+DTv37tYFMs2XqbQuHzpdOvA+LPP0vb0ngJ7Cm9rEiCkobgcVsivAqF6Nn1o7uOHyNm
 jAgZIdKoZWRWooMwJdJRRLkpSIZU0fauohk7bWGsoN/h9T6w4YRiF832cGK4h1e/kvVLhPCon
 31qT7PnjUV6NbFoLZJGW+ZiKRtlaWZDe2/gLr0Cr9nbFENnD6JTrgv77VGGUU+AWUQCYkUIdL
 jTDv+m9+0KMe6pPNK69s7qRwT7Cjwyu5vgy9Qd6n1F8LHU/ZNMxuTm6yfltowyPV96/ymcgna
 pyHhrx/Bf2DgqeEE5TPLMS88D/0Kzay+3CVbb7+n/K83fWW7E1Z+LntzDACBWN6tuNM2AMgJ+
 1jsBO9IwgrNUF7KLF6GAclFJJTzqgWEHlEOOk8wjJ/9aiW2+x9b30xw7A35cEC/8klVg2rwmt
 pejPhMulSoSPBsCeFS+Z/GPqvGVGkVWAeZZqdUVb/Z4yAJqIltkJN5mSCutddmAbv4lUXxWUA
 8EK4r9/kw7YRh2+J+d4B6nK8FyWWzQubGe9vUabJrGrGWQr/3Vn/K7Z9Gy5/Km74j7s+fGf2f
 XmF0LLDUWmPqJtZRfTmGKAM0bXkzrqoSKUGfUcJTPBUaJT0WD+EIY9BAtgz3hYYnEIo+MI6vs
 LUFddxnqe4lK29KI98P59dgw9Yf61vzIXZiUdVejd147UMoEf4/aLazXWY5FA35a5blueQ9v3
 C9k+Jj4Sh+kZq4p741+6Op+uwb6Qxj8JzwEt5SK4k+t4Ja1GteO37eSI2gpa101ZGeIp5h8VA
 T6EFD/MLGSsnCcVuEjwEIOX3yDkWR47kG5S
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-243009304-1561453858=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 24 Jun 2019, SZEDER G=C3=A1bor wrote:

> To make sure that the previously displayed progress line is completely
> covered up when the new line is shorter, commit 545dc345eb (progress:
> break too long progress bar lines, 2019-04-12) added a bunch of
> calculations to figure out how many characters it needs to overwrite
> with spaces.
>
> Use the just introduced term_clear_line() helper function to, well,
> clear the last line, making all these calculations unnecessary, and
> thus simplifying the code considerably.
>
> Three tests in 't5541-http-push-smart.sh' 'grep' for specific text
> shown in the progress lines at the beginning of the line, but now
> those lines begin either with the ANSI escape sequence or with the
> terminal width worth of space characters clearing the line.  Relax the
> 'grep' patterns to match anywhere on the line.  Note that only two of
> these three tests fail without relaxing their 'grep' pattern, but the
> third looks for the absence of the pattern, so it still succeeds, but
> without the adjustment would potentially hide future regressions.
>
> Note also that with this change we no longer need the length of the
> previously displayed progress line, so the strbuf added to 'struct
> progress' in d53ba841d4 (progress: assemble percentage and counters in
> a strbuf before printing, 2019-04-05) is not strictly necessary
> anymore.  We still keep it, though, as it avoids allocating and
> releasing a strbuf each time the progress is updated.

Very nice change, indeed, I totally love how much simpler the post-image
looks. Well done, for the entire patch series, and thank you so much!
Dscho

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  progress.c                 | 28 +++++++++++-----------------
>  t/t5541-http-push-smart.sh |  6 +++---
>  2 files changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/progress.c b/progress.c
> index a2e8cf64a8..095dcd0ddf 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -88,7 +88,6 @@ static void display(struct progress *progress, uint64_=
t n, const char *done)
>  	const char *tp;
>  	struct strbuf *counters_sb =3D &progress->counters_sb;
>  	int show_update =3D 0;
> -	int last_count_len =3D counters_sb->len;
>
>  	if (progress->delay && (!progress_update || --progress->delay))
>  		return;
> @@ -116,26 +115,21 @@ static void display(struct progress *progress, uin=
t64_t n, const char *done)
>  	if (show_update) {
>  		if (is_foreground_fd(fileno(stderr)) || done) {
>  			const char *eol =3D done ? done : "\r";
> -			size_t clear_len =3D counters_sb->len < last_count_len ?
> -					last_count_len - counters_sb->len + 1 :
> -					0;
> -			size_t progress_line_len =3D progress->title_len +
> -						counters_sb->len + 2;
> -			int cols =3D term_columns();
>
> +			term_clear_line();
>  			if (progress->split) {
> -				fprintf(stderr, "  %s%*s", counters_sb->buf,
> -					(int) clear_len, eol);
> -			} else if (!done && cols < progress_line_len) {
> -				clear_len =3D progress->title_len + 1 < cols ?
> -					    cols - progress->title_len - 1 : 0;
> -				fprintf(stderr, "%s:%*s\n  %s%s",
> -					progress->title, (int) clear_len, "",
> -					counters_sb->buf, eol);
> +				fprintf(stderr, "  %s%s", counters_sb->buf,
> +					eol);
> +			} else if (!done &&
> +				   /* The "+ 2" accounts for the ": ". */
> +				   term_columns() < progress->title_len +
> +						    counters_sb->len + 2) {
> +				fprintf(stderr, "%s:\n  %s%s",
> +					progress->title, counters_sb->buf, eol);
>  				progress->split =3D 1;
>  			} else {
> -				fprintf(stderr, "%s: %s%*s", progress->title,
> -					counters_sb->buf, (int) clear_len, eol);
> +				fprintf(stderr, "%s: %s%s", progress->title,
> +					counters_sb->buf, eol);
>  			}
>  			fflush(stderr);
>  		}
> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index 8ef8763e06..2e4802e206 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -213,7 +213,7 @@ test_expect_success TTY 'push shows progress when st=
derr is a tty' '
>  	cd "$ROOT_PATH"/test_repo_clone &&
>  	test_commit noisy &&
>  	test_terminal git push >output 2>&1 &&
> -	test_i18ngrep "^Writing objects" output
> +	test_i18ngrep "Writing objects" output
>  '
>
>  test_expect_success TTY 'push --quiet silences status and progress' '
> @@ -228,7 +228,7 @@ test_expect_success TTY 'push --no-progress silences=
 progress but not status' '
>  	test_commit no-progress &&
>  	test_terminal git push --no-progress >output 2>&1 &&
>  	test_i18ngrep "^To http" output &&
> -	test_i18ngrep ! "^Writing objects" output
> +	test_i18ngrep ! "Writing objects" output
>  '
>
>  test_expect_success 'push --progress shows progress to non-tty' '
> @@ -236,7 +236,7 @@ test_expect_success 'push --progress shows progress =
to non-tty' '
>  	test_commit progress &&
>  	git push --progress >output 2>&1 &&
>  	test_i18ngrep "^To http" output &&
> -	test_i18ngrep "^Writing objects" output
> +	test_i18ngrep "Writing objects" output
>  '
>
>  test_expect_success 'http push gives sane defaults to reflog' '
> --
> 2.22.0.589.g5bd7971b91
>
>

--8323328-243009304-1561453858=:44--
