From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Minor clarifications to git-filter-branch usage and doc
Date: Fri, 17 Aug 2007 22:53:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708172252440.20400@racer.site>
References: <20070817212359.GA14197@Hermes.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 23:54:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM9lc-0006Vh-4h
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 23:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbXHQVxo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 17:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756199AbXHQVxo
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 17:53:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:53242 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755607AbXHQVxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 17:53:43 -0400
Received: (qmail invoked by alias); 17 Aug 2007 21:53:42 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp031) with SMTP; 17 Aug 2007 23:53:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qiy5dfaqqU6Vt17F7c+FwM9uPZsz3wIFgHyX/m2
	Dh3KDc5biIpckw
X-X-Sender: gene099@racer.site
In-Reply-To: <20070817212359.GA14197@Hermes.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56090>

Hi,

On Fri, 17 Aug 2007, Brian Gernhardt wrote:

> -USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
> +USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] [BRANCHES]"

It is not just [BRANCHES].  Something like "HEAD~2..HEAD" is perfectly 
valid, and it will rewrite only the commits in that range, leaving HEAD~2 
and ancestors alone.

Ciao,
Dscho
