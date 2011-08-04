From: James Gregory <j.gregory@epigenesys.co.uk>
Subject: Re: git-fast-export is returning streams with source code inside
Date: Thu, 4 Aug 2011 10:08:43 +0100
Message-ID: <CAFC9htxRD0z3O_k_OLp08KZFUOL_T3AryCXD+OqqXx9ZYeRutg@mail.gmail.com>
References: <CAFC9htxwRg=+RD68hnnRy0hfptq23x3bL+xxHieK1evfFCTPjw@mail.gmail.com>
	<20110804070528.GA11805@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 11:08:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qotv9-0003s5-BX
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 11:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab1HDJIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 05:08:45 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34122 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab1HDJIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 05:08:43 -0400
Received: by pzk37 with SMTP id 37so1705956pzk.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=epigenesys.co.uk; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pgwU/KDb8yYtfuKd/QA2H0A6SXL6l7ItvKymOpkTRZs=;
        b=eD8A53Fnei6mD+BeX1X8AWF4QvBYT7ciFYTDm7IVezsmPOBiKsQ6i2/IXBuAvsiPV2
         DfzyWyxPAuS82vvBle0Ykb3/h3ozYPw4jJGHfkbFocfdDN4WEgbSIrOKK7/ztUx6Jfcg
         8rehW11vMjCQkmFSwwlwVzvubsI/3AFFxhuUQ=
Received: by 10.143.20.5 with SMTP id x5mr593488wfi.41.1312448923170; Thu, 04
 Aug 2011 02:08:43 -0700 (PDT)
Received: by 10.142.71.15 with HTTP; Thu, 4 Aug 2011 02:08:43 -0700 (PDT)
In-Reply-To: <20110804070528.GA11805@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178707>

Hi Peff,

Thanks for your reply. I'm afraid I won't be able to allow you access
to repo as it is for a business project and covered by NDAs, etc. If I
can do anything to help with diagnosing the problem (debug logs, more
excerpts from the stream, etc.) then that shouldn't be a problem.

James

On 4 August 2011 08:05, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 01, 2011 at 12:57:58PM +0100, James Gregory wrote:
>
>> I'm not sure if this is the right place to post bug reports - if not,
>> please can you let me know.
>
> This is the right place.
>
>> I've found (what appears to be) a problem in git-fast-export. I've
>> filed a bug in Launchpad, but I'm not sure if anyone from the Git
>> community actively monitors it so I'm reporting it here to see if it
>> can be fixed.
>
> I don't think anybody monitors Launchpad explicitly; thanks for the
> pointer.
>
>> The bug can be viewed online at:
>> https://bugs.launchpad.net/ubuntu/+source/git/+bug/815828
>> and I've done my best to describe the bug in some detail. If you need
>> me to elaborate on the problem further, don't hesitate to let me know.
>
> Definitely looks like a bug. Is it possible for you to make the
> offending repo available either publicly or to me in private? There's
> not enough information in your report for me to reproduce the problem
> here.
>
> -Peff
>



-- 

James Gregory
Senior Developer
epiGenesys - a University of Sheffield company
Enterprise Zone, Portobello, Sheffield, S1 4DP, UK
T: +44 (0)114 22 21 884 ~ F: +44 (0)114 22 24 042
www.epigenesys.co.uk ~ @epigenesys
--
This email and its attachments should be considered confidential and
are intended solely for the individual to whom the email is addressed.
If you are not the intended recipient you should take no action based
upon them, nor should you copy or show them to anyone. Any views or
opinions expressed are solely those of the author and might not
represent those of Epi Genesys Limited.
Epi Genesys Limited is registered in England and Wales with company
number 06388971 and has its registered office at 40 Leavygreave Road,
Sheffield, S3 7RD.
