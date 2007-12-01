From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] git-gui USer's Survey 2007 (was: If you would write git from scratch now, what would you change?)
Date: Fri, 30 Nov 2007 21:35:20 -0500
Message-ID: <20071201023520.GQ14735@spearce.org>
References: <fifstd$ilj$1@ger.gmane.org> <20071127015833.GL14735@spearce.org> <Pine.LNX.4.64.0711271136050.27959@racer.site> <fiib19$dj6$1@ger.gmane.org> <Pine.LNX.4.64.0711281225150.27959@racer.site> <20071128232523.GE9174@efreet.light.src> <Pine.LNX.4.64.0711282345500.27959@racer.site> <20071129065706.GA24070@efreet.light.src> <Pine.LNX.4.64.0711291200000.27959@racer.site> <20071130175018.GB30048@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyICo-0003QY-Oz
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843AbXLACf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757902AbXLACf1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:35:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37745 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757763AbXLACf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:35:26 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IyICF-0000pJ-4A; Fri, 30 Nov 2007 21:35:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9FB4020FBAE; Fri, 30 Nov 2007 21:35:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071130175018.GB30048@efreet.light.src>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66676>

Jan Hudec <bulb@ucw.cz> wrote:
> Nevertheless, I actually think git-gui is quite well in Tcl/Tk and rewriting
> it in python nor any other language would probably help it in any way.

UNIX (really X11) users think git-gui looks like cr*p on their
systems as Tk draws with 1980s widgets, not 2007 style widgets.
They have every right to complain about the look and feel of the
application, its utter crap.  Tk 8.5's tiles extension may help
that, but I haven't tried.

On Windows 2000/XP and Mac OS X I think I've gotten git-gui to
(almost) fit into the rest of the desktop.  It fits into the Windows
UI better than it does Mac OS X, there are still some rough edges
where it is really obvious its not a native Mac OS X application.

On all platforms Tk has some "features" that are less than desirable.
For example it has been an absolute nightmare to get split pane
divider things to work on all systems.  I can't tell you how many
days I spent just getting the main window to not react stupidly
on each system.  And it *still* doesn't act right everywhere.
Sometimes if you resize the window the status bar on the bottom
disappears and Tk just clips it right out of the UI (no, I didn't
ask it to do that, Tk has bugs).

Building context sensitive menus isn't fun.  Managing some data
structures in Tcl isn't fun.  The list of why I'm currently unhappy
with Tcl/Tk for git-gui is actually pretty long.

-- 
Shawn.
