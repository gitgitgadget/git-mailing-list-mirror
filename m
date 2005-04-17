From: Paul Jackson <pj@sgi.com>
Subject: Re: Storing permissions
Date: Sat, 16 Apr 2005 22:32:02 -0700
Organization: SGI
Message-ID: <20050416223202.3d7c2a5f.pj@sgi.com>
References: <20050416230058.GA10983@ucw.cz>
	<118833cc05041618017fb32a2@mail.gmail.com>
	<20050416183023.0b27b3a4.pj@sgi.com>
	<Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: mwelinder@gmail.com, mj@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:28:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN2Kp-0008Be-QG
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVDQFcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 01:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDQFcZ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 01:32:25 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:7825 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261265AbVDQFcW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 01:32:22 -0400
Received: from omx3.sgi.com (omx3-ext.sgi.com [192.48.171.20])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j3H5WLRC027444
	for <git@vger.kernel.org>; Sat, 16 Apr 2005 22:32:21 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H5tce0015599;
	Sat, 16 Apr 2005 22:55:38 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H5W6lU15308364;
	Sat, 16 Apr 2005 22:32:07 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus wrote:
> It might be ok to just change the "compare cache" check to only care
> about a few bits, though: S_IXUSR and S_IFDIR. And then ...

I think I agree.  But since I am reluctant to take enough time to
understand the code well enough to write this patch, I'll shut up now ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
