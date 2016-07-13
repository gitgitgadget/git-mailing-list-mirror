Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DAFB2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 16:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbcGMQK6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 12:10:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751302AbcGMQKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 12:10:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D87992B7D9;
	Wed, 13 Jul 2016 12:10:32 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I64w97aCUR7p9Vl4RawP9xcZNcA=; b=gdMb6H
	850CIsUXqxuitnydx1a7KYuOY/HgiZuBf1W6jZB+4UglMiQVv765yT2DP4OWVJI9
	8lTIzpUFyhiiaUzjipFoRdAkbjfUomntFLjJGT8g0bicLF26S3rvI8kluQzNDFcV
	/OjkLAwl356vu0je7IXcY0/xvCC5QfplP9aMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kJ5wwa68Goxrrn4FU4eeK2ee9rSWmP0S
	qRhoJ84x7nh2gWC7YQjYFGsGWEcueDorsCebS/JHO0SPVpUqdLaU1Zd011Cqclkb
	l7GH4PNmXz68Ci/HxfvjXVkYosBxIA8eQAfu76l0zDiH4IEWQsqjJLhzez5wh+mp
	5Kizp13+0F0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D04972B7D8;
	Wed, 13 Jul 2016 12:10:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 593A22B7D6;
	Wed, 13 Jul 2016 12:10:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607120927410.6426@virtualbox>
	<xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
	<20160712151630.GE613@sigill.intra.peff.net>
	<CAPc5daWcb5bfgsxMP0vCrQ7gBdeYBgefzPNHztaaCKzqbCv2aQ@mail.gmail.com>
	<20160712153520.GG613@sigill.intra.peff.net>
	<xmqqlh167tjd.fsf@gitster.mtv.corp.google.com>
	<20160712160921.GA2965@sigill.intra.peff.net>
	<xmqq60sa7rj2.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607131600110.6426@virtualbox>
Date:	Wed, 13 Jul 2016 09:10:30 -0700
In-Reply-To: <alpine.DEB.2.20.1607131600110.6426@virtualbox> (Johannes
	Schindelin's message of "Wed, 13 Jul 2016 16:00:46 +0200 (CEST)")
Message-ID: <xmqqd1mh34eh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 531A1042-4914-11E6-9D12-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 12 Jul 2016, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > In case it wasn't clear, I was mostly guessing there. So I dug a bit
>> > further, and indeed, I am wrong. Linux never bumped to a 64-bit time_t
>> > on i386 because of the ABI headaches.
>> 
>> X-< (yes, I knew).
>> 
>> > That being said, I still think the "clamp to time_t" strategy is
>> > reasonable. Unless you are doing something really exotic like pretending
>> > to be from the future, nobody will care for 20 years.
>> 
>> Yup.  It is a minor regression for them to go from ulong to time_t,
>> because they didn't have to care for 90 years or so but now they do
>> in 20 years, I'd guess, but hopefully after that many years,
>> everybody's time_t would be sufficiently large.
>> 
>> I suspect Cobol programmers in the 50s would have said a similar
>> thing about the y2k timebomb they created back then, though ;-)
>> 
>> > And at that point, systems with a 32-bit time_t are going to have
>> > to do _something_, because time() is going to start returning
>> > bogus values. So as long as we behave reasonably (e.g., clamping
>> > values and not generating wrapped nonsense), I think that's a fine
>> > solution.
>> 
>> OK.
>
> I kept the unsigned long -> time_t conversion after reading the thread so
> far.

That's OK at this point; it is not v2.9.x material anyway.

The primary reason why I cared 32-bit time_t is not about 2038, by
the way.  I recall that people wanted to store historical document
with ancient timestamp; even if we update to support negative
timestamps, they cannot go back to 19th century with 32-bit time_t,
but they can with long long or whatever intmax_t is on their system.
