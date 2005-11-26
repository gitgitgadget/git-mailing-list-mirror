From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 0/8] Make C-level operable from subdirectories
Date: Sat, 26 Nov 2005 13:44:29 -0500
Message-ID: <20051126184429.GH16995@mythryan2.michonline.com>
References: <43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xveth4l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de> <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de> <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org> <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 19:45:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg52a-0003rJ-7G
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 19:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKZSok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 13:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVKZSok
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 13:44:40 -0500
Received: from mail.autoweb.net ([198.172.237.26]:27011 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750708AbVKZSok (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 13:44:40 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1Eg52E-0002vx-G4; Sat, 26 Nov 2005 13:44:31 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Eg52D-0008FL-00; Sat, 26 Nov 2005 13:44:29 -0500
Received: from ryan by mythical with local (Exim 4.54)
	id 1Eg52D-0002Vi-UO; Sat, 26 Nov 2005 13:44:29 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12783>

On Sat, Nov 26, 2005 at 01:51:41AM -0800, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Fri, 25 Nov 2005, Junio C Hamano wrote:
> >>
> >> I once advocated for an environment to name the top of working
> >> tree directory --- it might make sense to resurrect that one.
> >
> > Please don't. 
> >
> > We should just make the scripts do it automatically instead.
> 
> Here comes an 8-patch series.

Should the documentation get an update to mention that using GIT_DIR to
create a totally out-of-tree setup is supported, but not recommended?

-- 

Ryan Anderson
  sometimes Pug Majere
