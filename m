From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 10 Nov 2011 13:41:49 -0800
Message-ID: <7vr51fslia.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org>
 <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
 <7v4nydurzh.fsf@alter.siamese.dyndns.org>
 <CALKQrgfZtELcK3H5ZYvmcW8RrtKMVRACFTvw3s5SidFvmFWkGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 22:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROcNj-0005Qw-SI
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 22:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab1KJVl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 16:41:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab1KJVly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 16:41:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3A755414;
	Thu, 10 Nov 2011 16:41:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xw05pw+fwquKv43owG7CPIdxc/M=; b=GnoLdu
	SyHp/z77YDkeGP+RbjBgDvbV7nqw4AGM005qxfB0U66K6JqNywK9j1LShcW0eQE2
	gIW/wpwaPY/DuCzNW9nPcHPZFBbzGmxciBBQonn80RgGVeHtbwpUh6ORrY7OvKPg
	W8KnV/84UNhHYaMERqFAL+0jXs3WC+5PK3YFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xSqzyIGvN5GOzmT5K321B7g1qF/3eojz
	32rcD1c8K7ygEAqlU3HxOaqg3daX/fqIqAcf5MFYoihdMndbVHQpzXHzTWkHBIiV
	AFf7Us/UHdQNM/su6AAIBlhB734r3/yZqil7JfIh89fTYewD6vNzBho7j9f+LeE9
	+1rXRIno0XE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC1905413;
	Thu, 10 Nov 2011 16:41:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C0B55410; Thu, 10 Nov 2011
 16:41:52 -0500 (EST)
In-Reply-To: <CALKQrgfZtELcK3H5ZYvmcW8RrtKMVRACFTvw3s5SidFvmFWkGw@mail.gmail.com> (Johan
 Herland's message of "Thu, 10 Nov 2011 09:02:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD5FB252-0BE4-11E1-81E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185245>

Johan Herland <johan@herland.net> writes:

> You would also have to keep track of deleted annotations, to enable the local
> side to delete an annotation corresponding to an already-deleted annotation
> on the remote side.

For the "signed commit or pull request" use case, I think "delete" is
probably not something you want to do in the first place.

If there is a "certificate" that says "I made this commit" or "I agree
this is a good topic to be merged to my history" that later turns out to
be incorrect, you do not just want to excise it from your repository and
the place you push to. You would instead want to distribute revocation
notice for such certificiate, which would be a new "note" that will be
attached to the commit or merge in question, so that other people who got
the "certificate" from you or the place you push to will know about the
removal using the same mechanism.

Of course the "UI" layer could match a "certificate" and a "revocation"
against each other and do something intelligent about them (like, not
showing revoked ones by default), so in that sense a moral equivalent of
"delete" from the end user's point of view can easily be supported [*1*].

Note that in this thread, I am not saying that "git notes" mechanism is
not good for anything. A tree whose node names encode an object name is a
valid way to store the mapping from that object to a set of other objects,
and we already agreed that as the "local" storage mechanism, "git notes"
may be used as-is for the purpose of this thread.

But the transfer and merge semantics "git notes" mechanism offers treats
the entire "notes" that appear in _one_ repository and merging that set to
the entire "notes" in another repository and it is not a good match for
the purpose of this thread.


[Footnote]

*1* The point is, it is not the only way to implement a "delete" to keep a
history with common ancestor that has something and your latest that does
not have that thing, which is what "git notes" gives you. If having to
keep the history brings other undesired semantic baggage, other ways that
do not have such undesired property need to be explored.
