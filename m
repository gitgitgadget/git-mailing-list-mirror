Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BCB51F454
	for <e@80x24.org>; Mon, 11 Nov 2019 02:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfKKCDR (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 21:03:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58156 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfKKCDR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 21:03:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAE8B3D804;
        Sun, 10 Nov 2019 21:03:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LEM/8TBvRqXl
        yuNsyslXOth7QFs=; b=WC4pEsS/yr54DJhNNffN687BXsCeIphyIOeq+ZK1e05N
        yHzh25hy0N6FbBuHG8M3wyxhWPTpFKoEyxsam+/YJN3oz2jDYYyEcCk/PzAqM7zd
        i6HznwqL7nVlrCfbgy0VrAtTip+rP7riIqFJA0GWwtbk8KwLtJKwo5+ultCoipY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jNpgqr
        wNx+pLH/XB0x1OJCJ1aPglRLS8KlfsGHpFdphFmn9EPOaGmB9MAW0Gp5pFfhLNwQ
        pyZqm0CkdteTAp8CkYWCKpah3fAbURTqVRtsIvX6zh08Isp2ars5XIJf/w4ZxzHX
        u/iHYpu1HFKTsP+cUIxwpwOuilLGoV1g7dGio=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF7573D803;
        Sun, 10 Nov 2019 21:03:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F5FD3D802;
        Sun, 10 Nov 2019 21:03:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dominic =?utf-8?Q?J=C3=A4ger?= <dominic.jaeger@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge-strategies: Fix typo "reflected to"
References: <CAFOfB_LMQBOFK5PzhezcMGshmETY0agVK_iRW7vEayR9=Oyaow@mail.gmail.com>
Date:   Mon, 11 Nov 2019 11:03:13 +0900
In-Reply-To: <CAFOfB_LMQBOFK5PzhezcMGshmETY0agVK_iRW7vEayR9=Oyaow@mail.gmail.com>
        ("Dominic =?utf-8?Q?J=C3=A4ger=22's?= message of "Fri, 8 Nov 2019 15:47:01
 +0100")
Message-ID: <xmqq5zjrjhjy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B6D3918-0427-11EA-847E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dominic J=C3=A4ger <dominic.jaeger@gmail.com> writes:

> reflected to" does not exist (according to
> https://dictionary.cambridge.org/dictionary/english/reflect?q=3Dreflect=
ed and
> https://www.merriam-webster.com/dictionary/reflected)
>
> Signed-off-by: Dominic J=C3=A4ger <dominic.jaeger@gmail.com>
> ---
> I only took a quick glance at the submitting patch guidelines.
> Feel free to quickly push this yourself if you want.
> Also, I'm not native, so I hope I looked this up correctly.

Thanks, looks good.  Will queue.

>
>  Documentation/merge-strategies.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/merge-strategies.txt
> b/Documentation/merge-strategies.txt
> index aa66cbe41e..2912de706b 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -32,7 +32,7 @@ The 'recursive' strategy can take the following optio=
ns:
>  ours;;
>         This option forces conflicting hunks to be auto-resolved cleanl=
y by
>         favoring 'our' version.  Changes from the other tree that do no=
t
> -       conflict with our side are reflected to the merge result.
> +       conflict with our side are reflected in the merge result.
>         For a binary file, the entire contents are taken from our side.
>  +
>  This should not be confused with the 'ours' merge strategy, which does=
 not
> --
> 2.17.1
