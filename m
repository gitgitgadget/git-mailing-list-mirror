Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01F21F859
	for <e@80x24.org>; Tue,  9 Aug 2016 19:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbcHITEB (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 15:04:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932453AbcHITEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 15:04:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5DEC34104;
	Tue,  9 Aug 2016 15:03:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NxcyLtK7oabeWzrIfoBqhSBM9Rw=; b=X8KCWe
	dVVqDhuipEUsLDBHLdAOA6vzP82PRNIi1h7dt6lbjSCuzAC3SqRfA7qf1bbQJFBl
	BQLtLmhSq/WaqcsTCu/2m/Cp30ny7z+beK0zXWN0r7Kqw2AoqHjmB+zO6VLeDsM/
	z9UmIuHrXJqMcjSnBvVHEKX6gqEbFHD8SUqZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=scpzLW306QCXhEVq1lVWRgBxmsY1IGtz
	JYO8tVT582aP1zZV2y3Ga6PtxowJuc7LBwnVbRWlNgk4/qJo36qDgbchTUUCVsTG
	BmBdwzu8ZVV6cHb9H/dsWmVhwSQzYCDMxmkdzAHGk0n6W9hbmaajI0mrkGs1WcZo
	+8fQ3eoG9Cs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F54F34103;
	Tue,  9 Aug 2016 15:03:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2834E34102;
	Tue,  9 Aug 2016 15:03:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Elijah Newren <newren@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2016, #03; Mon, 8)
References: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
	<CABPp-BEqRFid1_2_B+Q_FyVN3KeApV3pknG7FrfaMUoyY6WJGg@mail.gmail.com>
Date:	Tue, 09 Aug 2016 12:03:57 -0700
In-Reply-To: <CABPp-BEqRFid1_2_B+Q_FyVN3KeApV3pknG7FrfaMUoyY6WJGg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 9 Aug 2016 11:52:05 -0700")
Message-ID: <xmqq4m6tahnm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0730FA0A-5E64-11E6-94CA-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> So, I think the series looks good.  Sorry that I didn't spot any errors.

That's nothing to be sorry about--it is an excellent news.

Thanks for helping.
