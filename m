From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Computing the number of patches in linux-next tree
Date: Tue, 22 Jul 2008 17:28:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807221727210.8986@racer>
References: <12c511ca0807220919q4db6ee1fr33dc70fe35c58efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:30:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLKko-0002Jn-KR
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 18:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbYGVQ2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbYGVQ2T
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:28:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:54751 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750763AbYGVQ2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:28:18 -0400
Received: (qmail invoked by alias); 22 Jul 2008 16:28:16 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp043) with SMTP; 22 Jul 2008 18:28:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+36fkA/yq3jVJvdhUR4mf1QjIp4yVUUlbSNzSSzQ
	zQFTACthOgZOMD
X-X-Sender: gene099@racer
In-Reply-To: <12c511ca0807220919q4db6ee1fr33dc70fe35c58efe@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89495>

Hi,

On Tue, 22 Jul 2008, Tony Luck wrote:

> git tag | grep next- | sort | while read tag

This should not be necessary... AFAICT "git tag" sorts its output already.

> What does the "git-where-did-this-tag-branch-from-linus" command look like?

git merge-base --all <branch1> <branch2>

Be warned: there might be multiple merge bases.

Ciao,
Dscho
