From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [bug?] git-format-patch produces a 0-byte long patch for the
 first commit
Date: Tue, 24 Mar 2009 12:46:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903241244380.7493@intel-tinevez-2-302>
References: <Pine.LNX.4.64.0903231119110.4871@axis700.grange> <20090324075424.GC32400@coredump.intra.peff.net> <Pine.LNX.4.64.0903240901570.4451@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 24 12:48:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm571-0008Nt-9G
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 12:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbZCXLqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 07:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbZCXLqd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 07:46:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:50663 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754027AbZCXLqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 07:46:33 -0400
Received: (qmail invoked by alias); 24 Mar 2009 11:46:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 24 Mar 2009 12:46:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qcxtLuAoqd7SX6TLVWKu2/ofIzJFhNpZ+GOrH0L
	4l3J+o9oUOYO3M
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <Pine.LNX.4.64.0903240901570.4451@axis700.grange>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114453>

Hi,

On Tue, 24 Mar 2009, Guennadi Liakhovetski wrote:

> On Tue, 24 Mar 2009, Jeff King wrote:
> 
> > On Mon, Mar 23, 2009 at 11:34:07AM +0100, Guennadi Liakhovetski wrote:
> > 
> > > mkdir x
> > > cd x
> > > git-init
> > > echo hi > greating
> > > git-commit -a
> > > git-format-patch -1
> > > 
> > > produces a 0-byte long patch. git-format-patch HEAD^ produces an 
> > > error, whereas with more than one commit it produces tha last patch. 
> > > Yes, I know about "--root" and that it does allow to extract the 
> > > very first commit.
> > 
> > What version of git are you using? I believe the 0-byte diff has been 
> > fixed since git 1.6.1.1.
> 
> Mine is still 1.5.4, if it's already fixed in the meantime - all the 
> better!

There is the off-chance that somewhere in those 3127 commits between 
v1.5.4 and v1.6.1.1, not only this bug is fixed.  You might be surprised 
;-)

Seriously again, in a project that moves as fast as Git, you should always 
test with a recent version, and v1.5.1 -- being over one year old -- does 
not account for recent.

Ciao,
Dscho
