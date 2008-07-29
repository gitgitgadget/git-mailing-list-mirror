From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn and svn:externals, was Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 15:17:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291516120.4631@eeepc-johanness>
References: <20080729000103.GH32184@machine.or.cz> <m3myk1t54c.fsf@localhost.localdomain> <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness> <20080729130823.GB30334@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:17:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNp4j-00087M-33
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 15:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbYG2NQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 09:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbYG2NQM
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 09:16:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:43408 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753427AbYG2NQM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 09:16:12 -0400
Received: (qmail invoked by alias); 29 Jul 2008 13:16:09 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp015) with SMTP; 29 Jul 2008 15:16:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XerMpjI0XTnPcwZ5cRejtarafXlN3Wm/JlpmEw0
	zQShafM61lNB5p
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080729130823.GB30334@bit.office.eurotux.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90637>

Hi,

On Tue, 29 Jul 2008, Luciano Rocha wrote:

> On Tue, Jul 29, 2008 at 01:56:37PM +0200, Johannes Schindelin wrote:
> 
> > On Tue, 29 Jul 2008, Jakub Narebski wrote:
> > 
> > >  * handling of svn:externals using submodules
> > 
> > The main concern I have is to get the semantics right: AFAICT 
> > svn:externals has _no notion_ of "what is current".  It just _always_ 
> > fetches the HEAD.  Even if you check out an ancient revision in the 
> > "superproject".
> 
> Usually, yes. But you could specify a specific revision with -r <rev>.

I do not see how that helps defining the semantics for git-svn at all.

> With the new 1.5, it is also possible to specify pegged revisions. Much 
> better, because otherwise subversion would require that the path existed 
> in the server in HEAD.

As I already commented, the possibility (and for most svn repositories, 
the likelihood) that nothing is pegged makes this less helpful, either.

Ciao,
Dscho
