Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAAE20189
	for <e@80x24.org>; Wed, 22 Jun 2016 18:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbcFVSUf (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 14:20:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751242AbcFVSUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 14:20:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C8E82634D;
	Wed, 22 Jun 2016 14:20:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NXywXKVZ2Z/DAdOElkyLHTnaTBg=; b=mnYDSb
	XN+8rhYdsnzYCYdQx/LTraNKBAaUjbPw9L4o/Khqy0fbgpFbfGUDF5hxtDdhDtRA
	nix8iGuIkI2ZrFNL9KtdeIEbaVY9BJITvdDPl844GvupLUYLZbB7tW90TvsArQcQ
	r3Bss3kmF14orbCfNPzaOhMg7cUmQT7/aZRkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qkxTN12HjRbH7EMZ0MBkOFXuJqzmqesW
	WnySDostPGWkWm+76xFA3O9kNbwm8gg/EzUrrwaBNTJhlS61xYQpFGeEyBGjF0Px
	YR4IxfrnU8vXIQC5KOlFQninaf7L7goRrRR6a+kCnfT+o2e9YKxMnym05rAQJR77
	dIvYD3u2G2g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F24E2634C;
	Wed, 22 Jun 2016 14:20:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87C5D2634A;
	Wed, 22 Jun 2016 14:20:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: Re: How to find commits unique to a branch
References: <878txz8ubq.fsf@thinkpad.rath.org>
	<xmqqtwgnsdr3.fsf@gitster.mtv.corp.google.com>
	<87lh1z78fr.fsf@thinkpad.rath.org> <87oa6ubeq4.fsf@thinkpad.rath.org>
	<xmqq7fdiqtqv.fsf@gitster.mtv.corp.google.com>
	<87mvmdgowj.fsf@thinkpad.rath.org>
Date:	Wed, 22 Jun 2016 11:20:30 -0700
In-Reply-To: <87mvmdgowj.fsf@thinkpad.rath.org> (Nikolaus Rath's message of
	"Wed, 22 Jun 2016 09:38:04 -0700")
Message-ID: <xmqqh9clm6fl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01B39A30-38A6-11E6-A87E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nikolaus Rath <Nikolaus@rath.org> writes:

> On Jun 21 2016, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I find that the first sentence of the description is fuzzy
>> ("Determine whether" would imply that you would get "Yes/No" but
>> what we want is "here are the commits that do not have counterpart
>> in 2fix"),...
>
> This works, thanks! I don't quite understand why though. I started by
> saying that I want to know which commits in master are have been cherry
> picked after 3start was branched to 2fix, so <limit>..<head> must be
> 3start..2fix, which only leaves "master" as <upstream>.  What's wrong
> with that thought?

The only thing that is wrong in that is it does not match what
happens, but that is not the fault of the "thought"; as I said, I
think the description is fuzzy and has room for improvement to avoid
being read in such a way that leads to a wrong conclusion.
