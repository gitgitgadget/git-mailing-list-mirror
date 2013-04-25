From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 13:36:55 -0700
Message-ID: <7vip3a2vq0.fsf@alter.siamese.dyndns.org>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 22:37:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSuj-0004U7-6L
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130Ab3DYUhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:37:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087Ab3DYUg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:36:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7BCF19582;
	Thu, 25 Apr 2013 20:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WbW6Ka51Fg0jPcOcfKFbsYvPL9U=; b=dBBHzD
	svNN0H6GHkDTwGMlt+pDZkDgVzwvOmukVfpMHyu/4KjR4uC0AyCmtK2h+MNQFLDj
	rOitPpUW2fwZLDxvVLokPFZCU/jL3iW7dD0IXm3gbsvU+f/P8dtcSUuHpOF2hZhT
	nz+sO2tBF/LjPLxMxNpfWySGy0qg20AeoRcic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ieVG34jiKl1q0hbvUFsuHC+1w+zpxkGX
	VB30mP0Zvc/wOkeE5wWIe/RuJv9w7nAL4lTjVfE99WEsKos/loHXBXM3wno3sasN
	PdlO1VvQqmC9xTkoW3/H5Fv4r7oZHIVehzAvQACNgsukLTBlzGyKjhRElg/naqVG
	u2BtkYyxC7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B969F19580;
	Thu, 25 Apr 2013 20:36:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA89A19574;
	Thu, 25 Apr 2013 20:36:56 +0000 (UTC)
In-Reply-To: <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 14:20:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF499252-ADE7-11E2-8F98-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222444>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> But I do not care that much really. The patch is good either way, if
> you don't like it, you go ahead and fix it, because I won't. I have
> 174 remote-helper related patches in my queue, and nobody benefits
> from rambling about a one liner that is obviously correct, not you,
> not me, not the users, not the developers.

Three random points.

 * For this particular patch [1/9], especially because this would
   land close to the corresponding remote-hg fixes (e.g. "has_key is
   deprecated"), I think it is sufficient to say "port fixes from
   corresponding remote-hg patches" (you said it in 0/9 and didn't
   say it in 1/9, though) without going into individual details.
   Anybody who wonders what these changes were about will have a
   clue to check contemporary patches to remote-hg that way.

 * You may want to hold onto those 174 patches and polish their
   explanation up to save the list audiences' time by avoiding this
   kind of useless "why no explanation" exchanges.

 * If you do not want to keep a readable history, it would mean that
   nobody but you will fix problems discovered in the future in
   remote-hg, and there is no point carrying it in my tree for other
   Git developers to look at it.  The users are better off getting
   them from your tree and that will make it clear for them whom to
   ask help/fix for when they hit a snag.

> Junio of course might disagree and drop this patch, but then he would
> need to deal with the fallout of possible conflicts.

A much more sensible thing in such a case for me to do actually is
to drop the whole thing. I do not want to do that unless necessary.

> ... I think the less-than-perfect commit messages in a
> *contrib* script that is extremely recent is a small price to pay for
> having nice and workable bzr and mercurial remote-helpers as soon as
> possible

I do not share this view at all. The users survived without it long
enough; they can wait for a well maintained version.  On the other
hand, shipping something that will not be maintainable is not the
way to help end users. It is being irresponsive to them.

Helping other developers understand your code is a way to ensure
that your code that would help users will be kept maintained.  I do
not agree with Ram at all when he says that developers are more
important than users, and I agree with you that the project exists
for users, and not for developers.  But you need to help your fellow
developers anyway by spending effort to keep your history readable,
in order to help them help the users.

Do not take the "users matter" mantra to the extreme. You need other
developers to put users first.
