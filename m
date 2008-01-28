From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge with tkdiff fails (extra operand)
Date: Mon, 28 Jan 2008 14:24:56 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801281423390.23907@racer.site>
References: <fnk90t$gkq$1@ger.gmane.org>  <alpine.LSU.1.00.0801281309240.23907@racer.site> <bdca99240801280605i55f3df00na0eea23488d26e17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 15:25:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJUvm-0007Zs-NK
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 15:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757783AbYA1OZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 09:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757674AbYA1OZS
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 09:25:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:52379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756142AbYA1OZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 09:25:16 -0500
Received: (qmail invoked by alias); 28 Jan 2008 14:25:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 28 Jan 2008 15:25:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JuqZnsfcJcn+RVlZ92z7pXnQ6ykHR2apQ3FTSdV
	oc6wmTLLpqV7pf
X-X-Sender: gene099@racer.site
In-Reply-To: <bdca99240801280605i55f3df00na0eea23488d26e17@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71889>

Hi,

On Mon, 28 Jan 2008, Sebastian Schuberth wrote:

> > > I'm running Git 1.5.3.7 under SuSE 10.0. After pulling and getting a
> > > merge conflict, "git mergetool" by default is configured to run tkdiff.
> > > Unfortunately, tkdiff starts with an error:
> > >
> > > diff failed:
> > > diff: extra operand
> > > `Amira/QxViewer.cpp.REMOTE.28414`
> > > diff: Try diff --help for more information.
> > >
> > > I'm not sure whether the error is with the tkdiff integration into Git,
> > > or with tkdiff itself (as it refers to the help for "diff").
> >
> > It seems that tkdiff calls diff with arguments that diff does not like.
> > What version of tkdiff do you use?
> 
> I'm running TkDiff 4.0.2 (and "diff (GNU diffutils) 2.8.7").
> 
> > P.S.: to make sure that it is tkdiff, I would search for this line in
> > tkdiff:
> >
> >         set g(debug) f
> >
> > and change the "f" to "t".
> 
> I cannot find this line in my version of tkdiff ... in fact, the
> string "debug" does not occur anywhere in the file.

Ah, I was looking at the latest and greatest: 4.1.3.  You can, too:

http://tkdiff.cvs.sourceforge.net/tkdiff/src/tkdiff?revision=1.48&view=markup

Hth,
Dscho
