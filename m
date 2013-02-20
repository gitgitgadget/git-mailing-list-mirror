From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 22:50:26 -0800
Message-ID: <CAJo=hJvknVedGba5OxjjvZi2=JZyDuDoP2tD+LKQKdZNJ4NcsA@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 07:51:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U83WR-0001Py-Oi
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 07:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453Ab3BTGut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 01:50:49 -0500
Received: from mail-ia0-f181.google.com ([209.85.210.181]:54648 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab3BTGus (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 01:50:48 -0500
Received: by mail-ia0-f181.google.com with SMTP id e16so6480345iaa.40
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 22:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KbH/7eE5wEXYc2HOhO9odJhZ7FCyNOxXcihr3uBDfsg=;
        b=Y67vaOUepUTeWKq6PyaT9HrWbBMJKpT6yhZOSvyIcj7X8k+RhlKLHNCcru3Nar0MAj
         kBdIUaQWy+yQL3CMR8ksvyTF3yTY2yne6DoBZRO3gEDLNutJbfFJlLRM4zNrN0P2i7By
         GhBAj2ixXGM/P3CBFZ8XW5IXJaMr5Hv86PNiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=KbH/7eE5wEXYc2HOhO9odJhZ7FCyNOxXcihr3uBDfsg=;
        b=dVBFwLt57rcaVF6oUBmAsK/B7/Rb4iB2zMbwrIqMFyRXCvna8DW/IoExCcPCeZ5TTQ
         U7m1+ewzHuysISV+1mazrAaVMpsM5ELmDpZUvn6bW7ZI8/+ozPLqgM0owpWNe8tjMYFk
         vFwSK12F2O+eRE7vFAtdu4SaT2Z6dyPEXN6RqlSlTqDVqZexnQzLcNQ3DIaDqDmG2F2C
         XHv4hPAUXuJvxb1eIXU0HDh9JcEnOmIKFcMAcfgfs4i6VgVlr8tatnJdSnhRrOVZJlt+
         ZqQsNDk5/9VPF3qcCZnsu4TZ43F+x0pKLLbwTwVHf/UJcOQ/mSfK9Fo5rgK58765mtow
         BKAA==
X-Received: by 10.50.195.134 with SMTP id ie6mr9604786igc.6.1361343048235;
 Tue, 19 Feb 2013 22:50:48 -0800 (PST)
Received: by 10.64.89.99 with HTTP; Tue, 19 Feb 2013 22:50:26 -0800 (PST)
In-Reply-To: <20130218174239.GB22832@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQl4ojrUZuFkMofIy9UJcviXzg66x5rA6dJ1xyuBF6pudbHRm9rAN0DmSFzK+26cAVzFsNl4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216683>

On Mon, Feb 18, 2013 at 9:42 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 18, 2013 at 06:23:01PM +0100, Thomas Rast wrote:
>
>> * We need an org admin.  AFAIK this was done by Peff and Shawn in
>>   tandem last year.  Would you do it again?
>
> I will do it again, if people feel strongly about Git being a part of
> it. However, I have gotten a little soured on the GSoC experience. Not
> because of anything Google has done; it's a good idea, and I think they
> do a fine of administering the program. But I have noticed that the work
> that comes out of GSoC the last few years has quite often not been
> merged, or not made a big impact in the codebase, and nor have the
> participants necessarily stuck around.

This.

I actually think Git should take a year off from GSoC and not
participate. Consequently I will not be volunteering as backup org
admin.

Git has been involved since 2007. In all of that time we have had very
few student projects merge successfully into their upstream project
(e.g. git.git, JGit or libgit2) before the end of GSoC. Even fewer
students have stuck around and remained active contributors. When I
look at the amount of effort we contributors put into GSoC, I think we
are misusing our limited time and resources. The intention of the GSoC
program is to grow new open source developers, and increase our
community of contributors. Somehow I think Git is falling well short
of its potential here. This is especially true if you compare Git's
GSoC program to some other equally long-running GSoC programs.

> And I do not want to blame the students here (some of whom are on the cc
> list :) ). They are certainly under no obligation to stick around after
> GSoC ends, and I know they have many demands on their time. But I am
> also thinking about what Git wants to get out of GSoC (and to my mind,
> the most important thing is contributors).

I agree, our students have been pretty terrific. I think the
shortcomings in our GSoC program are on the mentoring side. Our
program has not really had much success with keeping students active
and engaged post GSoC. I see that primarily as a mentoring failure.
And its one we keep repeating each year.

> As far as merged code, I think part of the problem is that git is fairly
> mature at this point. The most interesting projects are of a bigger
> scope than a student with no experience in the code base can do in a
> summer project. Maybe that means we need to do a better job of breaking
> projects down into reasonably sized sub-components. Or maybe it means
> the project is hitting a point of diminishing returns for GSoC. I don't
> know.

Let me repeat myself. I think our GSoC program has plenty of room for
improvement on the mentoring side. Project scope and size is one of
our most common failure modes. Resumable clone keeps winding up on the
GSoC project idea list. Nobody who knows what they are talking about
has any idea how to approach this feature[1]. Suggesting it to a GSoC
student is just irresponsible[2].

I don't think Git's maturity is a road block for successful GSoC
projects. Peff's toy to insert Lua so `git log` could do fancy
formatting is an interesting one. I suspect there are still fun
archeology sorts of projects that could further improve the type of
data we can mine through log and blame. But touching the core file
formats on disk or the wire protocol is probably far too large for a
GSoC project.

[1] Android's "repo" tool and its /clone.bundle hack on HTTP
transports might work. Peff has talked about putting this into Git
itself one day. Maybe. But its still full of a ton of shortcomings and
somewhat hated by those that have to build the bundles and manage the
server infrastructure. So its probably still outside of the scope of a
successful GSoC project.

[2] I recognize and accept my share of blame for putting it on the
list a few times.

> There are a few counterpoints I can think of:
>
>   - Even though not all projects are winners, _some_ are. I see Carlos
>     and Ram on the cc list, two people who started as GSoC students and
>     stuck around.

I think these interesting cases like Carlos and Ram are places where
the student was able to succeed almost despite our mentoring program.
I am very glad they did.

>   - There is also the angle that even if _Git_ doesn't benefit directly
>     from people sticking around, those people may float into other open
>     source projects and work on them. Which makes the world a better
>     place on the whole.

Yes, sure, OK. But if Git doesn't participate in GSoC this year
another org will, and this same benefit will still be had by the
greater open source community.
