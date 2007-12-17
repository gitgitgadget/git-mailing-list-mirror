From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first
 argument.
Date: Mon, 17 Dec 2007 13:30:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171328020.9446@racer.site>
References: <20071217095014.GF7453@artemis.madism.org>
 <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org>
 <Pine.LNX.4.64.0712171149540.9446@racer.site> <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com>
 <Pine.LNX.4.64.0712171223210.9446@racer.site> <26962818-F702-44D2-BD26-95D74CE21F0D@wincent.com>
 <Pine.LNX.4.64.0712171253290.9446@racer.site> <223E3B44-92DA-4861-83D6-67E56F70E784@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 14:31:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4G3f-0006eI-3Y
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 14:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731AbXLQNae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 08:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756632AbXLQNad
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 08:30:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:40675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753891AbXLQNac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 08:30:32 -0500
Received: (qmail invoked by alias); 17 Dec 2007 13:30:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 17 Dec 2007 14:30:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kQVo9gsekcU/xMewqKBsgAdBOs1fzdTr+sNwcgs
	+jEv5/FwTWdPHT
X-X-Sender: gene099@racer.site
In-Reply-To: <223E3B44-92DA-4861-83D6-67E56F70E784@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68563>

Hi,

On Mon, 17 Dec 2007, Wincent Colaiuta wrote:

> El 17/12/2007, a las 13:55, Johannes Schindelin escribi?:
> 
> > I never had any problems explaining why "-p" goes before the 
> > subcommand here.  Never.
> 
> Would be even better if there was nothing to explain and it all just 
> worked, which is what I'm proposing here. As I said, -p is the only 
> special option which clashes with any non-special uses.

Even in the best of circumstances, you have to teach people a little.

> But leaving -p aside, will you oppose any patches that make it possible 
> for people to write stuff like:
> 
> git init --bare
> 
> Personally, I think this is an obvious usability improvement worth 
> striving for. Given that "git --bare init" will continue to work under 
> what I'm proposing, I really can't see any worthwhile argument against 
> it. Because we're talking about a UI improvement for newcomers at no 
> cost to old timers.

My reasoning is like as for "-p".  "--bare" is not special to "init".  It 
makes git not guess, but work on the current directory as a bare 
repository.

In my experience, it is easier to give people a clear-cut distinction 
between different concepts.  Then way fewer surprises will hassle them 
later.

Ciao,
Dscho
