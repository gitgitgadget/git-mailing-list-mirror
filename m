From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git branch bug
Date: Sat, 5 May 2007 19:54:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705051954130.4015@racer.site>
References: <Pine.LNX.4.64.0705051823300.13988@bianca.dialin.t-online.de>
 <Pine.LNX.4.64.0705051841200.4015@racer.site>
 <Pine.LNX.4.64.0705051942550.14963@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Sat May 05 19:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOSx-0008My-L2
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934162AbXEERyk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934163AbXEERyk
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:54:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:37599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934162AbXEERyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:54:40 -0400
Received: (qmail invoked by alias); 05 May 2007 17:54:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 05 May 2007 19:54:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0yPZY1WD0EPJ5OaCxRDwy5kK4GBspnIG6fyUXwi
	hHaLiiNxvavNgZ
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0705051942550.14963@bianca.dialin.t-online.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46276>

Hi,

On Sat, 5 May 2007, Guido Ostkamp wrote:

> > On Sat, 5 May 2007, Guido Ostkamp wrote:
> > 
> > > $ mkdir test
> > > $ cd test
> > > $ git init
> > > Initialized empty Git repository in .git/
> > > $ git branch experimental
> > > fatal: Not a valid object name: 'master'.
> > > 
> > > So, it seems it is not possible to create a named branch on an empty
> > > repository.
> > 
> > Actually, it is not possible to branch from a non-existing branch. So,
> > this is somewhat expected from my POV.
> 
> From a git beginners point of view, I would expect that the 'master' 
> branch is automatically created when performing the 'git init'. Why is 
> this not the case?

Well, one side of the branch _is_ created. But you have to provide initial 
content, to make it a proper branch, from which you can actually branch 
off.

Having said that, and having read Daniels mail, I agree that this 
behaviour should be changed, along with the behaviour of "git checkout -b 
<branch>" in a fresh repo.

It might be the illogical thing, to allow branching of a 
yet-to-be-initialised branch, but it does not hurt either.

Ciao,
Dscho
