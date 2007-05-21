From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit ID in exported Tar Ball
Date: Mon, 21 May 2007 02:53:55 -0400
Message-ID: <20070521065355.GN3141@spearce.org>
References: <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <20070520161048.GI5015@cip.informatik.uni-erlangen.de> <817CD103-261C-4D40-9C8F-00B2E14130BE@silverinsanity.com> <20070520163026.GA7387@cip.informatik.uni-erlangen.de> <20070521062953.GL3141@spearce.org> <20070521063752.GB23350@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon May 21 08:54:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1nC-0002HO-Es
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbXEUGyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754357AbXEUGyb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:54:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57458 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbXEUGyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 02:54:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hq1mG-0006ks-L0; Mon, 21 May 2007 02:53:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1D41920FBAE; Mon, 21 May 2007 02:53:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070521063752.GB23350@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47975>

Thomas Glanzmann <thomas@glanzmann.de> wrote:
> so maybe it isn't that useless as I thought it initial is. But my point
> still stands. I want the commit id of the HEAD in a _file within_ the
> tarball and I definitively don't want to tag my project before I get a
> unique identifier.

So what, a magic flag to git-describe like:

	git-describe --untagged HEAD
	1a8213...

Where --untagged just means "give me back the raw commit SHA-1 if
the input ref(s) aren't tagged"?

-- 
Shawn.
