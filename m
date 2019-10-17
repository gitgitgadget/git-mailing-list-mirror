Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150E01F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 07:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392783AbfJQHGB (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 03:06:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52785 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390955AbfJQHGB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 03:06:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF4218A714;
        Thu, 17 Oct 2019 03:06:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2hOY0LFoLpPrqWSzEG8jntwm8dc=; b=iunvep
        TUqDVgE+lhGlKPESXHz4A6Re/lQ7M8Ol9ZVemmMuDoVWLZlNgQxQfeFxDIvBnCtC
        PlUYj0AO/1UfWxs0o5tlFo863BYch5lyDVtBOxtkLwsmIeR4xcVqeMAoujcJujXB
        5wS/N1qY+iXjYvm31uVjeydXp9/NsdmYLtcKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZbBQl4NeXutpJ3lFBhDnQ5mtt/LDdODy
        Gs1XIT4gEDhFanZDmEY2PPcK6IKLZams/GiNU3PU4UC1ADJTI/vH8DP0NXCBB0DI
        vt/VP70faHZu84p4dQTfuKm7ie2C4F7X9Wg4tg+Gkk9tfoWtGUXx/SYHCpYi9Udf
        fus+cXHhTqI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8F888A713;
        Thu, 17 Oct 2019 03:06:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CED1B8A712;
        Thu, 17 Oct 2019 03:05:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] remote-curl: pass on atomic capability to remote side
References: <20191015010759.2259-1-sandals@crustytoothpaste.net>
        <20191015164028.GA4710@sigill.intra.peff.net>
        <20191016234306.tqaszjc2sfxqg3zr@camp.crustytoothpaste.net>
Date:   Thu, 17 Oct 2019 16:05:55 +0900
In-Reply-To: <20191016234306.tqaszjc2sfxqg3zr@camp.crustytoothpaste.net>
        (brian m. carlson's message of "Wed, 16 Oct 2019 23:43:06 +0000")
Message-ID: <xmqq4l0797ho.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 918F23D8-F0AC-11E9-B532-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Yeah, my default editor configuration for AsciiDoc is two spaces.  I
> noticed that Junio's already picked it up for next, but I'll send a v2
> with this fixed in case he wants to merge the fixed version to master
> instead.
>
> If it's more convenient, I can send a follow-up patch fixing the whitespace.

Either is fine.  At this point in the cycle where we are very close
to -rc0, I do not mind too much about having a few reverts of 'next'
to give a clean slate to an obvious and trivial fix.

Thanks.
