Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66DE71F855
	for <e@80x24.org>; Mon,  1 Aug 2016 22:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbcHAWfI (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 18:35:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752594AbcHAWfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 18:35:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8418832277;
	Mon,  1 Aug 2016 18:31:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yXmwK0u/6xWHKHv/+XyKPoUyasE=; b=Tt3zc+
	wbmhHeC536K6BYxEMZUM0waj3exYrYxbL9vVZZ6BK80Hz9q+Qp45f/h1ByuIh5/u
	kTp1tcSExyEicxiJfRmct19mYdhHrzHVWZaBsfJJaEaToyuk6Ozj8xm7R72DQUNn
	f1mhF3OTl+8LTO8K2ese3SpO5klFm5ESVZHwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qC+CnqZxm8QKsmQEQ+jwz2JEeVyJAjJS
	rHHVjkwpS7WurEuzMQ78+QwVSXN837QRJ4vbhfi4dEwGZTp12PT+z8Q+/fPlG73l
	qBkYikNzv3tzMVrEFArLDXd506JEwV3wcgoq07rm1dht8lojSan1v31k4v6yJLJJ
	xWtRsljOBZQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BF7932276;
	Mon,  1 Aug 2016 18:31:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B54C32275;
	Mon,  1 Aug 2016 18:31:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
References: <579CEF77.9070202@web.de>
	<20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
	<xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com>
	<20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net>
Date:	Mon, 01 Aug 2016 15:31:45 -0700
In-Reply-To: <20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 1 Aug 2016 17:11:31 -0400")
Message-ID: <xmqq60rkglym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBEB49C4-5837-11E6-A524-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> *1* I have a slight suspicion that this is cultural, i.e. how
>> arithmetic is taught in grade schools.  When an apple costs 30 yen
>> and I have 5 of them, I was taught to multiply 30x5 to arrive at
>> 150, not 5x30=150, and I am guessing that is because the former
>> matches the natural order of these two numbers (cost, quantity) in
>> the language I was taught.
>
> You might be right. I was trying to figure out what is "natural" for me
> in these cases, but after thinking about it for 2 minutes, I'm pretty
> sure anything resembling "natural" is lost as I try to out-think myself. :)

Do native English speakers (or more in general Europeans) think of
the apple example more like "5 apples, 30 cents each", and do 5x30?
