Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99CE5203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 19:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbcHKTAJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 15:00:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750888AbcHKTAI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 15:00:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA24033BDE;
	Thu, 11 Aug 2016 15:00:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YJO7RzzNHM7fRM9e/CjF9//IHyk=; b=BzS3m+
	UXbpTPBX1lyBpMR+Zc4VVGfzgQwuYUfS1OAoTZ9jxHRvEWEhUB1pCkjjehVQ7fNO
	XE95qrj+5QIEXpd7UQ0+kzDOgh7tx4oYa0UHBqfuGmFOQxaRaJLGR2pvfEt389ux
	+XU4DtxGmRsAVptoBpezdlsNggJ9gQt1axfkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yVa2Mjc0XzAVOA3mHxHn1wXHwL11gKjg
	+xDRTck2h2LNtYQbeCfibayOKrO2/fayq4+HKPoLzkPLVzuejTdbl/H6GhqueNzz
	49WN7wevir6vdn4HKicSyCjZiU3rFtGRYvOrtCj8nFEoQw++f1OD3i3SvvCYJEvD
	VlzlDMiyb6c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAAF433BDD;
	Thu, 11 Aug 2016 15:00:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5188733BCF;
	Thu, 11 Aug 2016 15:00:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 0/9] status: V2 porcelain status
References: <1470926762-25394-1-git-send-email-git@jeffhostetler.com>
Date:	Thu, 11 Aug 2016 11:59:57 -0700
In-Reply-To: <1470926762-25394-1-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Thu, 11 Aug 2016 10:45:53 -0400")
Message-ID: <xmqqinv7168i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D00C9EC4-5FF5-11E6-BC1A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> This patch series adds porcelain V2 format to status.
> This provides detailed information about file changes
> and about the current branch.

Everything up to 8/9 I didn't have anything to comment on; I didn't
see anything that smelled fishy, or anything I'd want to improve.

I did have a few minor nits in 9/9, though.

Thanks.



