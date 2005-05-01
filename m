From: Edgar Toernig <froese@gmx.de>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sun, 1 May 2005 19:23:03 +0200
Message-ID: <20050501192303.49ed8f0c.froese@gmx.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	<87zmvganq9.fsf@windlord.stanford.edu>
	<1114848175.24014.35.camel@localhost.localdomain>
	<20050430124048.79119cac.froese@gmx.de>
	<87r7gs87a9.fsf@windlord.stanford.edu>
	<Pine.LNX.4.58.0504301322130.2296@ppc970.osdl.org>
	<20050501005434.2d47131a.froese@gmx.de>
	<Pine.LNX.4.58.0505010934480.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 19:17:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSI4H-0007OC-Nl
	for gcvg-git@gmane.org; Sun, 01 May 2005 19:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVEARXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 13:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVEARXQ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 13:23:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:53458 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262624AbVEARXK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 13:23:10 -0400
Received: (qmail invoked by alias); 01 May 2005 17:23:06 -0000
Received: from p50907FAA.dip.t-dialin.net (EHLO dialup) [80.144.127.170]
  by mail.gmx.net (mp015) with SMTP; 01 May 2005 19:23:06 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505010934480.2296@ppc970.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
>
> 	Date: Fri, 08 Apr 2005 02:20:10 0200 -> bad
> 	Date: Mon, 18 Apr 05 15:05:29 Hora oficial do Brasil -> bad
> 	Date: 2002/04/11 18:29:07 -> bad
> 
> The second one is funny. Not just the "Hora oficial do Brasil" (hey, I 
> could add it as a real timezone and my parser would do the right thing ;) 
> but also because my parser decides that "05" is not a year, but the day in 
> the month, so it doesn't see the year.
> 
> I can fake out that year thing pretty easily ("if it starts with '0' it's 
> not a day of the month"), but it does show just how _strange_ stuff 
> there's out there.

And what happens then with the first example?  2008 Apr 2005?


I thought about missing timezones once more.  Don't you think it's
better to default to -0000?  Afaics, it was defined for just these
cases.  Simply appending an arbitrary timezone seems wrong.

Ciao, ET.
