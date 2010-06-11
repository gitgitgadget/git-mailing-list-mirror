From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/README: document --root option
Date: Fri, 11 Jun 2010 13:48:26 -0700
Message-ID: <7vpqzxgusl.fsf@alter.siamese.dyndns.org>
References: <c5efa5c15498fe562af98b9b16165127bc1690c2.1276193888.git.trast@student.ethz.ch> <20100610214807.GA24555@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 11 22:48:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONB9k-0006l7-3u
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 22:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671Ab0FKUsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 16:48:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628Ab0FKUsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 16:48:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4C73BB9CE;
	Fri, 11 Jun 2010 16:48:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fOMO9K/uZuyqkGduK+W6Ft9aN4w=; b=LJJgKm
	jzxVVCaHNwK0ES9drCl6Av1TtRuZoTaI5PT/VcZb9ANwXKjlwHLiBc1XcHHLFMpZ
	HI2go7tsnQXcSDjvFLdtT3VK6dy0roOiGa56PxFvTl6lqNpRqwg+PeYzGn1w0dwE
	+03qno8lkum/K+99PBvym7DRcuMM6qbzjbCgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EKAnoXY8eccH03sPxg9Z+5lx2DY//J+r
	vFGvgCdTgRs+5SkWlLISlcCMAi/4ctjhR44fHrot+p7Ipyavvhz3e46RLl4F90ot
	UAEqCTz7+/d+WAM85B84Us3hZgxm07+NsLNXQekUS0KVZFpROJFk6UQxFqjWYTPX
	pKqrxf3IeZk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FABCBB9CA;
	Fri, 11 Jun 2010 16:48:31 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B84DDBB9C9; Fri, 11 Jun
 2010 16:48:27 -0400 (EDT)
In-Reply-To: <20100610214807.GA24555@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 10 Jun 2010 17\:48\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1ED4F70-759A-11DF-91CE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148969>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 10, 2010 at 08:24:46PM +0200, Thomas Rast wrote:
>
>> We've had this option since f423ef5 (tests: allow user to specify
>> trash directory location, 2009-08-09).  Make it easier to look up :-)
>
> Acked-by: Jeff King <peff@peff.net>
>
>> +--root=<directory>::
>> +	Use <directory> as a trash directory to store all temporary
>> +	data during testing, instead of the t/ directory itself.
>> +	Using this option with a RAM-based filesystem (such as tmpfs)
>> +	can massively speed up the test suite.
>
> Minor nit: <directory> is not the trash directory, but rather the root
> of all trash directories. I think anybody with half a clue will
> understand what it means, though.

Then...

	Create "trash" directories used to store all temporary data during
	testing under <directory>, instead of the t/ directory.

perhaps?
