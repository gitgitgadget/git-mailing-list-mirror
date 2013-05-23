From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/17] revision: split some overly-long lines
Date: Thu, 23 May 2013 10:08:16 -0700
Message-ID: <7vy5b5fwu7.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<1368995232-11042-9-git-send-email-mhagger@alum.mit.edu>
	<7vzjvonsna.fsf@alter.siamese.dyndns.org>
	<519DB6E2.9010900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 23 19:08:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfZ0F-0004xw-0n
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 19:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758128Ab3EWRI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 13:08:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758062Ab3EWRIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 13:08:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EB2921B44;
	Thu, 23 May 2013 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qUzmezDVWMQt3SJANKFjFoGze18=; b=eGR3+C
	IY0RbSfhSK+wYv6fkTR606fgXYCqp7w0l9x6yPMMXxVYZVotEYWBGunyGF5XkIEf
	pihrdWtldTw1MH4dX3A7+pX87Flr+TVCoGNY1+90DuhjTHyeVx8630lciQT0wohe
	AS2J5sjTix8r/KlYKTrN/8LkHOcFZ/+u/6BEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RweO6A2unTEWwsJ7PzlFeRkUOSDQ5nYo
	QR0zSi0EYevhXUX3ph5NiSBZNfjwvfyShmwqQtT9MK+Q8wupEMdAXPqE4uIarZQm
	e2JpYiaQnneqC23ksq63WVhugg9nzIQQ3OV9cNbaTqPklW6DKUOIOFsOxFm4d9dn
	KagjR745bOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81B0721B43;
	Thu, 23 May 2013 17:08:23 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC0FB21B40;
	Thu, 23 May 2013 17:08:22 +0000 (UTC)
In-Reply-To: <519DB6E2.9010900@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 23 May 2013 08:27:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FE3F788-C3CB-11E2-9767-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225270>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 05/21/2013 07:34 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>>> ---
>>>  revision.c | 20 ++++++++++++++------
>>>  revision.h | 32 +++++++++++++++++++++-----------
>>>  2 files changed, 35 insertions(+), 17 deletions(-)
>> 
>> Looks obviously good for *.c file, but I am on the fence for *.h
>> one, as the reason we kept these long single lines in *.h files was
>> to help those who want to grep in *.h files to let them view the
>> full function signature.  It probably is OK to tell them to use
>> "git grep -A$n" instead, though.
>
> My goal with this patch was not to set a new policy but rather just to
> make the code conform a little better to the existing policy as
> described in CodingGuidelines.  *If* it is preferred that header files
> list all parameters on a single line, then by all means adjust the
> CodingGuidelines and I will just as happily make header files conform to
> *that* policy when I touch them :-)
>
> (That being said, my personal preference is to apply the 80-character
> limit for header files too.)

Yeah, that is why I said "I am on the fence but it probably is OK to
break" the unwritten but guessable rule.
