From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 20:50:36 +0530
Message-ID: <CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com> <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Troxel <gdt@ir.bbn.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3YyBEdXk=?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 07 17:21:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkyTk-0000PD-2H
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 17:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131Ab3FGPVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 11:21:19 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37761 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3FGPVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 11:21:16 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so2281560ieb.24
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UysXBgyw/0M9IC91xjLi56LrV2YrpjrWDAyyss+IefE=;
        b=HqmlDAJ/1CATXInUuUUSq4hoJFuDwAtQDDj0Rg4wFHR6tnA3akJNpMpeJnzzVK7V9D
         DNGFpOVjHd4E3VjZdZ+jMVJXliJFtfjt5RYQ8PJDXvV/4BQ5pnuD4B2ehqE+S23Y2JzP
         sfIUvT+7vfKJQuylyFEcnmTb3UwcAYEkBZEsCLCFsWJrucCvlTzC2JO+r9Q7KVz7239r
         +fJFefXwFexiFtPIPC4DpGVDNDz9NSkAIzQ/4FkFMtUgqGpm0zvyJYSWyOpkbNYATUoK
         cl/nf20rdYsNnX/UceOayGuyAsoFrUu+ccuS3mz70/hTkkX9A0wAsomrDSehvc01kKzT
         alFA==
X-Received: by 10.50.171.161 with SMTP id av1mr1601255igc.104.1370618476294;
 Fri, 07 Jun 2013 08:21:16 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 08:20:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226638>

Johannes Schindelin wrote:
> On Fri, 7 Jun 2013, Ramkumar Ramachandra wrote:
>> Johannes Schindelin wrote:
>> > My initial reaction, too. It was hard enough to get Perl included with Git
>> > for Windows (because of that pesky Subversion dependency).
>>
>> Nevertheless, we had to do it, and we did it.
>
> That is not quite correct. *I* did it. Not *we*. And I will not do it
> again.

When I say "we", I mean the git community.  You were incidentally part
of the git community when we got perl included in git-for-windows.
Don't make laughable assumptions about your indispensability: the
community will run fine without you (as it will run fine without me,
fc, or even jc).  There are enough and more smart diverse people to
replace the inactive people.

>> We will do it again, if we get enough important code written in Ruby.
>
> I am a bit bored by this hypothetical talk. This hypothetical "we will do
> it again", to be precise. Given my experience, it would be very painful if
> "enough important code" was written in Ruby. Nobody would help me "do it
> again". Just like nobody helps right now to upgrade to a newer Perl. Feel
> free to prove me wrong. Until that time, I will firmly believe that there
> is no "we will do it again".
>
> So here is a chance to prevent that: not repeat the mistake, and stay away
> from language hell by avoiding to require yet another language.

What is this "mistake" that you're talking about?  We never should
have merged git-svn.perl in our tree, and lost out on an incredibly
useful piece of software?

Let me make one thing clear: contributors are priority #1, and
everything else is secondary.  git.git is the sum of contributor
wishes, and we exist to keep contributors productive.  Yes, we have to
force some boring work onto contributors: nobody likes to write
documentation, and we have guidelines to make sure that it gets done,
for instance.

If enough people are interested in porting git-related to Windows,
they will figure out how to ship ruby with git-for-windows.  It is not
rocket science.

> As you know, there are very good reasons why I do not follow those mails.

No, I don't know the reason.  I would guess that you are disinterested.

> Exactly. Nobody really cares about keeping Git portable enough. Hence my
> impression that this idea to start requiring yet another language for core
> parts of Git is a bit misguided, and only logical from the point of view:
> "If you don't like it, why don't you install Linux?" (which, just in case
> you wondered, is a pretty naive way of looking at the real world).

I am personally disinterested in git-for-windows, but I wouldn't make
such a sweeping statement: there are some people interested in
git-for-windows.
