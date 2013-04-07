From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Sat, 06 Apr 2013 20:32:11 -0700
Message-ID: <7vy5cv818k.fsf@alter.siamese.dyndns.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 <20130402200948.GF2222@serenity.lan>
 <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
 <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
 <EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
 <CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
 <BA2657F2-708B-434E-87D2-D6371806E2D3@quendi.de>
 <7vd2u8bg7x.fsf@alter.siamese.dyndns.org>
 <CAMP44s1t=cTQiOoXdbdEKa3zLa+8pi+BUU1n1XOzo+-LqGHs2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	gitifyhg@googlegroups.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 05:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOgL4-0005ye-KY
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 05:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161572Ab3DGDcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 23:32:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161469Ab3DGDcN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 23:32:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30DCFF05E;
	Sun,  7 Apr 2013 03:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=clMheclmeJ2usfoxpqwz5XWjUCA=; b=uPM7ejKkXvljNAVPuiL9
	+dp0XRY7Zsz77IL+xfU3DoQzvpxJzXugy7r8QoFrd/p22ghbEHNltHtOpEF7/wmu
	jBexpfJ+ppgOduqFh7VGmd6IQGUJG6tIpnoibfc/RfDl3ixkafzJeAJtwy6nJTpw
	jz3iInn5xwXlpzaxMLVUQH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Ml3btn0RtYcNwucRljDC+0ULVkWkMxI9GoFawvJKoL3JIk
	lVgMrXypZdtJGkWRYeIUd7VTQKG42EbNMuFRIZc57faiemvfk2fdjemULIA+MjOV
	SqMxf05rg1WfTp5oMgfQcGUhWwd+VDFVwZENEZMT8KGrZww4vZtx62HEPkq6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 283EEF05D;
	Sun,  7 Apr 2013 03:32:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 896E0F05B; Sun,  7 Apr 2013
 03:32:12 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC5937CE-9F33-11E2-A6F3-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220277>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Apr 5, 2013 at 7:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> A tool that is in contrib/ follows the contrib/README rule.
>>
>> I do not maintain it. Maintenance is up to the person who asked to
>> include it there.  I do ask the people who propose to add something
>> in contrib/ to promise that they arrange it to be maintained.
>
> That's true, but I meant that you are the gatekeeper. Ultimately you
> decide which patches go in. If Max, or anybody else, wants a patch
> into contrib, you can get it in, even if I disagree with it.

In an ideal fantasy world, it could be true, but when I say "I do
not maintain it, and people who put it in contrib/ is responsible
for it", I really mean it.

I may find the behaviour/performance of the sub-maintainer of a part
in contrib/ unsatisfactory and have to take an administrative action
(e.g. to remove the problematic part out of contrib/), but I would
rather not to do that kind of thing, if possible.  Instead I expect
people who have any code in my tree (even in contrib/) to act as a
responsible adult, taking and responding to constructive criticisms
well, and more importantly, nudging those whose utterance you find
are mostly noise into raising a more concrete and actionable issues
that would be useful to you as an input.

> Either way, I think if things go well, remote-hg will prove it's worth
> and move out of contrib and into git's core.

That was what you promised when we started carrying it in contrib/;
I am still hoping to see it happen when it matures.
