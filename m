From: Paul Jackson <pj@sgi.com>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 12:16:52 -0700
Organization: SGI
Message-ID: <20050416121652.1b1a8645.pj@sgi.com>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
	<20050416123155.GA19908@elte.hu>
	<Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
	<4261132A.3090907@khandalf.com>
	<Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: omb@bluewin.ch, david.lang@digitalinsight.com, mingo@elte.hu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:14:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsk1-0006hw-K8
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVDPTRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVDPTRq
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:17:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:2254 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262736AbVDPTRo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 15:17:44 -0400
Received: from omx3.sgi.com (omx3-ext.sgi.com [192.48.171.20])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j3GJHfGJ020897
	for <git@vger.kernel.org>; Sat, 16 Apr 2005 12:17:42 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3GJeRcD009584;
	Sat, 16 Apr 2005 12:40:28 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3GJGvlU15194708;
	Sat, 16 Apr 2005 12:16:57 -0700 (PDT)
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Scott wrote:
> Please, let's talk about hash collisions responsibly.

Agreed.

Chasing down links from the one Petr provided:

  http://cryptography.hyperlink.cz/MD5_collisions.html

the best read I found was:

  MD5 To Be Considered Harmful Someday
  http://eprint.iacr.org/2004/357.pdf

As the author, Dan Kaminsky, states:

> it is far too easy to overestimate the risks described in this paper.

This paper does a good job of explaining the vulnerabilities
that MD5 has, currently (and yes, git uses SHA1 ...).

We have far greater vulnerabilities from intentional or accidental
coding errors, inadequately audited code, root exploits of user
(non-kernel) code, compilation and build tools, unreliable hardware
(how many of us use non-ECC memory - I do), poorly administered
systems, ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
