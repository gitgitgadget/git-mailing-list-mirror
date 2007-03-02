From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Fri, 2 Mar 2007 19:42:57 +0000
Message-ID: <200703021942.58780.andyparkins@gmail.com>
References: <20070228151516.GC57456@codelabs.ru> <200703021005.13620.andyparkins@gmail.com> <Pine.LNX.4.63.0703022014410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 20:46:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNDha-0000NL-SQ
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 20:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbXCBTpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 14:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbXCBTpu
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 14:45:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:60098 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965185AbXCBTpt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 14:45:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so797031uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 11:45:47 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T4KT4WS0zKhRA9AWOwVcCqIiIzhIi6DYcGfok6qb+dt2UGl313TvwynS2eXQRtW9+wQqEZivTt41jNkEpCL+A1q0xaHbgTrk+1dAes4c46MW+M7xKdAsYobpwfLdwHQ9PW2IdcyVPDGypxGyHvJYsVn1kEhENMBPE/rorWRcm38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CawjktySsOnC4grajwYM0d5obp0NLqNlFPeIeZu2+L7tNfBSzw9Rld4L5ogG08j8TwQPFLADogpTuHPL2AvGva+pbwTWRf5tVq9ntIYQupQzLCJizz/nsVfGgHpYo7l6m40HOZSWxNEjb2/nuGnODlk3CsIAfLuntc+OdBpFIEY=
Received: by 10.67.19.13 with SMTP id w13mr3865659ugi.1172864747535;
        Fri, 02 Mar 2007 11:45:47 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 53sm3380676ugn.2007.03.02.11.45.44;
        Fri, 02 Mar 2007 11:45:45 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.63.0703022014410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41242>

On Friday 2007, March 02, Johannes Schindelin wrote:

> On Fri, 2 Mar 2007, Andy Parkins wrote:
> > Here's another similar idea: generating copyright lines.  Let's say
> > we want to copyright every source file - that means writing "(C)
> > Junio, (C) Johannes, etc" at the top of every file.  Wouldn't it be
> > nicer if we could put $Copyright$ in the file, then have some
> > git-blame-like machinery fill in the copyrights automatically based
> > on who's made contributions?
>
> That's a horrible idea. A typo fix is not copyrightable. You'd add
> these. An obious fix is not copyrightable. You'd add these cases,
> too.

Well, I wasn't actually suggesting that as a final solution, it might be 
that it's done by more than just line count, and that some clever bit 
of machinery measures real contribution.  That wasn't really the point.

> Besides, IMHO adding copyright should be a _concious_ act.

Well, IMHO, the concious act was the commital of a change.

A lot of your objection to this seems to be "IMHO".  Fine: you don't 
like keywords, you wouldn't be /forced/ to use them.  I can see a use 
for them.  I'm having a lot of trouble understanding why they are seen 
as inherently evil.  Difficult to implement, I would accept, 
impractical to make work in git would be fine; but not this hand wavery 
that there is no conceivable use for them.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
