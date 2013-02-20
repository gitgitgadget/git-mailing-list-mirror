From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Wed, 20 Feb 2013 13:07:15 +0100
Message-ID: <CAP8UFD01bUgUz1LST6DPjhQ4qsNEA4-ndpLQ97XqH_fOEdew9w@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<20130218174239.GB22832@sigill.intra.peff.net>
	<CAJo=hJvknVedGba5OxjjvZi2=JZyDuDoP2tD+LKQKdZNJ4NcsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 13:07:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U88Se-0007ML-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 13:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935162Ab3BTMHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 07:07:18 -0500
Received: from mail-ve0-f173.google.com ([209.85.128.173]:58804 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab3BTMHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 07:07:16 -0500
Received: by mail-ve0-f173.google.com with SMTP id oz10so6832811veb.18
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 04:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3vMWayLm2uNR2i3NAQhkw1OPK1/yZC0S9nk6Vd280U4=;
        b=WWj2qoo69NlvhzJezxsvqyZmNbGmzEb3zCQKM7eFXnc49b/xSYEurTIBfS6nmi/Xfl
         Ez5Ws+oKNfBA6YRr+rPZHCrZZ6KHnxJhRs5qGotfByLoZSIe9Ki+i5w8Wu7J8chidYnq
         wflEbPQgjcVTqmwEA1zNamFUYrZz4TywJIa+nqZYRHf4oPAMFF0wgLt1GkoOs0JODUDu
         eFJppwl6lVWpbiaXsE702/2IpnOSeHhqHZfaGFuyUVILGj9Nz3hA1pjYf0lHaIJcsAuY
         eLo0rGHL/3BPYOYl10DWy2EnrKQsO26nyh2HgOaaoFnAc/UxK7dCe9hW591he9CRVXrB
         dOtQ==
X-Received: by 10.52.90.243 with SMTP id bz19mr22037735vdb.112.1361362035370;
 Wed, 20 Feb 2013 04:07:15 -0800 (PST)
Received: by 10.58.251.244 with HTTP; Wed, 20 Feb 2013 04:07:15 -0800 (PST)
In-Reply-To: <CAJo=hJvknVedGba5OxjjvZi2=JZyDuDoP2tD+LKQKdZNJ4NcsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216703>

Hi,

On Wed, Feb 20, 2013 at 7:50 AM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Feb 18, 2013 at 9:42 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, Feb 18, 2013 at 06:23:01PM +0100, Thomas Rast wrote:
>>
>>> * We need an org admin.  AFAIK this was done by Peff and Shawn in
>>>   tandem last year.  Would you do it again?
>>
>> I will do it again, if people feel strongly about Git being a part of
>> it. However, I have gotten a little soured on the GSoC experience. Not
>> because of anything Google has done; it's a good idea, and I think they
>> do a fine of administering the program. But I have noticed that the work
>> that comes out of GSoC the last few years has quite often not been
>> merged, or not made a big impact in the codebase, and nor have the
>> participants necessarily stuck around.
>
> This.

I think it is ok if the code doesn't make a big impact in the code
base and it is ok too if the participants don't stuck around.
Of course I would love both of these things to happen, but we have to
be realistic and just stop expecting it.

> I actually think Git should take a year off from GSoC and not
> participate. Consequently I will not be volunteering as backup org
> admin.
>
> Git has been involved since 2007. In all of that time we have had very
> few student projects merge successfully into their upstream project
> (e.g. git.git, JGit or libgit2) before the end of GSoC. Even fewer
> students have stuck around and remained active contributors. When I
> look at the amount of effort we contributors put into GSoC, I think we
> are misusing our limited time and resources.

I don't think so, at least not for me. I feel happy to mentor or
co-mentor GSoC student and I don't think I would work much more on git
these days if git was not participating to the GSoC.

> The intention of the GSoC
> program is to grow new open source developers, and increase our
> community of contributors. Somehow I think Git is falling well short
> of its potential here. This is especially true if you compare Git's
> GSoC program to some other equally long-running GSoC programs.
>
>> And I do not want to blame the students here (some of whom are on the cc
>> list :) ). They are certainly under no obligation to stick around after
>> GSoC ends, and I know they have many demands on their time. But I am
>> also thinking about what Git wants to get out of GSoC (and to my mind,
>> the most important thing is contributors).
>
> I agree, our students have been pretty terrific. I think the
> shortcomings in our GSoC program are on the mentoring side. Our
> program has not really had much success with keeping students active
> and engaged post GSoC. I see that primarily as a mentoring failure.
> And its one we keep repeating each year.

I don't quite agree with this. My experience has been the following:

- 2008: the student I co-mentored did pretty well though he didn't
send to the list his patch series early enough.
So there was some mentoring failure, but anyway the student stuck
around for 9 months and managed to get 53 commits merged.

- 2009: if I remember well, it was decided to have only 2 GSoC student
that year, and that 5 people would co-mentor both of them together.
One of the student did nearly nothing. The other one sent his patch
series too late to the list. My opinion is that he relied too much on
the people mentoring him and he worked on something that was difficult
to merge.

- 2010: the student I co-mentored stopped working 3 weeks before the
mid-term evaluation despite some warnings from me and Peff, and he had
not been doing much a few weeks before that, so we decided to fail him
at the mid term evaluation.

- 2011: I was lucky to mentor Ram who did well and is still around.

So my opinion is that we have some students who are just not doing
enough (2 out of 5).
Then we have some good students, 2 out of 5 who could sometimes do
better if we insisted more on submitting earlier to the mailing list.
And we have a few students (1 out of 5) who work difficult to merge
projects and who could do better if we insisted more on submitting
earlier to the mailing list.

So my conclusions are:
- it's quite often going well or well enough
- when it's not going well often the student is responsible
- yes, we could improve mentoring by providing better projects and
insisting even more on submitting earlier

[...]

>>   - There is also the angle that even if _Git_ doesn't benefit directly
>>     from people sticking around, those people may float into other open
>>     source projects and work on them. Which makes the world a better
>>     place on the whole.
>
> Yes, sure, OK. But if Git doesn't participate in GSoC this year
> another org will, and this same benefit will still be had by the
> greater open source community.

The greater open source community benefits a lot these days when Git
is improved and get new contributors, as git is now by far the most
widely used version control system in the open source community.
So my opinion is that we should have has many GSoC student as we can
properly handle.

Best regards,
Christian.
