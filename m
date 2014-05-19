From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Mon, 19 May 2014 14:31:00 -0700
Message-ID: <xmqqha4lwj57.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<537693aee4fdd_3e4812032fcc@nysa.notmuch>
	<xmqq7g5i4r48.fsf@gitster.dls.corp.google.com>
	<53795c3e58f73_10da88d30829@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 19 23:31:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmV9M-0005rV-Hy
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 23:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbaESVbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 17:31:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53156 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbaESVbG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 17:31:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 202F719E4C;
	Mon, 19 May 2014 17:31:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LO+NJ3VqYZZ/CwTKGq5iHe3pCh8=; b=eWheL4INc5SOdBXPlNLx
	71H+IlDmz4NjE42Q2Kxq9cy0RQNhUKRIX7pzmk0GlesxXM6Qs7hs1W7/WBCEah3Z
	bYm6lCNknUt3hzmxTuwtHushBBLgF9tskTgrDbJNCYdMUjS9pUa+OPiGtkqO34Pm
	cE/ghNqfxO60Z/ZzyIM2GPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Hqd8YacCtoQ/7oxLaWiSzDdEon5+zJET/RrehavvBcPgZl
	c+fKzJufmySqYIlHfb0tETEKtG9GtUiAFK3MGaoEyRHtAMAKzKhkS3yc4jBQ3Tkm
	1+Czf+h73Zr1tWW/tmP7aFgWKtwjwtlQnp3CyGU/B2+gYcIXIGDuiXPwVFFoY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 169B419E4B;
	Mon, 19 May 2014 17:31:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D455D19E47;
	Mon, 19 May 2014 17:31:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E017DB3E-DF9C-11E3-98E9-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249624>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> 
>> After looking at the reverse-depends list of packages, my faith is
>> strengthened in that the Git ecosystem is truly maturing and useful
>> third-party plug-ins will be picked up by distro packagers.
>
> Where is git-imerge packaged?

I didn't see it on the archive the said Ubuntu box slurps from, but
I did not check all the other distros.

Michael, do you know what distro folks are doing with imerge?  For
the purpose of this thread, "I do not follow distros, and I do not
know" is a perfectly acceptable answer, but it would be very
relevant if your answer is "I suggested these distros to include it,
but so far they have been uncooperative and I haven't had much
success".

> Do you want to bet? Nah, you don't *ever* want to accept you were wrong,
> even you clearly where.
> ...
> This is what's going to happen: there won't be an official git-hg
> package for *years*, if there is ever one. That is my prediction based
> on all the available evidence, I am willing to stand by it and accept I
> was wrong if it proves otherwise.
>
> Are you willing to stand by your own decisions?

If I understand correctly, you have made and you do maintain some
packages and as an insider, you do not have to wait for "an
outsider" to step up to make remote-{hg,bzr} packages yourself.  You
may already have done so for your own use and told other people
about them, and others may have chosen to wait for you to push them
to distros instead of championing these tools by packaging them
themselves.

When you have such an influence on the outcome either way of your
choice, I do not see much value in such a bet.

I do know enough to agree with you that there may be no committee,
packagers may scratch their own itches, and a program that is not
very useful for the packagers, especially the ones useful only for
non-technical niche audiences, may fall through the cracks.

But I actually think that "we package what we want to use" is a good
thing for programs whose primary audience is the software developer
types.  The packagers are part of their audiences [*1*].  Because of
that, even if remote-{hg,bzr} do not get packaged for a long time, I
doubt that it tells us what you are stipulating.  The only thing we
can infer would be that these programs did not interest the software
developer types to motivate them enough, and we wouldn't know why
they found the programs uninteresting.  It may be because those who
have history in Hg prefer to interact with remote Git repositories
by pushing into and fetching from them using Hg tools than using Git
tools.  It would not indicate "useful tools fall through the cracks"
if it were the case, would it?

Indeed I saw bzr-git that came from the Bazaar land packaged on the
box I mentioned, and its description sounded like it is meant to
work in such a way that allows Bazaar commits to be pushed to Git
repositories using a bzr tool.

By the way, I also saw git-mediawiki packaged from contrib/ in our
tree.  I found it not very credible to say "contrib/ is treated as a
single ball of wax without much value by packagers, and we need to
move the helpers up to core in order for them to be used more
widely" after seeing that.


[Footnotes]

*1* I saw you called them "wolves" at least twice recently---where
    does such a distrust come from?
