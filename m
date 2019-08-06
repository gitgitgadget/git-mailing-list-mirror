Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8599F1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfHFRyy (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:54:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59510 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHFRyy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:54:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A3576D442;
        Tue,  6 Aug 2019 13:54:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lMfwy4+DLpp2
        qPQVlFYGFbYihK4=; b=kaopiUE87iDtdnabTIqmgoqbIlXAPHBSDBUy6HksiTEm
        WvqOuyQBOzxa1AYNeokA0PJKk68Ob9e5CqpMjPNQs6pdHbs2fkQpYxCl+F1j800+
        lQuKcfN4m76M9R5DUbOhflQyjvBZSLnsf7rtM9XgUSGPtuZJ2y1SGk3xDX+P25E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=swkL+l
        KRBPUpzhcKZbNBl5UJx+nyjg8BHQkl5H0P+ZBpw0noBCQB1lVkYXoQgPP+4aVGOF
        JV1nSGNSoDRAMt9kOsFKxU+7fXmtb7MnQ4jI0wzG8OW5gTeA9kAUXZrk6gOkr+i1
        3h6PTb4OSfkXAOX0tIA72vRGcX7hk9uGzGMvQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52B126D441;
        Tue,  6 Aug 2019 13:54:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 81E1B6D440;
        Tue,  6 Aug 2019 13:54:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] l10n: reformat some localized strings for v2.23.0
References: <20190730033512.7226-1-worldhello.net@gmail.com>
        <20190806171952.15588-1-jn.avila@free.fr>
Date:   Tue, 06 Aug 2019 10:54:47 -0700
In-Reply-To: <20190806171952.15588-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Tue, 6 Aug 2019 19:19:52 +0200")
Message-ID: <xmqqo912ji1k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48E8B674-B873-11E9-8BEB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  builtin/checkout.c |  2 +-
>  builtin/fetch.c    | 15 +++++++++++----
>  2 files changed, 12 insertions(+), 5 deletions(-)

Thanks.  Folks, does this look sensible (it does to me)?

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 91f8509f85..6123f732a2 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1769,7 +1769,7 @@ int cmd_restore(int argc, const char **argv, cons=
t char *prefix)
>  	struct option *options;
>  	struct option restore_options[] =3D {
>  		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
> -			   N_("where the checkout from")),
> +			   N_("which tree-ish to checkout from")),
>  		OPT_BOOL('S', "staged", &opts.checkout_index,
>  			   N_("restore the index")),
>  		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 53ce99d2bb..c8bf4c651b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -850,6 +850,15 @@ static int iterate_ref_map(void *cb_data, struct o=
bject_id *oid)
>  	return 0;
>  }
> =20
> +static char warn_show_forced_updates[] =3D
> +N_("Fetch normally indicates which branches had a forced update,\n"
> +   "but that check has been disabled. To re-enable, use '--show-forced=
-updates'\n"
> +   "flag or run 'git config fetch.showForcedUpdates true'.");
> +static char warn_time_show_forced_updates[] =3D
> +N_("It took %.2f seconds to check forced updates. You can use\n"
> +   "'--no-show-forced-updates' or run 'git config fetch.showForcedUpda=
tes false'\n"
> +   " to avoid this check.\n");
> +
>  static int store_updated_refs(const char *raw_url, const char *remote_=
name,
>  			      int connectivity_checked, struct ref *ref_map)
>  {
> @@ -1005,12 +1014,10 @@ static int store_updated_refs(const char *raw_u=
rl, const char *remote_name,
> =20
>  	if (advice_fetch_show_forced_updates) {
>  		if (!fetch_show_forced_updates) {
> -			warning(_("Fetch normally indicates which branches had a forced upd=
ate, but that check has been disabled."));
> -			warning(_("To re-enable, use '--show-forced-updates' flag or run 'g=
it config fetch.showForcedUpdates true'."));
> +                  warning(_(warn_show_forced_updates));
>  		} else if (forced_updates_ms > FORCED_UPDATES_DELAY_WARNING_IN_MS) {
> -			warning(_("It took %.2f seconds to check forced updates. You can us=
e '--no-show-forced-updates'\n"),
> +			warning(_(warn_time_show_forced_updates),
>  				forced_updates_ms / 1000.0);
> -			warning(_("or run 'git config fetch.showForcedUpdates false' to avo=
id this check.\n"));
>  		}
>  	}
