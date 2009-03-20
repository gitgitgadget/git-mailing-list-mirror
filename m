From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Introduce %<branch> as shortcut to the tracked
 branch
Date: Fri, 20 Mar 2009 01:23:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Andreas Gruenbacher <agruen@suse.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:23:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSWQ-0005hR-OS
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbZCTAWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755342AbZCTAWG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:22:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:53538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751032AbZCTAWF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:22:05 -0400
Received: (qmail invoked by alias); 20 Mar 2009 00:22:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 20 Mar 2009 01:22:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NZrMKpxONGgwBK15gixg4DG/RgMvZ/elcxbX1y8
	svB8AXenrObWJP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113872>

Hi,

On Wed, 18 Mar 2009, Johannes Schindelin wrote:

> On Wed, 18 Mar 2009, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Suggested by Pasky.
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > In the longer term who suggested matters much less than why such a 
> > feature is desirable, how it is used, and without it what is impossible 
> > and/or cumbersome.  What's the motivation behind this?
> > 
> > You do not have to explain it to me, but you should explain it to the 
> > history that records this commit, and to the users who read doccos.
> 
> And that's not all... Documentation updates and tests for % and %<branch> 
> are missing, too.

Darn, darn, DARN!

Just when I squeezed that half an hour from the time I have to sleep, to 
provide documentation and tests, _just_ after I finished that, I got the 
idea that '%' might not be a 'bad ref char' after all.

And of course I was correct.

Just try this:

	$ git checkout -b %helloworld

and weep... so, no v3 of that patch, even if I have it right here.

Ciao,
Dscho "who goes to bed being frustrated"
