From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Tue, 3 Jun 2008 21:16:42 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806032115340.13507@racer.site.net>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:19:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3cxz-0005nY-S5
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbYFCURz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbYFCURz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:17:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:58815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751918AbYFCURy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:17:54 -0400
Received: (qmail invoked by alias); 03 Jun 2008 20:17:52 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 03 Jun 2008 22:17:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18L5lpCj28Lavj0XmlPTM7tIFdOql3kOVGuxeYI1s
	wGAJfb8q0mutsq
X-X-Sender: gene099@racer.site.net
In-Reply-To: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83699>

Hi,

On Tue, 3 Jun 2008, Jaroslav Kysela wrote:


>  'git-am' [--signoff] [--keep] [--utf8 | --no-utf8]
> -         [--3way] [--interactive] [--binary]
> +         [--3way] [--interactive] [--binary] [--committer]
>
> [...]
>  
> +--committer
> +	Use committer and committer date extracted from
> +	`X-Git-Committer` and `X-Git-CommitterDate` header
> +	lines.
> +

That feels really funny, given that the guy running git-am _is_ the 
committer, not whoever provided some extra headers to the mailbox.

Ciao,
Dscho
