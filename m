Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4181F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 07:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeKZRzg (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:55:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54990 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeKZRzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:55:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A5F710ECC5;
        Mon, 26 Nov 2018 02:02:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wAqqXao+JVNcFwV2mYdhnX8bkrU=; b=F6lcjw
        HMoJGFFbk9R1Z4hMToColqspECuVPxOaSJdbSDSmbtfu0fgFsvignp+gcC2/7ANv
        PxGKRGYMrdoUVfMyG5QktfCg5rw3k2FClI6vScOQh2ZsN/SYmW5nK/bzGbN5BKfU
        JdjTF8rfoiAVf0GC8epDokTFoiWFHL29EVWoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lzXvHLq7ZAgEqKQYxlk8KtFSgeWMdnyw
        4TYTecTvz0why8vHChY7uXyUMljfEZFuB5jeaSj5hphx+iAplVRFMO4SG7VKR1Fn
        JMzKqjImXjcGduOBFOsfjNfrPIch1TtvVUE7OnqETlimeiECSNrRa3CL5qGTVYxW
        Lbw0oNZ7+nk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6111A10ECC2;
        Mon, 26 Nov 2018 02:02:25 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C079F10ECC0;
        Mon, 26 Nov 2018 02:02:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH] doc: update diff-format.txt for removed ellipses in --raw
References: <xmqqwop32npr.fsf@gitster-ct.c.googlers.com>
        <20181124092958.3549-1-greg@hurrell.net>
Date:   Mon, 26 Nov 2018 16:02:23 +0900
In-Reply-To: <20181124092958.3549-1-greg@hurrell.net> (Greg Hurrell's message
        of "Sat, 24 Nov 2018 10:29:58 +0100")
Message-ID: <xmqqzhtwwccg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A501EE6-F149-11E8-94D3-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greg Hurrell <greg@hurrell.net> writes:

> Since 7cb6ac1e4b ("diff: diff_aligned_abbrev: remove ellipsis after
> abbreviated SHA-1 value", 2017-12-03), the "--raw" format of diff
> does not add ellipses in an attempt to align the output, but the
> documentation was not updated to reflect this.
>
> Signed-off-by: Greg Hurrell <greg@hurrell.net>
> ---
>
> The GIT_PRINT_SHA1_ELLIPSIS environment variable can be used, for now,
> to bring back the old output format, but that is already documented in
> git.txt, so I am not mentioning it here.

Thanks. Will queue.
