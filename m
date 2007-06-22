From: Raimund Bauer <ray007@gmx.net>
Subject: Re: problem pushing repository
Date: Fri, 22 Jun 2007 15:38:04 +0200
Message-ID: <1182519484.6207.38.camel@localhost>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
	 <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
	 <20070622022426.GA2961@bowser.ruder> <1182496916.6207.11.camel@localhost>
	 <Pine.LNX.4.64.0706221224310.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andrew Ruder <andy@aeruder.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 22 15:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1jL3-0000Ta-E1
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 15:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbXFVNiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 09:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbXFVNiJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 09:38:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:43601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754415AbXFVNiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 09:38:08 -0400
Received: (qmail invoked by alias); 22 Jun 2007 13:38:06 -0000
Received: from p5498A0C3.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.152.160.195]
  by mail.gmx.net (mp038) with SMTP; 22 Jun 2007 15:38:06 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1+gzlFUNUagVq2C9X+4zHir4hq2xArYdI+PsyiYMW
	dgXQJ0iYhifDrs
In-Reply-To: <Pine.LNX.4.64.0706221224310.4059@racer.site>
X-Mailer: Evolution 2.10.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50697>

Hi,

On Fri, 2007-06-22 at 12:26 +0100, Johannes Schindelin wrote: 
> Hi,
> 
> On Fri, 22 Jun 2007, Raimund Bauer wrote:
> 
> > $ git push slcom test:test 
> > error: dst refspec test does not match any existing ref on the remote
> > and does not start with refs/.
> > fatal: The remote end hung up unexpectedly
> > error: failed to push to
> > 'ray@softwarelandschaft.com:/home/ray/repos/drupal/multirate'
> 
> This is a completely unrelated problem!
> 
> It says that there is no branch named "test" on the remote side, and since 
> you could also want to push a tag, you have to say
> 
> 	test:refs/heads/test
> 
> here. However, I do not understand why you bother to use the :dst syntax 
> here, since your target name is _exactly_ the same as the source name. Why 
> not just
> 
> 	git push slcom test

because I had gotten the command line from bash-completion and since it
worked with existing branches I saw no reason why it shouldn't work with
new ones.
will read the documentation next time ;-)

> Ciao,
> Dscho

-- 
best regards

  Ray
