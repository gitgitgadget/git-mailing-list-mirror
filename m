Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5EEA2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbcFXTs3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:48:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751317AbcFXTs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:48:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D68CC25C0A;
	Fri, 24 Jun 2016 15:48:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BjoPmnqwFTHc2uxVfBT12NIb8xg=; b=QPyiWS
	5WvpwHUigbYCm7Wfzhaje++TDmUT9PO5nlEeivPlACrKVCk9Wb1t7QVnr2CVs/Cb
	FB9WcDFUHrNd1mPAmvzvmv2wep3FObVlVIcHtWM1rsUAa+C4od3f5s6kEM8Y8hvf
	PCsXL0QzVbNGWVsdGY1N96ND3edAoZRxHDnLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/W9W/oDPF5HwtDK1lMe7YyNNoYJHiwE
	bgdn7MocU5CdD35lPBLaTUuUc+Y7alz5DY61KAModUYuAavg3u2o1NDuBkOFnsAG
	dvzyMq0oRv33kD/RClHU2dPs1s8DuMCW7I1U6D9HCcSYfufFawA/vPcdZE+TWJX7
	93difaxX6Nw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDB2025C09;
	Fri, 24 Jun 2016 15:48:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AECE25C07;
	Fri, 24 Jun 2016 15:48:27 -0400 (EDT)
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
Date:	Fri, 24 Jun 2016 12:48:25 -0700
In-Reply-To: <vpq8txwtmg8.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	23 Jun 2016 09:04:55 +0200")
Message-ID: <xmqqbn2qfjw6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E9A8436-3A44-11E6-8154-89D312518317-77302942!pb-smtp1.pobox.com
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

I'll see what I can do at k.org these days.

Don't hold your breath, don't stay tuned, but don't be surprised if
you see a positive change in the future ;-)

Thanks.
