From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Install built-ins as symlinks
Date: Tue, 11 Jul 2006 20:02:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607111951350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11526131782190-git-send-email-alp@atoker.com>
 <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com>
 <11526131791902-git-send-email-alp@atoker.com> <11526131792773-git-send-email-alp@atoker.com>
 <11526131792377-git-send-email-alp@atoker.com>
 <Pine.LNX.4.63.0607111614550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44B3BC94.3000204@atoker.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 20:03:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0MZY-0003Zg-L7
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 20:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWGKSC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWGKSC4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 14:02:56 -0400
Received: from mail.gmx.de ([213.165.64.21]:21927 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751160AbWGKSCz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 14:02:55 -0400
Received: (qmail invoked by alias); 11 Jul 2006 18:02:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 11 Jul 2006 20:02:53 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alp Toker <alp@atoker.com>
In-Reply-To: <44B3BC94.3000204@atoker.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23722>

Hi,

On Tue, 11 Jul 2006, Alp Toker wrote:

> Johannes Schindelin wrote:
> > > Doing this now will save headache in the long run, avoiding mismatched
> > > versions of installed utilities and dangling copies of removed or
> > > renamed git commands that still appear to work. It also makes screwups
> > > when packaging git or making system backups less likely.
> > 
> > Could we please fix things, which are broken? Not things which work?
> 
> There are maybe a dozen arguments for and against the use of symlinks here,
> some of which Andreas has helpfully explained in his reply. You, on the other
> hand, have managed not to mention a single one of them.

Yes. That is correct. I hoped I did not need to.

The consistency is a non-issue, because the Makefile rules Do The Right 
Thing.

I happen to run git without installing it, mainly because I like to fiddle 
around with git. Now, if "git" does not compile for some reason, with 
symlinks I lose git-diff, git-ls-files, etc.

And -- just maybe -- I _did_ mention a single reason to keep hard links: 
It works now. So why change it?

> If you don't have the technical background to review a certain patch, please
> don't add to the noise.

It is not nice to tell a dumb man how dumb he is. Mommy! I am so sorry 
that I lack the technical background. Please apologize for the noise.

Ciao,
Dscho
