From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-clone not fetching all tags?
Date: Sat, 29 Apr 2006 19:05:42 +0200
Message-ID: <20060429170542.GJ27689@pasky.or.cz>
References: <20060427105251.AA4B2353DAC@atlas.denx.de> <20060429140042.1FB37353DAC@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 29 19:05:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZssZ-0000Gd-7o
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 19:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWD2RFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 13:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWD2RFE
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 13:05:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22443 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750762AbWD2RFD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 13:05:03 -0400
Received: (qmail 12070 invoked by uid 2001); 29 Apr 2006 19:05:42 +0200
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20060429140042.1FB37353DAC@atlas.denx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19310>

  Hi,

Dear diary, on Sat, Apr 29, 2006 at 04:00:42PM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> said that...
> it seems that "cg-clone" does not fetch all tags any more - only  the
> most  recent ones (modiufied in the last N days?) seem to be fetched?
> [Eventually the "N days"  might  correspond  to  "changing  tools  to
> version X", but I have no way to find out.]
> 
> This happens only when using HTTP; using ssh  or  rsync  works  fine.
> Also,  if  we follow the "cg-clone" by a "git-fetch -t" command, this
> will load the missing tags.
> 
> Is this intentional, or am I doing anything wrong?
> 
> [For testing, try "cg-clone http://www.denx.de/git/u-boot.git"]

  you need to run git-update-server-info every time you add or update a
tag (or best every time you push). See the NOTES section of
cg-admin-setuprepo documentation for details on how to set it up to be
called automagically at every push.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
