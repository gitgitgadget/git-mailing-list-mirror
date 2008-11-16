From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rev-list ordering
Date: Sun, 16 Nov 2008 22:16:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811162215370.30769@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0811151922310.2935@sys-0.hiltweb.site> <bd6139dc0811151727k605a3575hf409fed32a3a4baf@mail.gmail.com> <alpine.LFD.2.00.0811152040570.2935@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Git Mailing List <git@vger.kernel.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 22:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1otO-00076e-5g
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 22:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbYKPVIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 16:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbYKPVIr
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 16:08:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:53095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751966AbYKPVIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 16:08:47 -0500
Received: (qmail invoked by alias); 16 Nov 2008 21:08:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 16 Nov 2008 22:08:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oPA5aa5oojLjF8wWFFcdvsqbPHUqfwVzjCm2UF5
	VsQRQdo/gux1p/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0811152040570.2935@sys-0.hiltweb.site>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101159>

Hi,

On Sat, 15 Nov 2008, Ian Hilt wrote:

> On Sat, 15 Nov 2008, Sverre Rabbelier wrote:
> > The --reverse is applied after the --max-count, so you are seeing the 
> > reverse of one commit ;). For comparison, have a look at:
> > 
> > $ git rev-list --reverse --max-count=2
> 
> Ah, I see.  So if you didn't want the sorting to take a long time for 
> many commits, you would limit the output to n commits, then sort the 
> output.  Is this the logic behind this design?

Yes.  It is by design, since the guy who wrote the initial --reverse 
support cannot think of an interesting situation where you need to list 
the oldest n commits.

Ciao,
Dscho
