From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 15:20:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281520220.5399@eeepc-johanness>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <alpine.DEB.1.00.0804281444320.5399@eeepc-johanness>
 <E58664C1-86E5-452A-A7CD-2007DD59A75E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:21:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqUEi-0000CA-QT
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 16:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933782AbYD1OUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 10:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933574AbYD1OUt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 10:20:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:51524 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763151AbYD1OUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 10:20:48 -0400
Received: (qmail invoked by alias); 28 Apr 2008 14:20:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 28 Apr 2008 16:20:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185nMRqtRw5tFfaCw1FQKh/w3eizUtgmWtvzgzAYp
	MVMYSYhITsHX6R
X-X-Sender: user@eeepc-johanness
In-Reply-To: <E58664C1-86E5-452A-A7CD-2007DD59A75E@silverinsanity.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80537>

Hi,

On Mon, 28 Apr 2008, Brian Gernhardt wrote:

> On Apr 28, 2008, at 9:46 AM, Johannes Schindelin wrote:
> 
> >How about fixing the code to not need tac instead?  We went to great 
> >lengths to introduce the --reverse option to the rev-list command, in 
> >order to avoid tac in the original version of rebase -i.
> 
> Because this is reversing the output of a sub-shell (ll.395-471), not 
> rev-list.  And making the shell code insert commands before the lines 
> the produce it would make the code complex at best.  (And it's not 
> simple code either.)

That's my _point_: the code is way too complex for what it tries to 
accomplish, namely implement a sane syntax for rebase -i -p.

Ciao,
Dscho
