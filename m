From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 10:49:41 -0700
Message-ID: <7vobynui8a.fsf@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 19:49:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3tat-0003o3-6n
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 19:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113Ab1INRtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 13:49:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754950Ab1INRtq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 13:49:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24DA844B4;
	Wed, 14 Sep 2011 13:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h8b3VjOSETHiFEBh6DfbqVa87P0=; b=WMXWgX
	R8LQGU7YKmv0EpqtntsojNaYlirYWNblfsr41G7TdcabxNdKnNICnNr9UWI6vt+p
	a19yYr+bQCDBrZCwR/TQfrhUv5DbhWR+c75f3WgGniL/w/35YPZ97ri4miNj3ZC6
	zLllmS2xujiAF73ZJlx5fk9t70qVQ/LkJLF4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BKjh7vXRZvRZSH1KTWPXOb9VENfb0dkn
	Mfgm0e2IZ1F8eRueBzMQhjmgv7PHbVGTen+AZCEwQCoVDeadIhaqQdwC+9NwpUN+
	aXk/4//Om3yf6KUbT6Xt3AQKqat6A9/MSS67QfI2FnsI8q3knYvURejP8PKteYd4
	p1tI+PSKBYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 183EA44B2;
	Wed, 14 Sep 2011 13:49:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 746ED44B1; Wed, 14 Sep 2011
 13:49:43 -0400 (EDT)
In-Reply-To: <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com> (Linus
 Torvalds's message of "Wed, 14 Sep 2011 00:06:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED8E7D6E-DEF9-11E0-A8C8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181368>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I think that would probably be a good idea, although I'd actually
> prefer you to be more verbose, and more human-friendly, and actually
> talk about the commit in a readable way. Get rid of the *horrible*
> BRANCH-NOT-VERIFIED message (that actually messes up pull requests if
> mirroring is a bit delayed and throws away more important
> information), and instead just have a blurb afterwards saying
> something human-readable like
>
>  Top commit 1f51b001cccf: "Merge branches 'cns3xxx/fixes',
>  'omap/fixes' and 'davinci/fixes' into fixes"
>
>  and at *that* point you might have a "UNVERIFIED" notice for people
> to check if they forgot to push.

That UNVERIFIED thing was neither my favorite nor my idea, and I'd happily
rip it out in any second ;-)

>> An alternative that I am considering is to let the requester say this
>> instead:
>>
>>    are available in the git repository at:
>>      git://git.kernel.org/pub/flobar.git/ 5738c9c21e53356ab5020912116e7f82fd2d428f
>>
>> without adding the extra line.
>
> The extra line in the pull request is cheap - it's not like we need to
> ration them. The above format, in contrast, requires that the person
> doing the *pull* have a recent enough git client, otherwise the merge
> commit message will be just horrible.

In a re-roll patch I've added ";# branch-name" at the end of that line for
people with older git, but existing git wouldn't allow you to fetch anything
but refs so you won't risk getting "just horrible" merge message ;-)

> ... And what if the branch was updated since, so *no* branch name
> matches - does that mean that you'd disallow the pull entirely?

You are right about ambiguities, but when the specified commit does not
match the branch, it was indeed my intention to claim it is a _feature_ 
that pull fails, as you would be getting something different from what you
thought was promised by the requester with bait-and-switch.

> Also, if we're adding branch information, I'd say that a description
> of the branch is more important than a signature. Right now we lack
> even that.

I do not particularly want to go into that tangent, and I do agree with
your later message in this thread that it may make sense to tie the
publishing (and possibly recording) of the description of the branch to
"push -s"; people simply do not have reason to name throw-away branches.

> It would be lovely if people could annotate their branches with
> descriptions, so that when I pull a "for-linus" branch, if it has a
> description, the description of the branch makes it into the merge
> message.

I'm wondering if this could be something we can share between the push
certificate "Into this repository, I pushed this commit to that branch,
whose pupose is..." and pull request "...so please pull it to merge into
your history." There are three possibile orders of things a lieutenant or
a contributor may want to do after perfecting his tree locally:

 (1) Write pull-request, and then "push -s".

 (2) "push -s", and then write pull-request.

 (3) "push -s" auto-mailing a pull-request.

> I realize that cryptographic signature sound very important right now,
> but in the end, *real* trust comes from people, not from signatures.
> ...
> Technical measures can be subverted, and I think we should also think
> about the social side. Every time somebody mentions a signature, I
> want to also mention "human readability", because I think that matters
> as much, if not more.

I obviously agree 100%, but that is an argument against trusting only
technical measures---right now, we do not have a good technical measure to
validate latest commits not yet contained in any tagged releases.

A piece of e-mail to the kernel list from you that says "I pushed it out
and the tip is this SHA-1", if it is written in good English with a bit of
your usual humor sprinkled in, would in practice be just as good as GPG 
for the kernel list regulars who can recognize your style and serve as
that "technical measure" (by the way "What's cooking" does have the tips
of master and next branches for this exact reason).

> Imagine, for example, than when you do a
>
>   git push -s ..
>
> git would *require* you to actually write a message about what you are
> pushing.

Yeah, we could go in that direction.
