Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36AE1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 20:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeAWU3h (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 15:29:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61320 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbeAWU3f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 15:29:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20A12BA132;
        Tue, 23 Jan 2018 15:29:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vgF36KMKmu5BHKN2aEAEwhbtp4k=; b=NFk/EL
        G90ybjencerqC1Suv7kIklxAo0DlIF+a2IHzxkFvIoSGeTENJCStPV5G82grAGWg
        +577okLT2HXdt3NOBF+ZekwTDaUjDKlSHOSztvVuSnsk0ogNTHTJ6Je8OQ7Csd8B
        53O/1taOuz3DpyxH7B4Qy0oCR9F0ri6BCpcxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UwSuVzKIVRero/N1wfMHKTnXorIoWywi
        QhT6vVDThEY/9G1vflC1TjpcmHduQFteBtW7Ljo1W/5sePNqijJ7iDmUOZWT+nLh
        RmYvcDbEhDJrEJAIwuZeUM/N9eVUheHJ3YuP93xpofVy9jR8W51fj9l9rJdKGOcX
        BYlP0/OmAX8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17317BA130;
        Tue, 23 Jan 2018 15:29:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C313BA12F;
        Tue, 23 Jan 2018 15:29:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/8] rebase -i: offer to recreate merge commits
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
Date:   Tue, 23 Jan 2018 12:29:33 -0800
In-Reply-To: <cover.1516225925.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 18 Jan 2018 16:35:23 +0100 (STD)")
Message-ID: <xmqqwp08fhea.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FE6032C-007C-11E8-B544-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> My original attempt was --preserve-merges, but that design was so
> limited that I did not even enable it in interactive mode.
> ...
> There are more patches in the pipeline, based on this patch series, but
> left for later in the interest of reviewable patch series: one mini
> series to use the sequencer even for `git rebase -i --root`, and another
> one to add support for octopus merges to --recreate-merges.

I left comments on a handful of them, but I do not think any of them
spotted a grave design issue to be a show stopper.  Overall, the
series was quite a pleasant read, even with those minor nits and
rooms for improvements.

Thanks.
