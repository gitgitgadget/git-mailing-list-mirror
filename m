Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1EFC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 09:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbiHSJae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346238AbiHSJad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 05:30:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066FE9A99
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660901425;
        bh=mUvRWzUkZAy70rAZ0+EdhbRmEIPH207+1CGF3TIL+6g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h4r1IDaMI0gPCsWZNor53DgSaBWaA+sr95utLoJHSAvaYfPD/32zYuI5QRriTR7ny
         lvkOBzhN3mFQjFCz5y2vT++E0e4vgW2HASbfS4/6fYH2ChojbINK7zIoWtnAfX//G8
         zP9JO1hml9pK8z/tbpqTxxX7IBYqEnjp+bazdR1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JqV-1oOhLk0dE1-000O5P; Fri, 19
 Aug 2022 11:30:25 +0200
Date:   Fri, 19 Aug 2022 11:30:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Michael J Gruber <git@grubix.eu>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 4/4 v2] sequencer: spell out command names and do not
 translate them
In-Reply-To: <ef8b4536322eebd2bed53157f43349e9158631ae.1660894946.git.git@grubix.eu>
Message-ID: <o4op5qqo-206p-on30-49q7-n1qp4859q0n7@tzk.qr>
References: <xmqqilmpnvad.fsf@gitster.g> <ef8b4536322eebd2bed53157f43349e9158631ae.1660894946.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XEp+84YmxO2XB2P3QcakUeAeY5dntd169PO5zFAZ5YcGwocFfsp
 TZk/gfQibF5c5aat6zrPRlulRrdUYJPC9aQe6rWi4vCVNZOCQd9nlrCspfukOAdL3tkbSoL
 CeR/g771zk4t3JGE34CuWgRkpiWw4eLrFY2ZGqXvUzjKNj2I9Pdkqi0DSrl4y3ckX23IoNe
 WWCkYTtvoWQI1sbMvl5lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sP6M6nT5YJ0=:5ufoj7IMzKhtDpXd6fvMOC
 DXiIO+9s7f7aI+k8kiNJVy8NGpi5BmeL4ai2LzF5aksFgWPNeb7BBVLs5hBswLzd3VSsfcTQL
 PnqzYg7V7XWmvamk647DbX3mMyR+8MxfSUZKZ/364eBGKeA0MP9Ez44GcUtQKIUSeSgm7/+Q+
 AnyYu/eusOzXwVfEzNG22OpQuNunX9Ppkttt5KWkbywM+qE0lLb1RO0KZ7RTCQBoXeT0UC4hP
 ElAa1DEQ7/QrkTeZ4b0GfEyUhh3i1F8ZATtzv0Wq0aNCHBrUFhvoFnOx0DtTC59NUDU/p8Pa2
 QHoEAryY64HcnFIr8gYvpjUcJ0SHfCyhSJRyeCcb2aKlla6y5vGRUsNAy+AfrU04DaUlT9z5k
 AySt+ku9UaGzFL9QIk+WbpoOQUUP5W8iY6o4cdVbgfl1xQbPspzY3czihW4TWN9FOJfXpKYpJ
 ZLiriCbuT0DUI3Ghquwgf3NxT7dWjHNAhSFi9xMCGtkH2vG/dJJfnpnGP+Rr49NEKpgc4aTY/
 HPc8ourxCH8GqgNBfDCwiQvu3j/NG1GzI0DWaqmEDenm/bWpc8ornZ9aixtA70tTy58kJ5LDR
 6TazmKJXF0b738QCWQH+WR63Y9jWOKH0eyR9bdutQAF2TcUlzuoX7qAXU/hSgyIxXuI56pRyl
 m73OehEIM2OElwMKxEpwOeXUdJno+r79qVZenQLw9FX56ISmPAUHpOciLsWDPd7Ikfah73xBz
 MMRg4Ot3Sr197MCvM51Re11K7sSs2oaruJilzkgAJazkBgCCNAhGBgaRmrPuLNZ31aPKjmhy7
 RSuwejWH/tM7Lg50neK/e9AnsjSiLx1guO1Av2vbKoF6v0qSdrWCYfPlrdBaT2XjCc594zcfr
 8SgMKFbSTX1OGHQGnR3Yh/oodGUEf9zaX5fVGqXWa2EnMLeQFALBOScPv2fX7jI0VshAp9zVl
 jbD7dJLJxmsCOBdYrTBN2wxL4XWfqx6C5mKqiRhI5/IcEoIKgY+6eTjypmMcZfZJ/eUtCHQoT
 vVRRN5vaoDJSMwi/0UpdBh+KgCAf+hGTJxWMCYmCU5c+bIZW5+pwd38MTOtmL/G7vVBDML+bW
 +M0cNXvVlWFmXgKOhfYffIZR0MNzsayoU76jPOeX40S7oxYFTieq6dN9Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael & Junio,

On Fri, 19 Aug 2022, Michael J Gruber wrote:

> When we talk about sequencer action names as such we do translate the
> action name. In all cases, we talk about the like-named git command
> name, though, which is not translated.
>
> In order to make the correspondence clearer, reword those error messages
> to use the (untranslated) git command name, and adjust the po README to
> match the code base.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
> I guess there are two extreme views regarding these cases (in terms of
> how much to translate) and a few in between. v2 here implements the
> one of these. As a result, we don't need to N_()-mark the action names
> any more unless I'm overlooking something. I'm holding this back until
> the consensus is clear.

Thank you for being careful.

In general, I would like to leave the decision whether or not to mention
the _English_ word for an operation (or whether to treat the error
message's prefix as a short-hand for the Git command) to the l10n
maintainer, so that things can be consistent between translations.

Ciao,
Dscho

> Overall, we are not consistent with the prefixes in our error messages
> (command or not) nor the capitalisation. One could say that at the point
> of an error/die worse has gone wrong than the wording, of course ;)
>
>  po/README.md | 2 +-
>  sequencer.c  | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/po/README.md b/po/README.md
> index 3e4f897d93..7b7ad24412 100644
> --- a/po/README.md
> +++ b/po/README.md
> @@ -273,7 +273,7 @@ General advice:
>
>    ```c
>    /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> -  die(_("%s: Unable to write new index file"), action_name(opts));
> +  die(_("git %s: unable to write new index file"), action_name(opts));
>    ```
>
>  We provide wrappers for C, Shell and Perl programs. Here's how they're
> diff --git a/sequencer.c b/sequencer.c
> index 79dad522f5..c26dc46268 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -539,8 +539,8 @@ static int error_dirty_index(struct repository *repo=
, struct replay_opts *opts)
>  	if (repo_read_index_unmerged(repo))
>  		return error_resolve_conflict(action_name(opts));
>
> -	error(_("your local changes would be overwritten by %s."),
> -		_(action_name(opts)));
> +	error(_("git %s: your local changes would be overwritten"),
> +		action_name(opts)));
>
>  	if (advice_enabled(ADVICE_COMMIT_BEFORE_MERGE))
>  		advise(_("commit your changes or stash them to proceed."));
> @@ -725,8 +725,8 @@ static int do_recursive_merge(struct repository *r,
>  		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
>  		 * "rebase".
>  		 */
> -		return error(_("%s: Unable to write new index file"),
> -			_(action_name(opts)));
> +		return error(_("git %s: unable to write new index file"),
> +			action_name(opts));
>
>  	if (!clean)
>  		append_conflicts_hint(r->index, msgbuf,
> --
> 2.37.2.653.g5b2587383a
>
>
