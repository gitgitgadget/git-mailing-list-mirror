From: Olivier Galibert <galibert@pobox.com>
Subject: Re: What should I use instead of git show?
Date: Mon, 13 Mar 2006 17:50:15 +0100
Message-ID: <20060313165015.GC87487@dspnet.fr.eu.org>
References: <20060313144747.GA81092@dspnet.fr.eu.org> <200603131717.53416.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 17:52:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIqFc-0005ln-OI
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 17:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWCMQuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 11:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWCMQuV
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 11:50:21 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:52485 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751512AbWCMQuV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 11:50:21 -0500
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id DE121A364C; Mon, 13 Mar 2006 17:50:15 +0100 (CET)
To: Radoslaw Szkodzinski <astralstorm@o2.pl>
Content-Disposition: inline
In-Reply-To: <200603131717.53416.astralstorm@o2.pl>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17573>

On Mon, Mar 13, 2006 at 05:17:47PM +0100, Radoslaw Szkodzinski wrote:
> On Monday 13 March 2006 15:47, Olivier Galibert wrote yet:
> > Since it seems to be gone.
> >
> > Up until now, when I wanted to send a patch to someone with the
> > associated changelog, I just did a git log to find the changelog sha1
> > then a git show to get the goods.  How am I supposed to do that now?
> 
> Why not use git-whatchanged? It's exacly meant to do this.

Indeed, git-whatchanged -p origin..HEAD worked.  Thanks.


> Or try qgit, or even gitk (which is what git show did).

gitk does not seem to have an export function.  Dunno about qgit.

  OG.
