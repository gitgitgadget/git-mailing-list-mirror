From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 17:10:23 -0500
Message-ID: <20070208221023.GB1091@spearce.org>
References: <17866.27739.701406.722074@lisa.zopyra.com> <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org> <87fy9gz9vu.fsf@host94.eke.fi> <Pine.LNX.4.64.0702081321040.8424@woody.linux-foundation.org> <87bqk4z4qw.fsf@host94.eke.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Kalle Pokki <kalle.pokki@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHTQ-0003Ge-N4
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945907AbXBHWKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945927AbXBHWKb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:10:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36508 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945907AbXBHWKb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:10:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFHT7-000600-AJ; Thu, 08 Feb 2007 17:10:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2924F20FBAE; Thu,  8 Feb 2007 17:10:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <87bqk4z4qw.fsf@host94.eke.fi>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39103>

Kalle Pokki <kalle.pokki@iki.fi> wrote:
> Perhaps gitk could (optionally) also show ORIG_HEAD. That way we could
> just do
> 
>         gitk --all
> 
> after a pull and see what got pulled, and everything else was already
> there, too, if needed.

	git config alias.new "gitk --all --not ORIG_HEAD"

Would give you a new git subcommand:

	git new

which shows all of the new stuff, on all branches, but doesn't show
your prior commit history.

-- 
Shawn.
