From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Wed, 20 Feb 2008 15:38:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802201535250.17164@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>  <alpine.LSU.1.00.0802091307160.11591@racer.site>  <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0802100213330.11591@racer.site>  <20080210101756.GB26568@coredump.intra.peff.net>
  <alpine.LSU.1.00.0802101219280.11591@racer.site>  <20080210122321.GA31009@coredump.intra.peff.net>  <alpine.LSU.1.00.0802101303140.11591@racer.site>  <7vzltwavf9.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0802201305350.17164@racer.site>
 <76718490802200720w4dd89dc1lf7b19d546d3bfd00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 16:40:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRr3b-0008Pf-OB
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 16:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765387AbYBTPiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 10:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933415AbYBTPiu
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 10:38:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:53779 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933407AbYBTPis (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 10:38:48 -0500
Received: (qmail invoked by alias); 20 Feb 2008 15:38:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 20 Feb 2008 16:38:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Qc2xTnYuQixhkSAuRfDneGRnOSNXsYvDRi2oGd+
	CjhkQBXYAAj0zZ
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802200720w4dd89dc1lf7b19d546d3bfd00@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74520>

Hi,

On Wed, 20 Feb 2008, Jay Soffian wrote:

> On Feb 20, 2008 8:06 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 20 Feb 2008, Junio C Hamano wrote:
> >
> > > Putting this "push = HEAD" by default when "git clone" and "git 
> > > remote add" creates the [remote "$remote"] section is probably 
> > > possible, and at that stage we may even be able to do the "if the 
> > > other end is shared, then set this up automagically", as the result 
> > > of the magic can be inspected in the resulting config file.
> >
> > I think this is too magic, both of it.  Once people get used to "git 
> > push" being implicitly "git push origin HEAD", why should they not 
> > expect "git push <somewhere-else>" to push "HEAD" implicitly, too?
> 
> Well then, how about (don't cringe too much now...)
> 
>   push.conservative = true
> 
> If enabled and "git push" is run w/o arguments, it will first emit what 
> it plans to push and then prompt with "yes/no." I'm kinda opposed to 
> silly prompts -- folks just always go right past them -- so I dunno.
> 
> But it does make the operation a bit more safe I guess.

That depends awfully on your definition of "safe".

I, for one, hate the idea already, that I am "safe" when "git push" does 
not do the thing I asked it to, and which it has done for a couple of 
years now without complaint, and which I have gotten used to.

And then, there will be a great confusion for me, since I work on 5 
different machines on an average day, with 5 different git versions, and 
having different config settings.

That is not "safe" for me.

Thankyouverymuch,
Dscho
