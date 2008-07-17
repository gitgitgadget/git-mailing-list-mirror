From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 19:16:37 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807171915420.8986@racer>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <7vmykhpn6z.fsf@gitster.siamese.dyndns.org> <20080717155538.GE11759@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJY2q-0004Av-W3
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 20:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058AbYGQSQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 14:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757648AbYGQSQh
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 14:16:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:47089 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756410AbYGQSQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 14:16:37 -0400
Received: (qmail invoked by alias); 17 Jul 2008 18:16:35 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp019) with SMTP; 17 Jul 2008 20:16:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZZA43frRZsAU6XmUyodnpDQ7XDrTne8vj1AtKxn
	apWaQnJvPK4z8E
X-X-Sender: gene099@racer
In-Reply-To: <20080717155538.GE11759@fieldses.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88894>

Hi,

On Thu, 17 Jul 2008, J. Bruce Fields wrote:

> On Wed, Jul 16, 2008 at 01:51:31PM -0700, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Am I the only one who deems teaching plumbing to users ("I like it raw!  
> > > So I teach it the same way!") harmful?
> > 
> > I think that justification is harmful.
> > 
> > More productive way to think about it is to identify cases where we _need_
> > to go down to combination of the plumbing commands in our daily workflow,
> > with today's command set.  That would give us a good indication that some
> > Porcelain may need to be enhanced.
> 
> Is there a way to commit the contents of a tarball without using
> plumbing?  I occasionally want to track an upstream that I know only as
> a series of tarballs, so I do something like:
> 
> 	cd repo/
> 	git checkout upstream
> 	rm -rf *
> 	tar -xzvf ../new-version.tar.gz

How about "git add -u" and "git add ."?

Ciao,
Dscho
