Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA781F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 03:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbfJYDLL (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 23:11:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53911 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfJYDLL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 23:11:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B68522F62;
        Thu, 24 Oct 2019 23:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BWFB6SN6dp0v7r495OCYVctlNAs=; b=FETwLz
        yB/SGmus3kp2jo9yjBCyf+m1zEdXXeivVs3Sd1VWSGMLYg5NXmPUKCLfnzRqBUgb
        GF1gIn82JD8iRPMCU0/ibMwdfpOMgWTNOLHzjNpVBcCVMp7Dh5w3ARw0w5giKqR3
        aCbvPfVdIcPYeR1TZ29r3VnTxm4ljcxds2aXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VF8wbighjnXeMYEOIpFEOakITeZVlbDB
        FJ0/y11c0rD9FaDTO5Yw9BYFih+RjgWRH0hi6KRMRyyVD5wdvTf/ouOqzXir++pP
        qTj9ARTilarE2LZXPbgUQA9UOt/QhfdjJ85Zgoz2QfeXsXKiGEfLfXYJyyd+X8KN
        zULYwQ1UksE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4415122F61;
        Thu, 24 Oct 2019 23:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2B0D22F60;
        Thu, 24 Oct 2019 23:11:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/23] parsing and fsck cleanups
References: <20191018044103.GA17625@sigill.intra.peff.net>
Date:   Fri, 25 Oct 2019 12:11:07 +0900
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 18 Oct 2019 00:41:03 -0400")
Message-ID: <xmqqeez1ecz8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17411878-F6D5-11E9-8D29-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>     This a string of refactors that ends up with all of the
>     type-specific fsck functions not getting an object struct at all.
>     My goal there was two-fold:
>
>        - it makes it harder to introduce weirdness like we saw in
> 	 patches 5-8.

Yup.  I'd see that alone as a reason that makes these worth doing.

And it was a pleasant read.  Thanks.
