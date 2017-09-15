Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402D320281
	for <e@80x24.org>; Fri, 15 Sep 2017 20:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbdIOUdE (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 16:33:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57085 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751568AbdIOUdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 16:33:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C244ACF21;
        Fri, 15 Sep 2017 16:33:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uEzsg8SqJBEjWhMld6GWkadalRM=; b=j4z46R
        mwEXhUyeHOXjOPXRlb6N1lwJ8yZV4fOiBABQul0N4o8qVzCkCu76aYQkRg16Z7kK
        31sQE/PE0GD8m7CVB9W+BqDeBcxWCGd50q8rfLWGDXZGiXnDMAa8i56Mri4BffTA
        +9irRjST8XI1J82c3wOQSjkNoWp5TnVBHaSdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XEgvB4X63R8ZsxP9uOWn9Kxq8gbUDVw5
        ZnUHCFLAqvYgA7RC6wC0eeOEXdo63DuiNip4VtXJJk30MO+RttOplLLb6smL0D+1
        8LAnTFmk5vnKO7xwKA6DHtZzkWKqXWXGst6RM8XmYqyoLCgCRkOGVOIut6H1mMB+
        RyGxicmT96A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 629E7ACF1A;
        Fri, 15 Sep 2017 16:33:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC5A7ACF17;
        Fri, 15 Sep 2017 16:33:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709152113070.219280@virtualbox>
Date:   Sat, 16 Sep 2017 05:33:00 +0900
In-Reply-To: <alpine.DEB.2.21.1.1709152113070.219280@virtualbox> (Johannes
        Schindelin's message of "Fri, 15 Sep 2017 21:14:09 +0200 (CEST)")
Message-ID: <xmqqk20zwvlv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11A8660C-9A55-11E7-824E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Please stop stating that you expect a reroll for rebase-i-extra when you
> explicitly stated months ago that you would not take my v6. It gets a bit
> annoying.

I already explained to you why I skipped v6, which turned to be
identical to v5 when the unnecessary rebase was undone.  It does not
have anything to do with expecting a v7 or later to fix other things
already pointed out in the review.

Having said that, I am getting sick of your constant hostile
whining, and am inclined to merge it as-is to 'next' and advance it
from there, if only to reduce these noises from you.  Even if you
are unwilling to, you do not have the sole possession and veto power
over the area of the code (neither do I) to prevent further
improvements, so I can expect others with good design taste
(hopefully not me) to fix up the misuse of revision traversal
implementation detail with follow-up patches.
