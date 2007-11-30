From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run
 without sub-commands
Date: Fri, 30 Nov 2007 11:50:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711301149110.27959@racer.site>
References: <e66701d40711300016v15700deft3d262d75a9055aca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@bluebottle.com>
To: Kevin Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:51:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4OZ-0002eM-6N
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 12:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759664AbXK3Lui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 06:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759074AbXK3Lui
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 06:50:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:51248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759427AbXK3Lui (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 06:50:38 -0500
Received: (qmail invoked by alias); 30 Nov 2007 11:50:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 30 Nov 2007 12:50:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SvwlHplDS5zws4iugv5jrbli+ce2/VBmSkN/+d0
	TOFWuz/yhrrzUW
X-X-Sender: gene099@racer.site
In-Reply-To: <e66701d40711300016v15700deft3d262d75a9055aca@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66632>

Hi,

On Fri, 30 Nov 2007, Kevin Leung wrote:

> The current git-stash behaviour is very error prone to typos. For 
> example, if you typed "git-stash llist", git-stash would thought that 
> you wanted to save to a stash named "llist", but in fact, you meant 
> "git-stash list".

I am fine with your patch.  I would be equally fine with "git stash" still 
choosing a default message and stashing.

And yes, I agree that the "git stash <whatever>" might be a little too 
error-prone.

Ciao,
Dscho
