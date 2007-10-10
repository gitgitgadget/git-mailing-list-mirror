From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Two minor glitches in git-gui
Date: Wed, 10 Oct 2007 01:50:24 -0400
Message-ID: <20071010055024.GN2137@spearce.org>
References: <200710091121.59422.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 07:50:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfUSv-0000uI-Ad
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 07:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbXJJFu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 01:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbXJJFu3
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 01:50:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34588 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbXJJFu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 01:50:28 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IfUSg-0004PW-8t; Wed, 10 Oct 2007 01:50:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E9ED720FBAE; Wed, 10 Oct 2007 01:50:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200710091121.59422.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60463>

Michele Ballabio <barra_cuda@katamail.com> wrote:
> On Linux:
>   1. run git-gui
>   2. open edit->options dialog box
>   3. click on "select font". It will open the "choose font" box.
>   4. click on "options" box to give it focus.
>   5. return to the "choose font" box and try to choose a font.
> 
> At this point, the "choose font" box won't react to my actions.
> 
> The workaround is to iconify the "select font" dialog box and
> then restore it. Can someone reproduce this?
> 
> I think I've seen a similar behaviour before, on git-gui's
> about window, but I'm not sure (it doesn't trigger anymore).
> 
> The other problem is that it is possible to open the same
> "choose font" box many times (one is enough :).

I've actually seen this once before on X11.  I thought that I had
it fixed.  Apparently not.  Its got to do with the fact that I have
a grab on the options dialog, and then I set another one on the
font dialog.  Switching focus into the options dialog causes all
window to no longer go to the font dialog, but the option dialog
is the one with the focus.

I'll try to poke at it more and see if I can figure it out.  But
I already thought I had.  :-\

Thanks for the bug report.

-- 
Shawn.
