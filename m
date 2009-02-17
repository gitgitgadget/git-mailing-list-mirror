From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Feb 2009, #05; Mon, 16)
Date: Tue, 17 Feb 2009 15:12:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171509010.6185@intel-tinevez-2-302>
References: <7vfxid8phr.fsf@gitster.siamese.dyndns.org> <m3wsbps708.fsf@localhost.localdomain> <200902171204.20184.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:14:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQi9-0000cq-H6
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbZBQOMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbZBQOMl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:12:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:43247 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751171AbZBQOMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 09:12:41 -0500
Received: (qmail invoked by alias); 17 Feb 2009 14:12:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 17 Feb 2009 15:12:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2oH0n4uy2dFqjh2re1rjpWD6fM/YDkr1OoB4z4U
	NyJ/Df4TQJzPsq
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200902171204.20184.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110385>

Hi,

On Tue, 17 Feb 2009, Thomas Rast wrote:

> Jakub Narebski wrote:
> > > * tr/gcov (Sun Feb 15 23:25:45 2009 +0100) 8 commits
> > >  - Test git-patch-id
> > >  - Test rev-list --parents/--children
> > >  - Test log --decorate
> > >  - Test fsck a bit harder
> > >  - Test log --graph
> > >  - Test diff --dirstat functionality
> > >  - Test that diff can read from stdin
> > >  - Support coverage testing with GCC/gcov
> > 
> > Hmmmm... wouldn't it be nice to have more tests?
> 
> I was hoping the coverage patch would give people an incentive to
> write some ;-)
> 
> Seriously, the list is huge.

Well, judging from your patch-id example, I am somewhat doubtful: the meat 
of patch-id is exercized in the --cherry-pick patches.

IMHO the biggest shortcoming of gcov is that it cannot distinguish between 
functions that need thorough testing and functions which don't.

Don't get me wrong, I do not want to downplay the importance of tr/gcov, 
I'd like to have it in git.git, but just making tests for all the 
uncovered functions would just make a full test run longer, for dubitable 
value.

Ciao,
Dscho
