From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Sat, 1 Sep 2007 20:44:07 -0400
Message-ID: <20070902004407.GI18160@spearce.org>
References: <11886421573285-git-send-email-robin.rosenberg@dewire.com> <7vir6us1ia.fsf@gitster.siamese.dyndns.org> <20070901222036.GH18160@spearce.org> <Pine.LNX.4.64.0709020133540.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:44:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRdZZ-0005wZ-OM
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 02:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbXIBAoO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 20:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbXIBAoO
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 20:44:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35478 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514AbXIBAoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 20:44:13 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IRdZG-0002ZD-Gr; Sat, 01 Sep 2007 20:43:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 02CCD20FBAE; Sat,  1 Sep 2007 20:44:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709020133540.28586@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57290>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 1 Sep 2007, Shawn O. Pearce wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > 
> > > I might be in the middle of resolving a conflicted "git am".
> > 
> > And there's no way to tell the difference either.
> 
> AFAICT git-am creates an "info" file in .dotest/.

But git-rebase without -m and -i is defined as format-patch|am.
So when rebasing it looks identical to git-am.  Hence no way to
tell the difference between the two.

I think post 1.5.3 one of the things we should work on is trying
to better track our current operation state.  Most of that would
be to refactor how we track state in things like rebase/am/merge.
 
-- 
Shawn.
