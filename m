From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 13:24:43 -0500
Message-ID: <CAMP44s1QotO7yx7reiLdxd61VoZNOTUTWja7ed1G7E9mEJEdrA@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<rmisj0vnorm.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 20:24:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukerh-0000NK-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 20:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab3FFSYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 14:24:46 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:33086 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab3FFSYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 14:24:45 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so2626450lab.24
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Dox1SttO9UEiywwGij4I1PFU1nBlTCcid01YAcjoGHY=;
        b=vmv6ex90onKz4NWslZ+LBlpvBiIuEdnqmPGs3ukGa4QViRN6JjoMUzmpBx3osBIjKq
         3z6UWAY528GiJswFJo7+Ylftf824/fduLcbA0r6JdKX8gEPTlpZ1yeqmgDoD8t0CIuLB
         lqADQpj+FsI43Rn0v4/H/T5g3NXRL8KnwrmXapjlT0Pik/pnOnBho3JvDRWEtxBImHBF
         wBKohqM9CQJ67Ef/vu/INlfaYex+t4Oe8jOsh+0pEkTfK1UTkcNBLRpuM8TZKwJECqXC
         J4BpFArMeYE2a+PhconhPPlgbxVbVBxcRFLGOH1nqCvrsj1tWSjp+y9br/6KluVT9cRy
         fWng==
X-Received: by 10.112.16.163 with SMTP id h3mr426881lbd.85.1370543083745; Thu,
 06 Jun 2013 11:24:43 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 6 Jun 2013 11:24:43 -0700 (PDT)
In-Reply-To: <rmisj0vnorm.fsf@fnord.ir.bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226523>

On Thu, Jun 6, 2013 at 12:16 PM, Greg Troxel <gdt@ir.bbn.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Jun 6, 2013 at 9:54 AM, Greg Troxel <gdt@ir.bbn.com> wrote:
>>>
>>> git is a core tool that people use on almost the smallest of boxes,
>>> perhaps even replacing rcs for managing local config files.  On such
>>> machines, even perl may be large, but a second scripting language seems
>>> excessive.
>>
>> You can compile Git without any of them.
>
> That ignores the 99% of people who use packaged versions.

The 99% of people who use packaged versions wouldn't care about the
additional dependency.

>>> On a NetBSD 6 i386 system, the size of the ruby193-base
>>> binary package (as installed) is 25 MB (vs 15 MB for the git base
>>> package, which lacks gitk and docs).  (Presently, the git base package
>>> defaults to requiring python and installing the git_remote_helpers, but
>>> I think that's a bug.)  perl is 54 MB.
>>
>> That's only the default, if the default doesn't suit you, don't use
>> the default.
>
> It's not about what I want.

It is exactly about what you want.

You use the argument that 99% of the people use packaged versions, yet
you ignore the fact that 99% of the people don't care about a single
extra dependency (specially one that would be transitory). It is all
about 1% of the users, in fact, not even that, because of this 1% of
users who dread extra dependencies, most of them would be happy that
it's only temporary, and eventually a heavier dependency would be
replaced with a lighter one. It is for all intents and purposes only
you, the person you are speaking on behalf of.

If the Git project considers a new dependency that would be needed in
addition to Perl for a finite period of time, your argument does
absolutely nothing to block this route.

-- 
Felipe Contreras
