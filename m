From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: mergetool: support --tool-help option like difftool does
Date: Thu, 23 Aug 2012 10:39:14 -0700
Message-ID: <7vvcg94if1.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFAE1.3070304@gmail.com> <7vr4s2mnir.fsf@alter.siamese.dyndns.org>
 <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
 <7vzk5m41gk.fsf_-_@alter.siamese.dyndns.org>
 <CAJDDKr42YtfcpARQx6Vx8-Uy7KF3yEoGOQ0VzPKsWQA_hG=MgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 19:39:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4bNP-0000cc-08
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 19:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab2HWRjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 13:39:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32902 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134Ab2HWRjR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 13:39:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0DAE8D0F;
	Thu, 23 Aug 2012 13:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rHAKi/OWcUHkwdRwYQWfTL1V5Aw=; b=QFq7YM
	aTYUp6Dc1kZi/69WOPAIQEqt0wy0m9tjaTmHI1OmcvuMyxfEY1Yzf+XngKMnhBX2
	MUECloMDjtlBGpAX1USHigE60IiajIDUzAXPYOw82Igi4j4BvqcKKCVpxsX6JI6t
	B3zKQqniuK20Syzu5s5hdmjYEgOYSUJY6/8II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n++yQG/GYQ87Xl92TY1VNh8ODZwEB8JH
	A0+4oEafk8qSH5OpNOLEeADpKIsB3j0t0FnxNF3dUqzIeSskj5ZTyfqSWCqu6SZQ
	X/ln7+se7rUwOhAzWWZ1yET9yLPo5GRBaCd28Ik+iBYWvh6WW401cxXd/rQ7TzU5
	40KbtMA/fWQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB6538D0E;
	Thu, 23 Aug 2012 13:39:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AE588D0C; Thu, 23 Aug 2012
 13:39:16 -0400 (EDT)
In-Reply-To: <CAJDDKr42YtfcpARQx6Vx8-Uy7KF3yEoGOQ0VzPKsWQA_hG=MgA@mail.gmail.com> (David
 Aguilar's message of "Thu, 23 Aug 2012 00:39:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75CB9D02-ED49-11E1-BB81-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204159>

David Aguilar <davvid@gmail.com> writes:

>> After hinting a low-hanging-fruit that would be an easy way for new
>> people to dip their toes, I saw no takers for one month, so I ended
>> up doing it myself.
>
> My bad,...

Not yours.  These hints I drop from time to time are meant for eager
new people who want to dip their toes to the development (we don't
do "assignments" but these are the closest that we have); you no
longer quite qualify as "new" ;-)

> While on the mergetool topic...

Now we are not talking about "dip their toes" low hanging fruit
anymore ;-)

> Would the ability to resolve the various merge situations using
> the command-line be a wanted addition?
>
> This would let a submodule or deleted/modified encountering
> user do something like:
>
> $ git mergetool --theirs -- submodule
>
> ...and not have to remember the various git commands that it runs.

Does it have to run various git commands?  For a normal path, all it
needs to do is "git checkout --theirs $path", no?

What does it mean to resolve a conflicted merge of a gitlink to take
"theirs"?  We obviously would want to point the resolved gitlink at
the submodule commit their side wants in the resulting index but what,
if any, should we do to the submodule itself?

Stepping back a bit, if there is no conflict, and as a result of a
clean merge (this applies to the case where you check out another
branch that has different commit at the submodule path), if gitlink
changed to point at a different commit in the submodule, what should
happen?

If you start from a clean working tree, with your gitlink pointing
at the commit that matches HEAD in the submodule, and if the working
tree of the submodule does not have any local modification, it may
be ideal to check out the new commit in the submodule (are there
cases where "git checkout other_branch" in the superproject does not
want to touch the submodule working tree?).

There are cases where it is not possible; checking out the new
commit in the submodule working tree may not succeed due to local
modifications.  But is that kind of complication limited to the
merge resolution case?  Isn't it shared with normal "switching
branches" case as well?

If so, it could be that your "git mergetool --theirs -- submodule"
is working around a wrong problem, and the right solution may be to
make "git checkout --theirs -- $path" to always do an appropriate
thing regardless of what kind of object $path is, no?
