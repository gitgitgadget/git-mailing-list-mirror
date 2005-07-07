From: Peter Osterlund <petero2@telia.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: 07 Jul 2005 21:17:47 +0200
Message-ID: <m38y0ictno.fsf@telia.com>
References: <1119994003.9631.6.camel@localhost.localdomain>
	<m3ekagp9mk.fsf@telia.com>
	<1120385280.6845.12.camel@localhost.localdomain>
	<m3oe9k6p40.fsf@telia.com>
	<1120425269.6845.28.camel@localhost.localdomain>
	<m3y88m21ln.fsf@telia.com>
	<1120683255.6881.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 07 21:31:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqc5G-0006Z1-L1
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 21:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVGGTXB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 15:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVGGTUY
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 15:20:24 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:50936 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262179AbVGGTSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 15:18:08 -0400
Received: from r3000.localdomain (62.20.229.31) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 42BFBBD200200BC4; Thu, 7 Jul 2005 21:17:58 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j67JHnTG015207;
	Thu, 7 Jul 2005 21:17:49 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j67JHmWI015202;
	Thu, 7 Jul 2005 21:17:48 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1120683255.6881.8.camel@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> On Mon, 2005-07-04 at 14:32 +0200, Peter Osterlund wrote:
> > I agree with the other comments, it's probably not wise to rely on
> > wiggle, and wiggle sometimes makes a mess. However, it often does the
> > right thing, and with a configurable merge program and an undo
> > function, this should not be a problem. Just undo and try again if you
> > don't like the result.
> 
> In the today's snapshot you can get the 'stg push --undo' command which
> reverts the result of a push operation (either failed or not). The patch
> is reverted to its previous state. It works even if you ran 'refresh'.

Thanks, this seems to work as expected.

> The current implementation does not remove the .older/.local/.remote
> files from the tree when undoing a push. I think I will first implement
> a 'resolve' command which takes care of these files.
> 
> Anyway, once I fully test the current state of stgit, I will make the
> 0.4 release (probably this weekend).

I've found an unrelated problem. If I export patches with "stg export
dirname", there are no diffs included in the patches. The patch
description is all that is generated. If I omit the dirname parameter,
the export works correctly though.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
