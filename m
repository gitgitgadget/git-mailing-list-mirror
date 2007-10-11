From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch: if not fetching from default remote, ignore
 default   merge
Date: Thu, 11 Oct 2007 12:34:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710111233280.4174@racer.site>
References: <Pine.LNX.4.64.0710110146200.4174@racer.site> <470DC53A.4050707@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, hjemli@gmail.com, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 13:35:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfwJi-0007b3-7y
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 13:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbXJKLeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 07:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbXJKLeu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 07:34:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:56363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751694AbXJKLet (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 07:34:49 -0400
Received: (qmail invoked by alias); 11 Oct 2007 11:34:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 11 Oct 2007 13:34:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CHBoDFxiCQDuGbhbEw6Qk2KlEXGz9ZR0YKVLraB
	SPLACV7XY30qOv
X-X-Sender: gene099@racer.site
In-Reply-To: <470DC53A.4050707@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60592>

Hi,

On Thu, 11 Oct 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > +test_expect_success 'fetch with a non-applying branch.<name>.merge' '
> > +	git config branch.master.remote yeti &&
> > +	git config branch.master.merge refs/heads/bigfoot &&
> > +	git config remote.blub.url one &&
> > +	git config remote.blub.fetch 'refs/heads/*:refs/remotes/one/*' &&
> 
> Better use double-quotes around the refspecs.

Hehe, "oops!".

Although in this case we could even use the string unquoted (which I 
indeed did!), since there is no chance that there is a matching file in 
t/trash/.

Ciao,
Dscho
