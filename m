Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4993C2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 20:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbcGAUHo (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 16:07:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932107AbcGAUHl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 16:07:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA84727BBD;
	Fri,  1 Jul 2016 16:07:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oJqIW3Yl/BmdRUa1aV0iGMzMo1s=; b=aDsh+G
	niQEAggxBeheOQE6QgVhhru8lZBVSjvnJ7fTA2SbP/AkSGC++KMUAylV1ZFb0Cu5
	o2q7ym5kTz0BFOAICwi9ZETUpCaK95DfFazhcbW+V7cyAY3fIK8HW3Y196tE167Q
	4fP+/oO6YgKBhROUJVYIho0uBvq+31HQF8048=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AC5p+x+ZPblT/Z/KiOoOe4EJZCKYXBBa
	qYHk1d+jWrCoJTDjANC9LQXo0/IotX6eqHBQKJVFoxPJNS1/WiwQ9x25jOi0bL0o
	sCOIRO6tJQw9+eZtYieSf009o8WTSJqWYbpoiU5jxyvT5A1YECOnuQ+B5KHsLRZd
	ts7ChHFrf64=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B385F27BBB;
	Fri,  1 Jul 2016 16:07:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32D7127BB7;
	Fri,  1 Jul 2016 16:07:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] nd/icase updates
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160625052238.13615-1-pclouds@gmail.com>
	<xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
	<xmqqvb0pxjfi.fsf@gitster.mtv.corp.google.com>
	<xmqqk2h5xi3q.fsf@gitster.mtv.corp.google.com>
	<xmqqbn2hxgve.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 01 Jul 2016 13:07:38 -0700
In-Reply-To: <xmqqbn2hxgve.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Jul 2016 13:06:45 -0700")
Message-ID: <xmqq7fd5xgtx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76995E52-3FC7-11E6-8EBC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Ok, there was a miniscule conflicts but otherwise the squashed
>> material was all coming from a single step in the original, so
>> I did so myself.  Let's start merging the result to 'next' ;-)
>>
>> Thanks.
>
> IOW, this on top of the fixup we discussed.
>
>  sideband.c | 9 +++------

NO, sorry, a wrong thread.
