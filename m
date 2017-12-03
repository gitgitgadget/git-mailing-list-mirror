Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB83D20A40
	for <e@80x24.org>; Sun,  3 Dec 2017 00:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbdLCAsj (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 19:48:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57591 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751533AbdLCAsi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 19:48:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 289B9B8716;
        Sat,  2 Dec 2017 19:48:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pUc96LpBoO1D7eUjMY55XgWTiZI=; b=rF47lf
        tpTMkUm8Coj1g1jy6DMfx9gskVuxEx45xEu8P6K1CeOcyZmZswbzXZQpLcxbI6OC
        FouAF614cbdo5w3B9pzWNLZbJTg+jflvcN+49pOmBTUZ8rVUrhCSCIuNPtUfaAGd
        CBuKIeg6KCrTKgk+7sSNsE67W3LWpITlmBkSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xgF2dhBdftMrgaR8KdIJufj40vQsIT2j
        SpY9AdB92uUpFkQFyHeqxk7xyTlga9cCnDkSmlIlHmUaVVy0TpEiEl6A48qrfK4J
        h+q8GI1ukFYxqKu5sDNktwTf6gf8ZDeHWH/Wkz0LFW1PB1I9fK0xJXZ4ej6fpIMT
        oqzaL3pLK10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FE51B8715;
        Sat,  2 Dec 2017 19:48:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 797D1B8714;
        Sat,  2 Dec 2017 19:48:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20171126193813.12531-1-max@max630.net>
        <xmqqzi78e5dp.fsf@gitster.mtv.corp.google.com>
        <20171129050730.GG26158@jessie.local>
Date:   Sat, 02 Dec 2017 16:48:36 -0800
In-Reply-To: <20171129050730.GG26158@jessie.local> (Max Kirillov's message of
        "Wed, 29 Nov 2017 07:07:30 +0200")
Message-ID: <xmqqy3mkljq3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2C2B06E-D7C3-11E7-8E01-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> On Mon, Nov 27, 2017 at 01:02:10PM +0900, Junio C Hamano wrote:
>> To recap (other than the typofix in the proposed log message), here
>> is what I would have as SQUASH??? on top of (or interspersed with)
>> v6.
>
> Thank you. I'll update it a bit later. May/should I add
> "Signed-off-by:" from you?

As you'd be dropping the new helper, I think you will not use a
major part of that message.  But even if you would, a "Helped-by:"
before your sign-off should be enough for a small "help" like the
one in the message you are responding.

Thanks.
