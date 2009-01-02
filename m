From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: why still no empty directory support in git
Date: Fri, 2 Jan 2009 19:55:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021954410.30769@pacific.mpi-cbg.de>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com> <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net> <alpine.DEB.2.00.0812300113050.22107@vellum.laroia.net> <9b18b3110812300043l55a42f6sd995f36bf857543e@mail.gmail.com>
 <alpine.DEB.2.00.0812300346040.19911@vellum.laroia.net> <20090101200651.GB6536@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 02 19:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIpCN-00013K-W7
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbZABSzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbZABSzW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:55:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:39080 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751741AbZABSzW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:55:22 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:55:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 02 Jan 2009 19:55:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/A8bYiIhvAuWQLnBF9XItYvDrN49aY4fI+gR+Jpq
	8jFbJLDHculvcp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090101200651.GB6536@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104404>

Hi,

On Thu, 1 Jan 2009, Jeff King wrote:

> On Tue, Dec 30, 2008 at 03:58:46AM -0500, Asheesh Laroia wrote:
> 
> > So, let's say I take your suggestion.
> >
> > $ touch ~/Maildir/new/.exists
> > $ git add ~/Maildir/new/.exists && git commit -m "La di da"
> >
> > Now a spec-compliant Maildir user agent will attempt to deliver this new  
> > "email message" of zero bytes into the mail spool and assign it a message  
> > UID.  Doing so will remove it from Maildir/new.
> 
> No. The maildir spec says:
> 
>   A unique name can be anything that doesn't contain a colon (or slash)
>   and doesn't start with a dot.
>      -- http://cr.yp.to/proto/maildir.html
> 
> where a "unique name" is the filename used for a message. In practice,
> every maildir implementation I have seen ignores files starting with a
> dot. Do you have one that doesn't?

For the record, I am using Git to manage my mails, and never had any 
problems after installing a hook which marks new empty directories with 
.gitignore.

Ciao,
Dscho
