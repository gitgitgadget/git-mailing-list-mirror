Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9188E2036C
	for <e@80x24.org>; Thu,  5 Oct 2017 05:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbdJEFVK (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 01:21:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50093 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750995AbdJEFVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 01:21:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E2C5B548B;
        Thu,  5 Oct 2017 01:21:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=02yqEAb6NIv+bACGb/RIZKAdnC4=; b=plveOG
        m4uy4g/pDUpo4Ndfsh734LW0FQad0NBKh7Ob41GlGq9hW3hArTSIOtkiRKjPglsC
        O9EOO+tppSNMIKSFzM9KhUuxsUJjHKhj9ttHUMc2p65pay/vr/qkQ9T234km2US/
        /k7pMj777Xbj1lmAlGA9Z5FmLN8YhWll8MQEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qIrUNL+Svti0XGGF4naPBYjZCQTkIX2Z
        7Vdb57fTt1meuYojMt8u9kE9Vm58/NZ4QU1zoKgx3xQMHHzAo3ouwnVttPUM79tg
        EgdIDxhujfLUU0WzNIBe7p5TRJQtj7hHZiUEk/fIxAgSFydWxz57YVlWceyhApwH
        yyajLcW9W7U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36793B548A;
        Thu,  5 Oct 2017 01:21:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD483B5489;
        Thu,  5 Oct 2017 01:21:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #01; Wed, 4)
References: <xmqqy3orbcrr.fsf@gitster.mtv.corp.google.com>
        <20171004083111.5y7su63scydg2yzk@sigill.intra.peff.net>
        <xmqqr2ujb8rm.fsf@gitster.mtv.corp.google.com>
        <20171004180737.GA90224@D-173-250-188-46.dhcp4.washington.edu>
Date:   Thu, 05 Oct 2017 14:21:07 +0900
In-Reply-To: <20171004180737.GA90224@D-173-250-188-46.dhcp4.washington.edu>
        (Taylor Blau's message of "Wed, 4 Oct 2017 11:07:37 -0700")
Message-ID: <xmqqd1628918.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE6E41A0-A98C-11E7-9D90-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> It may make sense to send my other series to 'master' as well
> ("ref-filter.c: pass empty-string as NULL to atom parsers").

Thanks for reminding.  I was involved in the review and remember
that everybody was happy with the direction.  The topic was left on
the list without getting picked up by a mere accident.

Now it is queued.  Let's make sure nobody is depending on the
%(atom) vs %(atom:) distinction by merging it to 'next' soonish.

Those who don't raise stink while the change is in 'next' but only
do so after it hits a release won't be heard ;-)
