Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2634202DD
	for <e@80x24.org>; Sat, 21 Oct 2017 08:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbdJUIxB (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 04:53:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61220 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751668AbdJUIxA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 04:53:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B6F5B8CD4;
        Sat, 21 Oct 2017 04:52:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9DtB5fZQVRVrtufrgfx2DyCY85M=; b=ns/PXA
        av2f9u45mgJWaa73k+To0H8sySEMlJDdPnoJz2uGYzxeN+vYfo7GLp2wUtOJIdyc
        gbAXRsZOE3okri4KQUfoIx5oJjxCfPiMHOabafJP26vkASv0EPw9lPbDacoFakgh
        EGZtJG+s6o4cBIX94IwQ2vVh0wOtUh5wftv+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l7l54q1GNjv1HN+DRg7cwuugVQFG/fsH
        3rNuMW2+fgwE3b2CJCRC5zKdLgqhCkVeVqw1qBZbUE4Yr8DHyIayeMEFBBqy2yHk
        9kj34dvdIhdicN3SDDmYUoiL+JUOj3d6J8pm6AS1aCoEgXSXhNIxN1VJr6cIO0pM
        SPEJzUDVEkw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 735F5B8CD3;
        Sat, 21 Oct 2017 04:52:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1E3FB8CD2;
        Sat, 21 Oct 2017 04:52:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] a small branch API clean-up
References: <20171013051132.3973-1-gitster@pobox.com>
        <1508555222.2516.11.camel@gmail.com>
Date:   Sat, 21 Oct 2017 17:52:55 +0900
In-Reply-To: <1508555222.2516.11.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sat, 21 Oct 2017 08:37:02 +0530")
Message-ID: <xmqqtvysg9w8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BBABF86-B63D-11E7-B598-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On Fri, 2017-10-13 at 14:11 +0900, Junio C Hamano wrote:
>> This started as a little clean-up for a NEEDSWORK comment in
>> branch.h, but it ended up adding a rather useful safety feature.
>> 
>
> Part of this series seems to duplicate the work done in part of my
> series that tries to give more useful error messages when renaming a
> branch.
>
> https://public-inbox.org/git/%3C20170919071525.9404-1-kaarticsivaraam91196@gmail.com%3E/
>
> Any reasons for this?

Sorry, but I am not sure what you are asking.  

I was looking at the code, noticed NEEDSWORK comment and worked on
cleaning things up---you seem to feel that I need a reason, or
perhaps even your permission, when I try improving the codebase?
That starts to sound a bit ridiculous.

As different developers are multiple people, it just happens that
areas somebody changes overlap an area somebody else wants to
change.  It's not like anybody owns a piece of source file when s/he
expresses an interest to work on something that may or may not
affect that area.
