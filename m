From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Tue, 15 Nov 2005 22:59:43 +0100
Message-ID: <20051115215943.GW30496@pasky.or.cz>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de> <7vfypxlp8k.fsf@assigned-by-dhcp.cox.net> <437A46E4.5010909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 23:06:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8qC-0005wA-SE
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVKOV7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVKOV7q
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:59:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:35559 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750842AbVKOV7q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 16:59:46 -0500
Received: (qmail 13341 invoked by uid 2001); 15 Nov 2005 22:59:43 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <437A46E4.5010909@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11951>

Dear diary, on Tue, Nov 15, 2005 at 09:36:52PM CET, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> said that...
> Junio C Hamano wrote:
> >
> >I've applied the patch from HPA to update it to git.spec already
> >in my tree, so your script would not work any more ;-)
> >
> >But seriously, I suspect we should take a hint from the fact
> >that "git.spec.in" has ".in" in its name already.
> >
> 
> I'd prefer to have just @@OPENSSH_PACKAGE@@ and @@EXPAT_PACKAGE@@ 
> instead of completely virtualizing the dependencies.  Less flexible to 
> be sure, but it makes it less confusing to read and fix.

Actually, can you have some kind of %if in specfiles? Then you could
keep everything in the specfile and just pass it whatever system you
want to build for.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
