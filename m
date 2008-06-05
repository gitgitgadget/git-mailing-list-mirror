From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Allow git-apply to fix up the line counts
Date: Thu, 5 Jun 2008 14:04:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051403370.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:07:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4FAw-0003rK-B1
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbYFENFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYFENFu
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:05:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:36996 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753496AbYFENFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:05:49 -0400
Received: (qmail invoked by alias); 05 Jun 2008 13:05:47 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp055) with SMTP; 05 Jun 2008 15:05:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FdaxYxmhFtSBymJAjxHYL2DR+ZByYHRu+DqzkVY
	n55aiE4VIfAbKX
X-X-Sender: gene099@racer
In-Reply-To: <4847CCD9.6000305@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83924>

Hi,

On Thu, 5 Jun 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > +--fixup-line-counts::
> > +	Fix up the line counts (e.g. after editing the patch without
> > +	adjusting the hunk headers appropriately).
> 
> This sort of implies that there is some kind of output that tells the
> correct line counts. But that isn't the case (if I read the patch
> correctly). So I suggest to name the option --ignore-line-counts.

But there is some kind of output: the hunks themselves.  And the line 
counts are not ignored, but they are actively rewritten.  But if you have 
a suggestion which keeps the spirit, I am very interested...

Ciao,
Dscho
