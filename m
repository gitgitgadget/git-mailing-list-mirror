From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Make "git checkout" automatically update submodules?
Date: Fri, 23 Oct 2015 08:19:36 +0200
Message-ID: <CAP8UFD2cuZ=bonk49a39dDCrODH8uYUCWJ5-BT=gE1kkqcVA4Q@mail.gmail.com>
References: <loom.20151016T001449-848@post.gmane.org>
	<xmqq7fmnhg4x.fsf@gitster.mtv.corp.google.com>
	<loom.20151023T013752-72@post.gmane.org>
	<xmqq37x2qqzf.fsf@gitster.mtv.corp.google.com>
	<loom.20151023T044009-172@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kannan Goundan <kannan@cakoose.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 08:19:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpVhX-0006b8-0R
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 08:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbbJWGTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 02:19:39 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35975 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbJWGTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 02:19:38 -0400
Received: by lffz202 with SMTP id z202so72381101lff.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2015 23:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=40Zsu5UMijuN+cwiiI/7ldQxeVOXU1iOaXNze7Z+KTY=;
        b=NQIA6VAdrL72CF00BSAx6R1b1xjdFUEcq8jqRxCDGvm0soVd1e5L43D2w4sEheNW41
         wAa4Px2DEcYkVIdkwk3+Gw8uMZOLqy2jdDy8/7OAY4qpx8jZmNaEsfOwctwBp2i3L31B
         wEj1GF6ndQDvlODHjOx6f0C/vELRcD25hGRDFB3w5rFg1fZ0RJAp40XjnCwpk71kpVH5
         VyTijDvC+fM8FG2hJc4CSnY0/8tgvX8r6aIgngLngMXGI+H4RcJhQeJmihrS31xXcmVP
         rlWSvzvnXrWt4z0IFi32uxBlmfyzrPJtboe0cZTi/3JC7tOEa2B5odz3JHBe2RIqeFgg
         j4UA==
X-Received: by 10.112.158.1 with SMTP id wq1mr10203501lbb.67.1445581176572;
 Thu, 22 Oct 2015 23:19:36 -0700 (PDT)
Received: by 10.25.89.130 with HTTP; Thu, 22 Oct 2015 23:19:36 -0700 (PDT)
In-Reply-To: <loom.20151023T044009-172@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280085>

On Fri, Oct 23, 2015 at 5:46 AM, Kannan Goundan <kannan@cakoose.com> wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
>
>> We are unfortunately not set up to handle money well.  For a
>> background explanation, please go read [*1*], which I wrote my take
>> on "money" some time ago.  Note that it is an explanation and not a
>> justification.  It explains why we are not set up to handle money
>> well and what the issues around money that are troublesome for the
>> project are.  It does not mean to say that it is a good thing that
>> it is hard to buy feature with money from our project [*2*].
>
> I think the way I described it ("sponsoring a feature") doesn't really
> reflect how I was imagining it.  In my head, it looked like this:
>
> 1. Figure out whether the Git community and maintainers seem ok with the
> overall feature idea.  If not, give up.
> 2. Come up with a plan for the UI/UX; see if the Git community and
> maintainers seem ok with it.  If not, iterate or give up.
> 3. Implement it, then go through the regular process of getting it merged
> upstream.  If it doesn't go well, might have to iterate or give up.
>
> I could try doing that myself, but someone familiar with the Git
> codebase/community/history would be better at it (and probably be easier for
> you guys to work with :-)
>
> I guess I'm just wondering if there are people who meet those qualifications
> and are interested in going through those steps for pay.  Or maybe there's a
> company that does this, like the old Cygnus Solutions?

Well I am starting to do that for Booking.com. Not sure if it will
also be possible for me to work for you as I also work on IPFS
(http://ipfs.io) for the company that develops it, but we can discuss
it privately.

There was David Kastrup (dak at gnu.org) who previously said he could
be interested in such jobs. We wrote a very short article about it in
the first edition of Git Rev News last March:

http://git.github.io/rev_news/2015/03/25/edition-1/

We also wrote a very short article "Job Offer" article about
Booking.com looking for Git developers in Git Rev News in the third
edition last May:

http://git.github.io/rev_news/2015/05/13/edition-3/

so if you want we can write a similar "Job Offer" article in the next
Git Rev News edition.

You can even propose such an article yourself by editing the draft of
the next edition here:

https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-9.md

and then creating a pull request.

> In particular, I don't expect anything to change about the project's
> development process.
>
> (This part is not relevant to the Git project, but I understand that it's
> hard for anyone to guarantee a feature will make it into an open source
> project.  I imagine these kinds of contracts are set up so that you're
> primarily paying for the effort, not the outcome.  If it ends up not working
> out, you don't get your money back.)
