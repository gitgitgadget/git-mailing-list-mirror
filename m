From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] provide better committer information to commit-tree.c
Date: Mon, 18 Apr 2005 18:47:38 -0700
Message-ID: <20050419014738.GA13602@taniwha.stupidest.org>
References: <20050419001126.GB21170@kroah.com> <Pine.LNX.4.58.0504181730130.15725@ppc970.osdl.org> <20050419004548.GA21623@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:43:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhmK-0001Ps-G0
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVDSBrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDSBrw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:47:52 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:48519 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261261AbVDSBrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 21:47:51 -0400
Received: from taniwha.stupidest.org (adsl-67-124-119-21.dsl.snfc21.pacbell.net [67.124.119.21])
	by pimout4-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j3J1lc5K053668;
	Mon, 18 Apr 2005 21:47:42 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 3C614115C86F; Mon, 18 Apr 2005 18:47:38 -0700 (PDT)
To: Greg KH <greg@kroah.com>
Content-Disposition: inline
In-Reply-To: <20050419004548.GA21623@kroah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 05:45:48PM -0700, Greg KH wrote:

> But if you really don't like it, and you don't want anyone trying to
> hide anything, at least allow for a proper domainname.  On my boxes,
> the domainname doesn't show up at all without that patch (just the
> getdomainname() part).  I'll split it out if you want.

there are plenty of times you need this... internal domain names
usually have the MTA rewrite addresses as needed, i don't see how this
is all the different

we have internal/private state that's not globally useful and need to
replace it with something that is, how else could we do this?
