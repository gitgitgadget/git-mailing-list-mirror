From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 14:32:05 -0800
Message-ID: <7vip5p9rtm.fsf@alter.siamese.dyndns.org>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Feb 18 23:32:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ZGE-0001L0-FF
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 23:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252Ab3BRWcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 17:32:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757027Ab3BRWcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 17:32:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A435B14C;
	Mon, 18 Feb 2013 17:32:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V4RhfuTSUJ6ZjQD0Hz3sS1LSBqw=; b=hv+e0/
	gmNs4qDjv4foKRXYsLftKYSNMFbHaEShEhpRanatWMtAug2W4oSn/1hWRrD1PDu+
	eJ0vY+WL4vkHF3P9s9qInpNCI2AMaNLIe5FZG1n636DwcpzQ/ZoAgSmk1hVzdQQa
	qtj7M5qbhIQrxyLz8phsiP6iy4eNVYCYoEcUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ucfV7SvhgEUNARTxKwQ8i7ptYMMtrxcP
	0DSgGTkdY7AN9IFdPyY/fhVmkcs5dFU+5T02a82oo3oSTx1hsUJziYIk3TChVg0e
	rJPsMQo6u7QeFudR0HY1VvHijDx4TpcYRejBgzsjtb7R6hAW4gIYTtb7PImGaPag
	Lv2oFylGB7Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EC79B14A;
	Mon, 18 Feb 2013 17:32:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C512B148; Mon, 18 Feb 2013
 17:32:06 -0500 (EST)
In-Reply-To: <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 19 Feb 2013 00:14:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 067CC566-7A1B-11E2-9581-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216540>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> [corrected David Barr's email address]
>
> Jeff King wrote:
>> And I do not want to blame the students here (some of whom are on the cc
>> list :) ). They are certainly under no obligation to stick around after
>> GSoC ends, and I know they have many demands on their time. But I am
>> also thinking about what Git wants to get out of GSoC (and to my mind,
>> the most important thing is contributors).
>>
>> As far as merged code, I think part of the problem is that git is fairly
>> mature at this point. The most interesting projects are of a bigger
>> scope than a student with no experience in the code base can do in a
>> summer project. Maybe that means we need to do a better job of breaking
>> projects down into reasonably sized sub-components. Or maybe it means
>> the project is hitting a point of diminishing returns for GSoC. I don't
>> know.
>
> Also, we need more projects that will scratch everyday itches.  A
> collection of related tiny features might not be a bad idea.  Often,
> we risk erring on the side of too-big-for-one-summer when it comes to
> specifying projects.  What's the harm of including something estimated
> to take 80% of a summer?

I think the real issue is everybody in the GSoC mentor candidate
pool grossly underestimates the scope of suggested projects, does
not encourage students to send early drafts to the public from the
beginning, and perhaps overestimates the ability of total beginners.
After seeing my "index-thing is too big in scope" warning repeatedly
ignored for the last year's GSoC, I am not very hopeful unless the
attitude towards GSoC and its students drastically changes on our
mentors' end.

We have solicited "suggested projects" entries via wiki in the past,
letting anybody to put anything there, and I think that was a major
source of our past failures.  The practice lets irresponsive people
who think they know what they are talking about to place unrealistic
pie-in-the-sky there.  I wonder if we can somehow come up with a way
to limit them to realisitic ones in a sane way.  One possibility may
be to require the proposer to already have an 80% answer, not to be
shared with students.  A project that a GSoC student who is not
familiar with our codebase and culture (e.g. our no regressions
policy and requiring solid transition plan for disruptive changes)
is expected to finish in a summer should not be bigger than what a
mentor familiar with our project can do a rough outline design and
implementation as a two-weekend hack at most, I think.

Such a requirement on the proposer's end may be a reasonable sanity
check to make sure we do not suggest sure-to-fail projects to the
students.

It is ironic that I have to point out that the best "let's get
students exposed to the OSS process using Git community's reviewing
bandwidth" last year from my point of view happened outside the
GSoC.  Matthieu's school projects were not structured to the GSoC
standard (they assigned multiple students working together on each
topic), but the size of the projects seemed more manageable.  It was
a joy to work with these students during the term of the project. We
had a meaningful number of review iterations, unlike a typical GSoC
project where a student and her mentors sit in a dark cave for a
long time, send out the first draft too late, and the participant do
not get enough time to do meaningful iterations of reviews (it was
also a huge plus from our project's point of view that there were
even responsible post-program follow up to complete the unfinished
bits).
