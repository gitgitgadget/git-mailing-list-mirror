From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git checkout -b -t
Date: Tue, 02 Jun 2009 17:25:53 +0200
Message-ID: <4A254481.3020104@drmicha.warpmail.net>
References: <43d8ce650906020749r36a0cceao20dc54d1446a6ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBVtc-0006eE-Pg
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133AbZFBP0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757062AbZFBP0I
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:26:08 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56126 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757391AbZFBP0H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 11:26:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 3D4EB34CCC0;
	Tue,  2 Jun 2009 11:26:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 02 Jun 2009 11:26:08 -0400
X-Sasl-enc: 5DhnLhHoVPkIm3qDYULaHPLwRBOV567zEXCI2f3hLeqs 1243956367
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9D1454238E;
	Tue,  2 Jun 2009 11:26:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090602 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <43d8ce650906020749r36a0cceao20dc54d1446a6ea@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120519>

John Tapsell venit, vidit, dixit 02.06.2009 16:49:
> Hey all,
> 
>   I've become the "guy to ask about git" in my company and people are
> always getting into a mess with git.  So in turn I try to get git to
> be a more friendly.  Today someone had a problem.  Basically they had
> done:
> 
> $ git checkout -t origin/mybranch
> fatal: git checkout: --track and --no-track require -b
> 
> So they do exactly what it tells them:
> $ git checkout -b -t origin/mybranch
> Switched to a new branch "-t"
> 
> doh
> 
> How can we make this less easy for people to shoot themselves in the
> foot?  The behavior of -t has changed recently iirc, so I think that
> problem has gone away?

git 1.6.1 and above contains DWIMery which, in the case above, would
automatically behave like

git checkout -t origin/mybranch -b mybranch

which complains in case 'mybranch' exists already, without pointing at
'-b', though. Do you think this creates a new type of head aches for
your patients?

> 
> Also:
> $ git branch -D -t
> 
> Doesn't work.  I can see why, but it does make my life difficult :-D
> 
> John
