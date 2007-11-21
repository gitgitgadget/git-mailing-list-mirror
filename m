From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix warning about bitfield in struct ref
Date: Wed, 21 Nov 2007 01:51:55 -0500
Message-ID: <20071121065155.GT14735@spearce.org>
References: <20071118093137.GA2196@spearce.org> <Pine.LNX.4.64.0711200058270.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujRd-0005Eu-U9
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbXKUGwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbXKUGwB
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:52:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55108 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbXKUGwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:52:00 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IujRF-0003MW-19; Wed, 21 Nov 2007 01:51:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE45520FBAE; Wed, 21 Nov 2007 01:51:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711200058270.16728@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65602>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 18 Nov 2007, Shawn O. Pearce wrote:
> 
> > +	unsigned int force:1,
> 
> Isn't this "unsigned force:1" everywhere else in git's source?

That may be true but Junio already applied it as "unsigned int"
as I wrote it.  Anyway "unsigned int" and "unsigned" will give the
same result here; I just typed 4 characters more than I needed to.

-- 
Shawn.
