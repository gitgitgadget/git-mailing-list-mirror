From: Peter Osterlund <petero2@telia.com>
Subject: Re: Fix interesting git-rev-list corner case
Date: 30 Jul 2005 22:50:48 +0200
Message-ID: <m3fytwm313.fsf@telia.com>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
	<m31x5gob8k.fsf@telia.com>
	<Pine.LNX.4.58.0507300913000.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 22:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyyKF-00072I-Ni
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 22:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbVG3Uw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 16:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbVG3Uw2
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 16:52:28 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:61343 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263173AbVG3UvE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 16:51:04 -0400
Received: from r3000.localdomain (195.252.45.75) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 42B813B0006210D1; Sat, 30 Jul 2005 22:50:54 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j6UKonuX025950;
	Sat, 30 Jul 2005 22:50:49 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j6UKomBN025945;
	Sat, 30 Jul 2005 22:50:48 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507300913000.29650@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 30 Jul 2005, Peter Osterlund wrote:
> > 
> > I have problems pulling linux kernel changes from
> > 33ac02aa4cef417871e128ab4a6565e751e5f3b2 to
> > b0825488a642cadcf39709961dde61440cb0731c into my local tree. At first
> > I thought your patch would fix it, but it doesn't:
> 
> No, this is a merge conflict failure, and you simply have conflicts in the
> tree. git did everything right, it just couldn't do an automatic merge.

OK, but note that I didn't do any editing of any local files myself.
Both commit ids are from your public linux kernel git tree. What I did
was equivalent to:

1. rsync from rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
2. waited a day or so.
3. git-pull-script from the same kernel.org repository.

Is it expected that you end up with merge conflicts in this case? If
that's the case, is there a better way to pull changes that doesn't
involve having to resolve conflicts in files you didn't even know
existed?

I think it should be possible to just fast forward to the new HEAD in
this situation.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
