From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 16:05:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041602230.28586@racer.site>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com> 
 <20070904025153.GS18160@spearce.org>  <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
  <Pine.LNX.4.64.0709040439070.28586@racer.site> 
 <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com> 
 <46a038f90709032121v54454c6fi500ee15497eec85c@mail.gmail.com> 
 <9e4733910709032237y65ccafdai4889078533908fb0@mail.gmail.com> 
 <Pine.LNX.4.64.0709041131030.28586@racer.site>
 <9e4733910709040731s2695ab14kb9750923fcac007@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZyM-0005tb-09
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbXIDPFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbXIDPFi
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:05:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:56685 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754542AbXIDPFh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:05:37 -0400
Received: (qmail invoked by alias); 04 Sep 2007 15:05:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 04 Sep 2007 17:05:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+48flWapy4pUJ4VxNhIdGFyG9iFK7ftXwAiwae1G
	xm1L9ofO5YuQI7
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910709040731s2695ab14kb9750923fcac007@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57592>

Hi,

On Tue, 4 Sep 2007, Jon Smirl wrote:

> On 9/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Tue, 4 Sep 2007, Jon Smirl wrote:
> >
> > > In my scheme the path info is moved into the file object nodes and 
> > > the SHA list is in the commit node.
> >
> > And how should this "SHA list" be any different from a single tree 
> > object, except that you now merge it with the commit object?
> >
> > Really, go back to the mail Martin mentioned.  Having all objects in 
> > one list kills performance.
> 
> You are ignoring the fact the in this scheme temp indexes can be
> created as needed. These temp indexes could look just like tree nodes.
> 
> I'm saying that it may be a mistake to be recording the indexes (aka
> file names) as part of the commit when they really aren't.

You still have not acknowledged that you want to do (in essence) _exactly_ 
the same.  Your "temp indexes" awfully remind me of tree objects.

And that is no wonder, since you _need_ something like that, however you 
want to avoid it.  Just admit it that you found -- again -- that flat 
directory structure does not work, and you therefore need some smaller 
structures.  We just happen to call them "tree objects", and for ease of 
concept we wrap directories in them.

Hth,
Dscho
