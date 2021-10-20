Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87A2C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 15:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925E56138D
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 15:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJTPhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 11:37:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60051 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhJTPhW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 11:37:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D415FF309B;
        Wed, 20 Oct 2021 11:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b/XEeDbBsnpVpnM/1PAHDovjiFeC9Amsnhs84+
        XtMM8=; b=TcFR8H65lce6sDHrMmx71URY7hWBr5eIV2qnpmOuFlSJXK7byhmxZW
        gZ4D6w0qSoPUiD7yyVJQaJ9vOT6y2JuQGc55dL6/Rt0cy4U28Rb8eUqgr8zxjoll
        au/tHF9eGjdvISCYg1swEC6ho4UPLSeFOQdQzQ/0cGzRJMoAUBn9w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB0A4F3099;
        Wed, 20 Oct 2021 11:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 734FFF3098;
        Wed, 20 Oct 2021 11:35:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] git config doc: fix recent ASCIIDOC formatting regresison
References: <20211008091614.732584-3-bagasdotme@gmail.com>
        <patch-1.1-36700e581d2-20211019T123057Z-avarab@gmail.com>
        <YW80k4kCPG6VJfW/@coredump.intra.peff.net>
Date:   Wed, 20 Oct 2021 08:35:05 -0700
In-Reply-To: <YW80k4kCPG6VJfW/@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 19 Oct 2021 17:11:47 -0400")
Message-ID: <xmqq7de7r9p2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D38FA9A-31BB-11EC-A0CF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I just want to call this out not only as a good way to review this
> patch, but a great way in general to review any patches which touch
> documentation. Running:
>
>   doc-diff 8c328561332^ 8c328561332
>
> shows the original problem pretty clearly.

I actually was somewhat miffed to see that this did not help an
update being discussed on MyFirstContribution X-<.  It could have
been a driver error, though.

>>  Documentation/config/color.txt | 2 --
>>  1 file changed, 2 deletions(-)
>
> Patch looks good. There's a small typo in the subject:
>
>> Subject: [PATCH] git config doc: fix recent ASCIIDOC formatting regresison
>
> s/regresison/regression/

Thanks.
