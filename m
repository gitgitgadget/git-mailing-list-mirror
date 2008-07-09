From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Wed, 9 Jul 2008 14:31:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807091427270.5277@eeepc-johanness>
References: <20080701150119.GE5852@joyeux> <20080709101330.GA3525@joyeux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:32:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGYqV-000174-W9
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 14:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757140AbYGIMbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 08:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757040AbYGIMbS
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 08:31:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:34044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756366AbYGIMbR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 08:31:17 -0400
Received: (qmail invoked by alias); 09 Jul 2008 12:31:15 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp005) with SMTP; 09 Jul 2008 14:31:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187cfldzj47zTT5yeNIHR3OgWxg1/KowuL510LZ/z
	i5DhgG4aR3FJdD
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080709101330.GA3525@joyeux>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87878>

Hi,

On Wed, 9 Jul 2008, Sylvain Joyeux wrote:

>   On the symbols side, I propose:
>     > submodule commit is a direct descendant of the commit in the
>       superproject
>     < submodule commit is a direct ancestor of the commit in the
>       superproject
>     + no direct relation between submodule commit and commit in the
>       superproject
>     ? the commit in the superproject cannot be found in the submodule
>       (replaces the initial '!' in my patch)

I like the output of "git checkout" when your local branch is not agreeing 
with the tracked branch.  Maybe it would be more user-friendly to have 
submodule use that type of message, instead of cryptic single letter?

On a related note, the long commit name has been a constant nuisance for 
me.  A short commit name is perfectly enough, methinks.

> - define a git-submodule 'fetch' subcommand which call fetch in each
>   submodule and runs the verbose mode of git-status (can be disabled by
>   a --quiet option).

I like it.

You probably can refactor the code for "update" to do that nicely.

Ciao,
Dscho
