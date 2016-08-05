Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770B22018E
	for <e@80x24.org>; Fri,  5 Aug 2016 16:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760047AbcHEQOB (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 12:14:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753812AbcHEQOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 12:14:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB3BC2F053;
	Fri,  5 Aug 2016 12:13:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uwyjX933w+x0GMl+CQp5x3j5piI=; b=bYuMuj
	jZGSUbaakb8yNPx8dDU0Pu784RESz9wSP001DjfAXX0gXs4mwD5+5XVt1ZzurTDb
	CD28cXjRbv5+b7Er4IDaMz0S3QlYk2Q5d3YMJlahwPemleta+womVnhBTEWwgn92
	Q/KnJS01nTDH8zFoMCsBcDMdlQ5qbOIg4jwuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=shzBu54n11ibXrP8mgdGcpjXoyjwrwy6
	M3cKf4MFmf/34PL494vVRWY/bsRGhtfLgooPHLrPajsCd5sKY5QMvid5zAn6SI1G
	GDUq//Sa8RwFReea1uAdbI/7ehNYtYkvFN6YGOqSCXfMN7Fx8VLX+49vmokQIu8L
	4RwqaSYuqgI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D215A2F052;
	Fri,  5 Aug 2016 12:13:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 526602F050;
	Fri,  5 Aug 2016 12:13:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
	<57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
	<57A3BA26.5080601@web.de>
	<xmqqk2fwyx8h.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608051728380.5786@virtualbox>
Date:	Fri, 05 Aug 2016 09:13:56 -0700
In-Reply-To: <alpine.DEB.2.20.1608051728380.5786@virtualbox> (Johannes
	Schindelin's message of "Fri, 5 Aug 2016 17:34:49 +0200 (CEST)")
Message-ID: <xmqqpopnxkfv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D62C840-5B27-11E6-A95A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This setup will from now on test next & pu in the Git for Windows SDK, and
> rebase Git for Windows' current master to git.git's maint, master, next &
> pu, every morning after a weekday (unless I forget to turn on my laptop,
> that is).

Sounds really good.  Thanks.

