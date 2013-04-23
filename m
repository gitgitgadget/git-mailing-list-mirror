From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 24 Apr 2013 00:19:26 +0530
Message-ID: <CALkWK0m05nWS=fQVCkFhNx7BT6_7qHN8W2WVW=6mGFeKKfN1Mw@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org> <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net> <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
 <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
 <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
 <CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
 <CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
 <CALkWK0krWM4kJ5GTnQ2SL7HoNfNMNA0-xdRVbeatAFpyKW_RtA@mail.gmail.com>
 <CAMP44s0KW4_Q6-d-3=M7GzWmHwy4H--FcemK4UF5FS0t3wnOgg@mail.gmail.com>
 <CALkWK0ncfuzuYSKjkT2uQy4dGR=TSnHoJNdhU9ownDUytysL6w@mail.gmail.com> <CAMP44s162msct=W0eV93LX15Bho=DA1baLZcgFCouSRH=z0mDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 20:50:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUiIA-0008Av-VS
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 20:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757204Ab3DWSuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 14:50:08 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:39147 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab3DWSuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 14:50:07 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so1096608iec.36
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9KJms+Z0s6XjklZIa/r27SDETNUANt28552ZcfRt6qc=;
        b=FizeXB1ZTrHcxcN3cV3e7YLFFKGaGzdvfa4f/TVlQYG4K0D6YcAOfNP13+Wwv5sFTA
         riShl91QynPMTX9ho6AhVQB/zMKF0Umn5dSJ5PzDUGkM4TC0Ic/kndjd/s0ywaUn+HOW
         yodOm45Qgs1XRIQ4hEewRIZf03reszrSFwsny/lqvXds1gVyzr3WV5VDCcCNqlPvAqsn
         Vh1ws/xAP1y1MHasysZWTuU5MNQEpKf0g8saeftFn3R2UIcUCgF6INUcw6nYLMIkoIyg
         ZJbAWAMg1hwp2kW4T9eJ6eq9MngzJxiw1K4NKQSKXNO6VkWLKjVl3j4oef2eukLWnvGm
         1gmQ==
X-Received: by 10.42.204.79 with SMTP id fl15mr16349566icb.57.1366743006671;
 Tue, 23 Apr 2013 11:50:06 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Tue, 23 Apr 2013 11:49:26 -0700 (PDT)
In-Reply-To: <CAMP44s162msct=W0eV93LX15Bho=DA1baLZcgFCouSRH=z0mDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222206>

[off-topic; what happened/happens to your series is entirely unrelated
to the issue]

Felipe Contreras wrote:
> Nobody knows how life began, and it doesn't matter now, what matters
> is how life evolves. It doesn't matter if the chicken was first, or
> the egg, what matters is that if all the chickens and eggs are gone,
> there won't be more.
>
> Plenty of projects have died because they stopped caring about their
> users, and without users there's no new developers, and the old
> developers eventually move on, and all the literary quality of commit
> messages have no eyes to see it.

I was a pure end-user of git until about Jan 2010.  I was initially
impressed with git because it behaved in a beautiful consistent
manner.  Then I dug in and found out that it had a beautiful codebase,
excellent mailing list (content and conventions), and large
development community.  I could literally read through the commit
messages and code with ease.  I do bounce between a few projects, but
always come back to git because nothing else fits the criterion.  What
I do not consider (as much as the other things) is the
number-of-end-users.

Then again, you would argue that I came across git only because of a
large enough user-base.  I agree with that, but you're practically
idolizing user-base as the most important thing.

My point is simple: yes, it's nice to have a big user base.  We
already do.  Now, what's the point of pitching to end-users who only
use the most basic functionality?  Their inputs are likely to be
useless (arising from misunderstandings) anyway.  They're not going to
be the next developers.  And they're not going to help create what our
next developer is looking for in us either (i.e. codebase, community).

Our primary customers are each other, because that's how we get a
tight community and great codebase.  And because the next potential
developer looks like one of us.

That does _not_ mean: live only within the community.  Everyone should
have a healthy interaction with the outside world, otherwise they risk
turning into researchers and suffering engineering myopia.  And
ofcourse not attract a large userbase.
