From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 08 Jun 2011 13:51:07 +0200
Message-ID: <1307533867.2497.997.camel@laptop>
References: <20110608093648.GA19038@elte.hu>
	 <20110608203433.61e02ad8.sfr@canb.auug.org.au>
	 <1307529636.2322.320.camel@twins>
	 <20110608212910.093ba753.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Wed Jun 08 13:47:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUHEd-00060x-B0
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 13:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab1FHLri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 07:47:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42863 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab1FHLri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 07:47:38 -0400
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QUHEW-000187-Gs
	for git@vger.kernel.org; Wed, 08 Jun 2011 11:47:36 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1QUHEU-0002ID-Fe
	for git@vger.kernel.org; Wed, 08 Jun 2011 11:47:34 +0000
Received: by dyad.programming.kicks-ass.net (Postfix, from userid 65534)
	id B97668663C; Wed,  8 Jun 2011 13:51:04 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on dyad
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (dyad [192.168.0.60])
	by dyad.programming.kicks-ass.net (Postfix) with ESMTP id B908986638;
	Wed,  8 Jun 2011 13:51:00 +0200 (CEST)
In-Reply-To: <20110608212910.093ba753.sfr@canb.auug.org.au>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175360>

On Wed, 2011-06-08 at 21:29 +1000, Stephen Rothwell wrote:
> Hi Peter,
> 
> On Wed, 08 Jun 2011 12:40:36 +0200 Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> >
> > *groan*, I tried that, but got:
> > 
> > # git describe --contains  189d3c4a94ef19fca2a71a6a336e9fda900e25e7 --match '^v.*'
>                                                                                  ^
> These are globs. not regexps.

Yeah, figured as much, never would have thought of trying that though.
The man page said pattern, my brain made regex.
