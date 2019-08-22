Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971001F461
	for <e@80x24.org>; Thu, 22 Aug 2019 15:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbfHVPx6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 11:53:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55890 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfHVPx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 11:53:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D58C6E576;
        Thu, 22 Aug 2019 11:53:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/QvGCHb++FKJ
        L+4nm03g5Y6FslQ=; b=WVb4oFPDKSSyFD52SwcDy2iJEJ8SRJ9aJrLQhnIRQ8KH
        LRdYK6N8HPQFHOP8ru5DJXDvyzxC8mnRlUypDIpM/K4d+OFuBBaLu0OhkcwbzI3/
        DNkXuaLfD7xC2u92Q68m4mrYlNWWpcbsQgroYnn4ekyUOZusi1evK0sZbgoYp4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DOekxK
        zyBEAD7I803RP93zrmxv3j0m769Nivl1GgutV3BY2mVbuH5sokIGwBh6NaMShav9
        1ILQQYEaSxJCtF/oEZo45mPE67P6rxwl0XWVlvUL9s1CdXBPgMFxNxlAIJ7yDnl7
        58jJhxoniEZ2fvE9sNYfhknWCwWk+TSGvpGFM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75D786E574;
        Thu, 22 Aug 2019 11:53:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9CF786E56F;
        Thu, 22 Aug 2019 11:53:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/26] patch-id: convert to use the_hash_algo
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
        <20190818200427.870753-3-sandals@crustytoothpaste.net>
        <1d3b46de-155a-6072-5e44-2622ac821230@web.de>
        <20190820223606.GJ365197@genre.crustytoothpaste.net>
Date:   Thu, 22 Aug 2019 08:53:51 -0700
In-Reply-To: <20190820223606.GJ365197@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 20 Aug 2019 22:36:06 +0000")
Message-ID: <xmqqblwhqjqo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0AAB97B2-C4F5-11E9-9778-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2019-08-20 at 21:12:00, Ren=C3=A9 Scharfe wrote:
>> So perhaps this on top?  (Or squash it in, if you like, but it's
>> certainly not worth a re-roll.)
>
> Yeah, this seems sensible.  I'll include it if I do a re-roll.

Thanks.
