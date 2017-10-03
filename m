Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2570120281
	for <e@80x24.org>; Tue,  3 Oct 2017 01:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbdJCBSh (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 21:18:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64023 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750869AbdJCBSg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 21:18:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2F2FA59C2;
        Mon,  2 Oct 2017 21:18:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m6gvtRsCkPla+4OGDOz2+IwZIcE=; b=rmS+8o
        dfloussUW9tfvO1NXTfhw3ZD13DwZ2cP+Z5M+EJhP8z9+ZJJXXVQE/E8kzQR8PNf
        mDEw6wPxzPoSOsJn2snfotLSHiVa80LwrOtZ9lzRBuOBBZ8/0dkQ4zMRqvRul8V+
        /huWIzuOWAC/dMsdoJmN6v2T1y7WLLw4a3QiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rUhPisQqQtj5GF84xHjek8tkgOkXV8qJ
        Udy/cOuEA0Ab1uL7WZUF2K4bUUwZRJ50Cd6Mqme7ydR8x4/C7oDwckAqbu9pnxL2
        5Fw1HoWDOeKzSVwZIWTOa/xbu9+56FJZXfvy7gyYR2s5Kdgt+FCQRv5GBr7verI6
        l2+snnTnJZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9E1CA59C1;
        Mon,  2 Oct 2017 21:18:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9C61A59C0;
        Mon,  2 Oct 2017 21:18:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
        <20171002230017.GT19555@aiede.mtv.corp.google.com>
Date:   Tue, 03 Oct 2017 10:18:27 +0900
In-Reply-To: <20171002230017.GT19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 2 Oct 2017 16:00:17 -0700")
Message-ID: <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6DA121A-A7D8-11E7-9BB6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Yet another alternative would be to treat color.ui=always as a
> deprecated synonym for color.ui=auto.  I think that's my preferred
> fix.

It is mine, too.  And I do not think color.ui=absolutely-always for
those who want to keep the current behaviour is unneeded.

