From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: remote#branch
Date: Tue, 16 Oct 2007 22:35:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710162228560.25221@racer.site>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz>
 <Pine.LNX.4.64.0710161139530.25221@racer.site> <20071016210904.GI26127@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Oct 16 23:36:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihu51-0006Cy-NO
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 23:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965815AbXJPVfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 17:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965803AbXJPVff
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 17:35:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:41866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965445AbXJPVfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 17:35:34 -0400
Received: (qmail invoked by alias); 16 Oct 2007 21:35:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 16 Oct 2007 23:35:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UAMtUHtXUvMuZ0C6udnB3gcUd3Ty57vzEJq5/UX
	yXZr8YYhF9CDyB
X-X-Sender: gene099@racer.site
In-Reply-To: <20071016210904.GI26127@efreet.light.src>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61260>

Hi,

On Tue, 16 Oct 2007, Jan Hudec wrote:

> If it is a fragment, than "#" is the only correct separator and should 
> stay that way.

You did not listen, did you?  '#' is allowed in ref names.  Therefore this 
character really would lock us in to only ever reference _one_ and _only_ 
one remote branch at a time.  This might have worked for cogito, but it 
does not for git.

So, I say it again, '#' is _out_.

> If it is not a true fragment, than we might want to phase it out in 
> favor of something else. But I would strongly prefer staying within 
> characters allowed in URI (as per rfc2396).

If you do that, "http://<xyz-with-branch>" would be ambiguous, wouldn't 
it?  This would already reference an HTTP resource, and you could not 
embed refnames into the URL.

> As for multiple branches, separating them with "," feels logical to me, 
> no matter what separates them from the repository path. On the other 
> hand given that neither ":" nor "@" is allowed in refnames, reusing the 
> same separator would make sense especially if git switched to either of 
> those.

',' is allowed in ref names, so ',' is out.

Ciao,
Dscho
