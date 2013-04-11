From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 14:40:40 -0700
Message-ID: <7vppy0hhk7.fsf@alter.siamese.dyndns.org>
References: <20130410202456.GF24177@sigill.intra.peff.net>
 <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net>
 <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com>
 <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com>
 <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
 <20130410215658.GC6215@sigill.intra.peff.net>
 <CALkWK0=Y-pO3+g21PLCWOxx+M-7fSmp2FedMBtZ68PWU_TOHDw@mail.gmail.com>
 <20130410222334.GC6930@sigill.intra.peff.net>
 <CALkWK0nvTisYCFjxwuGaBbWawwBahzeBHZ84rFkUYL8sjJuxvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 23:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQPEh-0004RN-2f
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 23:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab3DKVkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 17:40:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab3DKVkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 17:40:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F9A415698;
	Thu, 11 Apr 2013 21:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lM43sIMnoJ3NW82rLZ2SbpH1NBo=; b=A2Egow
	jTUNEVQpBbNwCRaGaIjhoXZYiaTTQy6KUlx4vMmvEV7zFgYt9UDO1CS6Xhz5fbHF
	s1Spr27ty0jHTN9UWrMS78GqSEy/uqMJLIrx2OGHmA7SOGcZmyTzddtUJ4igcMiO
	LLr/r88PW/OvNZRMxLg217rYy5NJQNd9HJ4l4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hC8lc28tMquOI6l5Jj2pQq58DyNPkKNI
	PdNiNF3DsWMV2r0H6NMD/+jIEL9Y/1MKvUHSj3ospmfbllq0ocNVwUiHetHs06Nv
	ApE60M99B4Sd4hzVHkAqfArf+lhEPKtWLbYE0KYcyiSvKvrJf8F2w1TV5aus8o2k
	M1X1KKCxfiI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65E3015697;
	Thu, 11 Apr 2013 21:40:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95A9015695; Thu, 11 Apr
 2013 21:40:41 +0000 (UTC)
In-Reply-To: <CALkWK0nvTisYCFjxwuGaBbWawwBahzeBHZ84rFkUYL8sjJuxvw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu, 11 Apr 2013 13:08:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 752C29E0-A2F0-11E2-8F76-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220933>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Let us imagine that origin points to git/git.git (upstream), ram
> points to artagnon/git.git and peff points to peff/git.git.  I fork
> off from upstream and have various local branches that only have
> corresponding refs in ram (say implicit-push).  Then, you fork off
> from me, and have various local branches that only have corresponding
> refs in peff (say implicit-push-next).  I have peff as a configured
> remote, because I routinely review the changes you make to my fork.
> In this case, I must have:
>
> - push.default set to anything but matching, because matching makes no
> sense in the multiple-remote scenario*.

The "matching" style makes sense only when pushing to your default
publishing repository, _and_ your work style is to finish working on
all branches that matter before pushing things out.  Instead of
keeping a configuration file on your local end that says "here are
the branches I want to publish", you let the remote side remember
them for you.

When pushing into other kinds of repositories (e.g. you can update
some but not all of the branches, or you want to touch only some of
them and not others even if you have enough privilege to update any
of them) or when you do not "batch" and push out one branch as work
on it is done, while other branches that you would eventually
publish are still not ready, "matching" is not for you.

> - remote.default set to origin, because this is where I get new code
> from for all branches.

OK.

> - remote.pushdefault set to ram, because this is where I publish all
> my refs to (whether branches or tags).  I might have local branches
> that I will never publish, but that's a separate issue.  The point is
> that all my tags will always be published here.

Makes sense.  The variable is to name such a publishing location.

> - branch.implicit-push.remote set to ram, because this is the correct
> upstream for the implicit-push branch.

If "implicit-push" branch at "ram" is updated by other people and
you may have to pull back from, you would need this for "git pull"
(without arguments) while on that branch, I guess.  But I got the
impression from your scenario that "ram" won't be updated by anybody
but you.

So I am guessing that this may not be needed.

> - branch.implicit-push-next.remote set to peff, because this is the
> correct upstream for the implicit-push-next branch.

Makes sense.  You are building on top of his work.

> - branch.implicit-push-next.pushremote set to null**, because I will
> never want to push this branch.

This becomes necessary only if you use push.default set to "current"
(or "upstream").  If you mistakenly say "git push" (no other
arguments), without this configuration you will end up pushing the
branch out.

With "matching", because "ram" would not have this branch (you
decided not to publish it), "git push" on this branch won't push it
out.

It may be that adding push.default=current-but-do-not-create-anew
could help.  It is a cross between 'matching' and 'current', to say
"consider pushing out the current one, but only when the other side
already has one", and may help people who do not "batch".

> (Note that branch.implicit-push.pushremote is unnecessary because
> remote.pushdefault takes care of that)

True.
