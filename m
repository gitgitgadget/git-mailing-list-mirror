Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDFD31FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 16:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbcLHQrJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 11:47:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61230 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752532AbcLHQrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 11:47:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 183B3540D5;
        Thu,  8 Dec 2016 11:47:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zORHNsDR/m1g+uLESz4+F+j2p/o=; b=P7IX7g
        wzjqNLASN9HP5fBqsKA+EMn6z8Zn/aSkUfAEg8LoA3rkmU7GSKwX/K0sy5eDuukJ
        LgjXjy6sQUwsbBo1h8ZnLF+zVwBKkcTtQKGuEYm+g9SvWrFSIHmpxwZ9st1UKCKn
        kbz/SkcvGRM9tb07j56qaby+uiz5fVWm5sNrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e4Ru4mJ+ZUhHZs0xXcdXSDjvqs0RyhYm
        WHpW9PlQMY+USWHBviXw2mcxIAAVyYy06U7B/6Vd5HBcEwFc7qfGg63SiFmT05W3
        OsskvPNXtDqalu8Xrq2ebcj+nIJQUBWEbdnUgxGnG/VBWqFhSHCYx8mdaviXO6pN
        iH2x53R0QaA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0ECC7540D4;
        Thu,  8 Dec 2016 11:47:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DF85540D3;
        Thu,  8 Dec 2016 11:47:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] commit: make --only --allow-empty work without paths
References: <20161202221513.GA5370@inner.h.apk.li>
        <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net>
        <xmqqd1h63xqn.fsf@gitster.mtv.corp.google.com>
        <20161208135029.GA16292@inner.h.apk.li>
Date:   Thu, 08 Dec 2016 08:47:06 -0800
In-Reply-To: <20161208135029.GA16292@inner.h.apk.li> (Andreas Krey's message
        of "Thu, 8 Dec 2016 14:50:29 +0100")
Message-ID: <xmqq1sxiv051.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4A70256-BD65-11E6-ADB7-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Krey <a.krey@gmx.de> writes:

> Ok, I've removed the clever message, as Junio suggested.
> I don't know what else to do to make it acceptable. :-)
> We're going to deploy it internally anyway, but I think
> it belongs in git.git as well (aka 'Can I has "will queue"?').

Oh, sorry for being unclear.  Before I started saying "Slightly
related topic.", after quoting "The patch itself looks good to me."
by Peff, I meant to say "Yeah, this looks good; thanks.", but
apparently I forgot.

Removal of "Clever" is a separate issue and it may make sense to do
so, but it deserves its own commit with its own justification.

Sorry for making you send an extra round; let's queue the original,
and if you still are interested, have the "Clever" removal as its
own patch.

Thanks.


