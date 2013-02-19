From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 14:30:11 +0530
Message-ID: <CALkWK0kdjKXAiOz6k-Anfb3Xut5apZbQ-rqYhkA73YRu83tLcw@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <20130218185801.GA25673@sigill.intra.peff.net> <CALkWK0kFYP4k5=237PZ3XHhxkzF-RWwwe=3+Thb_xU2Jw5tg2g@mail.gmail.com>
 <20130218211321.GD27308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
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
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:00:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7j4K-0003pE-QT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532Ab3BSJAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:00:32 -0500
Received: from mail-ia0-f179.google.com ([209.85.210.179]:55274 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab3BSJAb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 04:00:31 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so5832964iak.24
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 01:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uz9mmh7GQ1tUKB1G/zHMGUGQGaQzoZejuEPbkkgAL+k=;
        b=w4OL22qO1Ivf6wtPcGia4KV7WIndFS+eHgiIBX9qY5Eho8kE1nr6YT28sHOLBCtL1o
         q3ZKl7qGliLd9EO7k9kQ66tZhu8G+AWRDWBRwBws9nlNdvW/Cnn2NfXSDzfAcnpN6Ur5
         4EjDls6Q25a+uve96s8ILLGKGfkOLOyCe0gTVCzrZ3rZLakxBSp+mf0PvimHrE8Ka/VB
         X3C6l0SGu32STdQanZzssPQidINe1+gGAoyyzIV11ton9+akUNqGBycSZfzka5ix2DA6
         eLSskPrvxHUYr7f/g+wdm0XixpsBLnmeR+zkhmK6HDfTJGadGiA9UU6BM0vRw/iL/ACq
         GDIA==
X-Received: by 10.50.189.163 with SMTP id gj3mr8873808igc.14.1361264431191;
 Tue, 19 Feb 2013 01:00:31 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 01:00:11 -0800 (PST)
In-Reply-To: <20130218211321.GD27308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216578>

Jeff King wrote:
> On Tue, Feb 19, 2013 at 01:15:49AM +0530, Ramkumar Ramachandra wrote:
>
>> Take what I'm about to say with a pinch of salt, because I've never mentored.
>>
>> Mentors often don't provide much technical assistance: students should
>> just post to the list with queries, or ask on #git-devel.  Mentors
>> serve a different purpose; their primary responsibility, in my
>> opinion, is to teach the student a sustainable productive workflow.
>> This means: profiling them to figure out where they're losing out.  Do
>> they have the habit of:
>> - posting to the list regularly?
>> - CC'ing the right people?
>> - iterating quickly after reviews?
>> - using gdb efficiently to quickly understand parts?
>> - using git efficiently for the rebase/ patch workflow?
>
> I think you are spot-on. Those are the things that students need to
> learn to do, and what mentors should be pushing them towards. But it
> seems like we have the same problems with it year after year, and I know
> mentors have worked on it. I'm not sure where the problem is.

I essentially have a couple of suggestions:
- Be more thorough about discussing proposals; pick mentors from those
who are deeply involved in the discussion, and are interested in the
student.
- Increase the visibility of every GSoC project in the community.
Like I suggested earlier, a set of GSoC branches in-tree would be a
great start: it's easy to go through the `log`, and tell if the
student has been idle for a while.  We can put up links to the GitHub
graphs for each of these branches.

>> > I very much agree with you here. One problem is that those smaller
>> > projects often do not sound as grand or as interesting, and so students
>> > do not propose them. We have to work with the applicants we get.
>>
>> We have to post well-crafted proposals like this to pique their interest.
>
> True. I think we can bear some of the blame in the proposal writing. But
> if you look at the applications each year, they tend to cluster around
> one or two projects, and most projects get no hits at all. It could be
> because they're badly written. But I think it is also that they are not
> in areas that are as flashy (and the flashiness often correlates with
> complexity).

We need to collaborate on proposal writing, I think (which is why I
suggested one-thread-per-proposal in a different email).  In the past,
it has mostly been one person writing the entire thing.

>> There is one easy way to fight spam: don't expose a web-based editing
>> interface at all.  It's mainly going to be maintained by the
>> community, and we're all much more comfortable in our editors and git.
>> We can give the regulars direct commit access and ask the rest to
>> submit pull requests.  Make it cost pennies, so any of us can easily
>> afford it: just a cheap domain, DNS, and static HTML hosting.
>
> I'd be totally fine with that. You'd need to pick a static generator
> framework (I don't think it is a good idea for everybody to be writing
> raw html). I suspect kernel.org would be happy to host the static pages,
> but if not, GitHub can pick up the hosting tab (and we could probably do
> it as a subdomain under git-scm.com, too, if people want).

Ofcourse.  Nobody wants to write raw HTML.  Additionally, I'd love it
if we could post new posts via email, since we already have the habit
of writing emails.
