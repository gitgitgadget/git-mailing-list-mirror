From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 14:21:24 -0500
Message-ID: <CAMP44s1+ax-Z=CRsSFEZHYKrBA1voQFv1=Vso9RkWDwEqhZR-A@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
	<CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
	<alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:21:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2E6-0000Eh-Do
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab3FGTV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:21:26 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:45316 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878Ab3FGTVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:21:25 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so4051912lab.29
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RNuKQnA8QLyMF2hmeuSMRLVapvoUCzDkhSpo6jvLqr8=;
        b=jOYU27GjxSzEksLIidXMZKMusTpBCQbyc3OoJZ2H//g34MVJxNv6Q8WmZN2qCgZKhc
         7gVtd2dCDQd1+f6J7ptoy5UnKD5rOCvMt+bkBwsSK/kLMJqnHsw3wojyyBGt+SLzU9Tl
         5/apwPTYQlOdABhs4jPY++7p6rS5HapQJOnD63dC/pH41g9MD55vPR1M0p3vFKXMq0z+
         WhxTn1/VVDEiLluz5P+qUF1BN8sGsgScAgaWsv5xIdYL+gZAZoR8gcOUi1WJbJUlwc+G
         2Pqjj3mAd22NOWX348jU84sG3c6JEKb9ioLYOvvJHzT+qtsVPIQqaYqTENwt3GV++Ilr
         67yg==
X-Received: by 10.152.7.74 with SMTP id h10mr9078laa.83.1370632884255; Fri, 07
 Jun 2013 12:21:24 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 12:21:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226679>

On Thu, Jun 6, 2013 at 3:19 PM, David Lang <david@lang.hm> wrote:
> On Fri, 7 Jun 2013, Ramkumar Ramachandra wrote:
>
>> David Lang wrote:
>>>
>>> Perl use may or may not be declining (depending on how you measure it),
>>> but
>>> are you really willing to take on the task of re-writing everything
>>> that's
>>> in Perl into another language and force all developers of scripts to
>>> learn
>>> that other language? what's the ROI of this?
>>
>>
>> Let's not talk hypotheticals.  git-svn.perl (+ perl/SVN/*.pl) is
>> absolutely massive.  It's an incredibly useful tool in that it
>> actually works, and that there is nothing replacing it in the
>> foreseeable future.  This monster was written almost entirely by one
>> brilliant person, and nobody is going to rewrite it.  We don't start a
>> huge discussion about what languages are "approved" before accepting
>> such a contribution: if the contributor wants to write something in a
>> dominant language (Perl in this case), and it's going to be useful, we
>> merge it.  End of story.
>
>
> Well, Felipe is saying that Perl is dieing and we should re-write everything
> that exists in Perl to Ruby.

No, I said we should try to move away from Perl. Move stuff to C,
shell scripts, and yeah, Ruby.

>> Why are we discussing something that is indeterminate?  It is
>> impossible to foresee the future, but that is no reason to freeze
>> _present_ development.
>
> and it's not a reason to throw away existing stuff based on the argument
> that Perl is dieing

Who said anything about throwing away code?

>> Nobody claimed that "press coverage" is a good metric.  We can only
>> talk about facts, and Felipe already showed you a TIOBE index graph.
>> If you have overwhelming _evidence_ that Ruby is a weak language that
>> will die soon, share it: otherwise, I see no value in this discussion.
>
>
> TIOBE index graph is "press coverage" as far as I'm concerned.
>
> I'm not saying that Ruby in particular has a fatal flaw, I'm just
> questioning the "Perl is dead, re-write everything in Ruby" mantra.
>
> The language that you choose to use when writing a new application is
> related to things related to that type of application.
>
> Ruby is not an extremely common language for sysadmins to use.

Who said we need a language commonly used by sysadmins for our Git core?

> Perl remains a common language for these sorts of tasks, even if it's not
> used for user visible applications.

Ruby is pretty much a replacement for Perl. For every task Perl is
good, Ruby also is. Ruby's syntax even borrows from Perl.

The difference is; Ruby is better for many more tasks that suck in Perl.

> Arguing that Perl is dieing, we need to abandon it is just wrong.

Straw man. Nobody is arguing that.

I said we should try to avoid it, not abandon it immediately.

-- 
Felipe Contreras
