From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 19:12:42 -0400
Message-ID: <20071015231242.GR27899@spearce.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47130B25.4010304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 01:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhZ7J-00049s-Kx
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 01:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbXJOXMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 19:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbXJOXMr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 19:12:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41937 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbXJOXMq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 19:12:46 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhZ6w-0004xx-0A; Mon, 15 Oct 2007 19:12:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 820BF20FBAE; Mon, 15 Oct 2007 19:12:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47130B25.4010304@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61051>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> FWIW, I'm using the MinGW port from cmd.exe, i.e. not from a posix shell, 
> on a *production* repository. gitk and git-gui work. Not all operations 
> that I regularly use are available[*] via the GUIs, like git-rebase or 
> non-fast-forwarding push, so the use of the command line is needed from 
> time to time.

Rebase in git-gui is starting to be developed.  But its still not even
close to something I can use, let alone that I would be willing to ship
to another person for testing.

Force push (non-fast-forwarding push) is in git-gui.git's master
branch now as part of the 0.9.x series.  There's a new checkbox
option in the push dialog to trigger adding --force to git-push
command line.

> Unfortunately, "Fetch" does not yet work[*] from within git-gui, so you 
> have to fall back to git-fetch on the command line.
> 
> [*] Note the distinction between "not available" and "does not work".

What's broken?  Is this that Git protocol dump showing up in
git-gui's console window thing?

Are you using the C based fetch that is in git.git's next branch,
or the shell script based one that is in master?  Which Tcl/Tk
version are you using to run git-gui?

-- 
Shawn.
