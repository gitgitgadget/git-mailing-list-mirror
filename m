From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 11:00:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191058090.14781@racer.site>
References: <11848281302504-git-send-email-aroben@apple.com>
 <200707190848.54655.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 12:01:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBSos-0003ej-VF
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 12:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbXGSKAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 06:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764878AbXGSKAj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 06:00:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:47015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765188AbXGSKAg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 06:00:36 -0400
Received: (qmail invoked by alias); 19 Jul 2007 10:00:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 19 Jul 2007 12:00:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AUpodwuBAejBKqCr90R/DeWS90X8J5Y1pxetxe/
	wAo0Kr1bBfEp9M
X-X-Sender: gene099@racer.site
In-Reply-To: <200707190848.54655.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52960>

Hi,

On Thu, 19 Jul 2007, Andy Parkins wrote:

> On Thursday 2007 July 19, Adam Roben wrote:
> 
> >    Well, it turns out we already do launch an editor in other places,
> > namely "git am -i" and "git send-email --compose". So, this patch takes
> > care of those cases as well.
> 
> Perhaps I'm being overly pedantic, but it seems odd to put options that are 
> relevant only to porcelain under the "core" section.
> 
> core.pager is in the same category - but that's already in.
> 
> Would porcelain.editor be a better name for this variable?

>From my point of view you can put into "myWonderfulGit.editor".  It does 
not matter.

So why not just leave it in "core", also because -- strictly speaking -- 
those commands in git.git are not really your regular porcelain. They are 
tested with almost every commit, and therefore have a much better chance 
not to be broken inadvertently by changes to the core.

Ciao,
Dscho
