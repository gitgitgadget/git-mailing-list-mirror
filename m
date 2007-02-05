From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 5 Feb 2007 01:57:58 -0500
Message-ID: <20070205065758.GB13472@spearce.org>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 07:58:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDxnp-0004E8-0d
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 07:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbXBEG6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 01:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbXBEG6J
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 01:58:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35958 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbXBEG6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 01:58:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDxng-00031k-16; Mon, 05 Feb 2007 01:58:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1B9E920FBAE; Mon,  5 Feb 2007 01:57:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38731>

Junio C Hamano <junkio@cox.net> wrote:
> We seem to have accumulated some crufts, duplicated and/or
> disused features.  I think we should start planning deprecation
> and removal.
> 
> Here are potential candidates we might want to mark as
> "scheduled for removal".  Note that I threw in a bit more than
> what I seriously consider bloat, so your favorite may appear in
> the list.

I'm OK with everything on the list going away.  But that's because
I don't ever use them.  :)

I'd think we also want to remove the following older aliases:

  annotate
  init-db
  fsck-objects
  repo-config

1 year after 1.5.0 final ships.  That should give people a chance
to upgrade their other tools (StGit, qgit, etc.).

-- 
Shawn.
