From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: try to read the dcommit url from the config
	file
Date: Sun, 22 Feb 2009 18:05:46 -0800
Message-ID: <20090223020545.GE26706@dcvr.yhbt.net>
References: <200902191930.10139.kumbayo84@arcor.de> <20090221120815.GA8145@dcvr.yhbt.net> <200902222241.56223.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Mon Feb 23 03:07:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbQE0-0002Uf-MJ
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 03:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZBWCFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 21:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbZBWCFr
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 21:05:47 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54453 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbZBWCFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 21:05:46 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476241F5FC;
	Mon, 23 Feb 2009 02:05:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902222241.56223.kumbayo84@arcor.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111072>

Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> On Samstag 21 Februar 2009, Eric Wong wrote:
> > Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> > > The commit url is determined in the following order
> > > --commit-url commandline
> > 
> > actually, it should look in the .git/config for this, too:
> > 
> >   svn.commiturl
> > 
> 
> I did not see that the commandline options are also searched in the
> config.  Also this option does not seem to be documented.  Should i
> document svn.commiturl in dcommit or is that just a implementation
> detail.

Please document svn.commiturl, thanks

> > > svn-remote.<name>.dcommiturl
> > 
> > Of course, having a per-svn-remote commiturl can be useful, too.
> > 
> > Though I'd call it "commiturl" instead of "dcommiturl" to match the
> > existing config setting.  The not-often-used "set-tree" command could
> > probably be updated to use these config options, too...
> > 
> 
> sorry, i do not understand enough of perl/git-svn to do this :-(

Don't worry about set-tree, for now :) dcommit has been the recommended
workflow for a while now so very few people use set-tree (it's highly
git-centric and makes history confusing to SVN users).

> > I'll ack this patch with "dcommiturl" replaced with "commiturl".
> > 
> 
> OK, will resend the patch once i know if i should document svn.commiturl.

Thanks Peter

-- 
Eric Wong
