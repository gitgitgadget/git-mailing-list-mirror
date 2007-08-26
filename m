From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: `git-rev-parse master` not referred to by any ref?
Date: Sun, 26 Aug 2007 18:28:52 -0400
Message-ID: <20070826222852.GC18160@spearce.org>
References: <20070826134521.GA20243@fieldses.org> <20070826135251.GB20243@fieldses.org> <20070826140645.GC20243@fieldses.org> <7vir72ng1n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 00:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPQbN-0002tz-2R
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 00:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbXHZW26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 18:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbXHZW26
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 18:28:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41219 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbXHZW25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 18:28:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IPQb4-0007Yn-TF; Sun, 26 Aug 2007 18:28:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB39520FBAE; Sun, 26 Aug 2007 18:28:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vir72ng1n.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56741>

Junio C Hamano <gitster@pobox.com> wrote:
> Also, I *think* objects that are only reachable via ORIG_HEAD
> are not considered as reachable by fsck/prune --- we probably
> would want to fix this.

Probably.  But most users also have reflog enabled on HEAD in the
repository if they were to also have ORIG_HEAD there.  In such a
case ORIG_HEAD is usually HEAD@{1}, which is considered reachable
by fsck/prune/repack.

-- 
Shawn.
