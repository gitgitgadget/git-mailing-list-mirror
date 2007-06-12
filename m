From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Please remerge git-gui.git into git.git
Date: Mon, 11 Jun 2007 22:27:47 -0400
Message-ID: <20070612022747.GP6073@spearce.org>
References: <20070611231013.GM6073@spearce.org> <7vd502niu3.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 04:27:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxw6x-000100-23
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 04:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbXFLC1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 22:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbXFLC1w
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 22:27:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60097 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbXFLC1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 22:27:51 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hxw6b-0000Jr-Na; Mon, 11 Jun 2007 22:27:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E378B20FBAE; Mon, 11 Jun 2007 22:27:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd502niu3.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49910>

Junio C Hamano <gitster@pobox.com> wrote:
> Sorry for the screw-up.  Will do when able.  This week I am a
> bit busy with day job and other stuff and expect to be slow on
> git side.

No big deal, just don't release a git.git without merging git-gui
again please.  But it already sounds like you won't be doing that.
;-)

One of the risks I took on when you started carrying git-gui in
git.git like this was patches stepping on git-gui by accident,
or people submitting patches to both git.git and git-gui.git in
the same patchfile (uh, Makefiles anyone?!?).

I'll be happy when the subproject support is mature enough that
git-gui can be unmerged from git.git, and we can instead just point
git.git at the git-gui project.  But I still think its a good idea to
distribute git-gui as part of the release tarball for core Git; users
have come to expect they can find a stable version of git-gui there,
much as they also expect to find a reasonably stable version of gitk.

-- 
Shawn.
