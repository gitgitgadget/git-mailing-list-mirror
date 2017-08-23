Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF55520899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbdHWTCL (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:02:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51144 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932485AbdHWTCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:02:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6002A9C6FC;
        Wed, 23 Aug 2017 15:02:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5pK9HM6YJuJN
        mDKQkQiHQOlQo1E=; b=HGdXnfj0AKT2AUKdHEUuFszFg4UrOADkZtOwF27pZiir
        vXbHX+fzKphKvrHWFu1yfbBuFCFGeuPjfg65FbXKph0DvNRDha4AgNhnV8HF66wH
        xSamoTt4UY3n4fjQ2cBePkJkKv9eh/U06ZhpvRkCIJ2Hm5eHCAWsBMAfZxWY3R0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tuvMGR
        F9k0rKbZ0yaEVvRU8j+gYnLm3HAqDeroxTB+F5o/3Uqzl11QN5FNm9826BvhjWZu
        cxCssJkeNcbrIxfi5F27iLReLpPt5akzfnUxIv9VoD6ces/IwcH/3SWy3kvdWHeM
        PNfDOewNpwbZHe6Zg4qiVPdghZh3Xo/P1vow8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5944D9C6FA;
        Wed, 23 Aug 2017 15:02:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6A579C6F9;
        Wed, 23 Aug 2017 15:02:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        STEVEN WHITE <stevencharleswhitevoices@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/user-manual: update outdated example output
References: <CAJXxHvVSXkQ4SYA5=ZtnWZCBbVk51oWY1OqM_XbGNoruyAGBrA@mail.gmail.com>
        <731cc618366d4835762d330e2398cf1a754ff11d.1503494617.git.martin.agren@gmail.com>
Date:   Wed, 23 Aug 2017 12:02:07 -0700
In-Reply-To: <731cc618366d4835762d330e2398cf1a754ff11d.1503494617.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 23 Aug 2017 19:49:34
 +0200")
Message-ID: <xmqqfuciyuog.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8FEFFF98-8835-11E7-8471-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Since commit f7673490 ("more terse push output", 2007-11-05), git push
> has a completely different output format than the one shown in the user
> manual for a non-fast-forward push.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
> I'd say it's "not very many read this and immediately tried it out" and
> not "nobody read this for the last ten years".

Thanks for spotting, and I tend to agree that the above is very
close to a fair assessment. =20

When the software was young, those who adopted early were much more
highly motivated to not just follow documentation and examples but
also to improve them, compared to the more recent crop of new users
who can take it granted that "other people" work on supplying tools
and learning material for free.  And that is not a bad thing---it is
progress.

So it may even be "many may have read, tried and found it different
from reality, but did not bother trying to fix or even report".

>  Documentation/user-manual.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
> index bc2929867..d3c53b513 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2044,10 +2044,12 @@ If a push would not result in a <<fast-forwards=
,fast-forward>> of the
>  remote branch, then it will fail with an error like:
> =20
>  -------------------------------------------------
> -error: remote 'refs/heads/master' is not an ancestor of
> - local  'refs/heads/master'.
> - Maybe you are not up-to-date and need to pull first?
> -error: failed to push to 'ssh://yourserver.com/~you/proj.git'
> + ! [rejected]        master -> master (non-fast-forward)
> +error: failed to push some refs to '...'
> +hint: Updates were rejected because the tip of your current branch is =
behind
> +hint: its remote counterpart. Integrate the remote changes (e.g.
> +hint: 'git pull ...') before pushing again.
> +hint: See the 'Note about fast-forwards' in 'git push --help' for deta=
ils.
>  -------------------------------------------------
> =20
>  This can happen, for example, if you:
