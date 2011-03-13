From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Clarify: rebase abort leaves <branch> checked-out
Date: Sun, 13 Mar 2011 18:40:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1103131839030.1561@bonsai2>
References: <1300035258.5129.12.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Mar 13 18:41:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PypHo-0007RD-Ag
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 18:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646Ab1CMRkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 13:40:45 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:41547 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754724Ab1CMRko (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 13:40:44 -0400
Received: (qmail invoked by alias); 13 Mar 2011 17:40:40 -0000
Received: from pD9EB1B5E.dip0.t-ipconnect.de (EHLO noname) [217.235.27.94]
  by mail.gmx.net (mp057) with SMTP; 13 Mar 2011 18:40:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JHGUEV+jJBDUzm57gfn20K6LfrBfZt/Pk7WNvR3
	xdxzDpzXWLzi/i
X-X-Sender: gene099@bonsai2
In-Reply-To: <1300035258.5129.12.camel@drew-northup.unet.maine.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168973>

Hi,

On Sun, 13 Mar 2011, Drew Northup wrote:

> This change makes it clearer that while the change
> to the history effected by executing
> 'git rebase master' and 'git rebase master topic'
> (in the example given) will be the same the
> implicit checkout of the second form will not be
> undone even if the rebase operation itself is
> aborted.

I wonder whether we should not handle that case better. I know that I 
would have expected an abort to undo the branch switch.

Thanks for bringing this to our attention,
Dscho

P.S.:

> 1.6.4

Whoa!
