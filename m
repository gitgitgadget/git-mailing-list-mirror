From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-cvsimport with cvsps output in commit msg breaks imports
Date: Fri, 10 Dec 2010 13:48:35 +0100
Message-ID: <4D0221A3.6080706@drmicha.warpmail.net>
References: <20101209220347.GA3180@shuttle.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cvsps@dm.cobite.com
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Fri Dec 10 13:56:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR2WB-0006gD-Nj
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 13:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab0LJMvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 07:51:05 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:46785 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755762Ab0LJMvE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 07:51:04 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2152D2F0;
	Fri, 10 Dec 2010 07:51:01 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 10 Dec 2010 07:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=crtVn0+lTdS6UtwAzQ3T8hERH4c=; b=XhwRhtNJEmQAP7OA/6ZMZtQBw4lwSFnLjz4m8RR4qCeEqtOpOq/6KVSSNUo2ZCOQSDQS4xVvXLEYLEJiBgyes/VuuwZJJd0Ww8rno90Gm1hgMGPS2ZOQ0ExaV98J2ui+GPxZ1RevQ2C+KOnYyeNCmKEdsCD4H3zH+FWs1LkEELE=
X-Sasl-enc: rLY+4TzvScRZqL1u07y6+aw61QmBI0i7tjTNRDjuShGE 1291985460
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 11B8A5E07EA;
	Fri, 10 Dec 2010 07:50:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101209220347.GA3180@shuttle.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163409>

Thomas Adam venit, vidit, dixit 09.12.2010 23:03:
> Hi all,
> 
> [ I've Cced both the cvsps maintainer and the author listed for
> git-cvsimport in case it's more relevant to either tool. ]
> 
> I am wondering if anyone here is able to shed some light on a problem I've
> encountered with git-cvsimport.  For ages now, I've had an automatic
> conversion of a CVS repository to a Git one, using git-cvsimport to update a
> repository as commits happen in CVS.
> 
> The repository in question is here:
> 
> https://github.com/ThomasAdam/tmux
> 
> Everything is on the Master branch.
> 
> More specifically, the commit which I think introduced the problem, and all
> subsequent commits thereafter is here:
> 
> https://github.com/ThomasAdam/tmux/commit/f0220a10b01a764e0dc52ea1b2407f58600a30eb
> 
> Note that from this commit onwards, the commit *message* has a bunch of
> cvsps output in it.  I can only surmise that this somehow causes problems
> for cvsimport.
> 
> But I can't say for sure.

The previous one has cvsps info in the commit message already, prefixed
with "|". So the problem is the previous one or the one before.

If you have cvs checkout, can spot anything between those? Can you redo
the cvsps import from that point on and check cvsps log?

Michael
