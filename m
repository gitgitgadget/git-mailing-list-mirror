From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: a475e8095aeb898c1ca60673b82df97d2300cc95 broken for docs
Date: Tue, 21 Aug 2007 21:41:40 -0400
Message-ID: <20070822014140.GK27913@spearce.org>
References: <86odh0ojx4.fsf@blue.stonehenge.com> <7vsl6coahd.fsf@gitster.siamese.dyndns.org> <86hcmso9ga.fsf@blue.stonehenge.com> <7v7inoo38o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 03:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INfEJ-0005El-1O
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 03:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXHVBlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 21:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXHVBlp
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 21:41:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33049 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbXHVBlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 21:41:45 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1INfDv-0004Sn-5F; Tue, 21 Aug 2007 21:41:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BF9DD20FBAE; Tue, 21 Aug 2007 21:41:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v7inoo38o.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56342>

Junio C Hamano <gitster@pobox.com> wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
> 
> >>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
> >
> > Junio> I think we've seen it reported that docbook-xsl 1.72 and/or 1.73
> > Junio> are broken.  Is your debug log from either of these versions?
> >
> > 1.71
> 
> Interesting.  I use 1.71 here too but it does not break.
> 
> I wonder what the differences are between our environments
> (don't answer that you use OSX and I use Debian and FC -- that
> much I already know).

It broke at day-job on Cygwin today.  I don't know what version
of docbook-xsl I'm using there.  But its fine on my OSX system.
I had planned on debugging it at home tonight, but I can't reproduce
it here.  Cute.  I will look at it again tomorrow and see if I can
debug the issue.

I'm pretty sure it was my recent edit to git-rev-list.txt; its
one of the only commits that has impacted that manual page since
the last time I had built that manual on Cygwin.  And no, nothing
else (e.g. docbook, asciidoc, xmlto) has changed since the last
successful build.

-- 
Shawn.
