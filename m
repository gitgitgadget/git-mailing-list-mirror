From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui translators: gitgui-0.10.0 coming soon
Date: Fri, 14 Mar 2008 23:31:10 -0400
Message-ID: <20080315033110.GC8410@spearce.org>
References: <20080313052713.GU8410@spearce.org> <alpine.DEB.1.00.0803140723450.30157@perkele.intern.softwolves.pp.se> <20080314063817.GW8410@spearce.org> <Pine.LNX.4.64.0803140936130.25570@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sat Mar 15 04:31:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaN7h-0002Gq-Ug
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 04:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYCODbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 23:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbYCODbN
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 23:31:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34548 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbYCODbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 23:31:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JaN6o-0006vA-M2; Fri, 14 Mar 2008 23:30:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3093320FBAE; Fri, 14 Mar 2008 23:31:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803140936130.25570@ds9.cixit.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77302>

Peter Karlsson <peter@softwolves.pp.se> wrote:
> Quick sanity check, is "Apple" really supposed to be translated here:
> 
>   #: git-gui.sh:2092 lib/choose_repository.tcl:41
>   msgid "Apple"
>   msgstr ""
> 
> In git-gui.sh:
> 
>  .mbar add cascade -label [mc Apple] -menu .mbar.apple
> 
> Since the menu title is the Apple symbol, should it really have a
> translatable label?

Hmm, maybe not.  What triggers that menu being attached to the menu
bar as the Apple menu itself is I think being called .apple.  But as
you point out, there is little point in translating that string.
It should only be used on a Mac, and on a Mac we really want that
to be your true Apple menu, not a menu that happens to say "Apple"
in your preferred language.

Actually on a Mac OS X system the "Apple" menu is now the application
menu, so it will say either "Wish" or "Git Gui", depending on how
you managed to start git-gui.

I'll remove the [mc] block on that.  We shouldn't translate it.

-- 
Shawn.
