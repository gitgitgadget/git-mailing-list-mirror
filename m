From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 19:07:54 +0700
Message-ID: <CACsJy8D8xD3mdC2gsBpU74Faa+CUfEWEgh5fhwPoRjz46-hjcw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
 <CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
 <CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com> <CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 14:08:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlHwc-0002q5-ML
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 14:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab3FHMI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 08:08:27 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:61952 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab3FHMI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 08:08:26 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so7719371obq.7
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/YYKu6C4ZA6UQw6Hu49ZEK8esxfg1mhvJf90WzoSfxc=;
        b=BaFs+ZoO1T45VOIX/m//sXGolORrobxQswo9kMN1BEh2INjA2qNBTSzZ/gFOefJ5aI
         fEzN/pyZQ4FZCk9Zs8228BOojO4g61PwPRPmvBv121KQ2bggZvyTHSF5hdec6sFVSj9P
         V7F5eB7IEXDmXvhCyG2w5VFJG+yg8OKpDVlx/GhIrqvXI5vmyM6oi29/q6H923/eOos1
         kyLsY63V+1OvpVA6blZ1qQmpjvj682/4VrTFffCk3Vu+0TQH3PIQkxHbnjmXiZcVv+/x
         2PFNCNrZskfhChpGMj8hNtAx1cfIL95waPteF/roFWyweN/v5x3dKV4Pwf4UZd+B0WbX
         kw8w==
X-Received: by 10.60.85.74 with SMTP id f10mr2118595oez.32.1370693305599; Sat,
 08 Jun 2013 05:08:25 -0700 (PDT)
Received: by 10.76.76.69 with HTTP; Sat, 8 Jun 2013 05:07:54 -0700 (PDT)
In-Reply-To: <CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226807>

On Sat, Jun 8, 2013 at 6:56 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Jun 8, 2013 at 6:28 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Jun 8, 2013 at 5:02 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Fri, Jun 7, 2013 at 9:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Thu, Jun 6, 2013 at 11:22 PM, Johannes Schindelin
>>>> <Johannes.Schindelin@gmx.de> wrote:
>>>>> Hi Greg,
>>>>>
>>>>> On Thu, 6 Jun 2013, Greg Troxel wrote:
>>>>>
>>>>>> As one of the people who helps maintain git packages in pkgsrc, my
>>>>>> initial reaction is negative to adding a ruby dependency.
>>>>>
>>>>> My initial reaction, too. It was hard enough to get Perl included with Git
>>>>> for Windows (because of that pesky Subversion dependency).
>>>>>
>>>>> As you can see from the commit history, I was the primary force behind
>>>>> trying to get everything "core" in Git away from requiring scripting
>>>>> languages (I think it is an awesome thing to provide APIs for as many
>>>>> languages as possible, but a not-so-cool thing to use more than one
>>>>> language in the core code). It does not seem that anybody picked up that
>>>>> task when I left, though.
>>>>
>>>> Nobody seems to mention it yet. There's another reason behind the C
>>>> rewrite effort: fork is costly on Windows. The C rewrite allows us to
>>>> run with one process (most of the time). This applies for shell, perl
>>>> and even ruby scripts because libgit.a is never meant to be used
>>>> outside git.c context (unlike libgit2). In this regard, ruby is just
>>>> as bad as currently supported non-C languages.
>>>
>>> Are you sure?
>>
>> I'm not saying you can't. I'm saying it's not meant to be used that
>> way. Which means there may be problems lurking around.
>
> Code is code. If something is not meant to be used in certain way, you fix it.

Code is code. Bugs can be hard and easy. Hard bugs take a lot of time
and may not be worth it after all.

>> You can write a ruby extension to access libgit.a, sure,
>
> I'm not using libgit.a, I'm using the builtin commands. This is
> exactly the same code you run when you type 'git foo'.
>
>> but how many people on this
>> list understand git design and limits _and_ ruby's good enough to spot
>> the bugs?
>
> Now you are changing the subject. Does that mean that you accept that
> 'fork' wouldn't be a problem when writing Ruby scripts?

There are a lot of static variables in builtin/ (and outside too),
which make it non-entrant, or at least not safe. fork provides a
process space isolation, some depend on that. And there are die()
everywhere. Good luck controlling them.

> As for the people that know Git and Ruby; they can learn. Didn't you
> just said that you didn't see any problem with the community learning
> a new language?

I said nothing about the community being ready _now_, did I? When you
have the support for Ruby in Git, sure go ahead.

>> If a bug is found and requires major restructuring in
>> libgit.a, how are you sure it's worth the effort and does not
>> destablize the rest of git?
>
> There is no need to destabilize anything. I just showed you 100 lines
> of code that are able to run git commands without forks, and without
> changing anything in libgit.a.

And how do you deal with, for example die(), or thread safety?
-- 
Duy
