From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Fri, 19 Oct 2007 01:00:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710190054570.25221@racer.site>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>  <47159779.6010502@bluelane.com>
  <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com> 
 <200710171800.37345.robin.rosenberg.lists@dewire.com>
 <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com>
 <4717EF40.6000509@bluelane.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: Pete/Piet Delaney <pete@bluelane.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IifIB-0003kv-RN
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761732AbXJSAAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761146AbXJSAAa
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:00:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:41506 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759889AbXJSAA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:00:29 -0400
Received: (qmail invoked by alias); 19 Oct 2007 00:00:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 19 Oct 2007 02:00:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IQO1kdjiI9B0f/7bG5UEvRSIhLMZkPFR411IvVE
	1Zm+n6nvdX2NkM
X-X-Sender: gene099@racer.site
In-Reply-To: <4717EF40.6000509@bluelane.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61577>

Hi,

On Thu, 18 Oct 2007, Pete/Piet Delaney wrote:

> Johannes:
>   I read somewhere in the past week that it was possible to maintain
>   our existing CVS environment with git. I though it was a separate
>   package to export git back to cvs but I just noticed a git-cvsserver
>   and as a std part of git and was wondering about using that.

Where did you read that?  AFAIK git-cvsserver is one option.  The other is 
cvsexportcommit.  The former is more appropriate if you want to switch the 
developers over to git, and want to provide a smooth path for the devs (or 
cannot convert a few hardcore CVS "fans").

The latter is appropriate if you cannot control the server side, or are 
not allowed to switch to CVS.

> We have a number of build machines with flamebox perl scripts pulling 
> out CVS branches for builds. I was wondering what is the best way to use 
> git and it's nicer pull/push model and merge facility and possibly 
> maintain CVS exports for scripts doing builds if possible the cvsweb and 
> bonsai (CVS Query Form) that a number of engineers are currently using. 

I don't know how cvsweb copes with git-cvsserver, but I guess that there 
will be no problem.

> I started looking over out flamebox scripts with the intent up 
> converting them over to git but I mentioned the git to cvs coexistence 
> and we are wondering if that's a better route than upgrading the 
> flamebox scripts. Having our existing cvsweb, bonsai, and gitweb along 
> with the git utilities seems at least desirable. Any thoughts or 
> suggestions?

My suggestion: if you're fine with CVS, stick with it.  Really.  I am not 
here to teach the whole world about the advantages of git, so by all 
means, if you yourself do not find any advantage to using git, don't use 
it.  Stick with what works for you.

Ciao,
Dscho
