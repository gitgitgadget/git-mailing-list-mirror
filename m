From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Sat, 30 Apr 2005 18:37:24 +0200
Message-ID: <20050430163724.GE20146@opteron.random>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <20050429203027.GK17379@opteron.random> <20050429203959.GC21897@waste.org> <20050430025211.GP17379@opteron.random> <20050430152014.GI21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 18:27:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRunn-0007kS-So
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 18:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVD3QcR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 12:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVD3QcR
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 12:32:17 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:48167
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261285AbVD3QcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 12:32:05 -0400
Received: by opteron.random (Postfix, from userid 500)
	id 65F761C1690; Sat, 30 Apr 2005 18:37:24 +0200 (CEST)
To: Matt Mackall <mpm@selenic.com>
Content-Disposition: inline
In-Reply-To: <20050430152014.GI21897@waste.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 30, 2005 at 08:20:15AM -0700, Matt Mackall wrote:
> Most of that psyco speed up is accelerating subsequent diffs in
> difflib, which you probably didn't hit yet.

Correct. Plus I've a 64bit python so I can't use psyco anyway.

> I can make it some sort of environment variable, sure. I think the
> speed is already in a domain where it's not a big deal though. There

No big deal of course, I mentioned it just because it was by far the
most CPU userland intensive operation during checkin. Perhaps doing less
vfs syscalls would improve checkin time too, but I'm unsure if that's
easily feasible (while disabling compression was certainly easy ;)

> Yep, I'm rather new to actually packaging my Python hacks.

I sent you by private email a modified package that gets that right.

Thanks!
