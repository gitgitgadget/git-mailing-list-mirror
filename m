Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DBE01F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 19:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfJIThO (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 15:37:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57422 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731616AbfJIThN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 15:37:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C740180F8;
        Wed,  9 Oct 2019 15:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7WbbPLkF6ZIY0k8f19ogN6Zl3xI=; b=hvqS5i
        1XQ5dAAQ9GOgwpvpxWu11Ffvuo+2xf46WwRbgFH+tbCcYeH5k7hXcFdx3+T3RPpU
        AxwPrPOOcp6noTSSc6vt5308b9cTtYXrtlaYVkcoKks4mXJJR2lFe7L962+mKxms
        qUCqbxZGYmKf6NCCA3PiCFb9/lHDU/2EwDILA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iX1zuJ+lkUvaTIKCiXv+b6Gv4WYh7tUP
        lfOq6B8BIpQU9tk5Ho3GnVbzvejP9l5FZDf+jFigg/UElrar9HJaTxGPLoARO1o4
        d/pdoBcKrK3uMOsJZnDg0o86J+xf0x9WhGoXuHYOJJS7pTb9kE6vzQEotDstHizi
        HtggwLVTtms=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54353180F7;
        Wed,  9 Oct 2019 15:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B98BF180F6;
        Wed,  9 Oct 2019 15:37:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru cracks
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
        <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
        <CABPp-BGjaOofi_gWEatKnnkpY04OOyMDZucXqQ-FPYw8yeCacw@mail.gmail.com>
Date:   Thu, 10 Oct 2019 04:37:09 +0900
In-Reply-To: <CABPp-BGjaOofi_gWEatKnnkpY04OOyMDZucXqQ-FPYw8yeCacw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 9 Oct 2019 11:29:19 -0700")
Message-ID: <xmqq5zkxlnh6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FCDB7A8-EACC-11E9-9E78-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Those Acked-by's are nearly in alphabetical order (at least at first
> glance) until Brian, Derrick, and me.

Sorted in ascii order after the first "<" on the line.
