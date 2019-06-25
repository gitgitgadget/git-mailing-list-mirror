Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B91F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 17:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfFYRoa (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 13:44:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63104 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbfFYRoa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 13:44:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A748B164865;
        Tue, 25 Jun 2019 13:44:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3myjTL9RgH8+EFVLDw4Lu2nT304=; b=FsohMJ
        792RDP01ZU0sNL/G7R2nMgqS9AWg8tq5WJ2vKlaZXwiA2MBYHcJtQUh4bvANVqWr
        5hyt1VolhW4ANDdsDmLn72aASJa/s7sN1mHlNmg7t7gErEUhn0ThtLE7Nylxntj0
        RoHP/0NwxvOWUk+YsX0FvomBe/yrwNIPlUqYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=he1HJHxeRv/Vku6kjZC0YzOgcZill8/o
        h7OBTuQzYYPcE1MNFaVmAzNkLAJPEUSEwTYyUGqk1CXv9PauEc/1xxlOk+2aJ2e3
        pCH2xv30sgIy0Qll/iTL+oUbRLiT6ebdUtt7kULEEe3WI+h7HYHnXubVIamqbUrp
        bLfwLybAHFg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BC0B164864;
        Tue, 25 Jun 2019 13:44:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDB95164863;
        Tue, 25 Jun 2019 13:44:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrey <ahippo@yandex.ru>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "luke\@diamand.org" <luke@diamand.org>
Subject: Re: What's cooking in git.git (Jun 2019, #05; Wed, 19)
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
        <1748011561196810@sas2-7b909973f402.qloud-c.yandex.net>
        <xmqqmui6j4mk.fsf@gitster-ct.c.googlers.com>
        <8406251561455942@sas2-a1efad875d04.qloud-c.yandex.net>
Date:   Tue, 25 Jun 2019 10:44:25 -0700
In-Reply-To: <8406251561455942@sas2-a1efad875d04.qloud-c.yandex.net> (Andrey's
        message of "Tue, 25 Jun 2019 05:45:42 -0400")
Message-ID: <xmqqr27hftl2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0727170-9770-11E9-90F9-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrey <ahippo@yandex.ru> writes:

>> Thanks. When I ask "Is this ready", I am asking for opinion(s) from
>> third-party, not self nomination ;-)
>
> Ah, ok, sorry. :)
> I just haven't seen any related comments to any of your previous "What's cooking" emails,
> so thought I should send a keepalive email just in case.
>
>> Let's merge it down to 'next' and to 'master' anyway.
> Thank you!  That'll be great!

Thank *you* (and also Luke) for keeping "git p4" alive ;)
