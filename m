Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5C5202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 01:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbdKUB6v (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 20:58:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50875 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751305AbdKUB6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 20:58:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B92E1A6137;
        Mon, 20 Nov 2017 20:58:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J7cZ4luDkCY1ApFLiJ5VQydPPKc=; b=Nm+lQe
        j+YLMZIkP5JajipJ1k71hJTATFuS+frr6GypedJ1Pxwrpvp8d4RZUsjOXHBJswLY
        ajQCtjX4PMsP7aQWoJ7Xn8Qrl1ocwXIzsVoVzwHIIHEaST7GSPVOc0JwUDgI2avM
        T+6gq8V0ZtLB69rm/1oNAMaw/uCtfloja368w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xGFSI55ZZK/JFOfJ1Ot13YhIggvEYR/O
        XGs356i671tf9V2GOkjTLXY2NIhtnaIXldrl5i4nmPXsUyG2vUD49l6DWa43BoSZ
        0uZy5cglmOLm0TwOAbJojIymy4J/kCRN2ot/AEnMIftrokQ9RdzML+DKAfbRxrl9
        aDX0i5njisA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B246AA6136;
        Mon, 20 Nov 2017 20:58:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3011CA6133;
        Mon, 20 Nov 2017 20:58:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH] contrib/git-jump: allow to configure the grep command
References: <20171119230536.1628-1-dev+git@drbeat.li>
        <xmqqh8tpmypa.fsf@gitster.mtv.corp.google.com>
        <20171120191846.pco4wfsu2ptci3uv@sigill.intra.peff.net>
Date:   Tue, 21 Nov 2017 10:58:43 +0900
In-Reply-To: <20171120191846.pco4wfsu2ptci3uv@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Nov 2017 14:18:46 -0500")
Message-ID: <xmqqh8tojsto.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84BA6A62-CE5F-11E7-97CA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> How about this?
>
> -- >8 --
> Subject: [PATCH] git-jump: give contact instructions in the README
>
> Let's make it clear how patches should flow into
> contrib/git-jump. The normal Git maintainer does not
> necessarily care about things in contrib/, and authors of
> individual components should be the ones giving the final
> review/ack for a patch. Ditto for bug reports, which are
> likely to get more attention from the area expert.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  contrib/git-jump/README | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/contrib/git-jump/README b/contrib/git-jump/README
> index 225e3f0954..4257cef2e6 100644
> --- a/contrib/git-jump/README
> +++ b/contrib/git-jump/README
> @@ -92,3 +92,10 @@ how to activate it.
>  
>  The shell snippets to generate the quickfix lines will almost certainly
>  choke on filenames with exotic characters (like newlines).
> +
> +Contributing
> +------------
> +
> +Bug fixes, bug reports, and feature requests should be discussed on the
> +Git mailing list <git@vger.kernel.org>, and cc'd to the git-jump
> +maintainer, Jeff King <peff@peff.net>.

Thanks, will queue.
