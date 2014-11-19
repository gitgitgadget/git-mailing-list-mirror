From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 13:00:21 -0800
Message-ID: <xmqqwq6qrjmi.fsf@gitster.dls.corp.google.com>
References: <6997784.RuzRO1AFsK@al> <20141119190800.GB9908@peff.net>
	<xmqq61ebrl1g.fsf@gitster.dls.corp.google.com> <1588976.dNB1P7S71u@al>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Wed Nov 19 22:00:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCMs-00015M-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862AbaKSVAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:00:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932375AbaKSVAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:00:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 955551FFC1;
	Wed, 19 Nov 2014 16:00:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yLYEQuU9Z3TrGfmJaR1Hjzjd79U=; b=Hw1zUd
	5fX6hfB0nUL7GNGILyp8Y3cvItccJRBo2dbSZESIM0RpB2r6ilGosVK9zjYn/KYO
	tqu3VNJPQZsnYU9AcOhbYq26BAg3lbfP17l28zkSxQw7lQuS4ITaVzpFPrYoJvet
	wmgx00w9Uzb8/fGD4x/613qjavBsZ+tqgZwXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XaoKkc0L/2CszCPCRqwvq0FIX6NDTIYE
	yDJhvOnfqDVd9acHhfwDJXtyc0HpRfsm7g8/nmAPJQC6U/nfrWQgMG1zzhHlQ3Ln
	NlIDkWDgv6Xn9HKRzSQJ2joODxKriTeOmlhWjGLWxUFJGF5UBRJV2WC7z8yKPD+s
	OOlA+Qfr3zM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C7A81FFC0;
	Wed, 19 Nov 2014 16:00:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC8531FF9C;
	Wed, 19 Nov 2014 16:00:22 -0500 (EST)
In-Reply-To: <1588976.dNB1P7S71u@al> (Peter Wu's message of "Wed, 19 Nov 2014
	21:52:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13E03204-702F-11E4-845E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Wu <peter@lekensteyn.nl> writes:

> On Wednesday 19 November 2014 12:29:47 Junio C Hamano wrote:
> ...
>> Yes, the semantics the updated code gives feel very strange.  I
>> wouldn't be able to write a three-line summary in the release notes
>> to advertise what good this new feature brings to users myself.
>
> What about:
>
>     "git remote set-url" learned a new "--fetch" option which can be
>     used to change the fetch URL while leaving the push URL intact.
>     Useful to keep a ssh URL for push and change the fetch URL to https.
>
> which is effectively the functionality I am using it for.

I do not think that clarifies the confusion-factor Peff has been
pointing out in this thread, unfortunately.  At least not to me.
