From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log --graph and root commits
Date: Fri, 13 Feb 2009 12:41:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902131237490.10279@pacific.mpi-cbg.de>
References: <slrngp9t0u.va9.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 12:42:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXwQq-0002Jh-Pr
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 12:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbZBMLkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 06:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbZBMLkT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 06:40:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:57457 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751180AbZBMLkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 06:40:18 -0500
Received: (qmail invoked by alias); 13 Feb 2009 11:40:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 13 Feb 2009 12:40:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lKK92f8rlWC+193v9utyrUIbTab8Z6AFqhlcm6w
	f6umtCkq5iY7dW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <slrngp9t0u.va9.sitaramc@sitaramc.homelinux.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109742>

Hi,

On Fri, 13 Feb 2009, Sitaram Chamarty wrote:

> I was wondering if there was any way, when using 'git log
> --graph --pretty=oneline' to get a different marker (perhaps
> an underscore) for a root commit.

Is it not enough that the line ends?  That is a pretty obvious visual 
marker for me that this is a root commit.  But I see that you are _asking_ 
for the lines not to be shown, by using --pretty=oneline.

You might be interested in this instead:

	git log --graph --pretty=format:'%h %s%n'

Hth,
Dscho
