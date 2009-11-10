From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC, PATCH] git send-email: Make --no-chain-reply-to the
 default
Date: Tue, 10 Nov 2009 20:58:25 +0100
Message-ID: <1257883105.4108.465.camel@laptop>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
	 <1257789555.4108.348.camel@laptop> <20091110040847.GC29454@elte.hu>
	 <1257838352.21088.5.camel@twins>
	 <b4087cc50911101146j7f773613j74d6d6716a82ebd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 20:58:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7wrR-0002wo-5K
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 20:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967AbZKJT63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 14:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757957AbZKJT63
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 14:58:29 -0500
Received: from bombadil.infradead.org ([18.85.46.34]:38435 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757941AbZKJT63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 14:58:29 -0500
Received: from e53227.upc-e.chello.nl ([213.93.53.227] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1N7wrH-0004lW-2R; Tue, 10 Nov 2009 19:58:31 +0000
Received: from [127.0.0.1] (dyad [192.168.0.60])
	by dyad.programming.kicks-ass.net (Postfix) with ESMTP id 58C4110BC1;
	Tue, 10 Nov 2009 20:58:49 +0100 (CET)
In-Reply-To: <b4087cc50911101146j7f773613j74d6d6716a82ebd4@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132588>

On Tue, 2009-11-10 at 13:46 -0600, Michael Witten wrote:
> [Sorry about the repeat, Peter]
> 
> On Tue, Nov 10, 2009 at 1:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, 2009-11-10 at 05:08 +0100, Ingo Molnar wrote:
> >> about half of every patch series that gets sent to me on lkml is
> >> unreadable in my email client due to the default threading that
> >> git-send-email does. It looks like this:
> >>
> >> 28685 r T Nov 05 Hitoshi Mitake  (  31) [PATCH v5 0/7] Adding general performance benchmarki
> >> 28686   T Nov 05 Hitoshi Mitake  (  31) +->[PATCH v5 1/7] Adding new directory and header fo
> >> 28687   T Nov 05 Hitoshi Mitake  ( 368) | +->[PATCH v5 2/7] sched-messaging.c: benchmark for
> >> 28688   T Nov 05 Hitoshi Mitake  ( 148) | | +->[PATCH v5 3/7] sched-pipe.c: benchmark for pi
> >> 28689   T Nov 05 Hitoshi Mitake  ( 149) | | | +->[PATCH v5 4/7] builtin-bench.c: General fra
> >> 28690   T Nov 05 Hitoshi Mitake  (  24) | | | | +->[PATCH v5 5/7] Modifying builtin.h for ne
> >> 28691   T Nov 05 Hitoshi Mitake  (  25) | | | | | +->[PATCH v5 6/7] Modyfing perf.c for subc
> >> 28692   T Nov 05 Hitoshi Mitake  (  30) | | | | | | +->[PATCH v5 7/7] Modyfing Makefile to b
> >
> > Do what I do and flame the sender and have them repost.
> >
> > I simply won't even attempt to read crap send like that.
> 
> What, precisely, is unreadable or crappy about that? I suppose the
> chaining was introduced to keep some order to the patches.

As can be seen in the example above, the subjects become useless at
about the 4th patch.

The reply to the first patch together with sort on subject or date also
keeps the patches in order, since consecutive patches have increasing
timestamps and properly increasing numbers in them. It also keeps the
subjects readable.

People want me to read their patches, if they make it hard on me, I
simply wont spend my time on their stuff and do something else instead.
