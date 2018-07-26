Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2453D1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 12:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeGZNuk (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 09:50:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:53189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbeGZNuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 09:50:40 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrNE4-1g7qk60Z9o-013AOJ; Thu, 26
 Jul 2018 14:33:50 +0200
Date:   Thu, 26 Jul 2018 14:33:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@iDaemons.org>
Subject: Re: [RFC PATCH] sequencer: fix quoting in write_author_script
In-Reply-To: <20180718155518.1025-1-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1807261332130.71@tvgsbejvaqbjf.bet>
References: <eb295aea-dae5-5e1c-bacf-2c77d3ce0195@talktalk.net> <20180718155518.1025-1-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oBz32VFL3qNBzn2pP+Cvr2dGWAH3jtzEHGhKMVWzASxp4+QB81b
 Uy3Ya44bCl6P2MtJNeiYbR2/zem9wNqMMueCQjaSVuw9cxGS+FoqPswc5OJWC+fIxLbYmAg
 EIZ6UN5LqZBxYA3+1qriO4T+CIHxwpCv8aKXQ9EtFYvoZ20vr7y5e2cntBviL5C8CShvxwF
 sYV0Cfsx2Q6xzC2lP3aEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4cvyJviaPTQ=:Dt199sOO83ASzSXxHiOq2m
 WSaXIyBpnhGN+68ssNnQbKyWpKpPdvKdKeoO28EcjdWzb2pO04l/yTpbycJlFJPORw8s+g6K8
 /MuIcv9SORRCvyqHS/iGMob3uq8ZllBxu1re0YnVtZvad7ZCwG2qzsAMH2i7+h4MVS8wDlWVS
 QWsPxZtUDR8Bp1IBFAJfh5efZNaZVOJh5ZIwiQFBzdYWdh8r5/dy4f3htQADyVsWwjetudeAV
 z45GHhh65PyHTPKKY3us0tuzI+Vby3GEfTFCxSLJKaU2M9FM+1HCMDxExfKvBfE3y+3maoFzI
 EDlOaG1oDHkpC4P+XbMrPHgBiWoEbg90rFT58+WKngyVOJRzwFh2TPMwl4un7okumsLNVMHJw
 dTY5t5/vDJf8Cn/0jGe1XRLdO5nJ2EZXA0CYhcXTtotGyxRM10+/sa/faNvxolm0PUw0HuQGT
 c6QZbZwgFTKfuocl2sLNa3zvIOBwE1+X9KWDxyJARK8+XYc6EgbuMMs+/c/3FhIrABzRO2pPQ
 3KLJtLVgocnO6h2KFp0pOyvf/F/69191sERx3LCkb304u8y/Af/QcPVTsByfYbolmg5AOStxy
 XvgNLemuMsEvbQo+Ab+7c0QqvdfeJDrhL1nXj6MF31Y8s330KBUUxUp712pdMM79M7VmTx8Xm
 PpX6fT89wWRiqO+SW3BC3IkxBoxhJlAcJI3VH6gUo0WziY+pzxtwtHrk5hnGEUa0qt1/Gm0mj
 2HJu+Fn33wbV46uQ9/x1gaDTbQ0+5LQ00muMQYM5J0iSsacJGKdv/sKxlE5JOCHMj4BKBDb2n
 dwFiy3H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 18 Jul 2018, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Single quotes should be escaped as \' not \\'. Note that this only
> affects authors that contain a single quote and then only external
> scripts that read the author script and users whose git is upgraded from
> the shell version of rebase -i while rebase was stopped. This is because
> the parsing in read_env_script() expected the broken version and for
> some reason sq_dequote() called by read_author_ident() seems to handle
> the broken quoting correctly.
> 
> Ideally write_author_script() would be rewritten to use
> split_ident_line() and sq_quote_buf() but this commit just fixes the
> immediate bug.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Good catch.

> This is untested, unfortuantely I don't have really have time to write a test or
> follow this up at the moment, if someone else want to run with it then please
> do.

I modified the test that was added by Akinori. As it was added very early,
and as there is still a test case *after* Akinori's that compares a
hard-coded SHA-1, I refrained from using `test_commit` (which would change
that SHA-1). See below.

> diff --git a/sequencer.c b/sequencer.c
> index 5354d4d51e..0b78d1f100 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -638,21 +638,21 @@ static int write_author_script(const char *message)
>  		else if (*message != '\'')
>  			strbuf_addch(&buf, *(message++));
>  		else
> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +			strbuf_addf(&buf, "'\\%c'", *(message++));
>  	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
>  	while (*message && *message != '\n' && *message != '\r')
>  		if (skip_prefix(message, "> ", &message))
>  			break;
>  		else if (*message != '\'')
>  			strbuf_addch(&buf, *(message++));
>  		else
> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +			strbuf_addf(&buf, "'\\%c'", *(message++));
>  	strbuf_addstr(&buf, "'\nGIT_AUTHOR_DATE='@");
>  	while (*message && *message != '\n' && *message != '\r')
>  		if (*message != '\'')
>  			strbuf_addch(&buf, *(message++));
>  		else
> -			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +			strbuf_addf(&buf, "'\\%c'", *(message++));
>  	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);

