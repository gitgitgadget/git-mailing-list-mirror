From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 22:21:43 -0400
Message-ID: <20070319022143.GF20658@spearce.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT7VN-0007kt-BQ
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 03:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933660AbXCSCVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 22:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933663AbXCSCVs
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 22:21:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48072 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933660AbXCSCVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 22:21:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HT7V8-0004rP-3f; Sun, 18 Mar 2007 22:21:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E1BBC20FBAE; Sun, 18 Mar 2007 22:21:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42563>

Junio C Hamano <junkio@cox.net> wrote:
> Theodore Tso <tytso@mit.edu> writes:
> 
> > Is it at all possible to figure out <commit-id-before-the-push>?  It
> > seems the answer is no, and I suspect that's a bug.
> 
> Doesn't update hook get pre- and post- commit object name?

Yes, and the same is true in the new post-receive hook.

-- 
Shawn.
