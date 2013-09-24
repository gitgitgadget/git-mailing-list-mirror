From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] fetch: add missing documentation
Date: Tue, 24 Sep 2013 02:41:37 -0500
Message-ID: <CAMP44s3potrCHyj8QYVfqBjsOqxh0xnuSfrK92enVWKND11CeA@mail.gmail.com>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
	<1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
	<20130924050343.GF2766@sigill.intra.peff.net>
	<CAMP44s1FFTS=wOcWBfqg3zt3TO-aM83oXHcGwBcwvt_HnXrn8g@mail.gmail.com>
	<20130924053023.GA5875@sigill.intra.peff.net>
	<CAMP44s1ezYMSuQRMp_SY1HqLiuyuf0tjuf3Fn6fXF2drODZ_iw@mail.gmail.com>
	<20130924054053.GA6192@sigill.intra.peff.net>
	<CAMP44s3QfkvXjgmhWPXN7qonbEPpvJFyVm82EBOMSjX7ng3OQg@mail.gmail.com>
	<20130924061043.GA6678@sigill.intra.peff.net>
	<CAMP44s23FMeZP=xum1X9bvHuKVo=j8O=8_8DVNgXq9F7Cpsr7A@mail.gmail.com>
	<20130924065454.GB7257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 09:41:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VONFf-00009K-E0
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 09:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749Ab3IXHlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 03:41:39 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:58580 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab3IXHlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 03:41:39 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so3614310lbi.29
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+amv4wUuGnMR1HkCGa1oMgiLQ/x6nwSz3G9h1XQAx9s=;
        b=lB7cugeFxcCljgZp02w6McgB7x378AugFYkeeDcHaFgL+S55pFXTxd5yUtCsYOo63i
         BqrOqM6+gnjwgnHzVObM23qjnNfycRvlrR/88fZqLyXBLDdQmRo+CFYpKmXmr+9/m5St
         mq2/B51sdk8kBauecAG09EzG2NhEnE0RvNpouRgfby+/PMXWFIq8drHR5nPEERoBPEP9
         Jn40Ivf2vx1Q+qymq7vPD9BBCwltMVy2czpLIsayLvZ5GjoLx7QHAsVH9DFz2j5I17W8
         MIGG/M1rlxTwniKg/9ohB7Bapk5DpQUL3IOpeMvsJTXbZWi0qJ4R0A52F98AN6YqDNKh
         v7gg==
X-Received: by 10.112.168.170 with SMTP id zx10mr23215675lbb.0.1380008497491;
 Tue, 24 Sep 2013 00:41:37 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Tue, 24 Sep 2013 00:41:37 -0700 (PDT)
In-Reply-To: <20130924065454.GB7257@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235281>

On Tue, Sep 24, 2013 at 1:54 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 24, 2013 at 01:31:48AM -0500, Felipe Contreras wrote:
>
>> > I don't think it is the end of the world if we say "upstream branch". I
>> > was hoping to find a term that could be both friendly and accurate.
>> >
>> > And failing that, I hoped you might say "I see what you are saying, but
>> > I cannot think of a term that is more precise that does not sacrifice
>> > friendliness". But as I seem incapable of even communicating the issue
>> > to you, I'm giving up. It is not worth wasting more time on it.
>>
>> And I was hoping you wouldn't use rhetorical warfare and label things
>> as "inaccurate", "imprecise", "breadcrumbs".
>
> FWIW, the term "breadcrumbs" was meant as a _good_ thing. I meant that
> you are using a term that will link the user to other concepts that use
> the same term (like "branch --set-upstream-to"), and that is something
> we would like to keep.

"breadcrumbs" implies it's not the full thing the user expects. While
in some cases it might indeed lead the user to further concepts, it's
also likely the user already knows what "upstream branch" means, in
which case it's not a "breadcrumb", it's the full meal.

It's as misleading as saying Atlas Shrugged is a light read, sure, it
might be to some people, but it's certainly not the case for
everybody, so saying so is not an actual fact.

> As for the others, I find your accusation of rhetorical warfare
> ridiculous. Insulting your patch with non-constructive insults would be
> rhetorical.

That actually wouldn't be rhetorical. If you say "I think this is
crap", that would simply be stating an opinion, and everyone would
understand that, saying "This is imprecise" is rhetorical, because you
convey an opinion as a fact, and it's actually much more damaging than
the former, because people wouldn't read it as an opinion, which is
precisely what rhetoric is about: persuation, rightly or not.

Even worst, you might believe it yourself.

> Saying "I think it has a flaw, here are my reasons, and I
> hope we can come up with a solution that does not have that flaw without
> weakening the other properties" is collaboration.

But you didn't say you *thought* there was a flaw, you said there was
a flaw, specifically, you said it was imprecise.

USA didn't say "Well, uhm, we think Iraq has weapons of mass
destruction", they said "Iraq has weapons of mass destruction, and
it's not a question of _if_ they are going to use them, but _when_".
These two statements cause a very different reaction from the
listener, thanks to the art of rhetoric.

> I do not know why you and I have so much trouble communicating on even
> basic things. I am willing to accept that it is entirely my fault. But
> that does not change the fact that I often find it a waste of time, and
> I plan to do less of it by ending my involvement in threads that seem to
> be unproductive.

I think it's very clear, you think your opinions are worth a hundred
times more than my opinions. Actually, it's even worst, you think your
opinions are facts. What kind of person challenges facts? only stupid
little brats on the Internet, or morons, right? But when two equals
have a difference of opinion, it's just that.

If you accepted that my opinion weighs as much has yours, and that
when we differ it might be you the one that is wrong, as much as it
might be me, things would go very differently.

>> At this porcelain level, branch.<name>.remote does not exist, so
>> "upstream branch" is accurate. Period.
>
> I do not agree with your first sentence at all.

> And your second one is purely rhetorical.

Exactly. You used rhetoric to convey your opinions as facts, so I used
it to the same effect.

> I can elaborate if you really care, but I have a feeling you do not.

If you are going to present your opinion as facts, then no, I do not care.

If you are going to explain why you *personally* *think* *in your
opinion* that branch.<name>.remote is a porcelain level concept,  then
sure, I would be interested in hearing why. But first I would like for
you do an exercise and find out where exactly does this high level
concept lands in the ProGit book.

-- 
Felipe Contreras
