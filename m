Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A126A2018E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbcGLPlr (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:41:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753256AbcGLPlq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:41:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52F55280AC;
	Tue, 12 Jul 2016 11:41:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+7y0zjvAL1dUIZ3x2+xScjgRD7w=; b=j47NtA
	Z8ja8L2fABq+0/QahwoPTJnKrT0/kEFbz2X94RmJoyvnUatXsn4tCfCtVJmpwDAA
	XpyRUknoN8ALvYO27rauUf4/ZO2+EMrBmCaKYhIyP5HN0q0BrJpMsbGn43/uq47d
	iYInYusZtm25LQYuht/1UU8iD4BHuBxduCnEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VjqaDOfNnomhjxzjBBZ0SNJaWfCne8Gz
	DSwcZYS86CLvbJ9S5P91tt8YAVEO42FVM7iJzp7rU22Ma6aPTdKS8y2rqLvn6mSV
	xytP8fRlimmcQmD7xyfdOt9yM64RbhxupGI5do76pdEs1GwAHp2t8Sol8r0CfSm8
	c4mcjGIdO7g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 494DE280AB;
	Tue, 12 Jul 2016 11:41:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF88D280AA;
	Tue, 12 Jul 2016 11:41:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607120927410.6426@virtualbox>
	<xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
	<20160712151630.GE613@sigill.intra.peff.net>
	<CAPc5daWcb5bfgsxMP0vCrQ7gBdeYBgefzPNHztaaCKzqbCv2aQ@mail.gmail.com>
	<20160712153520.GG613@sigill.intra.peff.net>
Date:	Tue, 12 Jul 2016 08:41:42 -0700
In-Reply-To: <20160712153520.GG613@sigill.intra.peff.net> (Jeff King's message
	of "Tue, 12 Jul 2016 11:35:20 -0400")
Message-ID: <xmqqlh167tjd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22F8A356-4847-11E6-B333-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I am not certain that there is a modern system with 32-bit time_t. We
> know there are systems with 32-bit unsigned long, and I think that is
> what produced the results people saw. I'd expect even 32-bit systems to
> use "int64_t" or similar for their time_t these days.

OK.
