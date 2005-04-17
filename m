From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 21:11:16 +0100
Message-ID: <20050417211116.F13233@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org> <20050417195742.D13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171226530.7211@ppc970.osdl.org> <20050417205149.E13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171306360.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 22:14:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNG9k-0007QX-JD
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVDQURq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVDQUNk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:13:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15624 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261464AbVDQULW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 16:11:22 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNG6v-0008Qn-EQ; Sun, 17 Apr 2005 21:11:17 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNG6u-0006tD-8O; Sun, 17 Apr 2005 21:11:16 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504171306360.7211@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Apr 17, 2005 at 01:08:51PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 01:08:51PM -0700, Linus Torvalds wrote:
> On Sun, 17 Apr 2005, Russell King wrote:
> > This will (and does) do exactly what I want.  I'll also read into the
> > above a request that you want it in forward date order. 8)
> 
> No, I actually don't _think_ I care. In many ways I'm more used to
> "reverse date order", because that's usually how you view a changelog
> (with a pager, and most recent changes at the top).
> 
> Which one makes sense when asking me to merge? I don't know, and I don't
> think it really even matters, but maybe we can add a "for now" to whatever 
> decision you end up coming to?

It's trivial to change - it's either sort -n or sort -nr !

I'll pick the reverse format so that we generate the changelog in the
order which people have come to expect from our previous set of tools.
Consistency with existing practises is a good thing at this point.

-- 
Russell King

