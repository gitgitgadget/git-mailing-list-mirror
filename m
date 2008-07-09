From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merging a foreign tree into a bare repository.
Date: Wed, 9 Jul 2008 20:42:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807092040360.4010@eeepc-johanness>
References: <1215562468.4199.26.camel@moss-terrapins.epoch.ncsc.mil> <alpine.DEB.1.00.0807090238561.5277@eeepc-johanness> <m3lk0bdkyl.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 20:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGedG-0005Sb-2z
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 20:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbYGISmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 14:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbYGISmK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 14:42:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:37113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753019AbYGISmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 14:42:09 -0400
Received: (qmail invoked by alias); 09 Jul 2008 18:42:06 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp061) with SMTP; 09 Jul 2008 20:42:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18M/iVU9UYM/ni+3lg4ag8XZTuIFeoXU/gcliQshP
	frx95rl3nB71g6
X-X-Sender: user@eeepc-johanness
In-Reply-To: <m3lk0bdkyl.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87905>

Hi,

On Wed, 9 Jul 2008, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 8 Jul 2008, Dave Quigley wrote:
> > 
> > > I tried to then merge them but you need a working directory to merge the 
> > > changes which makes sense.
> > 
> > Of course it does.  Merging runs the risk of conflicts, and you need a 
> > working directory for that.
> > 
> > > How would one go about doing this with a bare repository?
> > 
> > Very easy: clone it ("non-barely"), merge, and push back the results.
> > 
> > You _need_ a working directory for the merge.
> 
> Or, alternatively, you can tell git where you want to have working
> directory with '--work-tree' parameter to git wrapper,

... which runs the risk of you forgetting to specify the same working 
directory all the time.

Which is the reason I did not suggest it.

> You can also set core.worktree configuration variable...

... effectively turning it into a non-bare repository.  Was that the 
question, how to turn a bare repository into a non-bare one?

Ciao,
Dscho
