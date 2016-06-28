Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385D02018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbcF1SDt (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:03:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752060AbcF1SDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:03:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D70225E48;
	Tue, 28 Jun 2016 14:03:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CycXsdZJx9m1sMuffpnw3+N0W/E=; b=tIufKi
	Z0i6YPyjfpE5O798OF246OFZJfis4F5e8D+5CIbTEwQq8q9Kh7ZbAh9NEiD8TztP
	Rp54q0MzYs8nW0fDOiHagG5rlhDBLhfJprebcsGsV8gk8yKSxxydzllR0rFPGGHU
	k+k6rjjebHSlB9zok4Lu5jnxh1RLR3/4qwIRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k8/yilc5c6e9fHElWFB4nmKofV4fHtlI
	r9Z2y3hL+ACc/1vo+NQQ+XFYMwur3vHLMeuyhLMkj9LiXhD+kWJXGHRNDFYQ3T0J
	ME5XDGFlqNwUN9Y56Y5LfGPNIWUeaZcmbXbN3Oo0/QtM4cBLyMpWXI0uM3uMnlkY
	jD0DPamyFo0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65BA425E47;
	Tue, 28 Jun 2016 14:03:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E36A625E44;
	Tue, 28 Jun 2016 14:03:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:	Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Andrea Stacchiotti <andreastacchiotti@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: git-htmldocs.googlecode.com is no more
References: <146652690896.29270.13813898006180324611.reportbug@duelitri>
	<20160622024151.GA20206@google.com>
	<20160622190018.GA786@dcvr.yhbt.net>
	<CAPc5daUiUv-EEv7ouQ=K+Q8S64QVV5wn4H6+TuF0wLeo123K5Q@mail.gmail.com>
	<vpq8txwtmg8.fsf@anie.imag.fr>
Date:	Tue, 28 Jun 2016 11:03:44 -0700
In-Reply-To: <vpq8txwtmg8.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	23 Jun 2016 09:04:55 +0200")
Message-ID: <xmqqpor18a2n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8C87B0C-3D5A-11E6-8CAE-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> On Wed, Jun 22, 2016 at 12:00 PM, Eric Wong <e@80x24.org> wrote:
>>>
>>> Just wondering, who updates
>>> https://kernel.org/pub/software/scm/git/docs/
>>> and why hasn't it been updated in a while?
>>> (currently it says Last updated 2015-06-06 at the bottom)
>>
>> Nobody. It is too cumbersome to use their upload tool to update many
>> files (it is geared towards updating a handful of tarballs at a time).
>
> Then, I guess it would make sense to remove it to avoid pointing users
> to outdated docs?

Actually, it turns out that k.org folks have an auto-builder that
updates the documentation set for each release.  It hasn't been run
since v2.5 days, though, until very recently.

I was told that the above URL currently should be showing v2.9.0
docs.

The rule for https://kernel.org/pub/software/scm/git/docs/ currently
is that it shows documentation set for a released, but this is
likely to change in the future (s/a released/the latest release/ at
the minimum, with some definition of "the latest").

Also https://kernel.org/pub/software/scm/git/docs/v2.4.0/git.html
would give you the documentation set for that version.
