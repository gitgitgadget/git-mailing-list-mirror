From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC PATCH] Add a stdio prompt for SSH connection information.
Date: Mon, 23 Jun 2008 02:34:30 -0400
Message-ID: <20080623063430.GO11793@spearce.org>
References: <200806222306.25434.robin.rosenberg.lists@dewire.com> <20080622231355.GH11793@spearce.org> <200806230823.20534.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 08:36:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAfes-00058N-Nc
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 08:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbYFWGeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 02:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbYFWGeh
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 02:34:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39056 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYFWGeg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 02:34:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAfdI-0004T8-C0; Mon, 23 Jun 2008 02:34:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C8A1A20FBAE; Mon, 23 Jun 2008 02:34:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200806230823.20534.robin.rosenberg.lists@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85837>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> > > I'm also a little unsure about how to invoke the promptKeyboardInteractive method.
> > 
> > I think you implemented this method correctly.  Its a confusing API,
> > but it does seem to make sense.
> 
> No idea on how to make JSch inoke it?

Might require a server that has a token cards for authentication.
Server can ask for a user password and also give you a code to
enter into the card, which gives you the response to enter back in.
I have never worked with such a configuration so I have never seen
that sort of multi-input prompt come up in any SSH client before.

-- 
Shawn.
