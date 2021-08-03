Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F33C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78933601FD
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhHCWhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:37:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61151 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbhHCWhH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 18:37:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0663A148414;
        Tue,  3 Aug 2021 18:36:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oGEVt3ZceVEdv9HTVhh/ZrncGdzpKAVZ218eeX
        oqIU0=; b=X1Dga20LgZik2YfMHo/wKmpKgrlvZSyov3ilTJN4B8jz13Knm8XOIJ
        KgXUf/6nYyLuHRJXz18pjGdNa/Q5SYXtT9+Q0ihoLmvICENe23nLXseG/hPLxl7t
        ZZoAJ806CiEfsjzQ6dlXbYAjeAkMHfy8Q+yp40O9hLyRxkMwqj8js=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F29ED148413;
        Tue,  3 Aug 2021 18:36:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 494AD148412;
        Tue,  3 Aug 2021 18:36:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 1/2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
        <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
        <5d2fd55c580abc2057f2e6fe9f7d9c94748bf8de.1627953383.git.gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:36:50 -0700
In-Reply-To: <5d2fd55c580abc2057f2e6fe9f7d9c94748bf8de.1627953383.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Tue, 03 Aug 2021 01:16:21
        +0000")
Message-ID: <xmqqa6lytat9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C6485A0-F4AB-11EB-BC96-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> GIT_CHERRY_PICK_HELP is an environment variable, as the
> implementation detail of some porcelain in git to help realize
> the rebasing steps. E.g. `git rebase -p` set GIT_CHERRY_PICK_HELP

set -> sets

> value in `git-rebase--preserve-merges.sh`, `git rebase --merge` set

set -> sets

> GIT_CHERRY_PICK_HELP value in run_specific_rebase().

"help realize the rebasing steps" did not tell us much on "how" the
environment variable helps or what it is used for.  A sentence at
this point, e.g.

    The variable carries a custom help message to be shown when one
    step of replaying an existing commit fails in conflict.

may help.  And there is one leap in the logic flow here.

    However, the code also removes CHERRY_PICK_HEAD pseudoref when
    this environment variable exists, assuming that the presence of
    it means the sequencer machinery and not end-user is doing the
    cherry-picking.

> But If we set
> the value of GIT_CHERRY_PICK_HELP when using `git cherry-pick`,
> CHERRY_PICK_HEAD will be deleted, then we will get an error when we
> try to use `git cherry-pick --continue` or other cherr-pick command.

And then we can drop "But" before "If" here.

> Introduce new "hidden" option `--delete-cherry-pick-head` for git
> cherry-pick which indicates that CHERRY_PICK_HEAD will be deleted when
> conflict occurs, which provided for some porcelain commands of git like
> `git-rebase--preserve-merges.sh`.

indicates that CHERRY_PICK_HEAD will be ... ->

tells Git remove CHERRY_PICK_HEAD to separate the decision from
message customization to clean up this mess.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by Hariom Verma <hariom18599@gmail.com>:
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Hepled-by: Junio C Hamano <gitster@pobox.com>

Heple?

> diff --git a/sequencer.c b/sequencer.c
> index 0bec01cf38e..83cf6a5da3c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -397,24 +397,13 @@ static void free_message(struct commit *commit, struct commit_message *msg)
>  	unuse_commit_buffer(commit, msg->message);
>  }
>  
> -static void print_advice(struct repository *r, int show_hint,
> -			 struct replay_opts *opts)
> +static void print_advice(struct replay_opts *opts, int show_hint)
>  {
>  	char *msg = getenv("GIT_CHERRY_PICK_HELP");
>  
>  	if (msg) {
> +		advise("%s\n", msg);
> +	} else if (show_hint) {
>  		if (opts->no_commit)
>  			advise(_("after resolving the conflicts, mark the corrected paths\n"
>  				 "with 'git add <paths>' or 'git rm <paths>'"));

OK.  That makes sense.

> @@ -2265,7 +2254,16 @@ static int do_pick_commit(struct repository *r,
>  		      ? _("could not revert %s... %s")
>  		      : _("could not apply %s... %s"),
>  		      short_commit_name(commit), msg.subject);
> -		print_advice(r, res == 1, opts);
> +		print_advice(opts, res == 1);
> +		if (opts->delete_cherry_pick_head) {
> +			/*
> +			 * A conflict has occurred but the porcelain
> +			 * (typically rebase --interactive) wants to take care
> +			 * of the commit itself so remove CHERRY_PICK_HEAD
> +			 */
> +			refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
> +					NULL, 0);
> +		}

OK, this separation makes sense, too.

> -test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
> -	pristine_detach initial &&
> -	(
> -		GIT_CHERRY_PICK_HELP="and then do something else" &&
> -		export GIT_CHERRY_PICK_HELP &&
> -		test_must_fail git cherry-pick picked
> -	) &&
> -	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
> -'

Hmph, this is a bit troubling.  So has this been part of the
"published" behaviour since d7e5c0cb (Introduce CHERRY_PICK_HEAD,
2011-02-19) that introduced this test, and there are people who are
relying on it?  IOW, should the resolution to the original problem
report have been "if it hurts, don't do it" (in other words, "setting
GIT_CHERRY_PICK_HELP will remove CHERRY_PICK_HEAD, so if you do not
want to get the latter removed, do not set the former")?

