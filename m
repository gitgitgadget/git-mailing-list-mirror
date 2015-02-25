From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [msysGit] Re: [RFH] GSoC 2015 application
Date: Wed, 25 Feb 2015 10:25:47 +0100
Message-ID: <54ED951B.8020105@drmicha.warpmail.net>
References: <20150218191417.GA7767@peff.net>	<20150218193234.GA8298@peff.net>	<5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>	<vpqioerz03s.fsf@anie.imag.fr>	<CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>	<c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org>	<vpqh9uavp6q.fsf@anie.imag.fr> <CAGZ79kbcoN=-Byu8fPV9_9ZpFhsuZ=5U=V-Xif_30s-J8OWfJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQYEC-0002pV-4r
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 10:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbbBYJZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 04:25:53 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60934 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751590AbbBYJZu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2015 04:25:50 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 43F5720CE1
	for <git@vger.kernel.org>; Wed, 25 Feb 2015 04:25:49 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 25 Feb 2015 04:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=UshKywxm4BEq+jtrcW0RUK
	Is4mg=; b=Wrq35SztqT3frJJMtjPkqpy0+L/l/TJ5yKuMZ+lmjPXL9/DeXxBZhM
	j9nCWA+yuF+qyA72U8AjIRhi4bwQnqcorRKsIXV5WFWCqHyqMGQEQW2PF5a0Rh2d
	cpSxTI8gj1WqNGnm4j86ZGqEasNdsoNSPZ50kqsG4yEBo46k3FppU=
X-Sasl-enc: GK/0onKnikA3hy7j90TnuQUY1QtL3Wg6u4dhH6WsdNA5 1424856349
Received: from localhost.localdomain (unknown [188.96.93.179])
	by mail.messagingengine.com (Postfix) with ESMTPA id 50C13C002A7;
	Wed, 25 Feb 2015 04:25:48 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAGZ79kbcoN=-Byu8fPV9_9ZpFhsuZ=5U=V-Xif_30s-J8OWfJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264371>

Stefan Beller venit, vidit, dixit 25.02.2015 01:34:
> On Tue, Feb 24, 2015 at 3:56 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> Hi Junio,
>>>
>>> On 2015-02-24 19:25, Junio C Hamano wrote:
>>>> On Tue, Feb 24, 2015 at 9:32 AM, Matthieu Moy
>>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>>> About the proposal:
>>>>>
>>>>>   The idea of this project is to dive into the Git source code and
>>>>>   convert, say, git-add--interactive.perl and/or git stash into proper C
>>>>>   code, making it a so-called "built-in".
>>>>>
>>>>> My advice would be to try converting several small scripts, and avoid
>>>>> targetting a big one....
>>>>> add--interactive and stash are relatively complex beasts, perhaps
>>>>> git-pull.sh would be easier to start with.
>>>>
>>>> Yeah, I think that is a very good suggestion.
>>>
>>> Well, git-pull.sh is really small. I did not want to give the impression that the Git project is giving out freebies. But I have no objection to change it if you open that PR.
>>
>> To get an idea, I counted the lines of code written by the student I
>> mentored last year:
>>
>> $ git log --author tanayabh@gmail.com -p | diffstat -s
>>  43 files changed, 1225 insertions(+), 367 deletions(-)
>>
>> I would consider this GSoC as "average" (i.e. not exceptionnally good,
>> but certainly not a bad one either), so you may hope for more, but you
>> should not _expect_ much more IMHO.
>>
>> In comparison:
>>
>> $ wc -l git-add--interactive.perl
>> 1654 git-add--interactive.perl
>> $ wc -l git-stash.sh
>> 617 git-stash.sh
>>
>> I'd expect a rewrite in C to at least double the number of lines of
>> code, so rewriting git-stash would mean writting at least as many lines
>> of code as the GSoC above. git-add--interactive.perl would be rather far
>> above.
>>
>> But my point was not to convert _only_ git-pull.sh, but to have a GSoC
>> starting with this one and plan more. Then, depending on how it goes,
>> you can adjust the target.
>>
>> This all depends on what you intend to do if the student does not finish
>> the job. If you're going to do the rewrite yourself anyway, then having
>> the student do even half of it is good already. If you're not going to
>> finish the job by yourself, then a 95%-done-rewrite means a piece of
>> code posted on the mailing list and never merged (and a lot of time
>> wasted).
>>
>> In any case, these are just advices, certainly not objections or hard
>> requests to change.
>>
> 
> 
> Once upon a time (Sep 2013) I rewrote builtin/repack.c which was a
> shell script before. I did not have much real-coding expertise with the
> git community before and by today there are 403 lines of code in
> builtin/repack.c. so going for roughly 3 times (1200 lines of code) change
> would make a summer, specially if you need to learn how the workflow
> is in the open source world.  There the lines in c doubled nearly exactly.
> (before 197 shell lines, afterwards 387 c lines).
> 
> Just last weekend I met people, who were afraid of contributing to open source
> "because sometimes the internet can be very mean". Git being quite a high
> profile project, as it is widely used, might not help, but rather fear
> people away.

I guess they've read about the lkml too much :)

I consider the gitml to be a relatively civilized place for constructive
criticism, without rants, flame wars and ad hominem swear word attacks.
I don't know how it's perceived from the outside (but that drew me in
back then).

Maybe we can attach a photo of our maintainer to the GSOC page? That
would prove we're nice and polite :)

> That said I would not underestimate the initial time a student needs to learn
> the workflow. Though most of that learning is done in the micro project phase.

Yes, the technical workflow as well as the "social habits". They should
follow the gitml even before, and then the micro projects are a great
learning ground.

Michael
