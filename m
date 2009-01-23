From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 04:20:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>  <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>  <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>  <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
 <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 04:21:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQCcA-0004rv-CD
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 04:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbZAWDU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 22:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbZAWDU0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 22:20:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:33901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750896AbZAWDUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 22:20:25 -0500
Received: (qmail invoked by alias); 23 Jan 2009 03:20:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 23 Jan 2009 04:20:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+O/9RIAsOOM6G9X8NFiEcpf7Y6mYo0NNtnsHn3SI
	5NSiXzjNEXd+2q
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106827>

Hi,

On Fri, 23 Jan 2009, Sverre Rabbelier wrote:

> On Fri, Jan 23, 2009 at 03:42, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > HTTP being 2nd class citizen anyway (and we can always fix it after 
> > Mike's cleanups), I'd say this patch is ready to roll.
> 
> Aside from that, am I correct in asserting that in the "worst case" 
> scenario the repo is cloned instead of erroring out, and a simple "git 
> fetch" would fix the issue?

Probably.  Note, however, that scripts might rely on a fail if there were 
problems.

But then, scripts have no business cloning repositories (fetching, yes.  
But cloning?)

Ciao,
Dscho
