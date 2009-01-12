From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 7/7] Create an automatic UI test for the Git
	Import Wizard
Date: Mon, 12 Jan 2009 08:45:14 -0800
Message-ID: <20090112164514.GG10179@spearce.org>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com> <1231433791-9267-7-git-send-email-robin.rosenberg@dewire.com> <1231433791-9267-8-git-send-email-robin.rosenberg@dewire.com> <200901081957.20591.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 17:46:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMPw2-0000w4-57
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 17:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbZALQpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 11:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbZALQpR
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 11:45:17 -0500
Received: from george.spearce.org ([209.20.77.23]:45656 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbZALQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 11:45:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 79B8338210; Mon, 12 Jan 2009 16:45:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200901081957.20591.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105355>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> We could hold onto this patch. It might be better if we start the built in git daemon and clone
> from it, or from file, instread of jgit.org, but please try it out and see if it looks like a good a approach to
> use SWTBot for UI tests.

I'm not applying this patch for two reasons:

1) I spent 30 minutes trying to get SWTBot installed and running,
I gave up.  It doesn't want to run in my Eclipse.  Heck, I didn't
even get as far as running, I couldn't get it to install far enough
to get the project to compile.

2) I really want to avoid remote network access during JUnit tests.
Now that we have our own server process we can run it over a pipe
or something to do this test.  Or at worst, bind to a random port
on the loopback and have the client clone from that port.

-- 
Shawn.
