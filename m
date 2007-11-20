From: Petr Baudis <pasky@suse.cz>
Subject: Re: gitweb: kernel versions in the history (feature request,
	probably)
Date: Tue, 20 Nov 2007 22:59:04 +0100
Message-ID: <20071120215904.GF1001@machine.or.cz>
References: <20071120142042.GA4157@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Jarek Poplawski <jarkao2@o2.pl>
X-From: git-owner@vger.kernel.org Tue Nov 20 22:59:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iub7y-0005xI-Mw
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 22:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbXKTV7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 16:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbXKTV7I
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 16:59:08 -0500
Received: from w241.dkm.cz ([62.24.88.241]:34328 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbXKTV7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 16:59:07 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3A6DB5A4CB; Tue, 20 Nov 2007 22:59:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071120142042.GA4157@ff.dom.local>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65577>

  Hi,

On Tue, Nov 20, 2007 at 03:20:42PM +0100, Jarek Poplawski wrote:
> I see gitweb is much more usable (faster) than a few months ago, but
> there is one thing a bit problematic: in the history of patches I'm
> very often interested in which kernel version of Linus' tree the patch
> appeared for the first time. If it's not some big problem, and maybe
> somebody else finds this useful too, I'd really appreciate adding such
> a feature.

  in git terms, you'd like gitweb to provide output for command:

	git describe --contains

This is interesting feature request. I guess the support would be nice,
though in theory this operation can be a bit resource-intensive in case
there is not many tags and a lot of development (with uncached
repository, this query took quite a bit of time on my copy of the kernel
git tree). Probably this should be an optional feature and somehow dwell
on a separate page, which doesn't fit too well in the current gitweb
page structure...

> Petr, I hope there is no necessity to subscribe to the git list for
> this one question, so I'd really feel greteful for forwarding, if you
> find this request reasonable.

  Yes, there is no necessity - you can post this on the git mailing list
without subscribing yourself.

-- 
				Petr "Pasky" Baudis
We don't know who it was that discovered water, but we're pretty sure
that it wasn't a fish.		-- Marshall McLuhan
