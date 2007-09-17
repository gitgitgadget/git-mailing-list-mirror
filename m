From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui i18n status?
Date: Sun, 16 Sep 2007 23:20:42 -0400
Message-ID: <20070917032042.GF3099@spearce.org>
References: <20070901042924.GE18160@spearce.org> <20070902022444.GK18160@spearce.org> <Pine.LNX.4.64.0709021320230.28586@racer.site> <200709161403.50780.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 05:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX7AK-0001m8-FH
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 05:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbXIQDUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 23:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbXIQDUs
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 23:20:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49225 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbXIQDUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 23:20:48 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IX79z-0007UH-D8; Sun, 16 Sep 2007 23:20:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 36CFF20FBAE; Sun, 16 Sep 2007 23:20:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200709161403.50780.stimming@tuhh.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58377>

Christian Stimming <stimming@tuhh.de> wrote:
> One question came up when seeing the i18n code really in git-gui.git: How are 
> translators supposed to submit new or updated translations? Is 
> git-gui-i18n.git of any use anymore? This doesn't seem so. Should updated 
> translations just be submitted by email to git@vger? In any case, the 
> instructions in po/README should probably be updated to explain the 
> recommended way of submitting translation updates. 

I was sort of hoping Dscho would be able to answer that.  ;-)

I can play patch-monkey and apply things people send to the mailing
list.  I'm also willing to pull from a tree if the commit history
is clean and mergable.  Since each language more or less stands
on its own in its own .po file translators may find it easier to
email patches.  I dunno, I'm not a translator.
 
> Oh, and po/git-gui.pot should probably be updated to reflect the latest string 
> additions and changes. 

Yes.  Dscho was looking at creating a custom diff filter for git
that would better handle showing diffs here.  I was sort of waiting
for progress from that (if any) before doing the pot update.  I also
have a lot of UI work that I wanted to do in the 0.9.x series and
those are likely to create/change the sets of messages we need
to translate.

-- 
Shawn.
