From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 10:25:25 +0200
Message-ID: <E1575DD6-AC8C-49FD-A765-801A19E1FA73@zib.de>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com> <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org> <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net> <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de> <20070730074937.GT20052@spearce.org> <577C7529-4C3C-40D4-B86A-8B3CE888C997@zib.de> <20070730081439.GA907@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFQYV-00049X-Jt
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 10:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745AbXG3IYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 04:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757015AbXG3IYk
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 04:24:40 -0400
Received: from mailer.zib.de ([130.73.108.11]:53218 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbXG3IYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 04:24:39 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6U8OUaT008568;
	Mon, 30 Jul 2007 10:24:30 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6U8OUV8004992
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 30 Jul 2007 10:24:30 +0200 (MEST)
In-Reply-To: <20070730081439.GA907@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54203>


On Jul 30, 2007, at 10:14 AM, Jeff King wrote:

>
> How about "git commit-tree HEAD^{tree} -p HEAD"?

Thanks, I wasn't aware of this syntax.

> But I think making a "fake" commit to force non-fast-forward is the
> wrong thing. You really want to make your "extra" commit be the merge
> that wouldn't have happened (which unfortunately is not as simple as
> just creating a commit by hand, since you have to actually _do_ the
> merge to get the tree).

I agree. But I think except for being 'fake' there shouldn't be any
problems with the extra commit.

	Steffen
