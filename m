From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 19:43:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807171940160.8986@racer>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <7vmykhpn6z.fsf@gitster.siamese.dyndns.org> <20080717155538.GE11759@fieldses.org> <alpine.DEB.1.00.0807171915420.8986@racer> <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJYTD-00071m-IZ
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 20:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758183AbYGQSnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 14:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758161AbYGQSnv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 14:43:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:36121 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754513AbYGQSnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 14:43:51 -0400
Received: (qmail invoked by alias); 17 Jul 2008 18:43:49 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp022) with SMTP; 17 Jul 2008 20:43:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/o3hVzyC/o0lwqb+1643aACLeW2b7rEhjL7hNTgW
	iibBKrM64j+KLi
X-X-Sender: gene099@racer
In-Reply-To: <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88901>

Hi,

On Thu, 17 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Is there a way to commit the contents of a tarball without using 
> >> plumbing?  I occasionally want to track an upstream that I know only 
> >> as a series of tarballs, so I do something like:
> >> 
> >> 	cd repo/
> >> 	git checkout upstream
> >> 	rm -rf *
> >> 	tar -xzvf ../new-version.tar.gz
> >
> > How about "git add -u" and "git add ."?
> 
> It would work only if new version never removes files.

You made me doubt for a second there.  But "git add -u" updates the index 
when a tracked files was deleted.  So after "rm -rf *", "git add -u" would 
empty the index.

AFAICT this has been a part of "git add -u" ever since dfdac5d(git-add -u: 
match the index with working tree.), i.e. ever since the "-u" option was 
added.

Ciao,
Dscho
