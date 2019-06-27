Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01411F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfF0RnZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:43:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50715 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfF0RnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:43:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E10D157434;
        Thu, 27 Jun 2019 13:43:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pFL8HCIjGd9j8pXJPnFESapJnsw=; b=nTvQA2
        H+QdH0fk7WtDLEBAhxhiiZut33yPv8RsmBmLHT9PWUQw/cStMVJI+RZaDztPCGOu
        G7swA90FTzwutdcTil6PNd7t8fXbWNV+vn+K1llLmO3uZypTNIGlSF6S6zOqdaep
        Szi/FkDmfcWneAFdYuol0pL62fGXB6djXevNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fuvcYNMFwcZ88BsL6T/XyqWT0xN4pa5a
        yGrD6Qkn/vDHpsSVY+S2y9NLrvKg86AJC+M+xBYPjvCuZHYhimV0/6bi55xZptEC
        aex39v1Yfho2EzxCaeBNGqJOBZsJ2oANP7XkGoBmL5T9NZG5dmkOrCaDjqEg3p+5
        V2tj3w8Y8tI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7542E157433;
        Thu, 27 Jun 2019 13:43:22 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7B50157432;
        Thu, 27 Jun 2019 13:43:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make slash-rules more readable
References: <20190604173446.2664-1-admin@in-ici.net>
        <bd722415-1547-8db5-f88a-c35c8b48d8be@in-ici.net>
Date:   Thu, 27 Jun 2019 10:43:20 -0700
In-Reply-To: <bd722415-1547-8db5-f88a-c35c8b48d8be@in-ici.net> (Adam Nielsen's
        message of "Tue, 25 Jun 2019 13:05:13 +0200")
Message-ID: <xmqqd0iyc4av.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E83DC46-9903-11E9-9D22-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

> Hi everyone,
>
> any comments about the patch note from 04.06 ?

https://git.kernel.org/pub/scm/git/git.git/log/ shows that the topic
holding the patch has already been merged to the 'master' branch
about 6 days ago, at

https://git.kernel.org/pub/scm/git/git.git/commit/?id=e694ea5e04ea2cabc64ade337063b5562810b268

Thanks.
