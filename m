From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 06:56:12 -0500
Message-ID: <CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
	<CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
	<CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
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
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 13:56:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlHkp-00019x-Hj
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 13:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab3FHL4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 07:56:15 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:37349 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab3FHL4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 07:56:14 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so4493408lab.1
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 04:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=if0lj5m4im6/u1T51t10GJ5qvnluMp4bpqxOzrAxGCg=;
        b=U5MxvDjwc69vyH1zqxbcGvKqJt17czahwBULenQJZNyX/15E9SPGmgeiNlYV+qgfP9
         sxs5683m3jI4/71dyMYASx31JBHYEDLEMsZ9sCuHniE7WQNDyZ47Lqi8qeWsI0aiIHS9
         N1Ze7A+9mHZg61uMPUTH/NvjqdSkXzz7z8B/O+msvhhlBlYOpiymqm36DcaUUULAiapl
         jA3dh8UrlypIFz1AUOfe8wlcmRA2qBRxWguNCDeLjzR4crXrUNjusZhEZYfH9S+ZDlF3
         SNS5CP5pqFoIwojAob0ec+al2pC3aGzxfUiycyDCUFiJl6vm+0xD0m8ATSMBdv4k9stU
         lpFQ==
X-Received: by 10.112.156.5 with SMTP id wa5mr2965138lbb.63.1370692572534;
 Sat, 08 Jun 2013 04:56:12 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 04:56:12 -0700 (PDT)
In-Reply-To: <CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226804>

On Sat, Jun 8, 2013 at 6:28 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 8, 2013 at 5:02 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Jun 7, 2013 at 9:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Thu, Jun 6, 2013 at 11:22 PM, Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>> Hi Greg,
>>>>
>>>> On Thu, 6 Jun 2013, Greg Troxel wrote:
>>>>
>>>>> As one of the people who helps maintain git packages in pkgsrc, my
>>>>> initial reaction is negative to adding a ruby dependency.
>>>>
>>>> My initial reaction, too. It was hard enough to get Perl included with Git
>>>> for Windows (because of that pesky Subversion dependency).
>>>>
>>>> As you can see from the commit history, I was the primary force behind
>>>> trying to get everything "core" in Git away from requiring scripting
>>>> languages (I think it is an awesome thing to provide APIs for as many
>>>> languages as possible, but a not-so-cool thing to use more than one
>>>> language in the core code). It does not seem that anybody picked up that
>>>> task when I left, though.
>>>
>>> Nobody seems to mention it yet. There's another reason behind the C
>>> rewrite effort: fork is costly on Windows. The C rewrite allows us to
>>> run with one process (most of the time). This applies for shell, perl
>>> and even ruby scripts because libgit.a is never meant to be used
>>> outside git.c context (unlike libgit2). In this regard, ruby is just
>>> as bad as currently supported non-C languages.
>>
>> Are you sure?
>
> I'm not saying you can't. I'm saying it's not meant to be used that
> way. Which means there may be problems lurking around.

Code is code. If something is not meant to be used in certain way, you fix it.

> You can write a ruby extension to access libgit.a, sure,

I'm not using libgit.a, I'm using the builtin commands. This is
exactly the same code you run when you type 'git foo'.

> but how many people on this
> list understand git design and limits _and_ ruby's good enough to spot
> the bugs?

Now you are changing the subject. Does that mean that you accept that
'fork' wouldn't be a problem when writing Ruby scripts?

As for the people that know Git and Ruby; they can learn. Didn't you
just said that you didn't see any problem with the community learning
a new language?

> If a bug is found and requires major restructuring in
> libgit.a, how are you sure it's worth the effort and does not
> destablize the rest of git?

There is no need to destabilize anything. I just showed you 100 lines
of code that are able to run git commands without forks, and without
changing anything in libgit.a.

> A better way to do it is linking against libgit2.

I would rather use what the rest of Git uses. It doesn't make any
sense fragment even more the code, and make Ruby scripts 2nd class
citizens along the way. Plus, any script that tries to use libgit2,
would certainly need more than 100 lines.

-- 
Felipe Contreras
