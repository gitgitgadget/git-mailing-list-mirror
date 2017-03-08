Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE622023C
	for <e@80x24.org>; Wed,  8 Mar 2017 22:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbdCHWTs (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:19:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51993 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751262AbdCHWTq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:19:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E65E56ED3A;
        Wed,  8 Mar 2017 17:19:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tu1GH760fQNPvNBqlo90SNtlhws=; b=YekC2u
        0Nen2xhxThJ+5yZhPFrCFMwPzN+84OWu1xAUDVneuzrfRwcOi7ZpHS+TIXAgVH6p
        xog6vnjjdDes3AEwX4neLJGHhGMyJyqeOynwhsFtrUxKI97Ds/+M1wfDxBieadGt
        pS9ZpMTt9uii4XDsR6AvptNQNvzfD1XF3KJa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rSLaF3PiQVvMgSQ6m9/XDKqFdU8oPbjy
        kbMccnkSUfq9a7f7nW9z+L+WwnBT0RMhGTDAhz9po4TDb69Qwze5KcRmdDo5tC+n
        wHwF6EvV3K6YDmejt4j0fl/k8eFgrd6bT6+SMh+zwmdyiskw8eqLBxgF5hDPkTqS
        fxJZHM0HOEI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF1DA6ED39;
        Wed,  8 Mar 2017 17:19:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54DD66ED38;
        Wed,  8 Mar 2017 17:19:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        valtron <valtron2000@gmail.com>, git@vger.kernel.org
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com>
        <alpine.DEB.2.20.1703072345530.3767@virtualbox>
        <alpine.DEB.2.20.1703080104580.3767@virtualbox>
        <20170308020918.GA1650@google.com>
        <alpine.DEB.2.20.1703081254480.3767@virtualbox>
        <20170308184606.GB130604@google.com>
Date:   Wed, 08 Mar 2017 14:19:25 -0800
In-Reply-To: <20170308184606.GB130604@google.com> (Brandon Williams's message
        of "Wed, 8 Mar 2017 10:46:06 -0800")
Message-ID: <xmqqr3271keq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A4C1506-044D-11E7-956D-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Of course, I usually try to clear the parts of the mail I'm not
> responding to...though there are times where I forget or am a bit lazy.
> I'll definitely work on remembering to do that for the future!

This cuts both ways.  Sometimes it is very useful to be able to see
other parts that the responder is not _directly_ responding to when
you come as a third person to the discussion, which forces you to
find messages upthread, so do not overdo it.

