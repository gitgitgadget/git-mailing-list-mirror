From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 07:55:48 +0100
Message-ID: <20050710075548.A11765@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com> <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <12c511ca050707170964a2cc92@mail.gmail.com> <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org> <20050709225818.A31045@flint.arm.linux.org.uk> <20050709232955.B31045@flint.arm.linux.org.uk> <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org> <Pine.LNX.4.58.0507092211470.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Tony Luck <tony.luck@gmail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 08:56:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrVjW-0002QC-5W
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 08:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVGJGz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 02:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVGJGz4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 02:55:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51721 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261857AbVGJGzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 02:55:54 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DrVjB-0000yW-UW; Sun, 10 Jul 2005 07:55:50 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DrVjA-0006gK-NF; Sun, 10 Jul 2005 07:55:48 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507092211470.17536@g5.osdl.org>; from torvalds@osdl.org on Sat, Jul 09, 2005 at 10:15:41PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 09, 2005 at 10:15:41PM -0700, Linus Torvalds wrote:
> So you can fix this by getting the current git release, but you probably 
> shouldn't even care.  Just use the pack-files as pack-files instead, and 
> enjoy the higher performance and lower disk use ;).

I would if I could, but my workflow involves having an untouched local
copy of your tree and several trees for each area.

This involves updates using relative paths, and as has already been
found elsewhere, this (with cogito 0.12) doesn't work with packed
objects yet.

-- 
Russell King
