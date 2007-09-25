From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unable to connect to the server
Date: Wed, 26 Sep 2007 00:51:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709260048370.28395@racer.site>
References: <1190365837.5497.4.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kaushalya Satharasinghe <kaushalyas@zone24x7.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaKEa-0007MF-SJ
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 01:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbXIYXwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 19:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbXIYXwk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 19:52:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:40136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752553AbXIYXwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 19:52:39 -0400
Received: (qmail invoked by alias); 25 Sep 2007 23:52:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 26 Sep 2007 01:52:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18p3+YyqG8pa51Fi08PKZhJ6O7yFFvKYMR0zaJTxa
	RaYN3OeLFusGvv
X-X-Sender: gene099@racer.site
In-Reply-To: <1190365837.5497.4.camel@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59196>

Hi,

On Fri, 21 Sep 2007, Kaushalya Satharasinghe wrote:

> I want to checkout a git package. I installed git and when I give the
> command
> "/root/bin/git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git /home/Kaushalya/moreWork/git_test
> "
> I got the result as
> 
> Initialized empty Git repository
> in /home/Kaushalya/moreWork/git_test/.git/
> git.kernel.org[0: 140.211.167.38]: errno=Connection timed out
> fatal: unable to connect a socket (Connection timed out)
> fetch-pack from
> 'git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git' failed.
> 
> I can ping the 140.211.167.38. I am using Fedora Core 5 hosted through
> vmware 5.5. Can anyone help me out here?

You're probably quite a few hops away from that machine.  However, mmc.git 
is a fork of the kernel tree, so if you can get ahold of any other kernel 
repository (for example from repo.or.cz), you can easen the load by using 
the --reference option to git-clone.

Hth,
Dscho
