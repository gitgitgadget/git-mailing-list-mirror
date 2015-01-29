From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] read_and_strip_branch: fix typo'd address-of operator
Date: Wed, 28 Jan 2015 22:22:53 -0800
Message-ID: <xmqqy4omds1u.fsf@gitster.dls.corp.google.com>
References: <20150128175314.GA13362@peff.net> <20150128175735.GA8172@peff.net>
	<xmqq1tmehc25.fsf@gitster.dls.corp.google.com>
	<20150128225755.GA15719@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 07:24:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGiWO-0001ks-TI
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 07:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbbA2GYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 01:24:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752597AbbA2GYC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 01:24:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6259D293B5;
	Thu, 29 Jan 2015 01:24:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w3nwI+SIfPulzLXB0+MPahliZKg=; b=JbHyhd
	HXsHMLpuB68Sw1qnIvJFu+wnmRPz9OlXKpy78680gTZBpa1ReXguPUtlPv3hxNoX
	iNQSyVR0Cc6+seiiBIi8sjRnJoZGx26HSzzlzAT9IT5vZlsHIAthf3KFapC+rhby
	GwlOqJjS64N9Hto1FzwLhuWeVouk6AiZ8Kaz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kGiIdSySbeUavYobEnxyvrssPCnSZDqU
	ecdLLdUuhwfTYGXOOMe3C7q5Z+RwWBTrQ+ywiuvvVJyZBMq43ctQyGV8FdKiUA+6
	Mr1HjCKFUix/lyhJmNEy4j18omgX/1IuqmR5+Ojxcu0MfCc3pAlvy1snaEXLE/vD
	rOPjbWBsuZM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1A5B293B4;
	Thu, 29 Jan 2015 01:24:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D14229397;
	Thu, 29 Jan 2015 01:22:54 -0500 (EST)
In-Reply-To: <20150128225755.GA15719@peff.net> (Jeff King's message of "Wed,
	28 Jan 2015 17:57:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4283619E-A77F-11E4-AFBA-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263142>

Jeff King <peff@peff.net> writes:

> This is not the first time I've seen this chomp/trim distinction come
> up. However, the thing that has prevented me from writing strbuf_chomp
> is that the trim is almost always a more reasonable choice.
> ...
> End mini-rant. :)

Thanks.
