From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 13:14:19 -0600
Message-ID: <20080827191419.GC18340@parisc-linux.org>
References: <20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:15:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQUa-0000Z4-9n
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288AbYH0TOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756139AbYH0TOh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:14:37 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:40106 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbYH0TOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:14:36 -0400
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
	id 8EDAF494005; Wed, 27 Aug 2008 13:14:19 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93925>

On Wed, Aug 27, 2008 at 08:00:17AM +0200, Ulrich Windl wrote:
> In HP-UX many commands (or "subsystems") use /opt/<subsys>/{bin,sbin} to place 
> their binaries. PATH usually does not contain all of them. That's against Linux 
> philosophy I think, and I really don't like huge PATHs, but it may be one solution 
> to reduce the size of linear lists. It won't help against the git<TAB><TAB> issue 
> directly, however.

In HP-UX, the default shell has a line length limit that is smaller than
the length of $PATH.  Be in awe of enterprise scalability.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
