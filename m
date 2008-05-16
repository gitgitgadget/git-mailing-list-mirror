From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why do git submodules require manual checkouts and commits?
Date: Fri, 16 May 2008 14:58:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161457250.30431@racer>
References: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com> <32541b130805160643y3bfe609et22b2d00627f98c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "skillzero@gmail.com" <skillzero@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 15:59:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0Sh-0005Ee-MK
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 15:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbYEPN6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 09:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbYEPN6R
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 09:58:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:55742 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750758AbYEPN6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 09:58:16 -0400
Received: (qmail invoked by alias); 16 May 2008 13:58:14 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp022) with SMTP; 16 May 2008 15:58:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HhSJnzbdH6ZRsW894ro4EUy2P/QxErm4AsP9o/2
	8TmyOD8QZnbBuM
X-X-Sender: gene099@racer
In-Reply-To: <32541b130805160643y3bfe609et22b2d00627f98c04@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82288>

Hi,

On Fri, 16 May 2008, Avery Pennarun wrote:

> So I think it would be very bad if the supermodule automatically
> updated to the latest version of the submodule whenever you commit in
> the submodule.  *However*, the other way around might be fine: if you
> commit in the supermodule, maybe it should commit in the submodule at
> the same time and link to that specific commit.  I'm pretty sure that
> idea doesn't have any *fundamental* flaws, it's just got a lot of
> really tricky details that need to be worked out.

Just the fundamental flaw that you might _not_ want to commit that, just 
as you can have a dirty Makefile _forever_.

Ciao,
Dscho
