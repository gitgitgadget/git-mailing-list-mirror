From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 8 Jun 2011 17:18:19 +0200
Message-ID: <20110608151819.GA11814@elte.hu>
References: <20110608093648.GA19038@elte.hu>
 <20110608203433.61e02ad8.sfr@canb.auug.org.au>
 <20110608125242.GA32745@elte.hu>
 <7vlixc2wpq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, git@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:18:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKWm-0002xw-JS
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355Ab1FHPSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 11:18:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:56573 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756084Ab1FHPSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:18:35 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QUKWV-0004BJ-00
	from <mingo@elte.hu>; Wed, 08 Jun 2011 17:18:28 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 003E73E2517; Wed,  8 Jun 2011 17:18:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vlixc2wpq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175380>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > Still it's not entirely logical that 'foreign' tags invade another 
> > branch this aggressively.
> 
> Is it a problem for "describe", or is the root of the problem that 
> git allowed you to slurp in 'foreign' tags that you do not care 
> about?

Well, if i checked out a linux-next related branch i'd expect those 
tags to go live, but if i stayed on -git i'd expect only Linus's tags 
to live.

I would not expect the linux-next tags to go away altogether - i 
added it as a remote, so i'd expect to see 'its' tags when i check it 
out.

at least that's my naive expectation from a 'remote' repository - if 
there's a better way to think about this then i'm eager to improve
:-)

Thanks,

	Ingo
