From: Peter Osterlund <petero2@telia.com>
Subject: Re: Fix interesting git-rev-list corner case
Date: Sat, 30 Jul 2005 23:01:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507302259140.26128@telia.com>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org> <m31x5gob8k.fsf@telia.com>
 <Pine.LNX.4.58.0507300913000.29650@g5.osdl.org> <m3fytwm313.fsf@telia.com>
 <Pine.LNX.4.58.0507301354000.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 23:03:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyyTe-00083J-A3
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 23:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVG3VCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 17:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVG3VCT
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 17:02:19 -0400
Received: from [81.228.11.159] ([81.228.11.159]:40859 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261617AbVG3VCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 17:02:16 -0400
Received: from r3000.localdomain (195.252.45.75) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 42B93717005FB4A1; Sat, 30 Jul 2005 23:01:54 +0200
Received: from localhost (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j6UL1p2k026172;
	Sat, 30 Jul 2005 23:01:51 +0200
X-X-Sender: petero@r3000.localdomain
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507301354000.29650@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 30 Jul 2005, Linus Torvalds wrote:

> On Sat, 30 Jul 2005, Peter Osterlund wrote:
> >
> > OK, but note that I didn't do any editing of any local files myself.
> > Both commit ids are from your public linux kernel git tree. What I did
> > was equivalent to:
> >
> > 1. rsync from rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> > 2. waited a day or so.
> > 3. git-pull-script from the same kernel.org repository.
> >
> > Is it expected that you end up with merge conflicts in this case?
>
> Nope. Something went wrong.
>
> > I think it should be possible to just fast forward to the new HEAD in
> > this situation.
>
> Indeed.
>
> Can you send me your HEAD and MERGE_HEAD (don't do the merge).

HEAD      : 33ac02aa4cef417871e128ab4a6565e751e5f3b2
MERGE_HEAD: b0825488a642cadcf39709961dde61440cb0731c

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
