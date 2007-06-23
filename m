From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Escape some tilde characters causing spurious subscripts
 in documentation
Date: Sat, 23 Jun 2007 23:36:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706232333320.4059@racer.site>
References: <31e9dd080706231519p25520183vb0f102a4585e17f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 00:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2EDr-0002ZK-6e
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 00:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbXFWWgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXFWWgq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 18:36:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:38376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750769AbXFWWgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 18:36:45 -0400
Received: (qmail invoked by alias); 23 Jun 2007 22:36:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 24 Jun 2007 00:36:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/C09I1vK/m6oyipXPshMXOlbAfCotqEqpz8oeel
	/Yu0s/MWCG++MC
X-X-Sender: gene099@racer.site
In-Reply-To: <31e9dd080706231519p25520183vb0f102a4585e17f4@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50755>

Hi,

On Sat, 23 Jun 2007, Jason Sewall wrote:

> This is my first attempt at actually submitting a patch to the git list; 
> let me know if this is a reasonably presented patch. It is truly 
> trivial, but getting those docs cleaned up is important!

You followed SubmittingPatches really well. Commit message, diffstat and 
the comment between message and diffstat.

Thanks.

> @@ -80,12 +80,12 @@ SPECIFYING REFERENCES
> 
> git-bundle will only package references that are shown by
> git-show-ref: this includes heads, tags, and remote heads.  References
> -such as master~1 cannot be packaged, but are perfectly suitable for
> +such as master\~1 cannot be packaged, but are perfectly suitable for

But you have some whitespace damage, unfortunately. The space at the 
beginning of the lines is missing.

Judging from your email address, I suspect you copied&pasted the patch 
into the web interface, and somehow this mangled the white space.

Can you send it somehow via SMTP?

Ciao,
Dscho
