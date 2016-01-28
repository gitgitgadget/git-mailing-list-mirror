From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Starting on a microproject for GSoC
Date: Thu, 28 Jan 2016 11:45:07 -0800
Message-ID: <xmqqio2dij3w.fsf@junio.mtv.corp.google.com>
References: <56A96380.3020308@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 20:46:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOsWE-0002PW-9R
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 20:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbcA1TqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 14:46:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966953AbcA1TpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 14:45:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 088113DB7A;
	Thu, 28 Jan 2016 14:45:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C38nIgvb2bVBaF39lcQyyYcYd9M=; b=gRPiRA
	fGScKyuErMQTzNnsVJo2UhbqoCELmDnGxdTDoGuBIFUHHBapSP5JKSxQT2U1CQ/B
	z5NqShR/aJwgejP+lRtllC1zMRRmWhiBnhMkxFexsxseJp2plzyDxkSmxpN9B6y8
	+t7V1RhY3/ETUPj+ESvRC4dW2DRAClFH5PQNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eL7Nt7b2hzCJsyV5D8nDxVvwiYS7y3sy
	1/UBWgwHEB9Cyc1+43KDB+YG0MKiN4AXNniVBt5JTUwB7sqa8wz+M1RViQrNbcOd
	NtIHa143vLNM8gOeHF1KgoNb55oay4VSVSRaf1GGERzgZm3S47ualTIY8iaJ3RiA
	7lTmDk93Dv8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F31A53DB79;
	Thu, 28 Jan 2016 14:45:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.88])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 513CF3DB76;
	Thu, 28 Jan 2016 14:45:08 -0500 (EST)
In-Reply-To: <56A96380.3020308@moritzneeb.de> (Moritz Neeb's message of "Thu,
	28 Jan 2016 01:40:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2CA85B8-C5F7-11E5-BD18-B4986AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285023>

Moritz Neeb <lists@moritzneeb.de> writes:

> the next Google Summer of Code is not too far away. I expect git to
> apply for it and hopefully have some student spots which in turn I plan
> to apply. It was recommended elsewhere and on this list as well, that it
> is beneficial to engage with the community early, that's why I am
> writing to you already now, before all this formal stuff has begun.

It is unknown if we are going to participate in GSoC this year.  One
question you must ask yourself first: will you still be interested
in hacking Git if we decide not to take GSoC students this year?

The GSoC microprojects are not about seeing who writes great code.
What we want to see primarily with them is how well candidates
interact with the community, responding to reviewers, showing
agreement or disagreement with received comments, making arguments
in a constructive way when opinions differ, updating their
submissions with suggested improvements in a timely matter to keep
the ball rolling, etc.  GSoC micros are primarily designed to be
small and can be finished within a short timeframe, but expected to
still have enough iterations with reviewers that candidates can use
as an opportunity to demonstrate how well they can work with the
community.

Suppose a candidate already tackled a micro, went through multiple
iterations with reviewers and came up with a polished solution.
When another candidate comes late and sends in a very similar
"answer" to the same micro, without meaningful interactions with the
reviewers and the community, the latter candidate would not be
demonstrating how good a "fit" s/he is in the community at all.

On the other hand, if the latter candidate approaches the same micro
somebody else attacked in a different way, s/he would have his or
her own interactions with the reviewers and would be demonstrating
his or her ability to work with us.

So in that sense, they are not "quiz" that has a single right
answer, and we do not necessarily have problems if multiple
candidates attack the same micro.

Now, if your answer to the "first" question is "No", then you might
want to avoid wasting your effort investing too early in preparing
for an event that may not happen.  You may want to stop reading here
and wait until GSoC micros are posted (if we decide to participate
this year, that is).

If the answer is "Yes", then welcome to the Git development
community ;-)

The purpose of GSoC micro I explained above also means that people
like you, who are interested in hacking Git, can start early and do
their own things to demonstrate that they can work well with our
community, which may give them a head start.  When they apply to be
a GSoC student (if we participate this year), we would already have
enough datapoint to convince ourselves that it would be a good idea
to pick them (even without them doing GSoC micro).

> The second task, to allow "-" as a short-hand for "@{-1}" in more
> places seems to be still open for reset, although someone almost
> finished it (cf. $gmane/265417). I suppose just fixing/revising
> this would be kind of a too low hanging fruit?  More interesting
> (also because I am a bit earlier) might be to unify everything, as
> suggested by Junio in $gmane/265260. Or implementing it for
> another branch command, e.g. rebase.

This actually is a very tricky one to do well.

> If all of that is considered as not relevant, I might just go for
> a newer idea, like converting strbuf_getline_lf() callers to
> strbuf_getline(), as suggested in $gmane/284104.

It is a good sign that you are familiar with a recent list
discussion.  There are other "once this topic settles, we would
probably want to do this and that kind of cleanups on top" left
behind that haven't made my "leftover bits" page (which I update
only after the discussion dies on the list and there is no sign that
others will be picking them up soonish).

Have fun.
