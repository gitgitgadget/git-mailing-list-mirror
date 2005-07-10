From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 16:59:54 +0200
Message-ID: <20050710145954.GB24249@pasky.ji.cz>
References: <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz> <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com> <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <12c511ca050707170964a2cc92@mail.gmail.com> <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org> <20050709225818.A31045@flint.arm.linux.org.uk> <20050710090914.B11765@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 17:00:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrdI5-0006Gg-VC
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 17:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVGJPAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 11:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVGJPAA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 11:00:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61666 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261948AbVGJO77 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 10:59:59 -0400
Received: (qmail 32449 invoked by uid 2001); 10 Jul 2005 14:59:54 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050710090914.B11765@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jul 10, 2005 at 10:09:14AM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> On Sat, Jul 09, 2005 at 10:58:18PM +0100, Russell King wrote:
> > $ mv .git/objects/pack/* .git/
> > $ for i in .git/*.pack; do git-unpack-objects < $i; done
> > Unpacking 55435 objects
> > fatal: inflate returned -3
> 
> This morning's cg-update gave these new errors:
> 
> receiving file list ... done
> 
> wrote 86 bytes  read 192 bytes  556.00 bytes/sec
> total size is 410  speedup is 1.47
> Missing object of tag v2.6.11... different source (obsolete tag?)
> Missing object of tag v2.6.11-tree... different source (obsolete tag?)
> Missing object of tag v2.6.12... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc2... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc3... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc4... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc5... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc6... different source (obsolete tag?)
> Missing object of tag v2.6.13-rc1... different source (obsolete tag?)
> Missing object of tag v2.6.13-rc2... different source (obsolete tag?)

Ok, cg-pull didn't quite handle this. I've fixed it so that it should
reasonably handle it now. Hopefully.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
