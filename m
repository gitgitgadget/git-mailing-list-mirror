From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Fri, 3 Apr 2009 04:52:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904030447480.10279@pacific.mpi-cbg.de>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de> <7v63hmekyv.fsf@gitster.siamese.dyndns.org>
 <49D542FA.3070304@gmail.com> <alpine.DEB.1.00.0904030107320.10279@pacific.mpi-cbg.de> <49D54799.9010607@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 04:52:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpZWM-0006ix-Eq
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 04:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbZDCCu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 22:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbZDCCu1
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 22:50:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:32892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752554AbZDCCu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 22:50:26 -0400
Received: (qmail invoked by alias); 03 Apr 2009 02:50:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 03 Apr 2009 04:50:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VTow/pcrV6hpcc/7KMF9LAj5Hxd6/9LE6u297xf
	MU5lahQFz2/uEr
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49D54799.9010607@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115513>

Hi,

On Thu, 2 Apr 2009, A Large Angry SCM wrote:

> Johannes Schindelin wrote:
> 
> > On Thu, 2 Apr 2009, A Large Angry SCM wrote:
> > 
> > > Junio C Hamano wrote:
> > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > >
> > > > > > What part of the email address is this going to lowercase? 
> > > > > > Only the domain name is case agnostic.
> > > >
> > > > That is my understanding of RFC, too.  Let's see where this mail 
> > > > goes to find out how much more lenient the real world is ;-).
> > > >
> > > Many email providers/servers are lenient when it comes to case in 
> > > the local part of an email address (after all, they control the 
> > > interpretation) but not every provider/server is and the RFC is VERY 
> > > clear on this issue.
> > 
> > And in one of my projects it is _very_ clear that this strict 
> > interpretation of the RFC, which does not matter in reality, 
> > _actively_ _hurts_.
> 
> Care to provide actual justification for that statement.

Well, I _did_!  I have at least _one_ repository where the case 
insensitive email addresses worked, and got fscked over, by having Git 
change behavior behind my back!

> > In the alternative, can I ask you to adjust my .mailmap in your free 
> > time?
> 
> _Your_ .mailmap file is your issue.
> 
> So which standards do you choose to follow and which do you choose to 
> ignore?

You chose a rather inappropriate moment to start one of those damned 
flamewars -- I am in the middle of some rather important day-job meeting, 
plus two projects in the deadline-is-looming GSoC frenzy.

In case it was not clear yet: if I have to chose between following a 
standard and reality that just took over, I will _always_ choose the 
latter.

If you take this mail to start a flamewar for real (i.e. not answer to my 
concerns, but point out that standard X says bla, and that everybody else 
should just obey, oh, and fix their ways as of 20 years), please do remove 
me from the Cc: list.

Ciao,
Dscho
