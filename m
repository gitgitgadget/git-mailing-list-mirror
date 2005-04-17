From: Paul Jackson <pj@sgi.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 18:18:02 -0700
Organization: SGI
Message-ID: <20050416181802.0400bb3f.pj@sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
	<20050416233724.GP19099@pasky.ji.cz>
	<20050416170221.38b3e66c.pj@sgi.com>
	<20050417003325.GA15608@redhat.com>
	<20050417025108.G2442@banaan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: davej@redhat.com, pasky@ucw.cz, git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 03:15:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMyO8-0002XR-A5
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 03:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVDQBTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 21:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVDQBTf
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 21:19:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54763 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261233AbVDQBTe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 21:19:34 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H2wK98025104;
	Sat, 16 Apr 2005 19:58:30 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H1I7lU15261961;
	Sat, 16 Apr 2005 18:18:07 -0700 (PDT)
To: Erik van Konijnenburg <ekonijn@xs4all.nl>
In-Reply-To: <20050417025108.G2442@banaan.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Erik wrote:
> How about putting using .git/tmp.$$ or similar as tempfile?

One could, but best to normally honor the users TMPDIR setting.

Could one 'git diff' a readonly git repository?

Perhaps someone has a reason for putting their tmp files where
they choose - say a local file system in a heavy NFS environment.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
