From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 22:35:43 +0200
Message-ID: <20070829203543.GD11824@steel.home>
References: <200708291005.08795.andyparkins@gmail.com> <20070829095202.GE1219@pasky.or.cz> <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com> <Pine.LNX.4.64.0708291446011.28586@racer.site> <20070829135441.GI10749@pasky.or.cz> <Pine.LNX.4.64.0708291502340.28586@racer.site> <20070829141948.GJ10749@pasky.or.cz> <Pine.LNX.4.64.0708291529010.28586@racer.site> <20070829144135.GI1219@pasky.or.cz> <Pine.LNX.4.64.0708291555450.28586@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Benjamin Collins <aggieben@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 29 22:36:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQUHV-0002FJ-9A
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 22:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbXH2UgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 16:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759070AbXH2Ufx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 16:35:53 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:9063 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbXH2Ufp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 16:35:45 -0400
Received: from tigra.home (Fc9fa.f.strato-dslnet.de [195.4.201.250])
	by post.webmailer.de (fruni mo10) (RZmta 12.1)
	with ESMTP id 906adaj7TJVfmk ; Wed, 29 Aug 2007 22:35:43 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 98EBF277BD;
	Wed, 29 Aug 2007 22:35:43 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6F343BE06; Wed, 29 Aug 2007 22:35:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708291555450.28586@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAciAx4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56979>

Johannes Schindelin, Wed, Aug 29, 2007 16:56:32 +0200:
> > > > Your company has certain rules on how all the source on the public 
> > > > branches should look like, etc. It's not quite clear to me how can 
> > > > build system enforce these rules.
> > > 
> > > The same as a hook.  You just put the check into the Makefile.
> > 
> > How exactly does the Makefile affect what does and what does not get 
> > checked in?
> 
> By refusing to compile when something's not right?
> 

How do I "compile" that pile of .docs which they called "project
documentation"?

I really do feel for people working for corporate projects: the rules
are strict (and often stupid) and there are mistakes and punishment
for them. You really don't want to make a merge of a branch containing
commits where description is in wrong format (or wrong content,
because the customer may see it, and one of the greate rules of
bussiness seem to be "hide and obscure").

People prefer to avoid mistakes from happening, then having to correct
them (and yes, they do and will commit without doing sanity check).

So I think Pasky has a valid point
