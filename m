From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert: Revert revert message to old behaviour
Date: Fri, 23 Mar 2007 20:13:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703232013330.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0703230805450.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703231705150.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703230926380.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 20:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUpD5-0004X0-M2
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 20:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbXCWTN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 15:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbXCWTNz
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 15:13:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:36672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752450AbXCWTNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 15:13:54 -0400
Received: (qmail invoked by alias); 23 Mar 2007 19:13:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 23 Mar 2007 20:13:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7cxsUj++7N08FgJeNp0fHLPF05IljrL2nK2BPnN
	CrknEPIoiNHSqN
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703230926380.6730@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42956>

Hi,

On Fri, 23 Mar 2007, Linus Torvalds wrote:

> On Fri, 23 Mar 2007, Johannes Schindelin wrote:
> > 
> > When converting from the shell script, based on a misreading of the
> > sed invocation, the builtin included the abbreviated commit name,
> > and did _not_ include the quotes around the oneline message.
> > 
> > This fixes it.
> 
> How about the empty line in between the message and the "This reverts 
> commit "..
> 
> > +		add_to_msg("Revert \"");
> >  		add_to_msg(oneline);
> > -		add_to_msg("\nThis reverts commit ");
> > +		add_to_msg("\"\nThis reverts commit ");
> 
> This should probably be
> 
> 	add_to_msg("\"\n\nThis reverts commit ");
> 
> with *two* \n's, no?

Yes. Sorry.

Ciao,
Dscho
