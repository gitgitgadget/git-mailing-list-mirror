Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A327D202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 01:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdIUBdx (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 21:33:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54874 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751000AbdIUBdw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 21:33:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3B75A6811;
        Wed, 20 Sep 2017 21:33:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dGwBk1VVfz9Q13a9hmwo3J0aisw=; b=JDGkfM
        /deOLvBlE/WPXBSOEb1bTI0LnBi5oD8SKN7oLAwDvVJz/Huj04JSwo7v1iXMNbMK
        xBRZ8cbv6KWJLjj4opr20xstlAEe7G720o8KxytWDHd5rsUrADQz9WEByuEcz1Hu
        NFrJXD9zhpNboI0tAW8vuOpzLil1FdPq9ce1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RPol1zNx+6ITy5SDo9+Ptol0xeow7A9S
        Ykw6PYsbBQ6zmMTLwtIjABSa3GNTCj2wPCHBpxDKNFf/YIONuEBKo5+YBIz4kkgB
        UD61iZ4dWSQWN8eHq9Jg07axfyKwMI7WwtQcF+PiI1gQ7jjzJEaZ5eQ5llvKl7tx
        ABWJIcS/efY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB02EA6810;
        Wed, 20 Sep 2017 21:33:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 076ABA680F;
        Wed, 20 Sep 2017 21:33:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] branch: document the usage of certain parameters
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
        <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
        <20170919071525.9404-3-kaarticsivaraam91196@gmail.com>
        <xmqq4lryovnm.fsf@gitster.mtv.corp.google.com>
        <d4e61e9b-e7ed-3565-6017-128b2fe3b72a@gmail.com>
Date:   Thu, 21 Sep 2017 10:33:50 +0900
In-Reply-To: <d4e61e9b-e7ed-3565-6017-128b2fe3b72a@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 20 Sep 2017 14:31:58 +0530")
Message-ID: <xmqqh8vwn8ch.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC8D6B9E-9E6C-11E7-9919-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Can I do this or should I keep the patch focused around the
> documentation part alone?

You can do both if you wanted to but not in a same patch that makes
the result noisier than it needs to.
