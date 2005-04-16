From: Paul Jackson <pj@sgi.com>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 16:11:53 -0700
Organization: SGI
Message-ID: <20050416161153.534b47d5.pj@sgi.com>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
	<20050416123155.GA19908@elte.hu>
	<Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
	<4261132A.3090907@khandalf.com>
	<Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
	<20050416151116.GC19099@pasky.ji.cz>
	<Pine.LNX.4.61.0504161114530.29343@cag.csail.mit.edu>
	<Pine.LNX.4.62.0504161549410.22652@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: cscott@cscott.net, pasky@ucw.cz, omb@bluewin.ch, mingo@elte.hu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:09:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwPT-0002qG-VX
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVDPXMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVDPXMt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:12:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:9679 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261189AbVDPXMr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:12:47 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3GNZT2n008973;
	Sat, 16 Apr 2005 16:35:34 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3GNBwlU15228708;
	Sat, 16 Apr 2005 16:11:58 -0700 (PDT)
To: David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0504161549410.22652@qynat.qvtvafvgr.pbz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> what I'm talking about is the chance that somewhere, sometime there will 
> be two different documents that end up with the same hash

I have vastly greater chance of a file colliding due to hardware or
software glitch than a random message digest collision of two legitimate
documents.

I've lost quite a few files in 25 years of computing to just
such glitches, sometimes without knowing it until months or years
later.

We've already computed the chances of a random pure hash collision
with SHA1 - it's something like an average of 1 collision every
10 billion years if we have 10,000 coders generating 1 new file
version every minute, non-stop, 24 hours a day, 365 days a year.

Get real.  There are _many_ sources of random error in our
tools.  When some sources are billions of billions times
more likely to occur, it makes sense to worry about them first.

Reminds me of the drunk looking under the lamp post for the
house keys he dropped - because that's where the light is.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
