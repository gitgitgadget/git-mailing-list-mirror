From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 09 Apr 2013 18:19:01 -0700
Message-ID: <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 03:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPjgt-0008QD-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 03:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936405Ab3DJBTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 21:19:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756358Ab3DJBTE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 21:19:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B481B10FA8;
	Wed, 10 Apr 2013 01:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=drCuIoakr7rpGDD8JfnLTQX66Jk=; b=n6S4nT
	Yk6sXy0biJXZLkgZNgDHkiCuxdCojxvmaFveOzdxtIQmm0V9mbw9cp0qp9b0H8yj
	kDAoA04ohSVy5qNBguXMf3kwslPFUoLDRIz8/agOT/bXSoEW6PxI+bt/QsuoZfSm
	FdV48PnjWgckBAa9dXqwG8y0QZQPJBu5bf2yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qz9E9U1y1KleTrsolFS8HgGr+GffqOkj
	/sVexRN4Dw92DvLaOLACci3hIyafIJ60lRTdrQj+BGJwyKzPk1TJ3GOqreFYOj7U
	eR80fzVjWP7JoQ+TVKT3iYHrQaxHXV+jmzDwYqpqfgU1S/qyFZKjdLg/F33jYR60
	bw7nfNSwKOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A92D610FA5;
	Wed, 10 Apr 2013 01:19:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80CD710FA4; Wed, 10 Apr
 2013 01:19:02 +0000 (UTC)
In-Reply-To: <20130409231332.GZ30308@google.com> (Jonathan Nieder's message
 of "Tue, 9 Apr 2013 16:13:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1275B5C-A17C-11E2-88A5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220655>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> And I think now I agree that indeed is a sensible assumption.  I am
>> not sure '-' is a good token for that, but I do not offhand think of
>> a reason why '-' would be a _bad_ token for that, either.
>
> Random idea: today you can do
>
> 	git push origin master; # push branch master to remote origin
> 	git push --multiple origin korg; # push default refspec to 2 remotes
>
> How about:
>
> 	git push origin korg -- master; # push master to 2 remotes

For this to be any useful, origin and korg has to have the same or
at least similar ref structure, such that pushing my 'master' to
their 'master' makes sense for both sites.  I am not sure how common
it would be.  If people commonly do so, the above looks like a
reasonably useful feature.

> 	git push -- master next; # push two refs to default remote

... or default "push remote" if there is one, I presume?

As you are giving what to push, I am assuming that
branch.$name.remote would not come into play in this case.

> 	git push origin -- master; # push master to origin, more explicitly


> 	git push origin korg --; # push default refspec to 2 remotes, again

As you are _not_ saying what to push, I would expect
branch.$name.remote may have to come into the picture, but because
you are saying where to push, that is not the case.  What does
"default refspec" mean in this context?  What "git push origin" (no refspecs)
would push by default will be sent to "origin", and what "git push
korg" (no refspecs) would push by default will be sent to "korg"?

All of the above sounds a bit too complicated to explain to end
users, but I think they are internally consistent.

> 	git push host:some/path; # ambiguous argument. Please disambiguate.
> 	git push host:some/path --; # push default refspec over SSH
> 	git push -- host:some/path; # push specified refspec to default remote

OK.

> 	git push origin; # is a remote name and not a refname. Good.
> 	git push master; # is a ref name and not a remote name. Good.

Hmm, I dunno.

> What do you think?
> Jonathan
