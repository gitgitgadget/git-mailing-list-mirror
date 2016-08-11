Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0EB20193
	for <e@80x24.org>; Thu, 11 Aug 2016 20:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbcHKUo7 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 16:44:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932129AbcHKUo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 16:44:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A201321C2;
	Thu, 11 Aug 2016 16:44:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gxu7OzQY2g1vCiQ2BQvQOD552Q8=; b=ICReBa
	evr+/8phROF2Od+q0THtHrNcXTOLAbRhpI2v7tTmECEshRtt8TNX0I1b3BCo164t
	NtSejoZdWDSDTjBYk9Q8mGhu21L8cxkOuDmoSWmMecT5jgfTWf23eseQLPV1mdHD
	vbaNAxn806T9+ZJTlGQO6YIyrN/UNXITbmDQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qNnmKuZXvIWW5iVwumH40E96l9v9YqEC
	eWMIaxkWecvbQqV/3bwmzyJBYLtRluXaBgvhOxaDbOKocpm1YMIXMCyfbzgd6SyU
	/RxVPrNZAK1vOnbOe2VDFzeH3CCTKTTSvj9BG2jYULsbuXV80B032CEtfuFlIlcY
	rRUGzT8uCfs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 620EF321C1;
	Thu, 11 Aug 2016 16:44:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6E2A321BE;
	Thu, 11 Aug 2016 16:44:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org
Subject: Re: public-inbox.org/git updates
References: <20160811194333.GA27387@starla>
Date:	Thu, 11 Aug 2016 13:44:55 -0700
In-Reply-To: <20160811194333.GA27387@starla> (Eric Wong's message of "Thu, 11
	Aug 2016 19:43:33 +0000")
Message-ID: <xmqqr39vyr08.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 774ADBCA-6004-11E6-975E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> There'll be over 5000K injected messages from 2006 I missed from
> the initial import :x
>
> I noticed this while adding gmane:NNNN mapping support to the
> search engine:
>   https://public-inbox.org/git/20160811002819.GA8311@starla/T/#u
>
> There will still be some missing messages because some are spam.
> news.gmane.org remains up if you want to check my work
> (please do, because I am careless)

Thanks for doing this.

I wanted to try out your NTTP service, but it took me a while to dig
in my inbox to find your announcement of news.public-inbox.org that
hosts inbox.comp.version-control.git "newsgroup".  Is it possible to
make this a bit more discoverable, or there is not enough NNTP
audience these days to warrant such an addition?  I first went to
http://public-inbox.org/git as I expected there may be some pointers
to other instances of the service, where you list the "git clone"
URL of the archive.

By the way, it felt quite strange to see messages from 8 years ago
mixed with more recent messages when I gold Gnus to fetch the most
recent 333 messages (and of course that fetches 333 messages with
largest message numbers, not sorted by "Date:").  I am assuming that
this is an artifact of "over 5k injected messages" bundle that was
added out of order.

