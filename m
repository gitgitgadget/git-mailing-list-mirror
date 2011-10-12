From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 00/20] [GIT PULL][v3.2] tracing: queued updates
Date: Wed, 12 Oct 2011 18:29:48 +0200
Message-ID: <20111012162947.GC31857@elte.hu>
References: <20111010133852.829771373@goodmis.org>
 <20111011055017.GA32616@elte.hu>
 <20002.1318367320@turing-police.cc.vt.edu>
 <20111012080711.GM18618@elte.hu>
 <20111012141939.GA25085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Valdis.Kletnieks@vt.edu, git@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Wed Oct 12 18:31:37 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RE1iR-0002Dw-GQ
	for glk-linux-kernel-3@lo.gmane.org; Wed, 12 Oct 2011 18:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab1JLQbZ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 12 Oct 2011 12:31:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:45597 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab1JLQbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2011 12:31:24 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1RE1iC-00058h-2E
	from <mingo@elte.hu>; Wed, 12 Oct 2011 18:31:20 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 5EED83E2596; Wed, 12 Oct 2011 18:31:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111012141939.GA25085@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183375>


* Jeff King <peff@peff.net> wrote:

> > It's really useful for a painless UI flow to disambiguate failure 
> > messages into clearly actionable variants.
> 
> I agree. I think some people are concerned with leaking information 
> about which repos exist and how they are configured. That is 
> probably not a big problem for a public site like kernel.org, 
> though.

Well, a gitconfig option could be provided to not leak that small 
amount of info - but it would otherwise be weird for an OSS SCM to 
default to a behavior that only makes sense with closed source, 
right? :-)

Thanks,

	Ingo
