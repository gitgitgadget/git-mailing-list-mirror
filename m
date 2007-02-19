From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Mon, 19 Feb 2007 18:04:06 -0500
Message-ID: <20070219230406.GC27722@spearce.org>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net> <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net> <20070217233203.GA6014@coredump.intra.peff.net> <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 00:04:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJHYQ-00047D-RW
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 00:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965511AbXBSXEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 18:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965513AbXBSXEO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 18:04:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56628 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965511AbXBSXEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 18:04:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJHY8-00052E-1O; Mon, 19 Feb 2007 18:04:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1B97120FBAE; Mon, 19 Feb 2007 18:04:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40158>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> (*) Although I have also noticed that even more often than using "git 
> apply" outside a git thing, I just import everything into git these days. 
> So I may not have actually used git-apply outside of a git project in a 
> long time any more. But I did, a few times.

Which makes me wonder, have you looked at (or used)
contrib/fast-import/import-tars.perl ?

Its Perl, which I know is not your favorite language, but it should
be a faster way to get a tar into a Git repository, as we never
actually extract the files from the tar, or create loose objects.

-- 
Shawn.
