From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to run git-gui always in English?
Date: Sun, 21 Oct 2007 02:52:30 -0400
Message-ID: <20071021065230.GE14735@spearce.org>
References: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 08:52:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjUg2-0006Ny-4l
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 08:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXJUGwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 02:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbXJUGwf
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 02:52:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35092 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbXJUGwe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 02:52:34 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjUfn-000075-FL; Sun, 21 Oct 2007 02:52:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ADA5220FBAE; Sun, 21 Oct 2007 02:52:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61884>

Steffen Prohaska <prohaska@zib.de> wrote:
> There are a lot of efforts going on to localize git-gui,
> including technical terms like "push". Personally I don't
> understand what this should be useful for. The command is called
> "git push"s. So, why should it be named differently in the gui.
> 
> Anyway, I can switch it off, right? So here's my question.
> 
> How can I switch msysgit's git-gui to English, independently of
> the language selected for Windows? I recognized that git-gui
> adjusts to the 'language selection' of Windows. How can I
> disable this? I want git-gui to always display English. Nothing
> else, never! I can't help people who use a different language
> in the gui, because I'll not understand what they are talking
> about and they'll not understand me.
> 
> Can I set an option in git-gui's option menu? I haven't
> found one.

Yea, we don't have a UI to let you set what language the UI should
appear in.  Partly because once the UI is up we'd have to restart
the entire process to change the strings its using.  And partly
because nobody has asked for this before.

I think that if you set LANG=en before you start git-gui it will
take on English, and so will all of the standard dialogs that we
"borrow" from wish.

-- 
Shawn.
