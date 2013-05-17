From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Random thoughts on "upstream"
Date: Fri, 17 May 2013 10:51:28 -0700
Message-ID: <7vk3mxze8v.fsf@alter.siamese.dyndns.org>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	<7vk3mx1rox.fsf@alter.siamese.dyndns.org>
	<CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:51:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOob-0000op-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513Ab3EQRvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:51:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756496Ab3EQRvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:51:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 130361BCF0;
	Fri, 17 May 2013 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=unNShkLtkDBotY2agUK+qWszQfU=; b=NHI3yf
	qiwAi/sN9czSwJIkHqPyxY2pq7XhV1hJhMYEzZUSKKOsYSxSxYbUsS1TD0qlgFCb
	32mGBrMedqaq3SndFxy+lw5dILdSmcL0zTSRK+bGbQMgLodg8ZTBHImNufBfZWQD
	bARb0ICHSH4jGYLprHvWzMKY74cL/8YM8WETM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oCANnod/ztI59F3rzbRljI7vN713lwtk
	UNYuynxLqJ/I5RA9YsY7y0BgV+KeUPd1/LE1YgBYchBlDWARs/2VqU+95y0ZEFoY
	xFKzX5S8Z1ELRMQYiqlytIxPuMAT+wVzo15LnzEQj46xR4U9wgxE7oJhr7AbIZiN
	WNu+rmfIDkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08E0F1BCEF;
	Fri, 17 May 2013 17:51:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3496D1BCEA;
	Fri, 17 May 2013 17:51:30 +0000 (UTC)
In-Reply-To: <CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 17 May 2013 22:31:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67927442-BF1A-11E2-9DAA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224721>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>
>>         Side note: I do not think "fork" rings bell to the end
>>         users.  Who is forking from what?  I am guessing you are
>>         trying to make a short form of "the branch in my public
>>         pepository I push this branch to, and other people would
>>         consider it my fork of the upstream project", but it is hard
>>         to do the reverse, i.e. a new person who is presented a word
>>         'fork' to guess that you wanted to refer to the above by
>>         that word.
>
> GitHub is an overwhelmingly popular service, and many end-users are
> used to clicking on the "Fork" button on various projects to
> contribute.  Here, "fork" is short for "my fork".  Do you have a
> better name in mind?

In my original "Random thoughts", I deliberately avoided introducing
a new name for the publishing point, because I did not think of a
good name myself ("publish" for "what I publish this as?" was what I
had in mind, and while it is better than "downstream" which this
thing clearly isn't, I do not think it is a great name).

As I said number of times, I am not good at naming, even though I
can tell when a proposed name (like "publish") is not a good one
X-<.

Matching it with the way to set this per-branch might be a good
alternative.  If branch.<name>.push is it, then it would mean
"@{push}".

> Ofcourse, I'm not saying it's not possible.
>
> 1. Getting @{f} requires extra computation, and that might be ugly/
> undesirable/ surprising considering how @{u} doesn't require it.

This is minor, but I am not sure "doesn't require it" part should
always stay true in the first place.  If you are always forking your
'master' from the upstream 'master' and your 'next' from the
upstream 'next', there is no real reason why the user must record an
obvious value in branch.master.merge and branch.next.merge
variables.

> 2. Setting @{f} with branch --set-fork-to won't operate on the
> branch.<name> section, and this might be surprising.

Hmm, why?

As I said, I do _not_ mean branch.<name>.push must _not_ exist.

Setting it explicitly with --fork-to or whatever option is perfectly
fine; the logic to resolve @{f} notation would honor it naturally if
you reused the same logic as "git push" decides where to push, no?

> 3. If remote.<name>.push is only going to be used by the Gerrit
> people, @{f} is not going to work anyway.

I do not understand what you mean by this.

> These issues aren't deal breakers, but are certainly worth mentioning.
> Frankly, I'm not overtly fond of the branch.<name>.push idea, and am
> tilting towards this now.  What do you think?

I think I'd better rephrase what I wanted to say in the message you
are responding to.

 * "branch.<name>.push" would be a way to set per-branch push
   destination. There may be other ways to do the same but I do not
   think it is bad and it probably will fall into bikeshedding
   category to attempt to come up with something different for the
   same purpose of setting per-branch destination.

 * There should be a mechanism to allow people _not_ configure it
   per-branch if they do not want to push to randomly custimized
   destinations per-branch (i.e. want to always push $branch to
   refs/heads/$branch, or refs/remotes/satellite/$branch).

So that is what I think.

Having said that I am not sure where your "not overly fond of" comes
from, as I do not see a problem with branch.<name>.push.  The only
problem I may have with the approach would arise _only_ if we make
it the sole way to allow people push to different names, forcing
people who want to push N branches to configure it N times.  Other
than that, I think it is an acceptable solution to give per-branch
control.
