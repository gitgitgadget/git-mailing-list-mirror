From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: respect Subversion's [auth] section configuration values
Date: Sun, 7 Oct 2007 14:43:34 -0700
Message-ID: <20071007214334.GA7442@untitled>
References: <20071006185719.GA3943@void.codelabs.ru> <4708355B.4090403@vilain.net> <20071006185719.GA3943@void.codelabs.ru> <20071007032241.GG14972@hand.yhbt.net> <20071007101437.GB3943@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iedui-00077j-BH
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbXJGVnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbXJGVnl
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:43:41 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39498 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932AbXJGVnk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:43:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6A5087DC093;
	Sun,  7 Oct 2007 14:43:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071007101437.GB3943@void.codelabs.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60223>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Eric, Sam, good day.
> Sun, Oct 07, 2007 at 02:24:43PM +1300, Sam Vilain wrote:
> > Eygene Ryabinkin wrote:
> > > Parameters 'store-passwords' and 'store-auth-creds' from Subversion's
> > > configuration (~/.subversion/config) were not respected.  This was
> > > fixed: the default values for these parameters are set to 'yes' to
> > > follow Subversion behaviour.
> > >   
> > 
> > I saw this in the svn api before.  It really is a strange API, requiring
> > the user to get things like this right.
> 
> Yes, the need to parse the configuration and set some flags is
> rather strange.  Looks like nobody cared to stuff the code like
> I had added to the configuration file parsing routines.

I think I started to look at it a while back and forgot about it :)

> > You can use no warnings 'once';
> 
> Great, thanks for the pointer!  Eric, do you want me to produce
> another patch or you'll correct mine?

Go ahead and produce another patch.  I haven't had much time to
work on git lately.

-- 
Eric Wong
