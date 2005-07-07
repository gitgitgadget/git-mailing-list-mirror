From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 16:59:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
  <20050707144501.GG19781@pasky.ji.cz>  <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>  <20050707221443.GB7151@pasky.ji.cz>
  <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 02:01:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqgJ3-0007ge-TZ
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 02:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVGHAAv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 20:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVGHAAu
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 20:00:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262379AbVGGX7v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 19:59:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j67NxcjA025400
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 16:59:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j67Nxb93001842;
	Thu, 7 Jul 2005 16:59:38 -0700
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <12c511ca05070716526954edd@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Tony Luck wrote:
>
> > > So, what _is_ then the way to pull now, actually? If we use rsync, won't
> > > we end up with having the objects we previous had twice now?
> > 
> > Rsync works fine. You can either unpack the pack you get, or, if you
> > prefer, just run
> > 
> >         git-prune-packed
> 
> cg-update from a local repo that contains packs is broken though :-(

Is this with cg-0.12? The most recent release should be happy with packs.

> Also "git-fsck-cache" in a repo that is fully packed complains:
> 
>    fatal: No default references

Ahh, that's true. I knew about it, and forgot. Will fix,

		Linus
