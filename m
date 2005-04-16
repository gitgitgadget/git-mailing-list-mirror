From: Paul Jackson <pj@engr.sgi.com>
Subject: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 23:59:41 -0700
Organization: SGI
Message-ID: <20050415235941.73f8a007.pj@engr.sgi.com>
References: <Pine.LNX.4.21.0504152221070.30848-100000@iabervon.org>
	<Pine.LNX.4.58.0504152000570.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: barkalow@iabervon.org, pasky@ucw.cz, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 08:57:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMhF4-0003Hi-Kt
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 08:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVDPHAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 03:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVDPHAl
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 03:00:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:26589 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261177AbVDPHAf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 03:00:35 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3G7NLSX009006;
	Sat, 16 Apr 2005 00:23:26 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3G6xklU15054735;
	Fri, 15 Apr 2005 23:59:48 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504152000570.7211@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

One trick I've used to separate good automatic merges from ones that
need human interaction is to run both the 'patch' and 'merge' commands,
which use different approaches to determining the result.

If they agree, take it.  To apply the changes between file1 and file2
to filez:

	diff -au file1 file2 | patch -f filez
	merge -q filez file1 file2

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
