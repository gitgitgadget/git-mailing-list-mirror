From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Make git-fetch follow tags we already have objects for sooner
Date: Fri, 29 Feb 2008 17:34:31 -0500
Message-ID: <20080229223431.GT8410@spearce.org>
References: <20080228084257.GC16870@spearce.org> <7v3arcduil.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 23:35:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDow-0000kT-KK
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbYB2Wei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755690AbYB2Wei
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:34:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38964 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbYB2Weh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:34:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVDo8-0000ir-Db; Fri, 29 Feb 2008 17:34:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 04BC620FBAE; Fri, 29 Feb 2008 17:34:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v3arcduil.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75580>

Junio C Hamano <gitster@pobox.com> wrote:
> This is cute.  Obviously some tests need to be adjusted for this
> change, though.

I'll take a look at the current tests this weekend and see what
needs to be adjusted, if anything.  I'd also like to get a few
tests written for this, so we are certain the optimizations are
kicking in when they are supposed to be.

-- 
Shawn.
