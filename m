Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F571FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbcGLPza (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:55:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816AbcGLPz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:55:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCE5C29800;
	Tue, 12 Jul 2016 11:55:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIkODs0RX9s/wN9fwxW9hHMCTWk=; b=YYOp8o
	roBZb0ceLcJDsk4UAuDryRZc4ocYbioNYID2nBB3aUNRTjqQ4eLHYC/j/G2KXw8h
	D700SsNM9SbQ/eR0/r587Terg135j7YcYoA7zOgD672pfOabE+aNHcFBq7i6snOA
	5esVMqUL/XCjuo89g4gUWmZHQIJIf6K3LRIPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o4mEE46NST01TwtXzSi+GI7UiCyabMbz
	cJ0hOz3jCDYVM3E0TlI69yrVa9RIOPr6TY09xyP3Vgh6ZREaL3PqmtR0H4OQCzVZ
	T9PjBvuWGxJ+sEnoIKX9pzX+C6Q1wzgT6j92k4FTXYKSmiAwXA9IjHEUZhjMK9lT
	xzd4S8ZpBd8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B47AA297FF;
	Tue, 12 Jul 2016 11:55:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4161E297F9;
	Tue, 12 Jul 2016 11:55:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<20160712035719.GA30281@sigill.intra.peff.net>
Date:	Tue, 12 Jul 2016 08:55:25 -0700
In-Reply-To: <20160712035719.GA30281@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 11 Jul 2016 23:57:19 -0400")
Message-ID: <xmqqa8hm7swi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DCDEAE8-4849-11E6-8B4E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> However, I was thinking that it might be handy to have this and some
> other information available for helping with debugging. E.g., that we
> could ask bug reporters for "git version --build-options" when we
> suspect something related to their config.

Sure.  I was wrong to phrase it as "I would have..."; either is fine
by me, and being able to ask "git version --build-options" is
probably a plus.
