Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5CA2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 15:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbcF0PI0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 11:08:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751850AbcF0PIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 11:08:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D139272BA;
	Mon, 27 Jun 2016 11:08:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=42lWZogrfgFI1QXy8/qIRz8xnGA=; b=dZZc54
	XnUyS2h/cbZ1DXTtEK0wrMgTWodk8R9Ur4p93ghnb3X2rdeh+nf/POtDaU7yKuXh
	TtzZAJoH14vbsW2Y1zYhC0+SaRrPL/n62dCQpD9Fdiaa0Jj2r9h/9eG3SiEg/U5a
	Ea17pPX12FKXjSmn6OmagYDBpEjz9ySeeL8Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s1TzumuE9sodu8fW/Nu8ZQXtfGDM4h2m
	B8kSljR4551HDGLGlYyKo0xLDT/jbyXy495aFgQDUNlILTDPTa0HSBE85+lvVfIS
	+Wb1KI7COcftgAXDs/n1fwOAyQE/4MFWhpQzxpdnD8nA8Q/4WXoIhfQNC9Xm2mdd
	XeV6Zb/Bi1E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 65C1A272B8;
	Mon, 27 Jun 2016 11:08:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6973272B5;
	Mon, 27 Jun 2016 11:08:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	"Jeff King" <peff@peff.net>, "Git List" <git@vger.kernel.org>
Subject: Re: name for A..B ranges?
In-Reply-To: <8001594309A04A42859024BAEB8FF188@PhilipOakley> (Philip Oakley's
	message of "Mon, 27 Jun 2016 14:37:35 +0100")
References: <0648000B273C412AB7140AE959EBC99A@PhilipOakley>
	<20160624160943.GA3170@sigill.intra.peff.net>
	<xmqqh9cih6ym.fsf@gitster.mtv.corp.google.com>
	<E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley>
	<xmqqwpldcamb.fsf@gitster.mtv.corp.google.com>
	<8001594309A04A42859024BAEB8FF188@PhilipOakley>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Date:	Mon, 27 Jun 2016 08:08:21 -0700
Message-ID: <xmqq4m8ed5zu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE2DF94C-3C78-11E6-B4A6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> ..., I was wondering
> if an alternative would be to refer to it via [use the headings of]
> it's notation, i.e. "the 'two-dot' range notation" (or 'syntax' is
> that is preferred), and the "three-dot symmetric difference notation".

That's a lot more sensible pair of headings, I would think.

> The existing explanatory text can stand as is, but they would now have
> a section for readers to find.
>
> Or should I just drop this?

I like the approach to separate them into clearly marked sections.
I primarily was reacting to the "single-sided" which nobody would
understand.
