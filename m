From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 15 Oct 2007 19:20:17 -0400
Message-ID: <20071015232017.GS27899@spearce.org>
References: <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com> <Pine.LNX.4.64.0710130130380.25221@racer.site> <853awepyz6.fsf@lola.goethe.zz> <20071013202713.GA2467@fieldses.org> <Pine.LNX.4.64.0710140135020.25221@racer.site> <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org> <20071014014445.GN27899@spearce.org> <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com> <47125BF7.2070503@midwinter.com> <alpine.LFD.0.9999.0710141542020.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Grimm <koreth@midwinter.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 01:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhZEo-0005ic-Up
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 01:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274AbXJOXUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 19:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756538AbXJOXUc
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 19:20:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42636 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933AbXJOXUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 19:20:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhZEH-0005ZO-9r; Mon, 15 Oct 2007 19:20:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0894720FBAE; Mon, 15 Oct 2007 19:20:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710141542020.19446@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61052>

Nicolas Pitre <nico@cam.org> wrote:
> BTW I have patches here reworking the progress code for a more compact 
> display which should mitigate this issue quite a bit.

git-gui is scraping the output of the current progress meter using
a regex and then building a graphical progress bar from that output.

Any change in how git produces the progress bar should still keep
it in a form that git-gui can regex match and scrape, preferably
without needing to know what version of git it is pulling that
output from.  For example just teach git-gui to try two different
regexps, new format and if that doesn't match then try the old
(aka current) format.

-- 
Shawn.
