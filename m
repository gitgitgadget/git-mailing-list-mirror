From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 17:38:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241736050.8986@racer>
References: <20080723145518.GA29035@laptop>  <alpine.DEB.1.00.0807231713280.8986@racer>  <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>  <alpine.DEB.1.00.0807231753240.8986@racer>  <fcaeb9bf0807240127p5226822atcd4a0711f1bc9c5c@mail.gmail.com>
  <alpine.DEB.1.00.0807241340490.8986@racer>  <fcaeb9bf0807240629v6958014bpfa9aebde281ff57@mail.gmail.com>  <alpine.DEB.1.00.0807241443230.8986@racer>  <fcaeb9bf0807240650v6eab6ad4n63c39973b3b43658@mail.gmail.com>
 <32541b130807240922r733dce6aw8b123bbb28c9002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM3qT-0008Tm-II
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbYGXQiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbYGXQiN
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:38:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:59056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752007AbYGXQiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:38:12 -0400
Received: (qmail invoked by alias); 24 Jul 2008 16:38:10 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp032) with SMTP; 24 Jul 2008 18:38:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18InqNv+UUIOvHEP0VfMPaYBVPdgzLaDNStdL2KtB
	udLc20hRmt2bAf
X-X-Sender: gene099@racer
In-Reply-To: <32541b130807240922r733dce6aw8b123bbb28c9002@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89903>

Hi,

On Thu, 24 Jul 2008, Avery Pennarun wrote:

> [a nice summary about why the index should know the sparse checkout 
>  prefix]

Thanks.

> Also, I don't know if git supports this right now, but I can imagine
> situations where you'd want to have more than one index (and
> associated working trees) sharing the exact same .git folder.

It is.  And I already mentioned it.  Note that it can make sense to work 
on an index only, without ever touching a working directory.

For example, I do that a lot when importing projects that use 
"tarball+patches" for version control.

Ciao,
Dscho
