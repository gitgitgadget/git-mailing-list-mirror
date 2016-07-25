Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D966203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 17:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbcGYRLY (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 13:11:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752143AbcGYRLX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 13:11:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5C7E30B1C;
	Mon, 25 Jul 2016 13:11:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pHdxJbu9bTC17JLh7vsRqpAhN8E=; b=VmeR3s
	NJwBYZIAcR8mrgPtN9mwZm3uef3JTUsScUZObPwR+/8pwQXyAMDIL6tRuNwv5BK/
	nq6ibdHCfHcDgf1M5hP4P5boUQ1DKfBb0x1BV4o4V619ZZhKD3nnekfqoTq6S+vA
	9Cky3L9Es2I5gnfg7QjSTilIcz65rKrK0Aslw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKWflgXVkyRZe7POXkvneGKDb0NEQDUS
	fuadWtlzZZMvV2Ni5D5AYfVL018fiGgDU0LE5Db+3CbqtDlQAKEErAavg8+F+5i2
	ZM9mqWRuk7s9+kCmrnQrnbHFhOHmh7VNnJJfmocJOEZkGkfTRFarl3RrlT4J+gV9
	FIrDI/cM/PM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ED8B30B1B;
	Mon, 25 Jul 2016 13:11:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36F5B30B1A;
	Mon, 25 Jul 2016 13:11:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jon Forrest <nobozo@gmail.com>
Cc:	Rodrigo Campos <rodrigo@sdfg.com.ar>, git@vger.kernel.org
Subject: Re: [RFC] A Change to Commit IDs Too Ridiculous to Consider?
References: <nn30dv$5sn$1@ger.gmane.org> <20160724185132.GN25141@sdfg.com.ar>
	<c0af7511-a5d5-29bb-d279-66b6c3e0519c@gmail.com>
	<xmqq1t2h92ul.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 25 Jul 2016 10:11:19 -0700
In-Reply-To: <xmqq1t2h92ul.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 Jul 2016 08:03:46 -0700")
Message-ID: <xmqq8twp7idk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF8B0044-528A-11E6-B6C4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jon Forrest <nobozo@gmail.com> writes:
>
>> Sure. Take a look at the 2nd or 3rd chapter of Pro Git Reedited, 2nd
>> Edition (or just Pro Git 2nd Edition - it doesn't matter). You see
>> lots of output showing 'git commit' commands and the commit IDs that
>> result. I suspect you'd see the same in almost any book about Git.
>
> I would think that the early-stage learners are better served that
> it is the norm, not anything strange, that the commit object name
> would be different when you do two identical sequence from scratch.

Ehh, sent without proofreading.  The above should say "... are
better served if the book taught that it is the norm, ...".

> Forcing them to know GIT_*_DATE variables, just to give them an
> impression as if setting of them is part of any normal workflow (or
> more importantly, stable commit IDs made by different people at
> different times is something expected), is doing them double
> disservice, IMHO.
