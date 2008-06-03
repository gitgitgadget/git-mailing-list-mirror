From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote rename, why dosen't it exists?
Date: Tue, 3 Jun 2008 21:12:13 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806032102350.13507@racer.site.net>
References: <1212497390.30731.3.camel@omicron.ep.petrobras.com.br>  <alpine.DEB.1.00.0806031449010.13507@racer.site.net> <1212503641.30731.11.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:14:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3cth-00043C-S1
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbYFCUN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbYFCUN0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:13:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:41250 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751094AbYFCUNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:13:25 -0400
Received: (qmail invoked by alias); 03 Jun 2008 20:13:22 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 03 Jun 2008 22:13:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19u7exPqWhu5fYwNyuOWdfGOKFlJGiv6S3twMC4qQ
	xxiDOUJ59efCnF
X-X-Sender: gene099@racer.site.net
In-Reply-To: <1212503641.30731.11.camel@omicron.ep.petrobras.com.br>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83697>

Hi,

[please do not top-post: it makes it very hard to follow the flow, 
especially on a high-volume mailing list like this.]

On Tue, 3 Jun 2008, Victor Bogado da Silva Lins wrote:

> On Tue, 2008-06-03 at 14:49 +0100, Johannes Schindelin wrote:
> 
> > On Tue, 3 Jun 2008, Victor Bogado da Silva Lins wrote:
> > 
> > > Well, that's about it, I need to rename my remotes. Mainly to move 
> > > the origin to another repository and I miss the feature. Since many 
> > > time there is a reason for a missing feature, I fought that maybe I 
> > > should ask here, before nosing around the sources... :)
> > 
> > The reason is easy to find: nobody cared enough about this feature to 
> > implement it.
> > 
> > Just tell me if you want to do it, I'll provide you with the necessary 
> > details.
>
> I don't mind trying. :P Pointers would help me, I already found that the
> git-remote source is on the file builtin-remote.c, bu I have not yet
> found the main function of it.

There is no main function, since it is a builtin.  The "main" function is 
called cmd_remote().

You might find inspiration with the rm() function, or might even be able 
to refactor the rm() function into an rm(), and an rm_or_rename() which
does both rm() and rename() depending on a second parameter being NULL or 
not.

Hth,
Dscho
