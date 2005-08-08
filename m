From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-commit-script, was Re: "git revert" (Re: pci_update_resource()
 getting called on sparc64)
Date: Mon, 8 Aug 2005 15:01:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508081458550.3258@g5.osdl.org>
References: <20050808.103304.55507512.davem@davemloft.net>
 <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com>
 <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com>
 <Pine.LNX.4.58.0508081249110.3258@g5.osdl.org> <Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
 <7vd5oo40mq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508081357020.3258@g5.osdl.org>
 <7voe882kds.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508082329170.2934@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vhde02jab.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 00:03:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Fgu-0008LP-89
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 00:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVHHWBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 18:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVHHWBt
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 18:01:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6879 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932283AbVHHWBs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 18:01:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j78M1gjA014484
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Aug 2005 15:01:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j78M1eEg029123;
	Mon, 8 Aug 2005 15:01:41 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhde02jab.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 8 Aug 2005, Junio C Hamano wrote:
> 
> Sure, what's the alternative spelling for the current -m,
> though?  Would -c be OK for commit?

How about using long names?

	git commit --reuse-message <sha1>

looks a lot more intuitively understandable to me than something like "-c"

Most of us don't use 300bps terminals any more, so typing a few extra 
characters is probably ok.

Now, to make things be backwards-compatible, it should be easy enough to 
notice

   "Oh, the argument to '-m' is just a single SHA1, let's see if it's a
    commit, and turn '-m' into '--reuse-message' automatically"

If anybody cares. Does cogito already use "-m"?

		Linus
