From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA official git repository
Date: Sun, 29 May 2005 11:06:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505291103080.1748@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 11:04:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcJiZ-0002wi-68
	for gcvg-git@gmane.org; Sun, 29 May 2005 11:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVE2JGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 05:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVE2JGl
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 05:06:41 -0400
Received: from gate.perex.cz ([82.113.61.162]:53228 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261289AbVE2JGe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 05:06:34 -0400
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP
	id EF7F774FBC; Sun, 29 May 2005 11:06:33 +0200 (MEST)
Received: from pnote.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP
	id C837E48004; Sun, 29 May 2005 11:06:33 +0200 (CEST)
Received: by pnote.perex-int.cz (Postfix, from userid 500)
	id 1832F18759; Sun, 29 May 2005 11:06:32 +0200 (CEST)
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 27 May 2005, Jaroslav Kysela wrote:

> On Fri, 27 May 2005, Linus Torvalds wrote:
> 
> > On Fri, 27 May 2005, Jaroslav Kysela wrote:
> > > 
> > > 	I created new git tree for the ALSA project at:
> > > 
> > > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> > 
> > Your scripts(?) to generate these things are a bit strange, since they
> > leave an extra empty line in the commit message, which confuses at least
> > gitweb (ie just look at
> > 
> >    http://www.kernel.org/git/?p=linux/kernel/git/perex/alsa.git;a=summary
> > 
> > and note how the summary thing looks empty).
> 
> Okay, sorry for this small bug. I'll recreate the ALSA git tree with
> proper comments again. Also, the author is not correct (should be taken
> from the first Signed-off-by:).

The ALSA git tree is updated with all fixes now. I had an old git version 
which inserted this extra line at top of comments.

Also, it seems that there's a delay between master.kernel.org and git web 
interface at www.kernel.org (the changes are not on web yet).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
