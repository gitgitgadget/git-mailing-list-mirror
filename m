From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Wed, 28 Nov 2012 04:05:46 +0100
Message-ID: <CAMP44s23FfxQG6v+dfRGWHzxpWZ5BSGpAm=8Q8Bmj04tDwmwKw@mail.gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
	<7v4nkdxawx.fsf@alter.siamese.dyndns.org>
	<CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
	<7vehjelizc.fsf@alter.siamese.dyndns.org>
	<CAMP44s0swzsg1MkQHkPUtwZi71xaad3y4uY542jYvXAf8Ha5nQ@mail.gmail.com>
	<7vsj7ujxr2.fsf@alter.siamese.dyndns.org>
	<CAMP44s3t54zYFha_qsDrg0JDZ52q8=WTs7q0rJ9qZL8kVCVWKA@mail.gmail.com>
	<7vpq2yihaq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:06:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXyM-00067u-A5
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab2K1DFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:05:47 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38916 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab2K1DFq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:05:46 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so11627547obb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 19:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N5X0I9U0rwJdfdGNTgSIKfo4JqEGWHttnNz25EnjYrk=;
        b=l/fVHbT5Dn7UPhP7paCeJu5WXgKsGL8sTPCzQHFZN8qo+YhkCNIM9HozHyPtutT1MY
         ujZi3SNggrb0XwJXuW7sArkExIjdEHzPmFUUlQUSJbz21bwl/G9fb5t3/nf1TI7SoZLd
         cCZftD76zbfTwlKZnfdwXhPKudYZzVBTMGuu1kjSLjKN78CihDYMvUwVk63zDguVOikx
         YOwqrbNBcaL1X9a8pGtrWqVLy0Zf1vUy78RKdlpHKQFG/3wKoNugh8IUA6FOAJaUpC4L
         f4bPpFeQQKT8F7JeeN/bPoCi8cAu224ILU6rCvr/ejJaFSf3PIOV8s5b0AYu+Fpr+vLI
         LoGQ==
Received: by 10.60.31.6 with SMTP id w6mr14751620oeh.65.1354071946295; Tue, 27
 Nov 2012 19:05:46 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 19:05:46 -0800 (PST)
In-Reply-To: <7vpq2yihaq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210680>

On Wed, Nov 28, 2012 at 3:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> At this point, both have been cooking for a week or more in 'next',
>>> there is no existing users, they are on the fringe so breakages in
>>> them won't negatively affect anybody anyway.  So it doesn't matter
>>> much if they are merged to 'master' and then fixed up with follow up
>>> patches after that, or fixed up with follow up patches while they
>>> are in 'next', as they won't be rewound and restarted from scratch.
>>
>> The fixes are affecting some people, that's why I did them. Some were
>> reported here in the mailing list, and some in my github's clone:
>>
>> https://github.com/felipec/git/issues?page=1&state=closed
>
> Are you talking about -hg or -bzr or both?
>
> In any case, I am mostly concerned about *my* next release, whose
> rc0 will be tagged sometime this week or the next week.
>
> People who have been bitten by bugs from *your* tree or versions in
> 'next' do not count.  When I said "no existing users", I was talking
> about the end users who need rock solid stable "releases" because
> tagged versions are the only ones they use.

If users you call "fringe" have noticed these compatibility issues,
chances are your "existing users" are going to catch them as well.

Those issues were fixed right away, but I didn't sent them because I
wanted things to settle. I didn't see that v2 landed in next until
now.

> If the code of these topics is still in flux and needs constant
> fixes, probably it is a better idea to cook them longer in 'next',
> skipping the upcoming 1.8.1 release.  If we are going to go that
> route, we can drop the v2 fc/remote-bzr and queue v3 when we rewind
> the tip of 'next' after 1.8.1 release (by that time you may have v4
> of the series, but then we can skip v3).  Is that more preferrable
> than rushing these topics forward before they are ready for general
> audience?

They are not in constant flux, that's why I haven't send any new
re-rolls since v3, which was on November 11. I've been using v3 for
baseline since them, and the rest of the patches I've sent on top of
that.

In fact, these particular fixes were already sent on November 13 (on top of v3):
http://article.gmane.org/gmane.comp.version-control.git/209558

On November 10 Jeff threatened to to merge v2 to next on the "What's
cooking", and I told him I was about to sent a re-roll, he
acknowledged the same day, and I sent the next one.

Since v3 remote-bzr hasn't been on flux.

Now, what you do is up to you, but I think v3 plus the two patches I
sent on nov 13, and just resent today should be safe. That being said,
I don't use remote-bzr really, and I don't know how many people have
been using it, so I have no idea how ready it really is. If I were you
I would just merge v3 to next, or revert v2 and merge v3, and then
apply the two patches on top. Or if you want, revert v2, wait for
1.8.1, and then merge v3. Either way it's doubtful there will be a v4
(if there are next patches they will be on top of v3, as they have
been for quite some time now), so it's not clear what "existing users"
will gain by that.

I'm confident about remote-hg though.

Cheers.

-- 
Felipe Contreras
