From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: auto-merge after push?
Date: Tue, 12 May 2009 01:28:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905120127320.27348@pacific.mpi-cbg.de>
References: <20090511142326.GA18260@redhat.com> <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302> <20090511201705.GA21045@redhat.com> <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de> <20090511211215.GC21045@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue May 12 01:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3evY-0007eE-CY
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 01:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613AbZEKX2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 19:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbZEKX2n
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 19:28:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:49765 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754083AbZEKX2m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 19:28:42 -0400
Received: (qmail invoked by alias); 11 May 2009 23:28:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 12 May 2009 01:28:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cNmwHXP9cGofljqG9SnalcfaEwz16fswpw4vT02
	1IX5V38v07BevN
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090511211215.GC21045@redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118862>

Hi,

[assuming that you did not mean this mail to be private, I send the answer 
to the Git list...]

On Tue, 12 May 2009, Michael S. Tsirkin wrote:

> On Mon, May 11, 2009 at 11:03:27PM +0200, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Mon, 11 May 2009, Michael S. Tsirkin wrote:
> > 
> > > On Mon, May 11, 2009 at 05:18:06PM +0200, Johannes Schindelin wrote:
> > > > The thing is, a merge can fail.  And then you already need direct access 
> > > > to the working directory in question.
> > > > 
> > > > If you were actually talking about fast-forward pushes (because you did 
> > > > the merge locally already), this might help you:
> > > > 
> > > > 	http://thread.gmane.org/gmane.comp.version-control.git/110251
> > > 
> > > Sounds good. But it looks like this patch is unlikely to be merged, does 
> > > it not?
> > 
> > Unlikely to be merged by Junio?  Without success stories, certainly.
> > 
> > But you can do the same as I did: run your local Git with that patch.  I 
> > am actually growing fonder and fonder of denyCurrentBranch=updateInstead.  
> > It works beautifully here.
> > 
> > Of course, I always know what I am doing.
> > 
> > Ciao,
> > Dscho
> > 
> > P.S.: :-)
> 
> OK. Could you send me the patch pls? gmane doesn't seem to have a "send
> to mail" coption.

It has.  It is a hidden function by the bot known as "Johannes 
Schindelin", listening on git@vger.kernel.org for requests:

http://article.gmane.org/gmane.comp.version-control.git/110251/raw

Ciao,
Dscho
