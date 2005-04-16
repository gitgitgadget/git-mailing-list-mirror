From: Paul Jackson <pj@sgi.com>
Subject: Re: Storing permissions
Date: Sat, 16 Apr 2005 16:19:35 -0700
Organization: SGI
Message-ID: <20050416161935.0d2cf3b0.pj@sgi.com>
References: <20050416230058.GA10983@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:16:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwWA-0003Wo-KX
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVDPXTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVDPXTp
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:19:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63185 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261193AbVDPXTo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:19:44 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3GNhAwA009898;
	Sat, 16 Apr 2005 16:43:10 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3GNJdlU15237465;
	Sat, 16 Apr 2005 16:19:39 -0700 (PDT)
To: Martin Mares <mj@ucw.cz>
In-Reply-To: <20050416230058.GA10983@ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> Does it really make sense to store full permissions in the trees? I think
> that remembering the x-bit should be good enough for almost all purposes
> and the other permissions should be left to the local environment.

That matches my experience - store 1 bit of mode state - executable or not.

Let local environment determine read, write and umask permissions.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
