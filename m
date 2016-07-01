Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EB912018A
	for <e@80x24.org>; Fri,  1 Jul 2016 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcGATOv (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 15:14:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751964AbcGATOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 15:14:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 324DB273F2;
	Fri,  1 Jul 2016 15:11:32 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b6cxJ4i2AKgKQK7XE9Bf5rBg0Ss=; b=pDvBu/
	bjRnz3S77Me67j4jBp/WToBNW7Tz5Rsa9pQ9J3qGOIxCfaxoPnHA10lDblLNOBfk
	I+ajp+gceJUUptEqRUzUlRgwAKigEUIYJ5t6pL+9Cpat9cuqYF9EU46qqDl0xlnX
	lwgNSV4VF0xoZjLmJusMswSuwtRH4mkQy9CU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ne4QBhilP3LxLdHOvlAdX29ygD0NCnbt
	YIHpc2XLf3lcvdXV4PzIC3LueQYz/T+EEvxcYc/phGy5b3ujJsigon36fmHqLjUu
	KvCeARCjtZkj3K6NhbHBkBm2LwyX9lhfIPUGHbmNwskMDf0f4H1APilGB0kUiiv5
	rE8NN1Woe5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22645273F1;
	Fri,  1 Jul 2016 15:11:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CD0C273F0;
	Fri,  1 Jul 2016 15:11:31 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] nd/icase updates
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160625052238.13615-1-pclouds@gmail.com>
	<xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
Date:	Fri, 01 Jul 2016 12:11:29 -0700
In-Reply-To: <CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 30 Jun 2016 17:45:52 +0200")
Message-ID: <xmqqvb0pxjfi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E9EE6EA-3FBF-11E6-9F32-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The rest looks good (after your comment fixup). I see you already have
> all the changes in your SQUASH??? commit. Do you want me to resend or
> you will just squash this in locally?

Squashing in would need to redo this into a few relevant commits,
so it won't be "just squash this in locally" I am afraid, but let me
try.

