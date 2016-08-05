Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336031F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbcHFUKR (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:10:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750934AbcHFUKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:10:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3C3A3298C;
	Fri,  5 Aug 2016 18:51:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=91UToeDrGhTO18JqQVXPmRkx7UQ=; b=vPWrot
	zRSK+WGzhfiDw6uNjHLHrb/ufoL0phE2hDUb6KFKb01Ht7n4GsTk2nYH5TO00rtD
	6XfjLZlApNyDpKDTSCV4B0mV87eLxGn9J/6HFhrDvgu1X+/pllbjXTReUDVEA/1L
	KUOEfIk94/u4t7E2FZJ0TZcpIZYFfiRi5GfPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UTRblj/dCKQosVSOvHK3q8dNezH0DSVU
	ltpHyJEUrQbCLSFWNG7sxNEW5TMglOg459xmPm6CGVPC6CNifXCno5bUyrfyVp5R
	PEAo2W3omuMgJ2Lta1p1lroKm/F4k9JjDyPr1MsjW+V7Ez67PCnLkkpqU6NeE0zH
	A0X9SEoHd4I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CC6E43298B;
	Fri,  5 Aug 2016 18:51:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57A7A3298A;
	Fri,  5 Aug 2016 18:51:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 5/9] status: print per-file porcelain v2 status data
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
	<1470434434-64283-6-git-send-email-git@jeffhostetler.com>
Date:	Fri, 05 Aug 2016 15:51:52 -0700
In-Reply-To: <1470434434-64283-6-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Fri, 5 Aug 2016 18:00:30 -0400")
Message-ID: <xmqq7fbuvng7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3496F95C-5B5F-11E6-A374-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Print per-file information in porcelain v2 format.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---

Relative to the previous version, the renaming of variables
(current, src)->(index, head) made it much easier to understand, at
least to me.  All other changes look sensible.

Thanks.
