From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 7 May 2007 21:41:14 -0400
Message-ID: <20070508014114.GC11311@spearce.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk> <20070507063505.GA31269@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 08 03:42:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEiU-0003uT-82
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934434AbXEHBl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934594AbXEHBl2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:41:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51143 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934434AbXEHBl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:41:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlEhO-0001wN-0R; Mon, 07 May 2007 21:41:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6AA5220FBAE; Mon,  7 May 2007 21:41:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070507063505.GA31269@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46507>

Karl Hasselstr??m <kha@treskal.com> wrote:
> I thought "git add -i" was the best thing since sliced bread -- until
> I found the same feature in git-gui, but with a _much_ better
> interface. Just right-click on a hunk in a diff, and you have the
> option of staging/unstaging that hunk. Pure magic.

"git add -i" has a hunk splitting feature that git-gui lacks.
I'm thinking of adding features to git-gui to let you select a
region of a hunk using the text selection, and then stage only
that selection.  I also want to let you revert hunks from the
working directory copy.

But after reading Junio's comments about "git add -i" being a
possibly bad idea and instead letting you park everything into
a shelf, reset --hard your working directory to HEAD and then
pull things back off the shelf to be staged, I might want to
do that differently in git-gui...  like use a shelf.  ;-)


But I'm glad someone else finds the hunk feature useful in
git-gui.  I use it far too often myself.

-- 
Shawn.
