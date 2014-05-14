From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Wed, 14 May 2014 13:59:19 -0700
Message-ID: <xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
	<1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
	<xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
	<536d4e7ba8ea_585ea5308a9@nysa.notmuch>
	<CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
	<xmqqsiodo7o6.fsf@gitster.dls.corp.google.com>
	<53726a577d6aa_4aa4b312f862@nysa.notmuch>
	<xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
	<CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
	<53729ccf26bb0_34aa9e53047f@nysa.notmuch>
	<CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
	<5373c56c5c531_56d6e3b30449@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 22:59:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgH1-0004sU-IO
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 22:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbaENU7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 16:59:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57504 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbaENU7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 16:59:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E0D818C9B;
	Wed, 14 May 2014 16:59:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ViRsNY2iqs/RwMUG4ViJ5s5PvY=; b=sZw8Rv
	3JbKQrDb0zjBwwPI50DiV3t5yzrr068zBbQUdrJiRbUoLiLE8r5ila/7pCN/OTKk
	1srCixwvlDi7ptkxmtzCdR9aihsTXCdsKLndPFl+OIs1YRuCpZUjttnl6V8VTZVg
	O2UnBBRV8LGcQcXCb6kP88zTfV4d1rSLwgjz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vyOEeyNP5yi+xCIV8IzgHPbQ/u9tij+q
	V4yXHoSjvxf8YTDN3skxDZYNuSpP5gZpO3UyXw8YyGtCaqvihYsgUw3dOrCgp3LI
	HlJjnNMDyJlIardnuHuLGMfXuiiPYKlywElSH95fQ+2F+5pPv/n2eFZQEaLKjbcX
	NzJTqnebo/4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EE0F18C99;
	Wed, 14 May 2014 16:59:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 333C818C76;
	Wed, 14 May 2014 16:59:21 -0400 (EDT)
In-Reply-To: <5373c56c5c531_56d6e3b30449@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 14 May 2014 14:35:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9F25EFD0-DBAA-11E3-9C3A-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248951>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Philippe Vaucher wrote:
>> >> I have had patches and contributions rejected in the past, sometimes
>> >> rudely. Same has happened to many others, if you contribute long
>> >> enough, it is pretty much guaranteed that it will happen to you.
>> >> Maintainer is wrong, or you are wrong, or someone is just having a bad
>> >> day.
>> >
>> > This is not about a couple of patches I worked in a weekend being
>> > rejected. This is about the work I've been doing since the past two
>> > years almost like a full-time job dropped to the floor with no
>> > explanation at all. I started with the expectation that they were going
>> > to move to the core, because Junio said so, then he changed his mind and
>> > didn't want to explain his reasoning.
>> >
>> > It's not just a bad day.
>> 
>> Here are two posts where Junio and Michael Haggerty explain the
>> reasoning to you:
>> 
>> - http://article.gmane.org/gmane.comp.version-control.git/248727
>> - http://article.gmane.org/gmane.comp.version-control.git/248693
>> 
>> Basically, in your case it boils down to your social manners.
>
> You are not paying attention at all.
>
> Junio did *not* use my social manners as a reason to block the
> graduation, nor the quality of the code, he used a *TECHNICAL* reason.
>
> Prior to his decision there were no complaints about my "manners" since
> I returned. It was his *TECHNICAL* decision that triggered this.
>
> Junio never explained his *TECHNICAL* reason, and Michael Haggerty
> simply said "there are good technical arguments for and against
> moving git-remote-hg out of contrib", that was all his explanation for
> the *TECHNICAL* reason.
>
> You, and other people, are using the behavior I displayed *AFTER* Junio
> made his *TECHNICAL* decision as the cause for his decision not to
> graduate. That's a wrong direction fallacy.

I am not interested in distinction between technical and social that
much.  The points that were raised in the thread started by John
Keeping, and some of the points that came to my mind while on that
thread, even though I may not have mentioned in *that* thread, that
affected the way *I* thought about the issue are these (not
exhaustive):

 - We may be painted in a hard place if remote-hg or remote-bzr take
   us to a position where the Git as a whole is blocked while it is
   incompatible with the other side.

   Maintaining it as an independent project (aka Unbundling) would
   eliminate that risk, instead of having to handwave and say "that
   risk does not exist".

 - A remote-helper has to depend on both sides.  Keeping it in
   either contrib/ or in core, as opposed to unbundling, may make
   things easier for the remote-helper maintainer, because at least
   it would allow the helper to advance with Git in lock-step (but I
   never heard that you do not prefer unbundling for this reason).

 - In a longer term, a properly maintained remote-helpers should
   work with wide varieties of Git and the remote system versions
   anyway, so unbundling would be logically the more "correct" thing
   to do.

 - Unbundling would make it less easier to use the remote-helpers
   for people who are used to keep up with my tree and pick them up
   from contrib/, but that is a tiny minority these days.  Most
   people use what distros package, and the distros that already
   package contrib/ remote-helpers will switch their upstream to
   unbundled repositories in order not to regress their packages for
   their users.

 - On the other hand, unbundling will make it easier for the the
   end-users (both the ones who are fed distro packaged versions and
   the ones who build from the source _and_ who overcome the "less
   easier because now they have to pull from not just me but from
   the unbundled places" inconvenience) to keep up with the
   leading/bleeding edge, because the remote-helpers do not have to
   freeze at the same time other parts of Git are frozen before the
   release, and users and distros can pick improved remote-helpers
   up and even "mix and match", when they have some other reason
   that prevents them from updating Git itself.

 - Unbundling would also involve the risk of making them obscure,
   and the original reason why we added contrib/ area to host
   "having something is often better than having nothing" tools,
   even if some of them were of lessor quality, was exactly that.
   While building the momentum and the Git community, it was
   necessary to have a nursery.  That reasoning no longer applies
   these days, and we have seen examples of third-party independent
   products that can improve the users' Git life flourishing.

   "We have less need for a nursery" is not a reason to kick bundled
   things out that want to be bundled, but it tells us that we no
   longer have to be afraid of unbundled things dying in obscurity,
   if there are other reasons that tell us unbundling is better.

I may be missing some others, and I would be lying if I did not at
all think of the "net liability" issue Michael brought up, but the
above that does not include anything you labelled as "social
manners" was more or less enough to convince me to say

    ... and I am inclined to be persuaded that the users of
    remote-hg/bzr may better off if they are unbundled from my tree.

in

    http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248242

That is not to say that I disagree with Michael and social issues do
not matter.
