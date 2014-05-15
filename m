From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Thu, 15 May 2014 15:56:42 -0700
Message-ID: <xmqq38gad51x.fsf@gitster.dls.corp.google.com>
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
	<xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
	<5373fc12bc5e4_7411589304eb@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:56:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4a4-0002OZ-7G
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbaEOW4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:56:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62438 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbaEOW4r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:56:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 876DE16CA4;
	Thu, 15 May 2014 18:56:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=q913ndiC8iJrZ3aMb1/ruIa6aVg=; b=AojplVLI1zZwESGtSYT3
	3/EOBqqEnjEYvJTZ8h1jEGX99Bvokonfwg2MUlZohkdTZEzHx5JHNWdcLmBbsBUh
	dTtL+OeoyQ3EqhMg/UnJv5Y2eQwHw6m4588bxNoYt55RXxRRwP0RBeOWDi80JhVV
	Lhrbddz7YQcaxHDUgWHS/Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ewyrl7RIYF8O2eYJ+Iow2pQ8Rfe14YwlkTuNPqgsxAEjEd
	l/Tmox+yS0h0HSpgz9asnf6nRd6DOFyNEUuGqgXpBG+9BAFUlt3tGv5xdIjwPu1o
	ag0eF4V+PFabKO2ueaYlZ22Ulw9SClTHY/ayHhRPto3ZeqayihHSAi+xBWBrk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CACC16CA3;
	Thu, 15 May 2014 18:56:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A6FA916CA0;
	Thu, 15 May 2014 18:56:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F338324-DC84-11E3-83A4-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249217>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> > Junio never explained his *TECHNICAL* reason, and Michael Haggerty
>> > simply said "there are good technical arguments for and against
>> > moving git-remote-hg out of contrib", that was all his explanation for
>> > the *TECHNICAL* reason.
>
>> I am not interested in distinction between technical and social that
>> much.  The points that were raised in the thread started by John
>> Keeping, and some of the points that came to my mind while on that
>> thread, even though I may not have mentioned in *that* thread, that
>> affected the way *I* thought about the issue are these (not
>> exhaustive):
>
> Let's be clear; the discussion in that thread was contrib vs. core. Most
> of the points you mention below are not related to that.
>
> == contrib vs. core ==
>
> This is the only point relevant to contrib vs. core:
> 
> >  - We may be painted in a hard place if remote-hg or remote-bzr take
> >    us to a position where the Git as a whole is blocked while it is
> >    incompatible with the other side.
>
> It will never happen. I already argued against it[1], multiple times.
> Essentially making the tests optional removes any possibility of
> blockage (pluse many more arguments).

I already said that your "It will never happen" is a handwaving, and
I already saw you "argued against it".  There is no point repeating
that exchange.  We both know, and bystanders with popcorns in their
hands also know, that we have different opinions.

You may have been interested in contrib/core in the thread, but that
does not prevent others from considering other aspects of the issue
and different and possibly better solutions, which was to unbundle.

I was very confident back in that thread that the remote Hg bridge
would not merely survive but would serve its users well as a
standalone project, and the level of confidence was actually a lot
higher than for a hypothetical case where other "already in-core"
bridges like git-svn/p4 are somehow forced to become standalone,
simply because of the difference in the depths of involvement of
respective area maintainers.  Without meaning any disrespect to Eric
or Pete, I think my prodding them (by forwarding issues and proposed
patches by others to them when I see them on the list) has been
helping the area maintainers who have other time and attention
obligations to help us, by drawing their attention and making their
workload smaller (they can only Ack and have me apply, instead of
maintaining a separate tree).  There is a greater risk for these
bridges to become unmaintained if we do not have them in my tree,
and that would only hurt our users.  In the ideal world, it may be
better if it weren't that way, but at the same time, new issues that
changing time brings to them seem to be handled more or less OK, so
we have to be content with the status quo.

But I did not see that particular risk at all for the remote Hg
bridge.  You have been very interested in maintaining it, and I
don't think I ever had to prod you to respond to an issue raised on
the list.  It is an apples-and-oranges comparison to bring up
git-svn/p4.

Besides, I want to see the "git-core has the best thing among
competing implementations for a specific niche subtask" perception
changed in the longer term so that it becomes natural for users to
say something like "For this particular task, there is no support in
what comes with core (or there is a tool that comes with core to
address similar issues but in a way different from what you want),
and the go-to tool these days for that kind of task is to use this
third-party plugin", because it is simply unrealistic to expect my
tree to forever be the be-all destination for everything.

Things like "git imerge" are helping us to go in that direction.  I
was hoping that the remote Hg bridge to be capable of becoming the
first demonstration to graduate out of contrib/ that shows the users
that is the case, not with just talk but with a specific example.

Anyway, the above is only within the discussion theme of John
Keeping's thread [*1*].  You seem to be adamant that you do not
consider other people's opinions that came in later threads you
started [*2*], and I do not think that is a sensible way to discuss
things.

After seeing these discussions, it tells me that the code is not fit
for the core (also [*3*]), and I think there no longer is any reason
for us to still talk only about contrib vs core.  As you already
said, you do not want to see them in contrib/, and as you already
saw, everybody other than you do not want to see them in core and
some of them do not want to even see them in contrib/ for that
matter.

I do not see that there is any direction other than out.


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248167
*2* http://thread.gmane.org/gmane.comp.version-control.git/248705
*3* http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248727
