Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3EE2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 19:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbcGATkY (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 15:40:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752296AbcGATkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 15:40:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15DD427792;
	Fri,  1 Jul 2016 15:40:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y7/5TnrFd83GhJ5lQmfD1nIgiU0=; b=QT6Zr8
	vpqdik/pHJIjtSrSwf/6bIUn/7/qUYUEmdH6LoGc/e/0otKhbnjrRObGFYsldJ80
	42rmFyn9ZFc8ggZtsHSsDA+992KvkU4E1BLOb9HTX/d29L+N3jNKkG1nfLm7yf5M
	J01YTWXzbJ8FMbsvBM6Uk0wQ3SG3aL0LY6bw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n3bEsCDUPkp2cupgQzdSWaniImSR1hXd
	Sl/YmsaIpolocw+aTI8g+rXzP7B0zYOyl2hJBGOEJPEH7gjUAVPzGcR4RvP1LZJC
	5eT1Q0eybg5SXWvBOHsA6cBGkyanUYDJ6tJwWp2xNHBUT98CPGziRHPLwJIFvN58
	thTA/eK9jWA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EEBC27791;
	Fri,  1 Jul 2016 15:40:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D53A27790;
	Fri,  1 Jul 2016 15:40:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] nd/icase updates
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160625052238.13615-1-pclouds@gmail.com>
	<xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
	<xmqqvb0pxjfi.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 01 Jul 2016 12:40:09 -0700
In-Reply-To: <xmqqvb0pxjfi.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Jul 2016 12:11:29 -0700")
Message-ID: <xmqqk2h5xi3q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FF078CA-3FC3-11E6-BC6C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> The rest looks good (after your comment fixup). I see you already have
>> all the changes in your SQUASH??? commit. Do you want me to resend or
>> you will just squash this in locally?
>
> Squashing in would need to redo this into a few relevant commits,
> so it won't be "just squash this in locally" I am afraid, but let me
> try.

Ok, there was a miniscule conflicts but otherwise the squashed
material was all coming from a single step in the original, so
I did so myself.  Let's start merging the result to 'next' ;-)

Thanks.
