From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-filter-branch
Date: Sun, 3 Jun 2007 01:50:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706030147520.4046@racer.site>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <f3t2mm$f0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 02:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HueKT-0003zZ-I6
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 02:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbXFCAwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 20:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbXFCAwQ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 20:52:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:58292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754057AbXFCAwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 20:52:16 -0400
Received: (qmail invoked by alias); 03 Jun 2007 00:52:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 03 Jun 2007 02:52:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rj/EcNYZrm/s4HGKXst8PMNyLVW1p4QhVC9X6wF
	yct6+SXWlEKoB7
X-X-Sender: gene099@racer.site
In-Reply-To: <f3t2mm$f0$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48967>

Hi,

[thank you for not including me in the Cc: list]

On Sun, 3 Jun 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > This script is derived from Pasky's cg-admin-rewritehist.
> > 
> > In fact, it _is_ the same script, minimally adapted to work without cogito.
> > It _should_ be able to perform the same tasks, even if only relying on
> > core-git programs.
> > 
> > All the work is Pasky's, just the adaption is mine.
> 
> I was thinking about rewriting cg-adin-rewritehist as git-rewritehist
> using Perl (IIRC it needs bash, not only POSIX shell), and make it
> use git-fast-import.

First, it does not need Perl.

Second, it does not even need bash.

At least that is what I tried to make sure. I replaced the only instance 
of a bashim I was aware, namely the arrayism of $unchanged. It can be a 
string just as well, as we are only storing object names in it.

Tell me if it does not work for you.

Or even better, provide me with a test case that fails for you.

Ciao,
Dscho
