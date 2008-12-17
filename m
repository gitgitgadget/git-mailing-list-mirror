From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Wed, 17 Dec 2008 08:21:27 -0800
Message-ID: <20081217162127.GG32487@spearce.org>
References: <4946F4D9.8050803@gmx.ch> <87zlixvtu9.fsf@jidanni.org> <49470D65.40808@gmx.ch> <alpine.LFD.2.00.0812160039180.30035@xanadu.home> <20081217154407.GZ32487@spearce.org> <alpine.LFD.2.00.0812171104340.30035@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, jidanni@jidanni.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 17:23:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCzAc-00036x-FF
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 17:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYLQQV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 11:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbYLQQV2
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 11:21:28 -0500
Received: from george.spearce.org ([209.20.77.23]:38481 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbYLQQV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 11:21:28 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5B8F838200; Wed, 17 Dec 2008 16:21:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812171104340.30035@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103359>

Nicolas Pitre <nico@cam.org> wrote:
> 
> And I consider any system doing such thing completely stupid.  Either 
> you consistently know the information or you don't.  When you don't, it 
> is best to not create expectations for the user.  And so far I think 
> that 99.9% of git users are just fine with the progress display we 
> currently provide.

Certainly true here; I never care how big the source I'm cloning is.
But then again I have pretty good network connectivity at work
and at least cable modem service at home...  most things clone down
pretty fast.

Its a quick hack to give a size upper bound.  I don't think its
that ugly.  Our network protocol is uglier with all of its hidden
fields jammed behind that NUL in the first advertisement line.
But I digress.

The better feature is probably resumable clone anyway.  At least
then people can abort a "long running" clone and have a good chance
they can pick it up again in the near future.  Its also not easy to
implement, which is why we've only been talking about it for years
and never actually seen a patch proposing to do it.

-- 
Shawn.
