From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Thu, 05 Mar 2015 14:24:28 -0800
Message-ID: <xmqqlhjb13s3.fsf@gitster.dls.corp.google.com>
References: <20150224220923.GA23344@peff.net>
	<CAP8UFD27xaJU3QFuQZqADmh=ZseiN=Y1WCFPk4v4RzizK=2Xtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	git@sfconservancy.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTeC5-0001h5-5v
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 23:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbbCEWYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 17:24:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752423AbbCEWYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 17:24:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACF873EAD4;
	Thu,  5 Mar 2015 17:24:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJOPhWvUvvPQbTSAUKvwkgpgGB4=; b=SSRvGA
	kmpk2xfLJLKwaCSi43eHA8eA3F5aPO/HGyR9ikewUZtTLvqd1PMEUWHfm29zlPtR
	ZxrrB+29NKkyPUooHeKdV6T1Aw4eEIcKSmcxirMnqLIm+CknCcLZ+XZbv9vFGU4T
	hXPP9zcPUb5Url+IVEOP5g0jruH7AbBLcK3+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AtFWwcoA5dIY5jSzQs0Vd8Gw9mvOE/SD
	lxehZTO7jHXz3p7+PRqdKxsDJETntu9wY2e3Sr0JkxDEPCCKsRyu79hwdXqVXpo5
	+7tzzEQpiwNPY7FuVQYawmalxNUsPaX2V144buZynWzYVWX6rwrTf1dlT6zAg0mt
	EgdyJyv9CV0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2B4D3EAD3;
	Thu,  5 Mar 2015 17:24:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 209813EAD2;
	Thu,  5 Mar 2015 17:24:30 -0500 (EST)
In-Reply-To: <CAP8UFD27xaJU3QFuQZqADmh=ZseiN=Y1WCFPk4v4RzizK=2Xtg@mail.gmail.com>
	(Christian Couder's message of "Thu, 5 Mar 2015 21:53:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 642A36A6-C386-11E4-90C8-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264874>

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 24, 2015 at 11:09 PM, Jeff King <peff@peff.net> wrote:
>> I wanted to make one more announcement about this, since a few more
>> details have been posted at:
>>
>>   http://git-merge.com/
>>
>> since my last announcement. Specifically, I wanted to call attention to
>> the contributor's summit on the 8th. Basically, there will be a space
>> that can hold up to 50 people, it's open only to git (and JGit and
>> libgit2) devs, and there isn't a planned agenda. So I want to:
>>
>>   1. Encourage developers to come. You might meet some folks in person
>> ...
>>   2. Get people thinking about what they would like to talk about.  In
>> ...
>> If you are a git dev and want to come, please RSVP to Chris Kelly
>> <amateurhuman@github.com> who is organizing the event. If you would like
>> to come, but finances make it hard (either for travel, or for the
>> conference fee), please talk to me off-list, and we may be able to help.
>
> I'd like the Git project to set up a more organized way to pay back
> the travel costs and the conference fee to the developers who come.
> For example the Git project could say that it will at least pay back:
>
> - all the travel costs to the 5 most important Git developers who come and ask,
> - half the travel costs to the 5 next most important Git developers
> who come and ask,
> - all the conference fee to the 15 most important Git developers who
> come and ask,
>
> I think it could help developers decide to come, and it looks like
> enough funding could be available, thanks to GitHub and the GSoC
> money. What do you think?

I personally perfer things to be kept informal---it would keep
things simpler for everybody.  You do not have to wonder what you
should do when you think you are among the five most important
people and you also know your employer will pay for the conference
if you asked, for example.

It feels to me that the suggestion Peff gave in his announce to ask
privately for case-by-case arrangement strikes the balance much
better.

> Apart from that it's also possible to find ways to accommodate some
> developers for free, if they don't mind crashing in someone's spare
> room.
>
> So please don't hesitate to ask if you would like to come.

These five lines, by not explicitly saying something like "the first
2 people who ask can crash in Christian's spare bedroom", is doing
exactly the same thing as Peff did by saying "please talk to me
off-list", it seems to me at least.  Both keep things informal and
simple, and both arrange things on case-by-case basis as needed.

And I think that is better than setting a seemingly hard rules
upfront, and causing more problems unnecessarily (e.g. who decides
who are the 5 most important, for example?).
