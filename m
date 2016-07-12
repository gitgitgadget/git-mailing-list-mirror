Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457FD1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 16:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbcGLQrQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 12:47:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751523AbcGLQrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 12:47:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F3B422A31C;
	Tue, 12 Jul 2016 12:47:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VdpraYg0Of6vv2MMJJhHWRaMagA=; b=WSJc2e
	WALvp8nA78iOkp/J7/fO+KgX/WGbSxmYHMnhqZ4UrPNWzHtShv27CCGDBArmgATX
	nozNA+pv++VgK+lEOW+scP5v9fKcx9moQeYT83+zfDwO2nZEMKHruQN4MiQTpweF
	2i2g0C3bz9+WiEN3VKpRr9xnI+RWieINeMUCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XH/6uUW81mrMeWkZV0J7w8AL6tkJZl7H
	Nby3Ts+GXSG1uxRFCTYqJDgrsQd6W7Gw3nnsGGACDqrgutKAJSUv+89uUMZBiTB3
	/JWnLQ5T3p0OzyZ5rn3zRALrsoXCPtwaOoDkXYOMhBik9V8jAjirYkG1f+sObhA6
	vbW8oXBaTD4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECEE62A31B;
	Tue, 12 Jul 2016 12:47:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 796002A31A;
	Tue, 12 Jul 2016 12:47:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/8] doc: revisions - name the Left and Right sides
References: <20160630202509.4472-1-philipoakley@iee.org>
	<20160711202518.532-1-philipoakley@iee.org>
	<20160711202518.532-3-philipoakley@iee.org>
Date:	Tue, 12 Jul 2016 09:47:11 -0700
In-Reply-To: <20160711202518.532-3-philipoakley@iee.org> (Philip Oakley's
	message of "Mon, 11 Jul 2016 21:25:12 +0100")
Message-ID: <xmqq1t2y7qi8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48AA65CC-4850-11E6-A69C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> The terms Left and Right side originate from the symmetric
> difference. Name them there.
> ---

Sign-off?

>  Documentation/revisions.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 19314e3..79f6d03 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -256,7 +256,7 @@ A similar notation 'r1\...r2' is called symmetric difference
>  of 'r1' and 'r2' and is defined as
>  'r1 r2 --not $(git merge-base --all r1 r2)'.
>  It is the set of commits that are reachable from either one of
> -'r1' or 'r2' but not from both.
> +'r1' (Left side) or 'r2' (Right side) but not from both.

I think it is a good idea to call them explicitly left and right,
but I do not think they need to be capitalized here or on the title
of the patch.

>  In these two shorthands, you can omit one end and let it default to HEAD.
>  For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
