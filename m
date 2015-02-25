From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [msysGit] Re: [RFH] GSoC 2015 application
Date: Wed, 25 Feb 2015 11:04:06 +0100
Message-ID: <CAP8UFD2PcBsU6=FK4OHVrB7E98ycohS_0pYcbCBar=of1HLx+Q@mail.gmail.com>
References: <20150218191417.GA7767@peff.net>
	<20150218193234.GA8298@peff.net>
	<5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
	<vpqioerz03s.fsf@anie.imag.fr>
	<CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
	<c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org>
	<vpqh9uavp6q.fsf@anie.imag.fr>
	<3e3da365d9b6021c9b6d8547ad8df788@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:04:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQYpD-00088V-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 11:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbbBYKEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 05:04:10 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:44210 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbBYKEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 05:04:07 -0500
Received: by iecar1 with SMTP id ar1so3501915iec.11
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 02:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xSlphbIA+gH2XwXZh8Ma16OTgsjjSLQP99lQXHcmPjw=;
        b=fus83+rmMZefkaZFBoq9xIV9FCJ/vaiS8JZ6xgS1AJ6VZIvCSbSIO6IOUkzzdl689z
         Z61gGa+HBzgCB1Cighh3UxDIPJXZ8991GGuNBa1AZjqfYeSSw+6PQGfq+tmptkSYbF3U
         i0s6v7Hf31p5W0wIoTOT2wGIFbJgXtIyf/g6XT7ZNQBdQRjax6rmXRuLsZ8QA5bulAYk
         6GdmfAGdxJ4bsnHkORnQKBzVtFoDCEWpWTZaiBw3Xh0SoC2DNdDXkUq9XpeQanovxcw6
         BlS5LUyBEosi+4wJg8kx/NPMGdoQmtjpOS/OJF2de1qQvQAIyTaP1PiOeW445ePV/BRH
         VclA==
X-Received: by 10.107.7.93 with SMTP id 90mr3369892ioh.69.1424858647024; Wed,
 25 Feb 2015 02:04:07 -0800 (PST)
Received: by 10.50.245.144 with HTTP; Wed, 25 Feb 2015 02:04:06 -0800 (PST)
In-Reply-To: <3e3da365d9b6021c9b6d8547ad8df788@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264378>

On Wed, Feb 25, 2015 at 9:44 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Matthieu,
>
> On 2015-02-25 00:56, Matthieu Moy wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
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

There is also:

$ wc -l git-bisect.sh
528 git-bisect.sh

And there is already builtin/bisect--helper.c that can be used to
convert step by step shell code to C. I can mentor or co-mentor this
convertion by the way, but that would conflict with the other bisect
related GSoC project if a student takes it.

>> I'd expect a rewrite in C to at least double the number of lines of
>> code, so rewriting git-stash would mean writting at least as many lines
>> of code as the GSoC above. git-add--interactive.perl would be rather far
>> above.
>
> Sure. You're right, I was thinking too big.
>
>> But my point was not to convert _only_ git-pull.sh, but to have a GSoC
>> starting with this one and plan more. Then, depending on how it goes,
>> you can adjust the target.
>
> That's excellent advice.

Yeah!

>> This all depends on what you intend to do if the student does not finish
>> the job. If you're going to do the rewrite yourself anyway, then having
>> the student do even half of it is good already. If you're not going to
>> finish the job by yourself, then a 95%-done-rewrite means a piece of
>> code posted on the mailing list and never merged (and a lot of time
>> wasted).
>
> Well, all of this is academic at this point.

Yeah, but it's still worth keeping in many parts of our collective mind :-)

> Let's see whether we get accepted, and then, if a student finds this project compelling enough.
>
> If both things happen, I will definitely heed your advice and encourage the student to start with some script that is easily converted, to "get her feet wet".

Great!

Thanks,
Christian.
