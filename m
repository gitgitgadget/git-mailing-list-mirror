Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054A3ECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 12:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiH2MZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiH2MZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 08:25:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B390C66
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661774922;
        bh=+zYpeHCQO/fjt8VZ2hQVJaQN4R4CG8ThhIfORkOzobA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c4HP22cZkBKI1QIEMclsenQGHGfucdN3SVbH4VO95w2rxHvR5YEzZyQLa5yQ8pTc9
         GeGeyyZRJlf/OhqPi8O4/v1CuwJT18SPFjLfuy+JVcSxQawc7UdQq5ozeppzNzzqQi
         6fUTVG3gwcDBIfhCUq1RJEe45C1XYiyv7VukVzoM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bjy-1pTnJ20sTW-0186c0; Mon, 29
 Aug 2022 13:48:06 +0200
Date:   Mon, 29 Aug 2022 13:48:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: allow forcing the use of in-body From:
 header
In-Reply-To: <20220826213203.3258022-3-gitster@pobox.com>
Message-ID: <q84op991-3s0n-r0q5-32pn-096595o03rs8@tzk.qr>
References: <20220826213203.3258022-1-gitster@pobox.com> <20220826213203.3258022-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-789095324-1661773204=:189"
Content-ID: <s85qr850-5123-4129-6s0n-onnr159o8447@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:X5R/WHGageYVIxxsQHY9L0sRzizlhHlfLWbGMNsPocHVr9z4K5K
 wuf2QgIm7h0ti/XtZg8vgIT7UT3HkHLLvnJtUBmO2uuLa3yOQ9wChaH+DOETpIOnENAXSBU
 2iy5iOhkz9egZZ1VodoJlJtzJEBKZ8uZPgijYubjTf76oNNC3rqH13lPA1yP8RhaBNJaJpi
 P/ovD2jAPWhPGUgmW7KBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m/aDHF4TF+Q=:qmFsoaGKAirrpeZDtYKpIo
 dtg+bJJ/oH0NWbhm0E4pQsfYOpf0Vy9y3Do0TbWT1H/BcTMJxc0GMc1s0lQv99qc3tb32+itp
 Cn3P2criL19Mo6OiY6lc6BjphckVEE9GN39a3Cbki557QgoNQweb+atut9Ippp9VyqK4Kadno
 Ltw2QePW003MCZ/xnkqxw+bw5ArhLOTs8+LDomFVmvZVy0lDYipJ9AUp0q3tERUa+HbwCcn/H
 EC2iWQ9bsP0V2BG49oJgmOboACLrdeW7Yupl/KvMzY6fMNGmtgcYlqgLmrevRqqUv6ufqSp1v
 Cw/8hN+F8A1rhAoqwyEtxv0w7/5RCBqjT1v1h7ZETKesNI6hhEMcMYBbBzDp3oWyPXLVKXxdx
 QwJnUv8ni/Iot46Xx6emWc5Ws9+dV60cmxTttAjID+cQI8cZ//DDIC9OrbZl/AOvvIcQVMi1t
 hIKtQRT61cfv9E7xPuhnj0fawZWaUwt8LRQ3HurR3GNIMpfp5TOQsKvE9ctab/ny3VRNxvKXO
 ff/wGeg9Tz66/xD2nxLI/rUj9ZWP6BhI0y/zrRWxMMFgyNbxmBsggo3MB3RsQD/IGFQPcKPnH
 2pV1HT3+6J6CWoxczudsFmLSlPp0YOJ1pVcG1UV94xHVzkUh9BhOWFa+1ppRF/uqInV1F8/KZ
 6njVmQ1aYkmYfsYpQK08wbH6RzbDGxOgciEsXRrcZ5nOlv9+manAIRVwUWyGi9KFqstOeSihu
 1oWqorLovIUohoQLRcI6B5vJ1WSUVoH4rV9Fhsh9ERh+DF8JPBiCrHbiV/EXqEHDBozNuZGHb
 wMJ/VzA1M8Eynwrzw8UisK+Y2ubAPwcvKChYjv0lf9oBPE9L84jggXwpbSW3LH3fAnLaxLbce
 UgxZCYqCqflizXmS6Rrswi0uEVl6ZfORgbwQ7mZbru5XK/ADpeHpm5aFHE2tDvxt3KAymrroF
 Yas/QB9WzU+zmg80v5ewE2z2wZMvic5Kgl7F8r47BbkHASrrGIzVsrib/jKzq97uZWSyiPp3s
 T8GjtW8UvqZYrLGaOAM1y6EfQYGKXrV0CuvvXG2u41BQeje1lQLQToncVQc1Bk/yJ6FEiKqYj
 16sI4SDi35eJkUZOnpwzJHtjcgE0PP+/QKmMZw/aqNEAYGlTe7sPdLccQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-789095324-1661773204=:189
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <658qnpsn-3rro-s2or-s18r-91o224oqs11p@tvgsbejvaqbjf.bet>

