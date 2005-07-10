From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 09:09:14 +0100
Message-ID: <20050710090914.B11765@flint.arm.linux.org.uk>
References: <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz> <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com> <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <12c511ca050707170964a2cc92@mail.gmail.com> <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org> <20050709225818.A31045@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 10:09:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrWsS-0007p9-51
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 10:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVGJIJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 04:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVGJIJU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 04:09:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24851 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261872AbVGJIJS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 04:09:18 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DrWsF-00010W-Tw; Sun, 10 Jul 2005 09:09:16 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DrWsE-0007pw-Ho; Sun, 10 Jul 2005 09:09:14 +0100
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050709225818.A31045@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Jul 09, 2005 at 10:58:18PM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 09, 2005 at 10:58:18PM +0100, Russell King wrote:
> $ mv .git/objects/pack/* .git/
> $ for i in .git/*.pack; do git-unpack-objects < $i; done
> Unpacking 55435 objects
> fatal: inflate returned -3

This morning's cg-update gave these new errors:

receiving file list ... done

wrote 86 bytes  read 192 bytes  556.00 bytes/sec
total size is 410  speedup is 1.47
Missing object of tag v2.6.11... different source (obsolete tag?)
Missing object of tag v2.6.11-tree... different source (obsolete tag?)
Missing object of tag v2.6.12... different source (obsolete tag?)
Missing object of tag v2.6.12-rc2... different source (obsolete tag?)
Missing object of tag v2.6.12-rc3... different source (obsolete tag?)
Missing object of tag v2.6.12-rc4... different source (obsolete tag?)
Missing object of tag v2.6.12-rc5... different source (obsolete tag?)
Missing object of tag v2.6.12-rc6... different source (obsolete tag?)
Missing object of tag v2.6.13-rc1... different source (obsolete tag?)
Missing object of tag v2.6.13-rc2... different source (obsolete tag?)

-- 
Russell King
