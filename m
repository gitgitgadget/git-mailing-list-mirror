From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push branch descriptions
Date: Wed, 14 Nov 2012 09:58:27 -0800
Message-ID: <7vbof0awxo.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9ABenaj=R0a6OW2GCsin8PdDCW3ZbuQbu6G0jnGG3s+sA@mail.gmail.com>
 <7vr4nwb832.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BN6vTnpPa8rv1Yumn2Os=XU=tEn3=j2QJJK1GpajY=VQ@mail.gmail.com>
 <871B6C10EBEFE342A772D1159D13208537AABCCA@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Pyeron\, Jason J CTR \(US\)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:58:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYhEb-0001pj-JV
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 18:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab2KNR6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 12:58:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602Ab2KNR6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 12:58:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 201E9A7AA;
	Wed, 14 Nov 2012 12:58:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nMj4WFU9r1FrWmSSSlKC1QRmTWY=; b=Ts0PZ1
	T/FpiLsVhJpNjeIIZFPm2ahzT9D13SQcVYCCJUhGu2hku0enhpgi17IRyMpRGY2U
	dRhoO96rttPaEO6MZtUYoG2MMjYaApQyXxxfaPs1wplYzrA8r7ovtLbLyiueZgIC
	EhZrRlTPZ0BUQchAW4LUHhirzUETGr6KbagRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F9aqDto1Zs8mWJbAf4Mkh+cAOF3o9zcO
	fp6lr/U4BPkSqv9G4e50oWNlQM9ZmSeJUDfYXTS/IahjzYkRLdfWQUft4VvnJyVi
	wrUtG0WEwQQZECbsosTY+ErZvENkuW0ZrU+bHSqrBqPvP+y5+Jbq6i1EH/AHlfpR
	ZhvyQqWyIZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DB01A7A9;
	Wed, 14 Nov 2012 12:58:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6316BA7A8; Wed, 14 Nov 2012
 12:58:29 -0500 (EST)
In-Reply-To: <871B6C10EBEFE342A772D1159D13208537AABCCA@umechphj.easf.csd.disa.mil> (Jason
 J. Pyeron's message of "Wed, 14 Nov 2012 17:21:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E56BB3A0-2E84-11E2-9079-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209734>

"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil> writes:

>> > Imagine the project creates a branch "magic" to enhance its system
>> > with magic words.  The description for the "magic" branch in the
>> > project may say "support magic words" or something.
>> >
>> > You and your friend are tasked to add a handful of magic words,
>> > e.g. "xyzzy", "frotz" and "nitfol".  You may start your work like so
>> > on your "magic-xyzzy" branch:
>> >
>> >     $ git clone git://example.com/zork.git/
>> >     $ git checkout -b magic-xyzzy -t origin/magic
>
> And here the branch description should copy from origin/magic.

I doubt it should.  The purpose of the "magic" branch at the remote
in my example were to "support magic words" (without limiting which
magic words the project wants to support) and that is what the
description over there may say, while the purpose of the local
"magic-xyzzy" branch you create in order to add the support for
"xyzzy" magic is just one small subtask of it.

That is what I meant by "the inherently local nature of the branches
and branch descriptions".  Git as a distributed system works well
exactly because what each repository has is inherently local, and
people can do whatever they want in their own repositories, while
allowing collaboration among participants by pulling and pushing
histories that share compatible (note: not necessarily "identical")
goals.  "support magic words" being a superset of "add xyzzy magic"
is an example of this principle.  They have different goals (and
that is why propagating the description of your "magic-xyzzy" to the
project global "magic" is a wrong thing to do), but from the point
of view of the project global "magic" branch, what your "magic-xyzzy"
branch wanted to do is compatible with its larger goal (and that is
why merging to "magic" from "magic-xyzzy" is a good thing, while
merging the other way is frowned upon in general).
