From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-rerere observations and feature suggestions
Date: Wed, 18 Jun 2008 20:43:29 +0200
Message-ID: <20080618184329.GB25707@elte.hu>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu> <20080618112931.GY29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K92eJ-0003T5-Ew
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 20:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbYFRSnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 14:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbYFRSnz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 14:43:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43376 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbYFRSny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 14:43:54 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1K92d2-0001Ws-4s
	from <mingo@elte.hu>; Wed, 18 Jun 2008 20:43:40 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 5F5933E21DD; Wed, 18 Jun 2008 20:43:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080618112931.GY29404@genesis.frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85396>


* Miklos Vajna <vmiklos@frugalware.org> wrote:

> On Wed, Jun 18, 2008 at 12:57:31PM +0200, Ingo Molnar <mingo@elte.hu> wrote:
> > just to demonstrate it, i tried today to do an octopus merge of 87 topic 
> > branches:
> > 
> > git-merge build checkme core/checkme core/debugobjects core/futex-64bit 
> > core/iter-div core/kill-the-BKL core/locking core/misc core/percpu 
> > core/printk core/rcu core/rodata core/softirq core/softlockup 
> > core/stacktrace core/topology core/urgent cpus4096 genirq kmemcheck 
> > kmemcheck2 mm/xen out-of-tree pci-for-jesse safe-poison-pointers sched 
> > sched-devel scratch stackprotector timers/clockevents timers/hpet 
> > timers/hrtimers timers/nohz timers/posixtimers tip tracing/ftrace 
> > tracing/ftrace-mergefixups tracing/immediates tracing/markers 
> > tracing/mmiotrace tracing/mmiotrace-mergefixups tracing/nmisafe 
> > tracing/sched_markers tracing/stopmachine-allcpus tracing/sysprof 
> > tracing/textedit x86/apic x86/apm x86/bitops x86/build x86/checkme 
> > x86/cleanups x86/cpa x86/cpu x86/defconfig x86/delay x86/gart x86/i8259 
> > x86/idle x86/intel x86/irq x86/irqstats x86/kconfig x86/ldt x86/mce 
> > x86/memtest x86/mmio x86/mpparse x86/nmi x86/numa x86/numa-fixes x86/pat 
> > x86/pebs x86/ptemask x86/resumetrace x86/scratch x86/setup x86/smpboot 
> > x86/threadinfo x86/timers x86/urgent x86/urgent-undo-ioapic x86/uv 
> > x86/vdso x86/xen x86/xsave
> > 
> > it failed miserably:
> > 
> >  warning: ignoring 066519068ad2fbe98c7f45552b1f592903a9c8c8; cannot 
> >  handle more than 25 refs
> 
> The upcoming builtin-merge won't have this problem. I have added a 
> testcase for this in my working branch:
> 
> http://repo.or.cz/w/git/vmiklos.git?a=commit;h=7eef40b3cd772692c6eb7520686300533f35f10c

cool, thanks a ton!

stupid question: does this mean that if i install the latest Git devel 
snapshot (v1.5.6-rc3-21-g8c6b578 or later), i'll be able to experiment 
around with it right now?

	Ingo
