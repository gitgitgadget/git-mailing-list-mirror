From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Mon, 16 Feb 2009 00:01:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 00:02:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpzx-0006Qt-4x
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbZBOXAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZBOXAh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:00:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:42811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752960AbZBOXAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:00:36 -0500
Received: (qmail invoked by alias); 15 Feb 2009 23:00:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 16 Feb 2009 00:00:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+p8YxTGX2pMStBOr6jOJ4oywK5yk+mNJ7L/Y1AfU
	vmN71rpOcCh76W
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110079>

Hi,

On Sun, 15 Feb 2009, david@lang.hm wrote:

> On Sun, 15 Feb 2009, Junio C Hamano wrote:
> 
> > Thanks.
> >
> > * git-push to update the checked out branch will be refused by default
> >
> >  Make "git push" into a repository to update the branch that is checked
> >  out fail by default.
> >
> >  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> 
> If I understand this one, it will cause grief for quite a few people.
> 
> I have a public repository that I push to and then have a trigger that checks
> out the current version, compiles it, publishes the compiled version, sends an
> announcement, etc

So you have to set a config variable.  Big deal.

Compared to that, the thousands of new Git users will no longer be bitten 
by the "do not push to a non-bare repository" issue without a useful error 
message.

Please, please, publicize that if there is somebody who is doing the same 
as you (which I deem a dangerous workflow; I certainly do not use it 
myself) that they will have to adjust their receive.denyCurrentBranch 
variable.

Ciao,
Dscho
