From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg update failing
Date: Wed, 20 Jul 2005 10:12:26 +0200
Message-ID: <20050720081226.GA27102@pasky.ji.cz>
References: <m3oe95qn64.fsf@lugabout.cloos.reno.nv.us> <1121365461.4729.0.camel@localhost.localdomain> <m3k6jtnod8.fsf@lugabout.cloos.reno.nv.us> <1121376069.4729.2.camel@localhost.localdomain> <m3d5plm50o.fsf@lugabout.cloos.reno.nv.us> <m3eka04shr.fsf@lugabout.cloos.reno.nv.us> <20050720010712.GB2255@pasky.ji.cz> <m3oe8yw0ws.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Darrin Thompson <darrint@progeny.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 10:13:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv9hG-00065S-MA
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 10:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVGTIM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jul 2005 04:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVGTIM3
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jul 2005 04:12:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48906 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261311AbVGTIM2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2005 04:12:28 -0400
Received: (qmail 28364 invoked by uid 2001); 20 Jul 2005 08:12:27 -0000
To: James Cloos <cloos+vger-git@jhcloos.com>
Content-Disposition: inline
In-Reply-To: <m3oe8yw0ws.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jul 20, 2005 at 06:34:43AM CEST, I got a letter
where James Cloos <cloos+vger-git@jhcloos.com> told me that...
> >>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:
> 
> Petr> Huh. Well, you had to do uberweird things with your repository -
> Petr> why did you cg-seek at all? What Cogito version is it?
> 
> All I ever did was track and compile linus??? tree.  IIRC, when the
> first new tag was added after I cloned the tree I had to seek to
> that tag to see the new versions of the files.  But obviously
> that was long enough before hg???s repo broke that I???d forgotten
> how I???d done that....

Ah so. Well, yes, the first tag was IIRC weird since it was a tree tag,
not a commit tag. That confused things, but it shouldn't be necessary
anymore since all new tags are hopefully commits. That might somehow
create the local modifications as well, although I don't have a clear
idea how could be that possible. Well, there were some bugs like this in
Cogito in the past, but that should be long fixed.

Thanks anyway,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
