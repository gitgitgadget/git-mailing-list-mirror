From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] approxidate: allow ISO-like dates far in the future
Date: Fri, 14 Nov 2014 14:15:19 -0800
Message-ID: <xmqqtx211lag.fsf@gitster.dls.corp.google.com>
References: <20141113110325.GD8329@peff.net> <20141113110722.GB4386@peff.net>
	<CA+EOSBn0-ZFOPaeU92a0YWPW_S9kenoRUjJMp-Nhm-azftrEfA@mail.gmail.com>
	<20141114084725.GA16030@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Colin Smith <colin.webdev@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 23:15:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpP9L-0001nH-9T
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 23:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072AbaKNWPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 17:15:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754484AbaKNWPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 17:15:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5867B1EABA;
	Fri, 14 Nov 2014 17:15:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XRdOnkVkvGv1AGIFoasPWe+vSPA=; b=XY2QPn
	pTOlVPrgyyADAsZeBT9xoY41Lr1CIfcx0RO+QV5hoHp5hLEHO2OF8LAcel3wvfHK
	bkKDA0rskaZdesD84gNZRy5EDrcLZTNOVb65ctHNXLE+DHwpaNw0gffWx1uZ1e5h
	zR6wKk7FK1nsgozRNwMMNijaBH09LpPZaC6vY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpfr8Cb05ooLqFyLP5LGY3Q4Y7vyjiKU
	YMqBC0ZzUgsuDakm9nWKgUOtkpgXbT21eSCS3dbDV33AYB/wO3U19WD2X8FZo/11
	Pp1NoQvVSa6CXNYG/cwVs1UWf1S3ZhHR7Y9C5sONyhYuL9fxZXhf9efyLUgN/BXI
	hZRk+qbh9qs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AECD1EAB9;
	Fri, 14 Nov 2014 17:15:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAF0E1EAB8;
	Fri, 14 Nov 2014 17:15:20 -0500 (EST)
In-Reply-To: <20141114084725.GA16030@peff.net> (Jeff King's message of "Fri,
	14 Nov 2014 03:47:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8DC8484-6C4B-11E4-A629-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 14, 2014 at 06:46:19AM +0100, Elia Pinto wrote:
>
>> > [1] http://en.wikipedia.org/wiki/Date_and_time_representation_by_country
>> > [2] http://en.wikipedia.org/wiki/Calendar_date
>> 
>> Isn't not so good to refer to external resources  in a commit message ?
>
> It is not good to omit any explanation and just include a link, like:
>
>   Fixes the bug reported in http://...
>
> because people who are reading "git log" have to follow that link to
> even see what you are talking about (and the link might go away, or they
> might not have access at the time).
>
> It is fine, and even desirable, to summarize the relevant content of a
> resource and provide a link for people who want to dig further. In this
> case, I am saying "Wikipedia claims that nobody uses this format" and
> backing it up with a link to indicate which pages I checked. You do not
> have to follow the link to know what I am saying, but if you want to
> dig deeper, you at least know where I left off my research.
>
> Does that make sense?

What you wrote matches the level of details I have been trying to
stick to when writing references in my own log messages and when
tweaking others' log messages.

Thanks.
