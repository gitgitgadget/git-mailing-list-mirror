From: Petr Baudis <pasky@suse.cz>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 14:41:24 +0200
Message-ID: <20070518124123.GX4489@pasky.or.cz>
References: <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517215841.GB29259@mellanox.co.il> <200705180141.06862.Josef.Weidendorfer@gmx.de> <464CF435.1010405@midwinter.com> <20070518045025.GT4489@pasky.or.cz> <f2k4g6$879$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 14:42:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp1mc-000280-Vz
	for gcvg-git@gmane.org; Fri, 18 May 2007 14:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbXERMl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 08:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756817AbXERMl0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 08:41:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54368 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754426AbXERMlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 08:41:25 -0400
Received: (qmail 15079 invoked by uid 2001); 18 May 2007 14:41:24 +0200
Content-Disposition: inline
In-Reply-To: <f2k4g6$879$2@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47604>

On Fri, May 18, 2007 at 02:00:07PM CEST, Jakub Narebski wrote:
> There is a bit ugly solution for this: instead of using symbolic name
> in versioned .gitmodules for a subproject (for a repo), use subproject
> identifier (inode), and put it in the tag object (or config) together with
> the URL.  Git would then search all the subproject / submodule info for
> a given inode.  You could have more than one inode / identifier name for
> a subproject repo; this would avoid the "independently created" issue
> with using inodes / file-ids in distributed SCM.  One would have to
> ensure however that different subprojects get assigned different inodes.

Well, then it doesn't make any difference, no? You just renamed the
problem but it stays the same - to ensure uniqueness even across
repositories.

Ok, you can declare now that you will just think out a UUID for the
subproject, but aside of not fitting well with the whole git philosophy,
then you don't need the indirection again, just use the UUID as the tag
name.

I have the feeling that I'm missing something basic in your proposal...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
