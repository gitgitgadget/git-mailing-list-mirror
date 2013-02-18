From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 01:15:49 +0530
Message-ID: <CALkWK0kFYP4k5=237PZ3XHhxkzF-RWwwe=3+Thb_xU2Jw5tg2g@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com> <20130218185801.GA25673@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Mon Feb 18 20:46:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Wfj-0002fn-Kg
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154Ab3BRTqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:46:13 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:60259 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab3BRTqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:46:11 -0500
Received: by mail-bk0-f43.google.com with SMTP id jm19so2756948bkc.30
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 11:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fkg7/GILZf34SWXKRfiDT3l7qa1OmhWapzY7vqDGiCo=;
        b=DN/8GjlYyNJlpmFEzwm1tUbOSzF9rVu7HeAMSFhr0LQqRynCjidlII/Y8vAgsZfck5
         e+wH101w3fqBxxGwZ4ORQYryoNfYUdv4wlyFQj4CzSA3zUbajo1c6SNZbcHmkBXLmap8
         /PSwr8dpQSlhpSnREmJ0nIVMOpF6WEKMe2NyHgQ055sQkrbfA9/mz0PZ3+tzHx4UL9R6
         NxmD2tkGn6NhBij6ErC/hMinB2wbh4AMy1rLZmFxfIP3Y7JlHQ48vwJlzbLjKFUIVR5q
         eaXQTgdFNKtBjvj9mJWb/qRfxTvNmJPaosieJHfUtCT2XmVM/mamx1hcBC6BcKJUeQLX
         Md2A==
X-Received: by 10.204.150.134 with SMTP id y6mr5294752bkv.15.1361216769675;
 Mon, 18 Feb 2013 11:46:09 -0800 (PST)
Received: by 10.205.81.202 with HTTP; Mon, 18 Feb 2013 11:45:49 -0800 (PST)
In-Reply-To: <20130218185801.GA25673@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216503>

Jeff King wrote:
> On Tue, Feb 19, 2013 at 12:14:19AM +0530, Ramkumar Ramachandra wrote:
>
>> I'll be frank here.  I think the main reason for a student to stick
>> around is to see more of his code hit `master`.  I think it is
>> absolutely essential to get students constantly post iteration after
>> iteration on the list. It would be nice to get them connected with 2~3
>> people in the community who will follow their progress and pitch in
>> everytime they post an iteration.  It might also make sense to stage
>> their work in the main tree (a gsoc/ namespace?), so we can just
>> checkout to their branch to demo what they've done.
>
> I agree. One of the main problems with GSoC projects is that the student
> goes away and works for a while, and then at the end does not
> necessarily have something mergeable. That is not how regular
> contributors work. They post works in progress, get feedback, and
> iterate on ideas. They break work into easily digestable and reviewable
> chunks.

> So maybe the mentors should be focusing more on that than on
> actual code problems.

Take what I'm about to say with a pinch of salt, because I've never mentored.

Mentors often don't provide much technical assistance: students should
just post to the list with queries, or ask on #git-devel.  Mentors
serve a different purpose; their primary responsibility, in my
opinion, is to teach the student a sustainable productive workflow.
This means: profiling them to figure out where they're losing out.  Do
they have the habit of:
- posting to the list regularly?
- CC'ing the right people?
- iterating quickly after reviews?
- using gdb efficiently to quickly understand parts?
- using git efficiently for the rebase/ patch workflow?

>> Also, we need more projects that will scratch everyday itches.  A
>> collection of related tiny features might not be a bad idea.  Often,
>> we risk erring on the side of too-big-for-one-summer when it comes to
>> specifying projects.  What's the harm of including something estimated
>> to take 80% of a summer?
>
> I very much agree with you here. One problem is that those smaller
> projects often do not sound as grand or as interesting, and so students
> do not propose them. We have to work with the applicants we get.

We have to post well-crafted proposals like this to pique their interest.

>> On a related note, I don't like our Wiki.  It's down half the time,
>> and it's very badly maintained.  I want to write content for our Wiki
>> from the comfort of my editor, with version control aiding me.  And I
>> can't stand archaic WikiText.
>
> Agreed on all of those points. Putting the Wiki on GitHub fixes that.
> But it means contributors need to have a GitHub account. On the other
> hand, I think kernel.org wiki contributors need an account these days?
> And GitHub is putting some active effort into finding and killing spammy
> accounts, which might keep wiki spam down (I do not pay too much
> attention to those efforts, but on kernel.org, it is mostly up to the
> Git community to do it ourselves).

No, I'm against using the GitHub Wiki for neutrality reasons.  There
is one easy way to fight spam: don't expose a web-based editing
interface at all.  It's mainly going to be maintained by the
community, and we're all much more comfortable in our editors and git.
 We can give the regulars direct commit access and ask the rest to
submit pull requests.  Make it cost pennies, so any of us can easily
afford it: just a cheap domain, DNS, and static HTML hosting.
