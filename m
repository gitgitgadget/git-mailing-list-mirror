From: Petr Baudis <pasky@suse.cz>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 05:40:59 +0200
Message-ID: <20070327034059.GJ4489@pasky.or.cz>
References: <1174825838.12540.5.camel@localhost> <vpqvegpe4e1.fsf@olympe.imag.fr> <20070325203901.GB12376@spearce.org> <7v3b3t3uws.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Eric Lesh <eclesh@ucla.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 05:41:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW2YZ-000854-U9
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 05:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbXC0DlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 23:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbXC0DlF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 23:41:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42126 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165AbXC0DlC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 23:41:02 -0400
Received: (qmail 845 invoked by uid 2001); 27 Mar 2007 05:40:59 +0200
Content-Disposition: inline
In-Reply-To: <7v3b3t3uws.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43224>

On Sun, Mar 25, 2007 at 10:55:31PM CEST, Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Actually, I'd almost say put it into .git/config, e.g.:
> >
> > 	mkdir .git
> > 	cat >.git/config <<EOF
> > 	[core]
> > 		repositoryversion = 0
> > 		filemode = true
> > 		link = /path/to/source
> > 	EOF
> >
> > as then the index and HEAD file can both be stored in .git, just
> > like with the non-gitlink case.
> 
> This is not usable at least for me as it does not allow sharing
> the .git/config file across checkouts.

Can't you take linked .git/config and override it with stuff from local
.git/config in that case? Don't replace, supraposition.

Take somewhat contrived example of having checkout on a FAT partition
linking to a repository on a sane filesystem (are you permanently short
on disk space on your /home partition too, except for about two months
right after you double your disk capacity? :). You might want to disable
core.fileMode there. Maybe this will not ever happen in real world and
we might not care. Maybe not...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
