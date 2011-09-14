From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Helping on Git development
Date: Wed, 14 Sep 2011 16:34:38 -0700
Message-ID: <7vd3f2snox.fsf@alter.siamese.dyndns.org>
References: <CAOz-D1JW8RSR8kVWhT7v-DCbWayU8KhbePJwWrWvJwbmueRezQ@mail.gmail.com>
 <CAOz-D1+77JZRXa57GLz=vZyrcGs4Ojj6Wa0cSD4QcEkMP3PPsA@mail.gmail.com>
 <CAH5451me+MDe34Boak=UDjH9T_WAnO6wxa6pW+JHOoGADoNfkQ@mail.gmail.com>
 <7vehzjugdz.fsf@alter.siamese.dyndns.org>
 <20110914231427.GA5611@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Ardill <andrew.ardill@gmail.com>,
	Eduardo D'Avila <erdavila@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 01:34:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3yyb-0004By-NC
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 01:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab1INXel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 19:34:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab1INXek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 19:34:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 052894A6D;
	Wed, 14 Sep 2011 19:34:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w5r5Y/AGjA1xTiWSoL2JTFp6wHE=; b=uS6/ND
	Z8o7wb7FYx1rjwgqYqlyUJXGA9LAYnE4qeXTvyvfXBnCz4p7J7Np74fM6gnJKOjA
	bdC4Kdy+17x5/kWJxoHvoR2xYRXRJv2jqfindls+UcijSVNvxO8TSc7mR9LvtgRQ
	qqpmSE/J89XEGidmr1OBbr+55hnp4O55b2a0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dQDGSrLaGyZzx9SUQ69Tgp+lQzOSSz/O
	g1Z/wtprHrLPGTa8RpctjBQbR83wzPCfytmo5CCrWmQonUhgE6HX6pLZeG6tgP65
	ulaILQlJBnTuDr7tEMvz2jL9jpenANgeDVz3GeDApnsUo7mTQDoSwnBSR+pdK6+z
	gaJN4ux2PQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F07D74A6C;
	Wed, 14 Sep 2011 19:34:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A5614A6B; Wed, 14 Sep 2011
 19:34:39 -0400 (EDT)
In-Reply-To: <20110914231427.GA5611@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Sep 2011 19:14:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D59468E-DF2A-11E0-B496-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181413>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 14, 2011 at 11:29:28AM -0700, Junio C Hamano wrote:
>
>> As to contributing to the project, right now, I think we have enough
>> people who want to write code and documentation for Git, but what we lack
>> are bandwidth to (this is not meant to be an exhaustive list):
>
> Is there such a thing as enough coders? :)

Ever heard of the Mythical Man-Month ;-)?

I thought it was clear from my message but probably I wasn't clear enough,
so let's make it clear. I didn't mean to ay "we have enough -- we need no
more -- we reject new applicants".

I was simply saying that there already are many people who scratch his own
real itch, and we are short of the bandwidth to review them all. It would
not help the project at all to add more people who scratch some random
non-itches that nobody is actually interested in (e.g. an entry in an
unmaintained "bug tracker" that may list irrelevant and stale non issues).

>   2. Read the list. People will report bugs. Try reproducing them,
>      bisecting them, creating minimal test cases, narrowing the issues
>      down to certain configurations or a certain bit of code, etc.
>      Sometimes that will lead you to propose a solution. Sometimes
>      you'll just add to the discussion, and then somebody with more
>      familiarity can pick up the topic from there. But you'll have
>      helped them by doing some of the work, and you'll have learned more
>      about how git works.

Yes. In the earlier steps in the above, you may find out that the report
was actually not a bug at all (e.g. old issue that has long been fixed,
pebcak, or wrong expectation), but even in such a case, reporting your
finding would help others.