I resolved the merge conflict with Akinori's patch. FWIW I pushed all of
this, including the fixup to Junio's fixup to the
`fix-t3404-author-script-test` branch at https://github.com/dscho/git.

>  	strbuf_release(&buf);
>  	return res;
> @@ -666,13 +666,21 @@ static int read_env_script(struct argv_array *env)
>  {
>  	struct strbuf script = STRBUF_INIT;
>  	int i, count = 0;
> -	char *p, *p2;
> +	const char *p2;
> +	char *p;
>  
>  	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>  		return -1;
>  
>  	for (p = script.buf; *p; p++)
> -		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> +		/*
> +		 * write_author_script() used to escape "'" incorrectly as
> +		 * "'\\\\''" rather than "'\\''" so we check for the correct
> +		 * version the incorrect version in case git was upgraded while
> +		 * rebase was stopped.
> +		 */
> +		if (skip_prefix(p, "'\\''", &p2) ||
> +		    skip_prefix(p, "'\\\\''", &p2))

I think in this form, it is possibly unsafe because it assumes that the
new code cannot generate output that would trigger that same code path.
Although I have to admit that I did not give this a great deal of thought.

In any case, if you have to think long and hard about some fix, it might
be better to go with something that is easier to reason about. So how
about this: we already know that the code is buggy, Akinori fixed the bug,
where the author-script missed its trailing single-quote. We can use this
as a tell-tale for *this* bug. Assuming that Junio will advance both your
and Akinori's fix in close proximity.

Again, this is pushed to the `fix-t3404-author-script-test` branch at
https://github.com/dscho/git; My fixup on top of your patch looks like
this (feel free to drop the sq_bug part and only keep the test part):

-- snipsnap --
diff --git a/sequencer.c b/sequencer.c
index 46c0b3e720f..7abe78dc78e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -573,13 +573,14 @@ static int write_author_script(const char *message)
 static int read_env_script(struct argv_array *env)
 {
 	struct strbuf script = STRBUF_INIT;
-	int i, count = 0;
+	int i, count = 0, sq_bug;
 	const char *p2;
 	char *p;
 
 	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
 		return -1;
 
+	sq_bug = script.len && script.buf[script.len - 1] != '\'';
 	for (p = script.buf; *p; p++)
 		/*
 		 * write_author_script() used to escape "'" incorrectly as
@@ -587,8 +588,9 @@ static int read_env_script(struct argv_array *env)
 		 * version the incorrect version in case git was upgraded while
 		 * rebase was stopped.
 		 */
-		if (skip_prefix(p, "'\\''", &p2) ||
-		    skip_prefix(p, "'\\\\''", &p2))
+		if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
+			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
+		else if (skip_prefix(p, "'\\''", &p2))
 			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
 		else if (*p == '\'')
 			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 97f0b4bf881..dd726ff4dc4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,16 +75,18 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
+SQ="'"
 test_expect_success 'rebase -i writes correct author-script' '
 	test_when_finished "test_might_fail git rebase --abort" &&
-	git checkout master &&
+	git checkout -b author-with-sq master &&
+	GIT_AUTHOR_NAME="Auth O$SQ R" git commit --allow-empty -m with-sq &&
 	set_fake_editor &&
-	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
+	FAKE_LINES="edit 1" git rebase -ki HEAD^ &&
 	(
 		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
 		. .git/rebase-merge/author-script &&
 		test "$(git show -s --date=raw --format=%an,%ae,@%ad)" = \
-			"$GIT_AUTHOR_NAME,$GIT_AUTHOR_EMAIL,$GIT_AUTHOR_DATE"
+			"Auth O$SQ R,$GIT_AUTHOR_EMAIL,$GIT_AUTHOR_DATE"
 	)
 '
 
@@ -1347,7 +1349,6 @@ test_expect_success 'editor saves as CR/LF' '
 	)
 '
 
-SQ="'"
 test_expect_success 'rebase -i --gpg-sign=<key-id>' '
 	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
