From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to remove a commit object?
Date: Thu, 02 Oct 2008 16:30:57 +0200
Message-ID: <48E4DB21.7020304@drmicha.warpmail.net>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>	 <48D36DF4.3030607@drmicha.warpmail.net>	 <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>	 <m3ljx7qemk.fsf@localhost.localdomain> <33f4f4d70810020726g71c6f39eq16585269fb268322@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:33:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPES-00030V-Rs
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbYJBObF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbYJBObE
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:31:04 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41042 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754105AbYJBObB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2008 10:31:01 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 14F0B17146B;
	Thu,  2 Oct 2008 10:31:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 02 Oct 2008 10:31:01 -0400
X-Sasl-enc: PyJf75JoB9uV245wvuT41HMJraPmWAPCI8lccS88Dsnr 1222957860
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3C17FA11F;
	Thu,  2 Oct 2008 10:31:00 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <33f4f4d70810020726g71c6f39eq16585269fb268322@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97343>

Klas Lindberg venit, vidit, dixit 02.10.2008 16:26:
> Repo size is a problem too, actually.
> 
> A solution to both problems seemed to be to use git-filter-branch to
> create a new repo by filtering out all the unwanted files. The
> astonishing result was that, for the subdirectory I tried it on, 90%
> or so of the commits on that subdirectory just disappeared. It didn't
> look right at all. Although I can't say for sure exactly what I did
> with filter-branch, I would appreciate some guidance for using it. It

I don't know about others, but I would appreciate more info:
Do you want to remove commits (as stated earlier) or files (as stated here)?
What are the boundary conditions? Rewriting history seems to be OK now.

> basically seemed to do exactly what I wanted (recreate the repo, minus
> some explicit stuff, with history intact otherwise), except the result
> looked crazy.

That may be due to the filter-branch incarnation, i.e. which refs did
you rewrite (--all or HEAD)?

Michael
