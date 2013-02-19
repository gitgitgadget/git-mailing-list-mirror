From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 12:38:51 +0530
Message-ID: <CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com> <7vip5p9rtm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7hKc-0006lh-18
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 08:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab3BSHJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 02:09:13 -0500
Received: from mail-ia0-f182.google.com ([209.85.210.182]:52025 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3BSHJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 02:09:13 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so5834728iag.27
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 23:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TQeA/tjoy+S6omdPfpyiDhjnheXZOO5xxd4NpXgBxOM=;
        b=xfF8ldYNbOKDcsmHzt2sYwiMBkWGN1bWNelEpJeSDRbHHHsYGk4GSWtGtyzyxFkgcp
         xN9QaaJkJ4nEeic53jFbQiCOBqtNXhKdqnuAnnP2IjutknJmiHb3hdEHglGiuMVgsIUS
         HwcIbs0DiwCFGw5crT76UaadBvFdjgC5lf4c7JIjBmzAD490leFxlXOXaqIkI0tbQTSV
         OnGnoS44t3gwqyMzUCNASvI51HkKWAqnhZvE0hPuu1zMYp6vQcaIq00hwd3xgdlPZdAC
         oV7VLxi6LHBxP0RA84lPScr8lTpXjP1TUYokEycwp98JBzHlrGesyCRIRm7KGc30gSWo
         WXwA==
X-Received: by 10.50.189.163 with SMTP id gj3mr8739529igc.14.1361257751461;
 Mon, 18 Feb 2013 23:09:11 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Mon, 18 Feb 2013 23:08:51 -0800 (PST)
In-Reply-To: <7vip5p9rtm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216567>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> [corrected David Barr's email address]
>>
>> Jeff King wrote:
>>> And I do not want to blame the students here (some of whom are on the cc
>>> list :) ). They are certainly under no obligation to stick around after
>>> GSoC ends, and I know they have many demands on their time. But I am
>>> also thinking about what Git wants to get out of GSoC (and to my mind,
>>> the most important thing is contributors).
>>>
>>> As far as merged code, I think part of the problem is that git is fairly
>>> mature at this point. The most interesting projects are of a bigger
>>> scope than a student with no experience in the code base can do in a
>>> summer project. Maybe that means we need to do a better job of breaking
>>> projects down into reasonably sized sub-components. Or maybe it means
>>> the project is hitting a point of diminishing returns for GSoC. I don't
>>> know.
>>
>> Also, we need more projects that will scratch everyday itches.  A
>> collection of related tiny features might not be a bad idea.  Often,
>> we risk erring on the side of too-big-for-one-summer when it comes to
>> specifying projects.  What's the harm of including something estimated
>> to take 80% of a summer?
>
> I think the real issue is everybody in the GSoC mentor candidate
> pool grossly underestimates the scope of suggested projects, does
> not encourage students to send early drafts to the public from the
> beginning, and perhaps overestimates the ability of total beginners.
> After seeing my "index-thing is too big in scope" warning repeatedly
> ignored for the last year's GSoC, I am not very hopeful unless the
> attitude towards GSoC and its students drastically changes on our
> mentors' end.

The short undiplomatic version of that is that our mentors suck (I'm
not pointing fingers, but that's what I infer from failing projects).
In my opinion, there is no point putting up proposed mentors for
projects in advance: ideal mentors are people who are interested in
the students, more than the project proposals.

> We have solicited "suggested projects" entries via wiki in the past,
> letting anybody to put anything there, and I think that was a major
> source of our past failures.  The practice lets irresponsive people
> who think they know what they are talking about to place unrealistic
> pie-in-the-sky there.  I wonder if we can somehow come up with a way
> to limit them to realisitic ones in a sane way.  One possibility may
> be to require the proposer to already have an 80% answer, not to be
> shared with students.  A project that a GSoC student who is not
> familiar with our codebase and culture (e.g. our no regressions
> policy and requiring solid transition plan for disruptive changes)
> is expected to finish in a summer should not be bigger than what a
> mentor familiar with our project can do a rough outline design and
> implementation as a two-weekend hack at most, I think.

The Wiki is often polluted with arbitrary, useless, unrealistic
projects.  We expect students to pick up from a small writeup on the
Wiki and come up with everything else, and I think this is a mistake.
Further, I think burdening one pre-chosen mentor with all the
groundwork is a terrible idea.

I propose that we have one thread for every proposal where we can all
discuss the implementation outline- this will serve as authoritative
source of information for students, and for picking mentors (the
people who contribute most to the discussion).  Students should be
matched with mentors on an individual basis.

> Such a requirement on the proposer's end may be a reasonable sanity
> check to make sure we do not suggest sure-to-fail projects to the
> students.

The discussion thread will automatically tell us which projects are
badly thought-out and unrealistic.
