Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7277A20193
	for <e@80x24.org>; Thu, 11 Aug 2016 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbcHKVBX (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 17:01:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752040AbcHKVBW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 17:01:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFB8A3246D;
	Thu, 11 Aug 2016 17:01:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wBgU40LszXo0OUFuYPd5gHbuZ7I=; b=cWTrMt
	VXoEUKmMF5uudG59a9B+I9Zze0ViMmE8bXe8lYfxubYfrjXSycxv38THEVaIp5WS
	laajl3G6LKyPvpkdp1axFe3TJH+EIV67jSt03tRqe6X1r4dYDRLneAEV5A8lhb35
	JjlsMFMUUOVYbZzQDYQXrNXmqANbB8ImTtjt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sPf8CW60hV5u3CAOlJxB62//NlCxApNx
	KGwUbWHVkJEmuWkBTWLzTr231FgKAkZyU0ah1MioQz7Dw5PlhmIGu41mhbdaYdLf
	6eqQFdYIxDdHLwPnoYijCs8lgbMlaYDJJHks2X92uETBFOAUU/QfM4PE3KS8/EMg
	RDEYNq4VoV8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C73B73246C;
	Thu, 11 Aug 2016 17:01:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B9B33246B;
	Thu, 11 Aug 2016 17:01:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 0/9] status: V2 porcelain status
References: <1470948697-63787-1-git-send-email-git@jeffhostetler.com>
Date:	Thu, 11 Aug 2016 14:01:18 -0700
In-Reply-To: <1470948697-63787-1-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Thu, 11 Aug 2016 16:51:28 -0400")
Message-ID: <xmqqeg5vyq8x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C16C34F4-6006-11E6-B6C6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
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
>
> The new output is accessed via:
>     git status --porcelain=v2 [--branch]
>
> This v7 patch series address the most recent feedback
> on the unit tests.
>
> This series has been rebased onto a more current master
> branch (to get the EMPTY_BLOB changes in the test suite).

Thanks for a note.  I've been queuing the series on top of f8f7adc,
so I am assuming I won't see any changes in 1-8.

Unfortunately I cannot be taking new rerolls or new topics for the
rest of the day as I need to start today's integration cycle and
I'll have to delay taking a look at this round, but from a quick
glance you still seem to have a lot of dirt in the new test and I
cannot quite tell if they are intended.

Thanks.
