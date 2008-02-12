From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: support Git Gui.app under OS X 10.5
Date: Tue, 12 Feb 2008 02:33:06 -0500
Message-ID: <20080212073306.GA24004@spearce.org>
References: <1202775434-28273-1-git-send-email-jaysoffian@gmail.com> <m2d4r30yjf.fsf@userprimary.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jaysoffian@gmail.com, git@vger.kernel.org
To: Seth Falcon <seth@userprimary.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 08:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOpeF-00006E-OH
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 08:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759577AbYBLHdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 02:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759552AbYBLHdM
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 02:33:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51329 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759523AbYBLHdL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 02:33:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JOpdb-00062E-6o; Tue, 12 Feb 2008 02:33:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BD67F20FBAE; Tue, 12 Feb 2008 02:33:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <m2d4r30yjf.fsf@userprimary.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73633>

Seth Falcon <seth@userprimary.net> wrote:
> jaysoffian@gmail.com writes:
> > The Tk Framework moved its location in 10.5 compared to 10.4
> >
> > Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> > ---
> > Argh. Third time's a charm? Sorry, forgot to add my change before
> > amending and resending.
> 
> I applied this and things work much better, thanks!
> Tested-by: Seth Falcon <seth@userprimary.net>

Thanks guys.  This is now in maint and master.  Its going to
be part of git-gui 0.9.3, whenever that happens.
 
> One thing.  When I quit git gui I see the following on the terminal:
> 
> TkMacOSXDoHLEvent failed : cppe 1                   ,kHighLevelEvent  61657674 0000 tvea,-1708

Yea, I see some random errors from git-gui when I use an option menu.
I think there's something buggy with Tk on Aqua.  Maybe we should
report these to the Tk Aqua folks, especially if we could distill
the issue down to a really short Tk script.

-- 
Shawn.
