From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 19:54:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810131950140.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081012183855.GA5255@spearce.org> <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vskr0bnlk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vhc7g9z7s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:48:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRX3-00035e-Bf
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbYJMRrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 13:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbYJMRrZ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:47:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:50365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752342AbYJMRrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:47:24 -0400
Received: (qmail invoked by alias); 13 Oct 2008 17:47:22 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 13 Oct 2008 19:47:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PjPhxEVVPTLLAISEAXQsmWxq5f3qOBPg2Y8IH3Y
	/ZvRNLCg4hFs7z
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vhc7g9z7s.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98131>

Hi,

On Mon, 13 Oct 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > - all the editors that this guy tested keep the hard links, so it was 
> >   kinda hard to understand why Git insists on behaving differently,
> >
> > - if the user asked for hard links, it is not Git's place to question 
> >   that decision,
> 
> These are non-arguments,

Actually, they are arguments.

The thing is: these editors do what they do for a reason.  Which is 
exactly the second reason.

When a user makes hard links, it is not just for fun and bullocks.  It is 
not for copy-on-write either, that's not what hard links are supposed to 
do.  It is for cases when you need the _same_ information in two places.

I am not that big a user of hard links myself, but when I do, I know 
exactly what I am doing.  And with my patch and that config variable set 
to true, Git will not interfer with that.

Ciao,
Dscho
