Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CB4A20193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934014AbcHDSYI (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:24:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933852AbcHDSYG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:24:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DA4C32579;
	Thu,  4 Aug 2016 14:24:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gRaQhy40TMNReicY9rHqVxuX/OA=; b=eLqykQ
	b+3blgTW4kK5xvaL8YkMMIDNJCBQnlGR++hBeFLPuEQdI2IMsyJM11SA+NVv2WjI
	F53eJcBb3uU4AXC5sknBAtZFTEJKT4SaHCiMAxJZAeb2P6Pkl1SwHnxZFZhELlk5
	R9JCRxYCfhZFCiI7hhX95P9KZAD85tCxMecCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ehr3vAfZIuFMBb++8ptM4VTqYAbRE24A
	Xrr0ygirOgeSt8TkHtJVx97zCO/u9otn28dLW1ABAVKGA0QxDyV3yMbuX1Sq1fQm
	J9j3bCpvPg41ea3epNJa9TMyjcPLrGqIde3gwGvfvr6T/uC8OxYRLyIF2C9u8HY+
	S3UdvRsIli4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95C0D32577;
	Thu,  4 Aug 2016 14:24:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B7FF32576;
	Thu,  4 Aug 2016 14:24:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/8] xdl_change_compact(): rename some local variables for clarity
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<ea7d76b1a97f3ab8d83ed8ba7570c2bec1195501.1470259583.git.mhagger@alum.mit.edu>
	<20160804070604.ggxjqibryqtrwntn@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 11:24:02 -0700
In-Reply-To: <20160804070604.ggxjqibryqtrwntn@sigill.intra.peff.net> (Jeff
	King's message of "Thu, 4 Aug 2016 03:06:04 -0400")
Message-ID: <xmqq37mk4cl9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F8FBDF6-5A70-11E6-8083-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 04, 2016 at 12:00:29AM +0200, Michael Haggerty wrote:
>
>> * ix -> i
>> * ixo -> io
>> * ixs -> start
>> * grpsiz -> groupsize
>
> After your change, I immediately understand three of them. But what is
> "io"?

I had the same reaction.

