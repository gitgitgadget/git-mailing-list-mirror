Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9552018A
	for <e@80x24.org>; Fri,  1 Jul 2016 21:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbcGAV1i (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 17:27:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932086AbcGAV1g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 17:27:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EA03296D4;
	Fri,  1 Jul 2016 17:27:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6OevHlz6sTZxI9oNHC8rRCVvYc0=; b=GhZIB0
	anTtwlVKwXkIjmuodiXfuMdAROPsGSyCmCGDM9XhOcPLLB0kzbmq6EOgeCHz6Maq
	vfU4jlno0nN71a1WSXOuB8HU8wCn8/wZhTlrZ8wiW+ArPn9wahUbUjsqt9aAsFVJ
	I9ck2ZLFyDsYBREwYnRnAeJ26XAibf1IA0EoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UPHzM2W2Xhlo0lkH0eEch/IujeLWwD0b
	uCRcLVA6tSqNc723hGGeW7nbzCMbkq1pqBtuqZjXOUVd/IiVBWMSghKZL+Y6hr+1
	ES5ILsaBTxUwV6r6Rn147J+7ZyQ/H3EdbBWJ7k+xMlpL/bBqF3YnUuk2QBeTc45O
	CfNBvSY0Alw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 877B4296D3;
	Fri,  1 Jul 2016 17:27:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 153A5296D2;
	Fri,  1 Jul 2016 17:27:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] Name for A..B ranges?
References: <20160625164654.5192-1-philipoakley@iee.org>
	<20160630202509.4472-1-philipoakley@iee.org>
Date:	Fri, 01 Jul 2016 14:27:33 -0700
In-Reply-To: <20160630202509.4472-1-philipoakley@iee.org> (Philip Oakley's
	message of "Thu, 30 Jun 2016 21:25:05 +0100")
Message-ID: <xmqqd1mxvyka.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0919F7A-3FD2-11E6-81BC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> This is the re-roll of the po/range-doc (2016-06-27) 3 commits
>
> The order is slightly re-arranged, and an additional patch clarifying
> that ^r1 excludes r1 itself being added.
>
> The heading have been tweaked.

Thanks.

I think 1-3 are ready for 'next'.  4/4 may need a bit more
thinking.

