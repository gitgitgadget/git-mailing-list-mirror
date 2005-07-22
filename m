From: Petr Baudis <pasky@suse.cz>
Subject: Re: Should cg-mkpatch output be usable with cg-patch?
Date: Fri, 22 Jul 2005 23:03:52 +0200
Message-ID: <20050722210352.GG11916@pasky.ji.cz>
References: <20050720234904.B3ED735267C@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:08:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4gY-0005tr-Oa
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVGVVDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVGVVDy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:03:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9479 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262173AbVGVVDy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 17:03:54 -0400
Received: (qmail 24898 invoked by uid 2001); 22 Jul 2005 21:03:52 -0000
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050720234904.B3ED735267C@atlas.denx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 21, 2005 at 01:49:04AM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> told me that...
> I wander what I should do with "cg-mkpatch" generated output;  I  had
> the  impression that this should be usable with "cg-patch", but these
> are incompatible with each other.

They certainly aren't.

> Forexample. if  a  commit  contains permission changes, my generated
> patch may look like this:
> 
> 	...
> 	diff --git a/MAKEALL b/MAKEALL
> 	old mode 100644
> 	new mode 100755
> 	diff --git a/mkconfig b/mkconfig
> 	old mode 100644
> 	new mode 100755
> 	diff --git a/tools/img2brec.sh b/tools/img2brec.sh
> 	old mode 100644
> 	new mode 100755
> 	...
> 
> If I feed this into "cg-patch", I get:
> 
> 	patch: **** Only garbage was found in the patch input.

And did the changes apply? :-)

The message is surely confusing, but appeared to be rather corner-casy
and after I imagined the required complexity of filtering this, I
decided to spend my time on something more useful for the time being. :)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
