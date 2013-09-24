From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] fetch: add missing documentation
Date: Tue, 24 Sep 2013 01:31:48 -0500
Message-ID: <CAMP44s23FMeZP=xum1X9bvHuKVo=j8O=8_8DVNgXq9F7Cpsr7A@mail.gmail.com>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
	<1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
	<20130924050343.GF2766@sigill.intra.peff.net>
	<CAMP44s1FFTS=wOcWBfqg3zt3TO-aM83oXHcGwBcwvt_HnXrn8g@mail.gmail.com>
	<20130924053023.GA5875@sigill.intra.peff.net>
	<CAMP44s1ezYMSuQRMp_SY1HqLiuyuf0tjuf3Fn6fXF2drODZ_iw@mail.gmail.com>
	<20130924054053.GA6192@sigill.intra.peff.net>
	<CAMP44s3QfkvXjgmhWPXN7qonbEPpvJFyVm82EBOMSjX7ng3OQg@mail.gmail.com>
	<20130924061043.GA6678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 08:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOMA6-0002Yn-5O
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 08:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754Ab3IXGbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 02:31:50 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:62858 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3IXGbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 02:31:49 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so3463906lbh.37
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 23:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yfc7jg/eM1NjFoW2RGKT2DvZ7yyLHEz7EAZ9STClNa0=;
        b=zG4xXICmi3Lld0eHljdhjBzh6R7AB1ZDiF0dR0pTEEdQjslIglA9kFOXC5hMdCyHhm
         YRp8plCtnc8X5SExS0M6uRmd1l8e0BJsN3UgmNmXaF7DyA+DOsXercQCTG+cHzo24WNm
         to94LSx7TjJKtaTNExcr7IxUlVg9/Jl5xfdIQmslOMKOMQokPPmzZ74/fnn363wtWDPA
         /LjVveM5XH+bFPVwTeBoyvZsKeOdjvM4+QJmYv82gaI7k2jCATTsyg/vUWZXaQ1azfxr
         GB9dw3NcoX2UWoyj4WQOid/gY1DmTYxIin5uhz53LDW2+KJs0Ik9BlMGq403YqbTho2+
         VcfQ==
X-Received: by 10.112.0.173 with SMTP id 13mr22893115lbf.8.1380004308462; Mon,
 23 Sep 2013 23:31:48 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 23:31:48 -0700 (PDT)
In-Reply-To: <20130924061043.GA6678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235274>

On Tue, Sep 24, 2013 at 1:10 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 24, 2013 at 12:57:36AM -0500, Felipe Contreras wrote:
>
>> No, I'm not. The users that know branch.*.remote exists know why it
>> exists. The part where it is explained, 'git config --help', is
>> perfectly clear: "When on branch <name>, it tells 'git fetch' and 'git
>> push' which remote to fetch from/push to.". So what does
>> branch.<name>.remote does, if not precisely what the documentation
>> says?
>>
>> This is not a rhetorical question, I'm actually expecting you to
>> answer, if a user knows that branch.<name>.remote exists, how would
>> the above confuse him?
>
> I do not know if by "above" you mean the part of git-config.1 you quoted
> above, or the text you are proposing to put into git-fetch.1.
>
> If the former, then I do not think it is confusing at all. The existing
> text explains exactly what is going on.
>
> If the latter, then my concern is that the term "upstream branch"
> implies implies that "git fetch" depends on branch.*.merge, but it does
> not.

That does not answer the question. The user knows branch.<name>.remote
exists, the user reads "When no remote is specified, by the default
the upstream branch configured for the current branch will be used",
how would that confuse him?

Since you are not able to answer, I will answer for you; the user
would not be confused, because the user knows the upstream tracking
branch is composed by branch.<name>.remote+merge, if the user doesn't
know that (very highly unlikely), the user can ignore the whole text,
and the concept of "upstream branch" (which any user familiar with
branch.<name>.remote would know anyway).

So, to this hypothetical non-existent user, such text would read "When
no remote is specified, by the default whaa-whaa-whaa will be used".
Doesn't matter what whaa-whaa-whaa is, the user knows
branch.<name>.remote will be used, because that's what the
documentation for branch.<name>.remote says.

But let's imagine an even more hypothetical user who does actually
wonder what would take priority, whaa-whaa-whaa, or
branch.<name>.remote. Well, clearly, if he hasn't specifically set
whaa-whaa-whaa, then his beloved branch.<name>.remote would be used,
but wait, there's more, he wonders if whaa-whaa-whaa is actually set
somehow, without him knowing, well then there are three options: 1)
whaa-whaa-whaa takes priority, 2) branch.<name>.remote takes priority
3) they are the same. Of these only 1) is a problem.

But this extremely extremely hypothetical user can just go ahead and
google "git upstream branch", and quickly find it indeed is
branch.<name>.remote+merge.

So... Where is the problem?

>> > I was hoping you might suggest something that can help both users by
>> > being both precise and giving the appropriate breadcrumbs.
>>
>> This is documentation for a Git porcelain command,
>> branch.<name>.remote is an implementation detail, and it's irrelevant
>> in the documentation at this level.
>
> I don't think it is the end of the world if we say "upstream branch". I
> was hoping to find a term that could be both friendly and accurate.
>
> And failing that, I hoped you might say "I see what you are saying, but
> I cannot think of a term that is more precise that does not sacrifice
> friendliness". But as I seem incapable of even communicating the issue
> to you, I'm giving up. It is not worth wasting more time on it.

And I was hoping you wouldn't use rhetorical warfare and label things
as "inaccurate", "imprecise", "breadcrumbs".

At this porcelain level, branch.<name>.remote does not exist, so
"upstream branch" is accurate. Period.

-- 
Felipe Contreras
