From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: newby question about merge.
Date: Wed, 16 May 2007 15:45:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705161542540.6410@racer.site>
References: <20070515113820.2621c8d5@localhost.localdomain>  <f2c23k$dm0$1@sea.gmane.org>
  <Pine.LNX.4.64.0705161241560.6410@racer.site>
 <46d6db660705160721u24e43f7bmb5171555158089fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 16:45:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoKkr-0005k7-Mt
	for gcvg-git@gmane.org; Wed, 16 May 2007 16:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074AbXEPOpJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 10:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756959AbXEPOpJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 10:45:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:54501 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756074AbXEPOpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 10:45:07 -0400
Received: (qmail invoked by alias); 16 May 2007 14:45:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 16 May 2007 16:45:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aspAvRMYaLubAfrrvxvTdGROVDeOCOu8EyBJO5K
	I2ua1Puluak4en
X-X-Sender: gene099@racer.site
In-Reply-To: <46d6db660705160721u24e43f7bmb5171555158089fb@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47440>

Hi,

[please, Christian, do not cut the Cc: list. In particular, do _not_ cut 
the person you are _responding_ to from the Cc: list]

On Wed, 16 May 2007, Christian MICHON wrote:

> On 5/16/07, Johannes Schindelin wrote:
> > > You can just do "git cat-file -p :2:filename > filename", then "git 
> > > add filename" (or "git update-index filename") to resolve conflict.
> > 
> > Do we really want to advertise this obscure-looking plumbing? Wouldn't 
> > it be better to teach people to use "git show" instead?
> > 
> > I mean, people can get intimidated by that...
> 
> I could be wrong, but git-show works in this way only after version 1.5, 
> right ?

Yes. So what?

> As far as I can tell, using git-1.4.4.4 or ealier, you would still need 
> git-cat-file -p... to fix this merge conflict.

If you are using pre-1.5 Git, you should really, really upgrade.

If you do not want to do that, then _at least_ you should not confuse 
newbies, who _should_ use Git 1.5+.

And most importantly: if you suggest a change in the man pages, it should 
reflect the new Git versions, _not_ the old ones.

Okay?

Ciao,
Dscho
