From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] Color skipped tests bold blue
Date: Thu, 20 Sep 2012 09:20:01 -0700
Message-ID: <7va9wkd5u6.fsf@alter.siamese.dyndns.org>
References: <505AAE34.2020408@viscovery.net>
 <1348132118-23139-1-git-send-email-git@adamspiers.org>
 <505AEB1B.7010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 18:20:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEjUI-0004Ta-Do
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 18:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab2ITQUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 12:20:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab2ITQUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 12:20:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D79FA9050;
	Thu, 20 Sep 2012 12:20:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u19o6QNkuT0pGPIYf9ECoK9TlVI=; b=ST3W0p
	jqMqsT1NIJqI4t2Vn4uDNwQ19DtaTpAx+zeOCYtt/gUAnlqAuGaSF3mJOwNJhc2D
	jM+ZeYncBdnuooE1g7FnWIJwHFn3rRUOSGvK7O61j5SNGOiZ1/GhLGzODMK4Jpls
	QrNLU7ZiLWEAgHBE38blU3FX8l8r+d42lmIWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uL2FjlsDko8ho8kBErlRGfIrtitIqvEt
	NWeOOqfkcERdUARh+1/WOXf2Ge+BpAIwQ6oSs9cmFLhpBnE/GtRek3s3LGX9KSUY
	QeQZqf1wI5DHOJMZ9Dk6LwOqlWIiDOfCQznba0X5WrqxFlX3KOlkW+aAt3Glpmc6
	g//Qx/q6a2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE96F904F;
	Thu, 20 Sep 2012 12:20:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D8C8904A; Thu, 20 Sep 2012
 12:20:03 -0400 (EDT)
In-Reply-To: <505AEB1B.7010702@gmail.com> (Stefano Lattarini's message of
 "Thu, 20 Sep 2012 12:08:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0879FF30-033F-11E2-9961-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206050>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> Hi Adam.
>
> On 09/20/2012 11:08 AM, Adam Spiers wrote:
>> Skipped tests indicate incomplete test coverage.  Whilst this is
>> not a test failure or other error, it's still not complete
>> success, so according to the universal traffic lights coloring
>> scheme, yellow/brown seems more suitable than green.  However,
>> it's more informational than cautionary, so instead we use blue
>> which is a universal color for information signs.  Bold blue
>> should work better on both black and white backgrounds than
>> normal blue.
>>
> A very minor nit (feel free to ignore it): IMHO, it should be nice
> to state explicitly in the commit message that blue is already used
> by other testsuite-related software to highlight skipped tests; you
> can report the examples of at least Automake, Autotest and prove --
> and extra kudos if you find further examples ;-)

Thanks.  Will tweak the proposed log message to include the above
when queuing the updated patch.
