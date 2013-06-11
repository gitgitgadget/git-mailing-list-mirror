From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 10:00:56 -0700
Message-ID: <7v38sod1kn.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:01:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmRwd-0004Xr-Qm
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324Ab3FKRBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:01:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199Ab3FKRA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:00:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA2B824722;
	Tue, 11 Jun 2013 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=8o0DAtKfwSDjU6jCiD3sSC38piE=; b=uywd2cET5aijXiyUcbWS
	LxHZy3q2NQ0SoVUQQ8n5Tm5aTLuNInga/asW0Ks33u/YF7lz02Gyl7wBRdI+RXKR
	Lh7A0JZcMNvVT0LAVpj7L6lz94QWPiiRYcOMP8JPbLZue/mFVOSJfR75UiAeVZVM
	L9mV8035WkN7Owp8ger8eVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=UyPAyMpdMopQrKGBA4vBikNMOiJELaTPwNiZjEm1bzPq6v
	O8txMNdaFoj1f8z3c06ztmiTCyaunGOuFrfj6TzbHNlSygxQLyzc05FAlo0FR7tk
	Tcd2XNSqj1s6deDE996rx7U/gHAqqu2HrvHHGKNYQJwFPUqWHBmko1tc9TSbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE6EA24721;
	Tue, 11 Jun 2013 17:00:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 426AD2471F;
	Tue, 11 Jun 2013 17:00:58 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CB85D4E-D2B8-11E2-94CF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227463>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I would prefer a community standards document that looks more like this:

OK.

> * Accept reviewers' comments gratefully and take them very seriously.
> Show that you appreciate the help by giving the reviewer the benefit of
> the doubt.  If, after careful consideration, you find that you cannot
> agree with a reviewer's suggestion, explain your reasoning carefully
> without taking or giving offense, and seek compromise.

In short, the only acceptable response to review comments are "You
are right. Here is a reroll", or "I think your suggestion will miss
these cases which I wanted to cover and that is why I did it this
way". There may be other small variants of the above two, but I
think I can agree with the general principle.

In cases, there are two or more equally valid approaches to solving
a problem.  I do not think I had to accept (or reject) many "it can
be done better in different ways and this perhaps is not the best
one" (or "it could be argued that it is correct") borderline topics
in the recent past, but I suspect that "a disagreement is healthy"
has to be accompanied by how disagreements that do not resolve
themselves are resolved (I think I've heard somewhere that some
communities break ties in favor of reviewers, for example).

> * When reviewing other peoples' code, be tactful and constructive.  Set
> high expectations, but do what you can to help the submitter achieve
> them.  Don't demand changes based only on your personal preferences.
> Don't let the perfect be the enemy of the good.

I think this is 30% aimed at me (as I think I do about that much of
the reviews around here).  I fully agree with most of them, but the
last sentence is a bit too fuzzy to be a practically useful
guideline.  Somebody's bare minimum is somebody else's perfection.
An unqualified "perfect is the enemy of good" is often incorrectly
used to justify "It works for me." and "There already are other
codepaths that do it in the same wrong way.", both of which make
things _worse_ for the long term project health.

> * It is not OK to use these guidelines as a stick with which to beat
> supposed violators.  However, if you genuinely feel that another
> community member is routinely behaving in ways that are detrimental to
> the community, it might help to calmly express your concerns to that
> person, preferably in a private email, and naming concrete and specific
> incidents rather than broad generalizations.

I would think it is perfectly OK to say "The way you are refusing to
listen to constructive comments is not how things work around here"
by pointing at a set of guidelines.

Why do you think is it not OK?  The "beating" part?
