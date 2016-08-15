Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012011F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 16:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbcHOQZr (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 12:25:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752886AbcHOQZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 12:25:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C75234C04;
	Mon, 15 Aug 2016 12:25:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFTiHiAhDuW9mR3uu8b/cbJ6yrQ=; b=NEqRls
	1zUfWG3rYkZm/ANXCK0d70UfI5tJidhcly+E6KwVsse9QuhxlnOZTE7+8EL7mg6u
	soui3Cb/yDVIBScDmpLgTCJ7PzYTJm572iqNyEYgCwQs+cpipaOuU9d5H6Wi1EwB
	aj//xG18hXg4Zr+zXbAbeiuvrpKHDkXgex+Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u9CmH8KgO8L8OVQSUDNjbGH5UZH5H6We
	4ePeM522SqE4ig/PQMi28zYpGiQPwo15BdeOsuF/BYN7SU3zSo3JoW1C+dUHgYxV
	Sn6YSVpsLVP2P4kLFUfEUQBKlUAVihwMG1m95qkxR2xkWcrVa2HkPu9jrjfqy9Zt
	Tacq3qHqVQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 742A434C02;
	Mon, 15 Aug 2016 12:25:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F385A34BFF;
	Mon, 15 Aug 2016 12:25:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Brian Henderson <henderson.bj@gmail.com>
Cc:	Eric Wong <e@80x24.org>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/3] diff-highlight: add some tests.
References: <20160730151149.15980-1-henderson.bj@gmail.com>
	<20160730151149.15980-2-henderson.bj@gmail.com>
	<20160810085635.GA1672@starla>
	<20160815162016.GA20659@tci.corp.yp.com>
Date:	Mon, 15 Aug 2016 09:25:40 -0700
In-Reply-To: <20160815162016.GA20659@tci.corp.yp.com> (Brian Henderson's
	message of "Mon, 15 Aug 2016 09:20:16 -0700")
Message-ID: <xmqq8tvyhud7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E98335FE-6304-11E6-A632-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> writes:

> On Wed, Aug 10, 2016 at 08:56:35AM +0000, Eric Wong wrote:
>
> <snip>
>
>> Typically, we expect a reroll in a few days, and I guess there's
>> no rush (so you can squash your comment patch in addressing
>> Junio's concern into 3/3).
>> 
>> Thanks.
>
> thanks, (slowly) working on an update.

Thanks, both, for keeping the ball rolling ;-)

