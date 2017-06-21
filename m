Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA1C20401
	for <e@80x24.org>; Wed, 21 Jun 2017 23:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbdFUXMQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 19:12:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61729 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750981AbdFUXMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 19:12:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E80BC8AB1D;
        Wed, 21 Jun 2017 19:12:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=zSUBJYmktjksfMDjGTKsFuSEMfw=; b=sp6oMK
        rJpm8RMC/NfdyszIULl/BQalAYh6OPOYM3llyeAobAPYhv95vZMnKOP2cok/hzRo
        gb9GxFGBlMJZnE2MoFPZa3+Y8P08bDqAipUoAeFBrZ+NjHd5/IaztiQjRiCQu8pO
        lN+6g3H7V2L1ZDToPZImH2HO5d6jOxoIGeJVY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E06468AB1C;
        Wed, 21 Jun 2017 19:12:07 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 447A98AB1B;
        Wed, 21 Jun 2017 19:12:07 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
In-Reply-To: <87efud7xjd.fsf@kyleam.com>
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net> <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com> <87efud7xjd.fsf@kyleam.com>
Date:   Wed, 21 Jun 2017 19:12:06 -0400
Message-ID: <87a8517x6h.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BBBEF46-56D7-11E7-897E-61520C78B957-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=zSUBJYmktjksfMDjGTKsFuSEMfw=; b=rsAF5uNiGko8CrAPwO81rRQuBRQGnQK8Cndrf2EUG8YzX10eMIHIBcuO8HnUy1xBJcha06fbPjknJieUS5j0YUtY3SSSzk8ESyS9DcTsREkwwqEui6QwxBAHdNZL0NPmyAqgypjK/vgtcwjuHpGmmQ8rgUmDxiWjSZ2dSzjJYQE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> Eh, sorry about that.  I haven't dug very deeply, but it seems like the
> entry is still in .git/logs/HEAD, while "git reflog" is only showing
> they latest entry.

s/entry is still/missing entries are still/

