From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Stupid quoting...
Date: Thu, 14 Jun 2007 10:51:57 +0200
Message-ID: <81b0412b0706140151o4e0d3a2fkfde1cd2726f9b14e@mail.gmail.com>
References: <86ir9sw0pi.fsf@lola.quinscape.zz>
	 <Pine.LNX.4.64.0706131316390.4059@racer.site>
	 <86ejkgvxmb.fsf@lola.quinscape.zz>
	 <Pine.LNX.4.64.0706140145450.4059@racer.site>
	 <86wsy76p4v.fsf@lola.quinscape.zz>
	 <81b0412b0706140006v601b345re7dc0e58488cf61e@mail.gmail.com>
	 <86hcpb6lr6.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 10:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyl3h-0006d3-4u
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 10:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbXFNIwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 04:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbXFNIwA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 04:52:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:51141 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbXFNIv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 04:51:59 -0400
Received: by ug-out-1314.google.com with SMTP id j3so613276ugf
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 01:51:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JviUFNSnUHGXIj41fLtzc3/Kpd9ydZ804PinXiyfWYBpOrtBbm3smyzgGD2fYC2Gd0o5FBE2XDrpZ+XSiKMi8MyKc0vdZOEEcfKVH2F+hhHNtdoVuCFLPgK3l+Q+fXYpNSx8OoI3Qc8I8gwttUsTO6YwFmoUNIRy9phZg6a46ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZNrUs7uYPyu/SHNsUPDcjbT3/QgQdKX8G6CzDnBOiXPrYBteqqx8zKcHMq5rs631/dRUQZLmg3r8mTSNA+mq4kOuUK3PHZmnly0nwbznvav6F2r1Td4em6/YcteKArbl9dHKNEPJblBeU9XB7L77Pt1DmJlP56LVTt8zDPatTgA=
Received: by 10.78.138.6 with SMTP id l6mr581569hud.1181811117879;
        Thu, 14 Jun 2007 01:51:57 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Thu, 14 Jun 2007 01:51:57 -0700 (PDT)
In-Reply-To: <86hcpb6lr6.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50181>

On 6/14/07, David Kastrup <dak@gnu.org> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > On 6/14/07, David Kastrup <dak@gnu.org> wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> >> Can you actually name a program that would work with the default
> >> >> output of git here?
> >> >
> >> > echo.
> >>
> >> It doesn't, since it does not interpret the \NNN escape sequences that
> >> git chooses to output.
> >
> > Have you tried that -z switch yet?
>
> What has that to do with "the default output of git"?
>
> Yes, in my application I _will_ be using -z

Just checking.

>  (in connection with the rather hackish read -d '' name
> command from bash which is not really documented) but that does not
> change the fact that the default output is broken.  There is no reason
> whatsoever to use octal quotes for non-ASCII characters.  Neither
> programs nor humans are better off by that, and none of the derision
> bestowed upon me changes that.

Well, fix that. How do you think _should_ it be?

It's just up until now you are only complaining.
No _useful_ idea came from you.
