From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Fri, 05 Apr 2013 18:28:02 -0700
Message-ID: <7vd2u8bg7x.fsf@alter.siamese.dyndns.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 <20130402200948.GF2222@serenity.lan>
 <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
 <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
 <EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
 <CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
 <BA2657F2-708B-434E-87D2-D6371806E2D3@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, gitifyhg@googlegroups.com
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:00:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWRi-0001b9-ED
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372Ab3DFB2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 21:28:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756293Ab3DFB2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 21:28:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C616610F8D;
	Sat,  6 Apr 2013 01:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oK/Ksnp+W6p67mtGOiMvSpVZVSI=; b=lGVCkg
	0CQMLUmK3LqpVHnqPtXt06qu2BZovRTEISzY6yl2Ap8CDeWxAKH8/33E2P4RNmFm
	FF41MC6nnVmC++PHHHNe8bOb2mNXrb9V3xMTSK7qehdqxgYyd/vvCcPsn1oN08zc
	ZchQLLk6j1DSZV6g32YijcA46r/yPTWRdsRkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IGHe3Z0lJvpvIU+x//H1aCQz1/YG/VNR
	064CuCNrlYBoJfoean28bVr1tMAWvL/dfRAIwizdlFdgBcE0FesRhWFBEYawhOtP
	/XHvjhgSzKB7ksXBpNi+EwSDYmAPu5xwUKi+USeSM0o6K74UWUb2A61TRXAniGUF
	+iEq2lnw8JQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCEF310F8C;
	Sat,  6 Apr 2013 01:28:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3144A10F83; Sat,  6 Apr
 2013 01:28:04 +0000 (UTC)
In-Reply-To: <BA2657F2-708B-434E-87D2-D6371806E2D3@quendi.de> (Max Horn's
 message of "Sat, 6 Apr 2013 00:30:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A4FE5B4-9E59-11E2-B405-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220178>

Max Horn <max@quendi.de> writes:

> OK, I'll try to keep a professional tone from now on :-).
>
> Please consider that the willingness of people to collaborate with
> you in any way is directly related to how you treat them. That
> includes bug reports. The way you acted towards Jed, who was very
> calmly and matter-of-factly explaining things, was IMHO completely
> inappropriate and unacceptable. Indeed, I should augment my list
> of reasons why people might not want to contribute to remote-hg by
> one major bullet point: You. And please, don't feel to compelled
> to tell us that Junio is really the maintainer of remote-hg and
> not you: Whether this is true or not doesn't matter for this
> point.

Only on this point, as the top-level maintainer.  I do not have any
opinion on technical merits between the two Hg gateways myself.

A tool that is in contrib/ follows the contrib/README rule.

I do not maintain it. Maintenance is up to the person who asked to
include it there.  I do ask the people who propose to add something
in contrib/ to promise that they arrange it to be maintained.

I do not even guarantee that they are the best in the breed in their
respective category. When something is added to contrib/, others can
raise objections by proposing alternatives, by arguing that tools of
the nature are better kept out of my tree, etc.  When remote-hg was
added, I didn't see specific objections against it.

There is one generic objection to adding anything new in contrib/ I
have myself, though.

In early days of Git, almost all users, who might be interested in
improving their Git experience by helping to polish third-party
tools, had clones of my tree and did not hesitate to come to this
list. Back then, having a copy of an emerging third-party tool in my
tree in contrib/ was a good way to give more exposure to it, and to
give those interested in it a place to meet and join forces to
improve it. Because Git population was small, almost everybody was
here, and it was an efficient distribution mechanism.

Git is now reasonably well known and has big enough user base, and
many users, even those who are inclined to help improving their Git
experience by contributing to third-party tools, do not necessarily
have a clone of my tree.  A third-party tool around Git, if it is
any good, is likely to have much much better chance to thrive as a
free-standing project with its own community, compared to those
early days.
