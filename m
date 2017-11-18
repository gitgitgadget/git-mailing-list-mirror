Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E21202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 03:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760848AbdKRDl6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 22:41:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50383 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760716AbdKRDl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 22:41:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36270BBA24;
        Fri, 17 Nov 2017 22:41:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y7fHsDCJezU+4Mn8p9dHjFpZftI=; b=PVnCnT
        BuoosIJQu/RNE3C89yKpB2a0WtSHQTPFKoKGWsrDuh+sLrowJJjaKMAXUXl1/OlI
        qArBVhxOgClCY3WDbIY9MB7RffDh82Fg/zeGFx0gsV409JBErEJeXzUEp1zt8GfB
        dPP1QQ/HaOu+lCjR8UOgBiGl3n79WLrU69374=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=er483hBABg1JgH2u2uRJKdv4OTW4hkZ9
        7znHsIsMy8sVfPlEDA8e3HqjLxLIhYV+p/iZz8H8S1Lo6reQAuF5dkbSOZ35BD3T
        0fG0xTNBsT3Nop8RfrwTjD+0fMeDFUhTn0ev2J5ADQiqRgeHI3XvbDvrGNyugj6T
        AYJgB4/6Li8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DE21BBA23;
        Fri, 17 Nov 2017 22:41:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70963BBA22;
        Fri, 17 Nov 2017 22:41:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/8] sequencer: don't fork git commit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171117113452.26597-1-phillip.wood@talktalk.net>
Date:   Sat, 18 Nov 2017 12:41:54 +0900
In-Reply-To: <20171117113452.26597-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Fri, 17 Nov 2017 11:34:44 +0000")
Message-ID: <xmqq4lpsqmm5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C31E3DE-CC12-11E7-86BD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> I've updated these based on the feedback for v2. I've dropped the
> patch that stopped print_commit_summary() from dying as I think it is
> better to die than return an error (see the commit message of the
> patch that adds print_commit_summary() for the reasoning). Apart from
> that they're minor changes - style fixes and a reworded a commit message.

Thanks for further polishing this topic; I found nothing in the
update that was questionable.  Will replace.

With this, perhaps it is ready for 'next'?
