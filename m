From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 4/5] Define Patch to parse a sequence of patch
	FileHeaders
Date: Thu, 11 Dec 2008 10:39:54 -0800
Message-ID: <20081211183954.GH32487@spearce.org>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org> <1228971522-28764-4-git-send-email-spearce@spearce.org> <1228971522-28764-5-git-send-email-spearce@spearce.org> <200812111934.13218.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 19:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAqTJ-00026N-8u
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 19:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400AbYLKSj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 13:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755082AbYLKSj4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 13:39:56 -0500
Received: from george.spearce.org ([209.20.77.23]:54615 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbYLKSjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 13:39:55 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BA36F38200; Thu, 11 Dec 2008 18:39:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812111934.13218.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102812>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > +		assertEquals(572, fRepositoryConfigTest.startOffset);
> > +		assertEquals(1490, fRepositoryConfig.startOffset);
>
> 1487 here

Really?  1490 is the only value that the test vector passes with.
What's the 3 bytes you think I'm off by?

-- 
Shawn.
