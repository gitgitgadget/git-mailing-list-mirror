From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 23:31:53 -0800
Message-ID: <7v7gm492ty.fsf@alter.siamese.dyndns.org>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <7vip5p9rtm.fsf@alter.siamese.dyndns.org>
 <CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:32:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7hga-0001D7-PL
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 08:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756967Ab3BSHb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 02:31:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756846Ab3BSHb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 02:31:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22418A842;
	Tue, 19 Feb 2013 02:31:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UNfioMAJ+9JgtKtTlxzmfy5poSc=; b=XFxBoD
	pWTVFnvj5G+aANxrlT5xM48SK9d6LrVe5S5566ysXpKv+7k2NLRc42s5kLKntJ2T
	U7PUEMAzWxhzb/60pxektu9WQ74Fr+VEOPe1aLKqT5/zbWxAYI0xxWCIYgRKbyX6
	SUhkr4fdyDEJX5bTvHhW7VFbAd2XVRslsm44s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OHchPgKvra8TwVRYYLzhgtHfJQWLJMy5
	MK7HJxIZ4MH1Gk57ztFVwqidizqnOhRk5Nvazf/iT98FjWhrgmm0xsKZqL8AQZjw
	a3xTA5AROP0bICGMZ8GCSaj7TqocuOPTxFk/dmr5oGmBVvOttzZFzJJ/BtOC7RnD
	avXrTo6da4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 163D7A841;
	Tue, 19 Feb 2013 02:31:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FCD5A840; Tue, 19 Feb 2013
 02:31:54 -0500 (EST)
In-Reply-To: <CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 19 Feb 2013 12:38:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F337A82-7A66-11E2-81B7-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216571>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> I think the real issue is everybody in the GSoC mentor candidate
>> pool grossly underestimates the scope of suggested projects, does
>> not encourage students to send early drafts to the public from the
>> beginning, and perhaps overestimates the ability of total beginners.
>> After seeing my "index-thing is too big in scope" warning repeatedly
>> ignored for the last year's GSoC, I am not very hopeful unless the
>> attitude towards GSoC and its students drastically changes on our
>> mentors' end.
>
> The short undiplomatic version of that is that our mentors suck (I'm
> not pointing fingers, but that's what I infer from failing projects).

I was conflating between people who add "suggested project" and who
act as mentors.  I do not think mentors are primarily responsible
for bad suggested projects.

Our mentors may be wonderful but I do not have enough evidence to
judge either way.  They are mostly student-facing and I as a
bystander to GSoC process didn't see much of their involvement in
their students' work---maybe that is how it is supposed to work,
maybe not.  The only failing of them observable from my point of
view was that we repeatedly saw the initial round of patches come
very late.

But my complaints were primarily about those sure-to-fail project
suggestions.

> I propose that we have one thread for every proposal where we can all
> discuss the implementation outline- this will serve as authoritative
> source of information for students, and for picking mentors (the
> people who contribute most to the discussion).  Students should be
> matched with mentors on an individual basis.

You are being unreasonable and/or unrealistic. A topic that needs a
large discussion thread to pre-discuss design and outline by many
existing members of community and mentor candidates is a sure sign
that the topic is too big for a beginner. A topic that needs only a
small enough discussion thread on the other hand will come to a
polished conclusion before even the student shows up.  

This is exactly why I suggested "doable as a private, at most
two-weekend hack by an experienced" as a quick and dirty way to
measure the size of a project.
