From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 16:46:58 -0700
Organization: SGI
Message-ID: <20050416164658.05bebed3.pj@sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
	<20050416233626.GV9461@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 01:44:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwxr-0005d7-0o
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVDPXsT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVDPXsT
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:48:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28884 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261205AbVDPXsR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:48:17 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H1R99u007800;
	Sat, 16 Apr 2005 18:27:19 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3GNl2lU15240957;
	Sat, 16 Apr 2005 16:47:02 -0700 (PDT)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20050416233626.GV9461@lug-owl.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> /usr/tmp/ ??? Hey, /usr may be mounted read-only!  Why not just use /tmp ?

Sure - that's fine to change.  Those that care will have TMPDIR set anyway.

I probably made that choice of /usr/tmp for the fallback 10 or 20 years
ago, and have never had reason to revisit it.  I have long forgotten why
I made that choice.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