Hi Junio,

On Fri, 26 Aug 2022, Junio C Hamano wrote:

> Users may be authoring and committing their commits under the same
> e-mail address they use to send their patches from, in which case
> they shouldn't need to use the in-body From: line in their outgoing
> e-mails.  At the receiving end, "git am" will use the address on the
> "From:" header of the incoming e-mail and all should be well.
>
> Some mailing lists, however, mangle the From: address from what the
> original sender had; in such an unfortunate situation, the user may
> want to add the in-body "From:" header even for their own patch.
>
> "git format-patch --[no-]force-inbody-from" was invented for such
> users.
>
> Note.  This is an uncooked early draft.

Did you mean to mark the patch as [RFC], then?

> Things to think about include (but not limited to, of course):
>
>  * Should this rather be --use-inbody-from=3Dyes,no,auto tristate,
>    that defaults to "auto", which is the current behaviour i.e.
>    "when --from is given, add it only when it does not match the
>    payload".  "yes" would mean "always emit the --from address as
>    in-body From:" and "no" would mean ... what?  "Ignore --from"?
>    Then why is the user giving --from in the first place?

I would offer up the suggestion `--in-body-from=3D{never,always,auto}` for
consideration.

>  * Should it be "inbody" or "in-body"?

The latter.

>  * Should it have a corresponding configuration variable?

Probably. The commit message talks about mailing lists requiring different
behavior from the default, which is likely to affect all patches generated
from a corresponding local checkout. Having a config variable would lower
the cognitive burden of having to remember this process detail.

>  * Should this patch be scrapped and the feature should be done
>    inside "git send-email" instead?

Since it affects the `--pretty=3Demail` mode, the current patch seems to a=
im
for the correct layer.

> diff --git a/builtin/log.c b/builtin/log.c
> index 9b937d59b8..83b2d01b49 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1897,6 +1897,8 @@ int cmd_format_patch(int argc, const char **argv, =
const char *prefix)
>  			   N_("show changes against <refspec> in cover letter or single patc=
h")),
>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>  			    N_("percentage by which creation is weighted")),
> +		OPT_BOOL(0, "force-inbody-from", &rev.force_inbody_from,
> +			 N_("Use in-body From: even for your own commit")),

Please start the usage text in lower-case, to keep it consistent with the
rest of the usage texts.

Also, I would like to avoid the personal address "you" in that text, and
also the verb "use". Maybe something like this:

	show in-body From: even if identical to the header

>  		OPT_END()
>  	};
>
> diff --git a/pretty.c b/pretty.c
> index 51e3fa5736..e266208c0b 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -483,6 +483,8 @@ static int use_inbody_from(const struct pretty_print=
_context *pp, const struct i
>  		return 0;
>  	if (ident_cmp(pp->from_ident, ident))
>  		return 1;
> +	if (pp->rev && pp->rev->force_inbody_from)
> +		return 1;

It would probably make sense to move this before `ident_cmp()`, to avoid
unneeded calls ("is the ident the same? no? well, thank you for your
answer but I'll insert the header anyway!").

>  	return 0;
>  }
>
> diff --git a/revision.h b/revision.h
> index bb91e7ed91..a2d3813a21 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -208,6 +208,7 @@ struct rev_info {
>
>  	/* Format info */
>  	int		show_notes;
> +	unsigned int	force_inbody_from;

The reason why this isn't added to the `:1` bits below is probably the
anticipation of the tri-state, but if that tri-state never materializes,
adding it as a bit is still the right thing to do.

>  	unsigned int	shown_one:1,
>  			shown_dashes:1,
>  			show_merge:1,
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index fbec8ad2ef..a4ecd433e2 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1400,6 +1400,19 @@ test_expect_success '--from omits redundant in-bo=
dy header' '
>  	test_cmp expect patch.head
>  '
>
> +test_expect_success 'with --force-inbody-from, --from keeps redundant i=
n-body header' '
> +	git format-patch --force-inbody-from \
> +		-1 --stdout --from=3D"A U Thor <author@example.com>" >patch &&
> +	cat >expect <<-\EOF &&
> +	From: A U Thor <author@example.com>
> +
> +	From: A U Thor <author@example.com>
> +
> +	EOF
> +	sed -ne "/^From:/p; /^$/p; /^---$/q" patch >patch.head &&
> +	test_cmp expect patch.head
> +'

The test script starts to look a bit non-DRY with all those repetitions of
`A U Thor <author@example.com>`, but that's hardly the responsibility of
this here patch to address.

Thank you,
Dscho

> +
>  test_expect_success 'in-body headers trigger content encoding' '
>  	test_env GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc" test_commit exotic =
&&
>  	test_when_finished "git reset --hard HEAD^" &&
> --
> 2.37.2-587-g47adba97a9
>
>

--8323328-789095324-1661773204=:189--
