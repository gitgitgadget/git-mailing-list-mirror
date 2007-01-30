From: Eric Wong <normalperson@yhbt.net>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 16:48:10 -0800
Message-ID: <20070130004810.GB18213@localdomain>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <45BB9C8B.8020907@fs.ei.tum.de> <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org> <204011cb0701271136m655815f6o1501de2bf699b362@mail.gmail.com> <20070129230050.GA15492@localdomain> <20070130004247.GA18213@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Lee <clee@kde.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 01:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBhAV-0002XC-VL
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 01:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbXA3AsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 19:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbXA3AsM
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 19:48:12 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47691 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964899AbXA3AsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 19:48:12 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 95D877DC094;
	Mon, 29 Jan 2007 16:48:10 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 29 Jan 2007 16:48:10 -0800
Content-Disposition: inline
In-Reply-To: <20070130004247.GA18213@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38117>

Eric Wong <normalperson@yhbt.net> wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
> > It seems to be following kde-common into pre-409202 revisions (down to
> > r11472) pretty well.  I'll upload the result to git.bogomips.org when
> > I'm done.
> 
> This will have to wait: I'm getting "Malformed network data" errors with
> both do_update and do_switch (not yet working on any release version of
> SVN incl. 1.4.3).  I'll have to examine this a bit more when I get the
> time.

Also, you should *not* be able to reproduce this error if you try
tracking kde-common on a local file:// repository.

-- 
Eric Wong
