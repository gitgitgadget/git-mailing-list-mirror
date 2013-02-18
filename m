From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 20:45:32 +0100
Message-ID: <87fw0txv6r.fsf@pctrast.inf.ethz.ch>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<20130218174239.GB22832@sigill.intra.peff.net>
	<CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
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
X-From: git-owner@vger.kernel.org Mon Feb 18 20:46:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Wf2-0002IF-QL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757033Ab3BRTpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:45:36 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:25571 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756872Ab3BRTpg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:45:36 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 20:45:30 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 20:45:32 +0100
In-Reply-To: <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 19 Feb 2013 00:14:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216502>

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
> I'll be frank here.  I think the main reason for a student to stick
> around is to see more of his code hit `master`.  I think it is
> absolutely essential to get students constantly post iteration after
> iteration on the list. It would be nice to get them connected with 2~3
> people in the community who will follow their progress and pitch in
> everytime they post an iteration.  It might also make sense to stage
> their work in the main tree (a gsoc/ namespace?), so we can just
> checkout to their branch to demo what they've done.

I agree, but I think there's an additional component.  Consider the 'log
-L' feature.  It's fairly workable, and I merge it in my own builds and
use it, but there were and are two main issues:

* The initial work by Bo was not in shape to be included, mostly because
  the code was too convoluted in the parts that process line ranges.

* The last version I posted was held up because there's _in principle_ a
  better way to do things, but it requires major refactorings of
  existing code.

I'm not going to try to discuss away the first one; it's also a failure
of myself as mentor.  However, as far as incomplete work goes, I think
the latter item is fairly symptomatic.  We underestimate the amount of
work required to polish and reroll a submission that a student would
deem "sufficiently working for inclusion", fixes to be done later.

So I agree with your suggestion:

> What's the harm of including something estimated to take 80% of a
> summer?

Maybe even less than 80%.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
