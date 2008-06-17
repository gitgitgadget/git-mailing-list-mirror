From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: no `bare = true' in `config' of a bare repository - problem or
 ignore?
Date: Tue, 17 Jun 2008 10:25:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806171024060.6439@racer>
References: <200806161436.37278.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:28:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8XUJ-0001CS-7M
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 11:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbYFQJ1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 05:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbYFQJ1d
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 05:27:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:51797 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755909AbYFQJ1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 05:27:07 -0400
Received: (qmail invoked by alias); 17 Jun 2008 09:27:05 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp045) with SMTP; 17 Jun 2008 11:27:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qAz04HC2qu7JnbH0mrB+T/wPUUQ9NXN9jyLIqDr
	dIlFF8e7RT8UmB
X-X-Sender: gene099@racer
In-Reply-To: <200806161436.37278.brian.foster@innova-card.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85278>

Hi,

On Mon, 16 Jun 2008, Brian Foster wrote:

>  Whilst investigating a (probably unrelated) mystery,
>  I noticed that some of my bare git repositories had:
> 
> 	[core]
>  	    bare = true
> 
>  whilst others did not (they had no `bare' setting at
>  all).

It's a historical thing: this setting was not present in older Git.  
Basically, we still have some autodetection ignoring the absence of 
core.bare.

Shouldn't be a problem.

Ciao,
Dscho
