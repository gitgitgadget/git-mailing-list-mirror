Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166051FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 18:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbcFWSg2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 14:36:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751564AbcFWSg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 14:36:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C09B925482;
	Thu, 23 Jun 2016 14:36:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KB33a083pmKhE3xMVHSHDRnjY6M=; b=QO/pig
	1VLDAE0LdAlS9LeFJg4vQmXg7uUNherNrVaqRe7xeJZPO4d2evVzhqHMhgEyLuNv
	ufPyv9JkATssmcn/7bdC3sW6CzkhFbYex9Xw6kv9EjjnJxQp4gDyvJBiFb7EoN3M
	WZvCvLLEO2oA/M3AAzriMmT0ok9qaUZqf8CuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aT2zzf8q9gXAju9D/MgAcDh5MPZY6Dc7
	N5XZu0HyZG9pYatQorS90cRurligyVo9F2GZfQGIX2MsuVCjOpCfwbgpnh/lHFUC
	Rd25nBWSHRCkfLIiFsY1bdIiuxq02un9cSftcOn+NE9hPEubRICLwaZVboQQ3a3c
	+2kYXV4IqN0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B817825481;
	Thu, 23 Jun 2016 14:36:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3981425480;
	Thu, 23 Jun 2016 14:36:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Simon Courtois <scourtois@cubyx.fr>
Subject: Re: [PATCH v2 7/7] color: support strike-through attribute
References: <20160623173048.GA19923@sigill.intra.peff.net>
	<20160623174015.GG15774@sigill.intra.peff.net>
Date:	Thu, 23 Jun 2016 11:36:23 -0700
In-Reply-To: <20160623174015.GG15774@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jun 2016 13:40:16 -0400")
Message-ID: <xmqqpor7iwgo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63F51400-3971-11E6-8A28-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is the only remaining attribute that is commonly
> supported (at least by xterm) that we don't support. Let's
> add it for completeness.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was mostly for fun.  I can't think of a way in which it would be
> useful, and I'm not sure how compelling completionism is as an argument
> for inclusion. I'm OK if we drop this one.

It indeed is fun and it even makes sense in this context:

    $ ./git -c diff.color.old='red strike' show

