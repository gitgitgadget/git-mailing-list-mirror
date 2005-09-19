From: Petr Baudis <pasky@suse.cz>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 18:34:39 +0200
Message-ID: <20050919163439.GB18320@pasky.or.cz>
References: <20050919134838.GC2903@pasky.or.cz> <432ECB92.5000505@gmail.com> <pan.2005.09.19.14.47.51.811409@smurf.noris.de> <432EE46F.9000806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:36:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHObO-0002Wn-PH
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVISQem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVISQem
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:34:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56484 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932468AbVISQel (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 12:34:41 -0400
Received: (qmail 22967 invoked by uid 2001); 19 Sep 2005 18:34:39 +0200
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <432EE46F.9000806@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8885>

Dear diary, on Mon, Sep 19, 2005 at 06:16:47PM CEST, I got a letter
where A Large Angry SCM <gitzilla@gmail.com> told me that...
> >Sure, many organizations bake their own, but I'd argue that the majority
> >doesn't.
> 
> The point is we should not be telling them what and how to put stuff in 
> the GECOS field.

The point is that our guess should be something which works for the most
people.

> >>AND/OR to include 
> >>the what Git thinks the user's name name might be in the commit message
> >>template they're editing (like the file list).
> >
> >I think that's a good idea, as long as people are told how to change it
> >(i.e., an envvar -- NOT by editing the file).
> 
> Yes.

I'll change cg-commit to always include the name/email fields in its
template. I think it's verbose enough as it is now, though, and I don't
want it to bloat it with more generic help text. I've expanded the
documentation of cg-commit on the GIT_ variables and that ought to be
enough. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
