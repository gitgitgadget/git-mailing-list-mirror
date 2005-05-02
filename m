From: Paul Jackson <pj@sgi.com>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Mon, 2 May 2005 15:17:14 -0700
Organization: SGI
Message-ID: <20050502151714.7a33d79d.pj@sgi.com>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
	<20050429172235.21c1af10.pj@sgi.com>
	<Pine.LNX.4.58.0504291956030.2296@ppc970.osdl.org>
	<20050429232922.03057aba.pj@sgi.com>
	<20050430110410.GA25322@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue May 03 00:17:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSjD6-0002B7-Pg
	for gcvg-git@gmane.org; Tue, 03 May 2005 00:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVEBWRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 18:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVEBWRi
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 18:17:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52372 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261177AbVEBWRd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 18:17:33 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j42NxaeM002975;
	Mon, 2 May 2005 16:59:36 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j42MHG5w20749773;
	Mon, 2 May 2005 15:17:17 -0700 (PDT)
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20050430110410.GA25322@lsrfire.ath.cx>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rene wrote:
> Are you sure it's SMP dependant?

No - I'm not sure.  It just happened to be that way on the couple of
systems I looked at (and I figured that in any case, it was a good bet
that Linus had multiple processors ;).

> Here's a patch for cg-log

Looks plausible to me.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
