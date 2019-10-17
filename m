Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942DD1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 07:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbfJQHjw (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 03:39:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59324 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfJQHjw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 03:39:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78FAB1CFD7;
        Thu, 17 Oct 2019 03:39:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BcE4436srP+0gwe09XXKI3GMC0U=; b=gVoL1t
        Og1ik4b/DXGTQJ+4YQeQYt0/p8Y5MZetmIQx8eQcRj6hATh4ghuszX1XrHKFjEcV
        +VNh2TaUIq0wh2r3VTs/J/nBAjTOXfsrlXtxrlnvUnA/W4p50mxf23yQmiNeU7Gh
        mwVc0BV6TPEZD1Uou+uF4VeNQFCDfI0opNTyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qRAwTYODkhs2bPI8N0lR629+eIdMScxx
        LUruZEfPVvUVDlWFiz8ZSrIFKppByCEnlRf87vNCjn4rMNwSN5/+DwEzjn0McGKX
        nZtnYErk/hxf9QCurHIsazt7A6mTRwquX8q7fWILdN0pnD8vvzBdgXY8jYxMeeSo
        4grG0lAH8ss=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FDBB1CFD6;
        Thu, 17 Oct 2019 03:39:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C26761CFD5;
        Thu, 17 Oct 2019 03:39:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] doc: provide guidance on user.name format
References: <20191017005330.9021-1-sandals@crustytoothpaste.net>
        <20191017005330.9021-2-sandals@crustytoothpaste.net>
        <20191017054051.GA10253@sigill.intra.peff.net>
Date:   Thu, 17 Oct 2019 16:39:48 +0900
In-Reply-To: <20191017054051.GA10253@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 17 Oct 2019 01:40:52 -0400")
Message-ID: <xmqqmudz7rcr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CB24092-F0B1-11E9-AA80-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think this is a good distinction to draw, but...
>
>>  Documentation/git-commit-tree.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> ...I was surprised to see it here, where I think most users wouldn't
> find it. Would it make sense in git-commit(1), or in the description of
> the user.name config?

Yeah, I had the same reaction as you had, both positive and negative
(eh, rather "surprised").
