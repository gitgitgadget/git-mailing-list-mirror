From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-restore - restoring modified files
Date: Fri, 29 Jul 2005 10:48:03 +0200
Message-ID: <20050729084801.GK24895@pasky.ji.cz>
References: <1118799921.3890.45.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 10:51:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQaQ-0003Gj-LP
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 10:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVG2Iur (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 04:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVG2Iur
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 04:50:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44556 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262526AbVG2IsH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 04:48:07 -0400
Received: (qmail 5814 invoked by uid 2001); 29 Jul 2005 08:48:04 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1118799921.3890.45.camel@dv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Umm. I just discovered a portion of mailing list I somehow completely
missed. :/ Sorry for the delayed replies.

Dear diary, on Wed, Jun 15, 2005 at 03:45:21AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hi,

> I believe the documented behavior of cg-restore is inconsistent.
> 
> "Restore given files to their original state. Without any parameters, it
> recovers any files removed locally whose removal was not recorded by
> `cg-rm`."
> 
> I interpret it that cg-restore without arguments restores removed files
> but not modified ones.
> 
> "If passed a set of file names, it restores those files to their state
> as of the last commit (including bringing files removed with cg-rm back
> to life; FIXME: does not do that part yet)."
> 
> I interpret it that cg-restore with arguments restores both removed and
> modified files.
> 
> Maybe we need an option whether to restore modified files?  Or maybe
> they should always be restored (I think it would more consistent)?  Then
> the help text should be more clear about modified files.
> 
> The actual behavior is that modified files are never restored.  We need
> "-f" option for git-checkout-cache to overwrite existing files, and it's
> not used whether the filenames are specified or not.  I wanted to send a
> patch, but after reading help I'm not sure what exactly cg-restore is
> supposed to do.

in the meantime, I actually implemented the -f option. Now I agree that
cg-rm'd files should indeed be restored only when -f is passed. Not a
big deal yet since we don't remove them at all now. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
