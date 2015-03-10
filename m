From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Tue, 10 Mar 2015 00:45:41 -0700
Message-ID: <xmqqzj7l1eje.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 08:45:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVErN-00062u-Pz
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 08:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbbCJHpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 03:45:45 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751066AbbCJHpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 03:45:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0BD431E13;
	Tue, 10 Mar 2015 03:45:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lbETNJETy/bEEJhGHI30Q/VVVK8=; b=N4cyFd
	iDZWTpWyGlvP5sRsAIlSiye9d7ApYVR71LN+pfPF0lXclhaQ8jDLcReTx/NfBw4s
	jfC2XQe0F1ojwF48t6P3u1AnXR93jBiqfaAfTk56vwK1/QYwTV5kOM7SPD0fmMBO
	Ci5HZX99KNJQvUrViK/G/V5doTSVnQK5cD0PY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n5a92bAlwYkYngHm3Rd2odZ6mLU9vGNH
	oJ6TRRA9fSyUEOarQSPPkU/Xb0Ox5C5f7Ok7rWobfR9tkID5NEAPJkgBZkR9b6tt
	6L0X3N6jCJ33Reg8ghG3j8Xa4EkT37NcoEWWNIaGYTcCImDN9Uuh977IKVug7Dma
	GiKd1HdccXQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6AA231E12;
	Tue, 10 Mar 2015 03:45:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1884531E0E;
	Tue, 10 Mar 2015 03:45:43 -0400 (EDT)
In-Reply-To: <54FDA6B5.8050505@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 09 Mar 2015 14:57:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74784400-C6F9-11E4-A5F0-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265215>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I guess we have at least 3 kinds of people here:
>
> A) Paid to do Git development, at least as part of their job.
> B) Freelancers who don't get paid directly for "doing git" but hope to
> profit from their git efforts directly or indirectly.
> C) Doing it in their freetime (or as minor, inofficial part of their
> non-programming job).
>
> I'm in camp C and honestly wasn't aware of camp B until now.
>
> I consider camp A to be beneficial for all of us, and I don't think
> specific employer interests have pushed the project in specific
> directions, or specific features (OK, maybe one, but not as a rule).
>
> I do see that remuneration is an issue for camp B.

As one of the four things you are not supposed to talk about in a
polite society, it is indeed hard to talk about money.

Let me digress a bit before coming back to your 3 classes, because
money is hard not only for those who want to receive, but is also
hard for those who want to pay. I remember having a brief discussion
during one of the GitTogether meetings with this person who managed
Git users at his company. I think it was one of the chip makers
whose association with Git was through its involvement with Android,
but don't hold me to this, as I do not exactly remember. The
conversation started with "How do you get changes to Git?" and what
he ultimately wanted to learn was how a company can enhance Git to
make the life of his engineers easier by hiring some Git experts and
have them work on missing features.

As you can guess, the conversation did not get to a satisfactory and
clear "here is how you would go about it". Sure, a company can pay a
developer to do a feature, but it is impossible to predict if the
end result will be used by us. For a usual work for hire, the hiring
company can set the evaluation criteria itself, which would be that
the end result works with the given version of the base software and
produces desired result for the specific workflow the company
needs. But the evaluation criteria for a "contribution" to us is not
under the control of the paying company and the bar the person who
does the work for hire has to cross is different. It of course needs
to fill the needs of the sponsoring company, but also it needs to be
cleanly done, maintainable, and it must not harm workflows other
people employ, which the sponsoring company may not care about at
all. That makes it hard for companies to pay a developer to work on
Git to benefit themselves. It is the same deal for an enterprising
soul who would start a crowdfunding campaign "I'll add this feature
to Git---if you guys raise this much money".

This also makes the involvement of employers in category (A) a
nuanced one. Because money is not an effective currency to buy
"inclusion", "Paid to do Git development" does not equate
"Companies pay developers to develop Git in a way to benefit the
sponsoring companies". When it comes to working on Git, I, Shawn
or Jonathan do not get orders from Google management to add funky
features nobody outside Google would use to help Android [*1*],
and I doubt that Peff and Michael's job description are to push
GitHub specific enhancement into our codebase, either [*2*].

There are different schools of thought on how to support open source
development [*3*]. I heard some people dream of "free software tax"
and have public support our endeavor, just like public purse supports
academia. We do not live in such world. Some projects pay for bugs
with bounty program; I think that would be the closest thing to
support your category (B), and that form of support does not have to
be limited to bugs. Projects could buy features in addition to bugs.

But we are not structured that way, at least so far. If we start to
buy features, that would make it even more difficult than the "My
company wants to fund somebody to add features to Git---how do we go
about it?" case. How do we decide an effort was successful? Would
that decision be affected by the fact that we paid for it in the
first place (i.e. declaring a failure would mean we admit that we
made a mistake when approving to fund the effort)? When other
developers think that a feature we bought shouldn't have been bought
in the first place, what happens? How should conflicts in such
decisions be resolved? How would that payment affect people who are
in category (C), or category (A) for that matter? Faced with two
reasonable implementations by a bounty hunter and a hobbyist, does
it enter the equation that one costs and the other is free? Do we
pay everybody to sidestep that issue? Where does the money come
from? Do we want to become a project that employ some developers but
not others? Who makes hiring decision and how?

In short, I agree with you that we are not set up to support bounty
hunters very well. That might be something we want to change, but I
am not sure what the endgame would be, if I would like that endgame
when I see it, or what the first step to reach that endgame would
be. My gut feeling is that there can be many "reasonable" answers to
all the question marks in the previous paragraph, but I have a vague
apprehension that taken together the answers would lead to a community
that is rather uncomfortable to live in, for hobbists and aspiring
hackers who want to be a part of category (A) alike, but that is
merely a vague apprehension at this point.


[Footnote]

*1* We however do get inspirations by being in a company that uses
Git in a way that may be different from the outside world, noticing
pitfalls common to in-house users, their pain points, etc. But we
know enough to think about the issues to see if they are common with
the outside world before considering to tweak the public version of
Git.

*2* I started Git from its early days as a category (C) participant,
but in later years before I came to Google I was doing Git
effectively out of my pocket, as I was paid only for the non-Git
days and by that time Git maintainership has grown to consume about
half my time. I however do not think I would throw me during those
days in category (B) myself. To me, I was still (C) with reduced
income. As you would expect, eventually that arragement became
untenable. There was a company who benefited from having a healthy
open source ecosystem that are supported by Git in the wider world,
and appreciated that I was not driving the project into ground, and
it was fortunate that they wanted me to continue. That is how I came
to be in category (A).

*3* I personally feel that good open source developers should be
like court painters. They may paint their employer's children to
earn their keep even if they did not like doing so, but their output
eventually enriched the wider public. Their employers might have
been leeches who exploited serfs, just like evil corporations in the
modern day, and I understand those who oppose my simplistic world
view.
