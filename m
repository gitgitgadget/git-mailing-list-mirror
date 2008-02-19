From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 19:19:49 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191916020.7797@racer.site>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>  <20080219063937.GB3819@glandium.org>  <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>  <alpine.LSU.1.00.0802191115440.30505@racer.site> 
 <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>  <47BB1EC0.601@freescale.com> <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Loeliger <jdl@freescale.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:20:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRY1H-0001kk-RS
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 20:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbYBSTUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 14:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbYBSTUL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 14:20:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:35300 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754085AbYBSTUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 14:20:10 -0500
Received: (qmail invoked by alias); 19 Feb 2008 19:20:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 19 Feb 2008 20:20:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19i4shbMtZiwsngj6pNvSF8KI0d/4zCmAym3G9bBw
	0bNLvEnDvM5S3b
X-X-Sender: gene099@racer.site
In-Reply-To: <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74445>

Hi,

On Tue, 19 Feb 2008, Anatoly Yakovenko wrote:

> > > If you often merge with the same branch, you may want to
> > > configure the following variables in your configuration
> > > file:
> > >
> > >     branch.master.remote = <nickname>
> > >     branch.master.merge = <remote-ref>
> > >     remote.<nickname>.url = <url>
> > >     remote.<nickname>.fetch = <refspec>
> > >
> > > See git-config(1) for details
> >
> > Did you follow this advice?  You've set up the
> > origin's URL now, and so it knows from where the
> > fetch step will happen, but have you set up the
> > merge step yet?  Does it know what branches to
> > merge on that pull request?
> 
> i dont understand what these values should be. 
> http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt
>  doesn't mention anything about configuring them.  So why cant i have 
> git working the same way over http as it does over ssh and the 
> filesystem?

You can.  But please understand that there is a difference from having 
cloned from somewhere, or setting up an uncloned repository.

You are experiencing that it is not all that easy to set up tracking 
information when your local branch is the original, and the remote was 
initialised with your local branch.

So the documentation you quoted does not help.  You are supposed to know 
enough about git details, such as where to find out what the 
branch.*.remote and branch.*.merge settings mean, before reading 
setup-git-server-over-http.txt.

Ciao,
Dscho
