Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93EB51F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391029AbfITRsV (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:48:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61186 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbfITRsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:48:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9BA72DB9B;
        Fri, 20 Sep 2019 13:48:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6QvkG3+EnU/YuIAr+zb8F2KXfmI=; b=qfftd/
        P6tjgOFb8bL6z4pdyHzTbwtkG9rmCreZPYhGwPSA7fTWVm2VMWgV3nhR6qNWoFIU
        ygGmGu0GNSx0H9oPlpDp6n4gqFCiyVUXwqh2vyxoUgZE1FMjOxhVpiZB50leeNnh
        W6Eq6K/TjitxoVl0z8TakDuAXuxTxE3hW2shU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n1DaEieDmIA4aLaCRNj4ctkNNfrXa7G+
        /m9oFbJliqaEs9UzVcMUE9YOufGK6eUdsUXKVahhczorIAzBKH+GLbleljQuI2Bl
        ClQ26wSauPr1RBMmMtYDY/MN1Si3VSXT/OaPu0PAxjNP0hotR/VFS5VNKDnqOo8w
        EV/LljRrOZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E03CC2DB9A;
        Fri, 20 Sep 2019 13:48:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CFB02DB99;
        Fri, 20 Sep 2019 13:48:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
        <20190919173423.GA70421@dentonliu-ltm.internal.salesforce.com>
        <20190919222607.GA25680@sigill.intra.peff.net>
Date:   Fri, 20 Sep 2019 10:48:17 -0700
In-Reply-To: <20190919222607.GA25680@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 19 Sep 2019 18:26:07 -0400")
Message-ID: <xmqqo8zevoym.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D450E456-DBCE-11E9-ABF6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I've had similar thoughts over the years, but eventually switched my way
> of thinking. I think part of that switch was coming to the conclusion
> that most of the value of a Code of Conduct isn't about having a system
> of enforcement against bad actors (in fact, I think that's the most
> difficult and potentially problematic part, because it creates a sort of
> justice system). IMHO the most important part is that it communicates
> and reinforces norms:
>
>   - It lets good actors easily understand what the expectations are.
>
>   - It gives a framework for agreed-upon principles, so that people can
>     more easily and productively discuss the conflicts that do happen.
>
>   - It advertises our values to people outside the community, which may
>     help make us more inviting for people to join (and ultimately
>     contribute code, or docs, or reviews, etc).

And it saves us time when we need to deal with problematic folks.
It would have saved a lot of mental energey from me, you, muggerhagger and
jrnieder (perhaps I am forgetting others) during the last incident,
if we already had one back then.

