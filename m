Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823C5C2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424D120740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UjtQs9H1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfL0W3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:29:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54359 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0W3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 17:29:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2ECFB0BD4;
        Fri, 27 Dec 2019 17:29:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RXG2RZt4u4rQU2Dm+reYiR3ejuM=; b=UjtQs9
        H1g1UpXdARSD/J4PTXTt4TK1XilJYKkIPH1ZKFREW5F9llBhS6wR7tBgTAK6a/rU
        qwCFZiuswZ0nn8kNMFQrEKafXIrKeGEyED+kaFxxnxVlqBlZIlj2DIF0k3cx2dwX
        zFdqruIWpjBDAuFipaTYyQlCfk+3yBTrdVf6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D2jUYjDSp6dtc8+ThnS4Z5eAvK9lgKOq
        uaq2wXLLWfgAMoIjjJ+TbCU6A/QqCv/JpFgMB3APtjdsWDrdvij0rWyBep0dhXRd
        GAXetl7nc+MY2f8odF72O1D9MYCEqTPTdHW6h7ko3X/7ELzziiDs6kvUw1+rU53a
        WweKRrHDHDE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA8E0B0BD3;
        Fri, 27 Dec 2019 17:29:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA0A0B0BD0;
        Fri, 27 Dec 2019 17:29:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0-rc0
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
        <20191226143527.GA24268@danh.dev>
        <xmqq4kxnm0w6.fsf@gitster-ct.c.googlers.com>
        <20191227113858.GB24268@danh.dev>
Date:   Fri, 27 Dec 2019 14:28:59 -0800
In-Reply-To: <20191227113858.GB24268@danh.dev> (Danh Doan's message of "Fri,
        27 Dec 2019 18:38:58 +0700")
Message-ID: <xmqq36d5jtck.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48502A08-28F8-11EA-8284-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2019-12-26 09:50:49-0800, Junio C Hamano <gitster@pobox.com> wrote:
>> Danh Doan <congdanhqx@gmail.com> writes:
>> 
>> > My name should be moved down to next paragraph,
>> > since I was lazy to type my name with all accents.
>> 
>> Your first contribution was back in v2.20 days, and then the recent
>> ones are all within this cycle for v2.25.
>> 
>> I am a bit curious why you need to avoid being lazy just to give the
>> correct name to your commits, though.  Isn't 
>
> Some of my projects requires ASCII-only user.name,
> instead of doing the right thing
>
> 	git config user.name <simplified-name>
>
> I decided to set it globally instead.
> I rarely need to type in my native language,
> hence I don't have the IME software start with Xorg.

Hmph, but back in v2.20 days, you did have IME?

In any case, if I were in such a situation to need my name spelled
differently depending on the project I work on, I would probably use

	$ git config --global user.name <simplified-name>
	$ cd <repository of git>
	$ git config user.name <name-with-accents>

or the other way around (depends on which projects your focus is on).

But perhaps that is not so useful to your situation?
