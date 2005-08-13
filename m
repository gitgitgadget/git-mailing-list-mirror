From: Petr Baudis <pasky@suse.cz>
Subject: Re: Add an empty directory?
Date: Sat, 13 Aug 2005 21:55:56 +0200
Message-ID: <20050813195556.GK5608@pasky.ji.cz>
References: <20050813173043.GA25013@hpsvcnb.fc.hp.com> <20050813180008.GJ5608@pasky.ji.cz> <20050813181945.GA2191@hpsvcnb.fc.hp.com> <Pine.LNX.4.58.0508131238150.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 21:57:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4278-0000PK-PP
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 21:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVHMT4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 15:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVHMT4C
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 15:56:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49166 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932276AbVHMT4A (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 15:56:00 -0400
Received: (qmail 17263 invoked by uid 2001); 13 Aug 2005 19:55:57 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508131238150.3553@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 13, 2005 at 09:41:45PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Sat, 13 Aug 2005, Carl Baldwin wrote:
> > 
> > The bottom line is that I don't really see many situations where it is
> > absolutely necessary but it is a convenience.  Not supporting it may
> > seem like an artificial limit that really didn't need to be there.
> 
> Well, there is an argument for not supporting it, namely that the way 
> patches work, traditionally a directory that became empty is deleted 
> (because patches have no way of saying "remove directory" or "create 
> directory").

If we have rename patches, why couldn't our patches deal with
directories as well? And git-apply, cg-patch etc might have a way to
behave in a "traditional" way for non-git patches and if a patch removes
all files in a directory, kill the directory.

That is, I would solve this on the SCM<->patches boundary, not
fundamentally limit the SCM itself.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
