From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git clone / SHA1 mismatch
Date: Fri, 21 Jul 2006 10:37:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607211036160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <007e01c6ac81$d523a700$76401f0a@almare2.tre>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 10:37:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3qVh-00056c-LL
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 10:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWGUIhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 04:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWGUIhR
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 04:37:17 -0400
Received: from mail.gmx.net ([213.165.64.21]:43218 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964827AbWGUIhP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jul 2006 04:37:15 -0400
Received: (qmail invoked by alias); 21 Jul 2006 08:37:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 21 Jul 2006 10:37:14 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Mika Muukkonen <mika.muukkonen@plenware.fi>
In-Reply-To: <007e01c6ac81$d523a700$76401f0a@almare2.tre>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24046>

Hi,

On Fri, 21 Jul 2006, Mika Muukkonen wrote:

> when attempting to clone repositories (Linus's kernel, stable 2.6.16, OMAP kernel) I seem to come across the following more or less constantly:
> 
> mmu@spud1:/var/git$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git linux-2.6.16
> Generating pack...
> Done counting 195441 objects.
> Deltifying 195441 objects.
>  100% (195441/195441) done
> fatal: unexpected EOF)      

This sounds like you had a timeout before the complete pack was 
transmitted (the Deltifying takes place on the other side).

Hth,
Dscho
