Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCA5C433E3
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF84922B3F
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q81GcUoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgGVVQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:16:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59246 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVVQk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 17:16:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64FCB76F10;
        Wed, 22 Jul 2020 17:16:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eI6UIL93s37mLzJp3cHIh7FDEtY=; b=Q81GcU
        ojL8iEb81xMHdCka4aZFleh63/rai7soLrrf4OOI2zhimXfIBKbWQqU064bHTZyz
        bzYeSlGjbaoeEjBh9WSmZWfzfVcNaf4xZdUCnWpVICKLW4OJd6+on99Mt11NQcOq
        b4jZoP4mpqtMAGMYEodYuoQClIHG/S4vfzxBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wZh9OCOWRxn7S4b1bg9AIZyOaoPy/RG3
        TH9irIdjEyLQF/50S/SQL3p7XAlPGjdmK7G2hNNvzWP4zkzWMCZKjdJorMdzMrGn
        3Uvq+HAIz8tVvuEDkt4/8Cak8wkt9JamkCNzj76AU3TIu2aC9cDB0swzG6E1FoKM
        foRWuuucbpI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AF9176F0E;
        Wed, 22 Jul 2020 17:16:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E122976F0D;
        Wed, 22 Jul 2020 17:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] doc: remove misleading documentation on pack names
References: <20200722202629.109277-1-johannes@sipsolutions.net>
        <xmqq5zaf5ka6.fsf@gitster.c.googlers.com>
        <ab8993fc6840765895ad39c59af1e536582e76d7.camel@sipsolutions.net>
Date:   Wed, 22 Jul 2020 14:16:37 -0700
In-Reply-To: <ab8993fc6840765895ad39c59af1e536582e76d7.camel@sipsolutions.net>
        (Johannes Berg's message of "Wed, 22 Jul 2020 23:14:03 +0200")
Message-ID: <xmqqsgdj45e2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A110BA34-CC60-11EA-96A4-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Really all I was trying to do is be a *little* more helpful than just
> point out "the documentation is wrong"...

Thanks.
