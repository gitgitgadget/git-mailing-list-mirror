Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1016A1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 03:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfFRDaL (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 23:30:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54709 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRDaK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 23:30:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68EC615B2D2;
        Mon, 17 Jun 2019 23:30:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A2kjXfXLnZckl9a2M+6nqQnDl5U=; b=JWsG2Y
        1IO8DzxLWuQBqnMcToO6v9GozgQYwM2LU7sAZSRVn9RP3T9bHkVT+EKQ2pUjyijk
        +3rWnGkfz6Tw3VwiTh7YNhId7s1R2r5aGTMJ9YUFPAXUfH8mqeqNgzbAlfhnoa7H
        FywKpWlLJRZxDRqY0kDeqa+gaouuR8y3iodCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bbn+B/ZXj49kjcgd5CRCU7kah0Ub+v8V
        oyhskkpMgqq99Sukw+B+xUsjkeYHesxku3IOiYYzMP8O6g8oc4tt/ezuHltStzVT
        Hyg1+mjum2s3TTWOmRnr1u7JLjA8NjKQ7gIMervFC3Vc4/D9Ocyk3IkJFj7MGvnX
        YOmn7k7NDNE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E90715B2D1;
        Mon, 17 Jun 2019 23:30:08 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CC5F15B2CC;
        Mon, 17 Jun 2019 23:30:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: pw/rebase-abort-clean-rewritten, was Re: What's cooking in git.git (Jun 2019, #04; Fri, 14)
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906172001490.44@tvgsbejvaqbjf.bet>
        <2a37d4c2-6eec-548d-0bd0-12bbd49c8071@gmail.com>
Date:   Mon, 17 Jun 2019 20:30:04 -0700
In-Reply-To: <2a37d4c2-6eec-548d-0bd0-12bbd49c8071@gmail.com> (Phillip Wood's
        message of "Mon, 17 Jun 2019 20:04:00 +0100")
Message-ID: <xmqq7e9jsh8j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DFAF336-9179-11E9-8597-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Yes I sent it just before I went offline, but that's a while ago now

Yup.  IIRC, you told us not to look at the patch "for now" as you
would be offline, and I was fully expecting that a regular review
exchange would happen after you come back.

I do not recall seeing much discussion, though, but ...

>> Phillip, I was under the impression that all reviewer comments had been
>> resolved. Does that match your impression?
>
> Yes, I think it's ready. Thanks for prompting me dscho, I'd seen this
> was on hold and then forgotten to write to Junio

... if you resolved "all reviewer comments", it must have seen
sufficient review, in which case let's merge it to 'next'.

Thanks.
