From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC, PATCH] git send-email: Make --no-chain-reply-to the
 default
Date: Tue, 10 Nov 2009 08:32:32 +0100
Message-ID: <1257838352.21088.5.camel@twins>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
	 <1257789555.4108.348.camel@laptop>  <20091110040847.GC29454@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Nov 10 08:31:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7lCW-0000ol-V1
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 08:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZKJHb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 02:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbZKJHb3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 02:31:29 -0500
Received: from bombadil.infradead.org ([18.85.46.34]:41382 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbZKJHb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 02:31:29 -0500
Received: from e53227.upc-e.chello.nl ([213.93.53.227] helo=twins)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1N7lCO-0007Tc-2D; Tue, 10 Nov 2009 07:31:32 +0000
Received: by twins (Postfix, from userid 1000)
	id 32EE818002432; Tue, 10 Nov 2009 08:32:33 +0100 (CET)
In-Reply-To: <20091110040847.GC29454@elte.hu>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132542>

On Tue, 2009-11-10 at 05:08 +0100, Ingo Molnar wrote:
> (moved from lkml to the Git list)
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > >                            Mailer: 
> > > git-send-email 1.6.5.2
> > 
> > Please teach your git-send-email thing to use --no-chain-reply-to.
> 
> about half of every patch series that gets sent to me on lkml is 
> unreadable in my email client due to the default threading that 
> git-send-email does. It looks like this:
> 
> 28685 r T Nov 05 Hitoshi Mitake  (  31) [PATCH v5 0/7] Adding general performance benchmarki
> 28686   T Nov 05 Hitoshi Mitake  (  31) +->[PATCH v5 1/7] Adding new directory and header fo
> 28687   T Nov 05 Hitoshi Mitake  ( 368) | +->[PATCH v5 2/7] sched-messaging.c: benchmark for
> 28688   T Nov 05 Hitoshi Mitake  ( 148) | | +->[PATCH v5 3/7] sched-pipe.c: benchmark for pi
> 28689   T Nov 05 Hitoshi Mitake  ( 149) | | | +->[PATCH v5 4/7] builtin-bench.c: General fra
> 28690   T Nov 05 Hitoshi Mitake  (  24) | | | | +->[PATCH v5 5/7] Modifying builtin.h for ne
> 28691   T Nov 05 Hitoshi Mitake  (  25) | | | | | +->[PATCH v5 6/7] Modyfing perf.c for subc
> 28692   T Nov 05 Hitoshi Mitake  (  30) | | | | | | +->[PATCH v5 7/7] Modyfing Makefile to b

Do what I do and flame the sender and have them repost.

I simply won't even attempt to read crap send like that.
