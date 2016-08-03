Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478651F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757777AbcHCQ7J (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:59:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757340AbcHCQ7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:59:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 11AF92FE37;
	Wed,  3 Aug 2016 12:59:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tjqcSkWAHJD+6OddDyK5VL4Bo88=; b=KXEg4B
	zBVWMjYHAk0ywct8l9RuDuvGWu1Sl1UYakxTqGi/WQF/tuXIp3tOTb2z6DoeLLbo
	4AyPWyNXJuF1uL/M6LINpREerGmMrE+QjWPhLaiZy+tlG7M3Z7fcoL755cdandts
	3EFvKsDj0YkQf7x9UD1+E/NPySQhGXhXFEkGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W7H4BYIOPziMhkJhY+ybk/+kaX2/zJ04
	xZ3HM6dcomfY8uZbxpXNd5dJsT5v8/IJhGboKSOomwa6y+IqYQDbLrfZJhvp8voS
	5sYB/jSSSSfekXd5e3wtUQqesHyR2HQeprm9TJaE+rhORisKYbFQ+3zSSwsriq2q
	Nx2dEzY47Uk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0947D2FE36;
	Wed,  3 Aug 2016 12:59:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F2C02FE34;
	Wed,  3 Aug 2016 12:59:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff Hostetler <git@jeffhostetler.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] status: V2 porcelain status
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
	<alpine.DEB.2.20.1608031708560.107993@virtualbox>
	<CAPc5daVuD7K7zKEG4yHTjBU77rUbdVcbSeBgX9eAJVMWMmxC2w@mail.gmail.com>
	<alpine.DEB.2.20.1608031808130.107993@virtualbox>
Date:	Wed, 03 Aug 2016 09:59:03 -0700
In-Reply-To: <alpine.DEB.2.20.1608031808130.107993@virtualbox> (Johannes
	Schindelin's message of "Wed, 3 Aug 2016 18:10:52 +0200 (CEST)")
Message-ID: <xmqq7fbxaiw8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96276258-599B-11E6-8973-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 3 Aug 2016, Junio C Hamano wrote:
>
>> On Wed, Aug 3, 2016 at 8:09 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > Any word when it will be included in `pu`, at least?
>> 
>> I've been waiting to see that the amount and quality of
>> comments from others indicate that the series passed
>> the phase that goes through frequent rerolls. Having a
>> serious review in the thread that demonstrates and
>> concludes that it is well designed, well implemented,
>> and ready to go would help, of course.
>
> Oh, I thought I had stated clearly already that what with Jeff being my
> colleague and working on a feature I have a lot of interest in, I had
> reviewed this patch series even before it was submitted to the Git mailing
> list.


What I meant by a "serious review" is a bit more than "I reviewed
without involving the list, and you know me well enough, trust me".

Even if a reviewer does not see any more need to change the patch,
perhaps because it is perfect after internal reviews, a reviewer can
still point out positive things, e.g. what is done well compared to
other possible approaches and in what way the presented patch is
better than possible alternatives.  See my response to your import-tars
update for an example.

Thanks.
