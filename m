From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Thu, 10 Mar 2011 15:09:43 -0800
Message-ID: <7v4o7a3748.fsf@alter.siamese.dyndns.org>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
 <20110310223732.GE15828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 00:10:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxozb-0006Xk-24
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 00:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab1CJXJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 18:09:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab1CJXJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 18:09:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2C5832FF;
	Thu, 10 Mar 2011 18:11:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6tC5IlUuS9SnW56C60bDn2Rgf0M=; b=hIESHi
	rOBVDaNRTCjHyHHQGCqYgVSO7YSr5n2M8H+eOiiAaUJSN3NBgMtW/pW3WOG1MsPb
	6YMLGDNqfXNtj0lLX8Rd3MyxCwiuBnXiwnbOIV/48tgPGJZSto3AT9zpXlh6vc86
	eNCSY7YRbluHamDxeVDvlwfF+DNNy46CiF5iE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=okozqs+tMz7+aG9v0M0P7dChAcgfj5hb
	u9iPfig6+LUKf4eOBHJ+ajLQoplguRG7wJQHw/o/XRt/vI/R16Mqw5+C/4GGpA75
	fI6h/hyicCUjQvPjZRH7qbm+eIpT/wsdLaHJUIOYeZucy1jNSTJpF/bQNuqHUna2
	0YvA0flIago=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD7C732F9;
	Thu, 10 Mar 2011 18:11:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6E8CD32D1; Thu, 10 Mar 2011
 18:11:15 -0500 (EST)
In-Reply-To: <20110310223732.GE15828@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 Mar 2011 17:37:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5E39074-4B6B-11E0-86B2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168867>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 09, 2011 at 12:17:53PM -0800, Junio C Hamano wrote:
>
>> As the project and the community grew, and also as the internal machinery
>> infrastructure got more modularized, I think ownership at the individual
>> command level has become almost meaningless concept.
>> 
>> Same reasoning applies to the "Documented by".  I think it's time for
>> these two sections to go from most (if not all) pages.
>
> Yeah, I would just as soon drop Author and Documented-by fields in all
> manpages. We could replace them with a single "Credits" in git(1). It
> can either mention nobody, very few people (like Linus as the originator
> and Junio as the long-time maintainer), or the top N (for N < 20 or so)
> people in shortlog. And then mention that you can run shortlog yourself.

Sounds sensible.
