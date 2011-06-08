From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 8 Jun 2011 14:52:42 +0200
Message-ID: <20110608125242.GA32745@elte.hu>
References: <20110608093648.GA19038@elte.hu>
 <20110608203433.61e02ad8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Wed Jun 08 14:53:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUIFr-0004Wk-3f
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 14:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711Ab1FHMw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 08:52:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:34760 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790Ab1FHMw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 08:52:58 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1QUIFZ-00024o-3c
	from <mingo@elte.hu>; Wed, 08 Jun 2011 14:52:50 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 0259C3E2517; Wed,  8 Jun 2011 14:52:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110608203433.61e02ad8.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175365>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > But the next-20080501 tag is useless, and i don't have linux-next 
> > as HEAD, it's only a remote.
> 
> You can restict which tags get used:
> 
> $ git describe --contains --match 'v*' 189d3c4a94
> v2.6.26-rc1~155

Ok, that works.

Still it's not entirely logical that 'foreign' tags invade another 
branch this aggressively.

Yeah, i know that Git tags are global but still, if i add a remote i 
do not intuitively expect it to create a union of tags, do i?

So it would be nice to have more separation for remotes - right now 
they do not sit still in their sandboxes! :-)

Thanks,

	Ingo
