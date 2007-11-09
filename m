From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 3/9] msm: timer support using the GPT and DGT timers
Date: Fri, 9 Nov 2007 05:39:30 -0800
Organization: Google, Inc.
Message-ID: <20071109133930.GA24962@bulgaria>
References: <11945526304057-git-send-email-swetland@google.com> <11945526302582-git-send-email-swetland@google.com> <11945526301578-git-send-email-swetland@google.com> <1194552630586-git-send-email-swetland@google.com> <20071109102323.GB376@flint.arm.linux.org.uk> <20071109105732.GB9657@bre-cln-ukleine.digi.com> <20071109110331.GA23896@bulgaria> <20071109131930.GA19343@bre-cln-ukleine.digi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Transfer-Encoding: 8bit
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>,
	linux-arm-kernel@lists.arm.linux.org.uk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 14:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqU92-0007mT-FP
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759823AbXKINnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 08:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759854AbXKINnX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:43:23 -0500
Received: from smtp-out.google.com ([216.239.45.13]:57822 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759664AbXKINnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 08:43:22 -0500
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id lA9DdfEE026627;
	Fri, 9 Nov 2007 05:39:41 -0800
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:subject:message-id:references:
	mime-version:content-type:content-disposition:
	content-transfer-encoding:in-reply-to:organization:user-agent;
	b=OC4M/mYy8+mPqIfL6KtFkaBEzUqpQeBz9Cba5joPqpFt49kDVeHo8YTTfjf+vN1TR
	5wwllgtyuNzwrYKjnCoeA==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps77.corp.google.com with ESMTP id lA9DdftQ028741;
	Fri, 9 Nov 2007 05:39:41 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id 012AC8F45E; Fri,  9 Nov 2007 05:39:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071109131930.GA19343@bre-cln-ukleine.digi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64179>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

[Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>]
> 
> Hello Brian,
> 
> [adding git ML to Cc:]
> 
> > > 	Content-Type: text/plain; charset=utf-8
> > > 	Content-Transfer-Encoding: 8bit
> > 
> > Mine do not seem to.
> I think they are only generated if the content contains non-ASCII.  So
> the attached example isn't very helpful.

Looking at more of the patches (sorry about sending one not exhibiting
the problem -- I picked a small one, forgetting that not all of them
had Arve's name as the author), it looks like the body is plain 7bit
ascii, but the From header has the utf-8 content:

>From 0ac8027053bb686c19a412f0f22f4a305a77ab59 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Date: Wed, 7 Nov 2007 22:17:29 -0800
Subject: [PATCH 3/9] msm: timer support using the GPT and DGT timers

When sent with git-send-email, the From: line above ended up in the
message, unescaped as utf-8 text, but the generated email itself did
not have any encoding specified.  I didn't 

Attached is the original patch and the message that resulted when I
used git-send-email to mail the patch to myself.

Brian

--45Z9DzgjV8m4Oswq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0003-msm-timer-support-using-the-GPT-and-DGT-timers.patch"

>From 0ac8027053bb686c19a412f0f22f4a305a77ab59 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Date: Wed, 7 Nov 2007 22:17:29 -0800
Subject: [PATCH 3/9] msm: timer support using the GPT and DGT timers

Signed-off-by: Brian Swetland <swetland@android.com>
---
 arch/arm/mach-msm/timer.c |  205 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/timer.c

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
new file mode 100644
index 0000000..0781a16
--- /dev/null
+++ b/arch/arm/mach-msm/timer.c
@@ -0,0 +1,205 @@
+/* linux/arch/arm/mach-msm/timer.c
+**
+** Copyright (C) 2007 Google, Inc.
+**
+** This software is licensed under the terms of the GNU General Public
+** License version 2, as published by the Free Software Foundation, and
+** may be copied, distributed, and modified under those terms.
+**
+** This program is distributed in the hope that it will be useful,
+** but WITHOUT ANY WARRANTY; without even the implied warranty of
+** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+** GNU General Public License for more details.
+**
+*/
+
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+
+#include <asm/mach/time.h>
+#include <asm/arch/msm_iomap.h>
+
+#include <asm/io.h>
+
+#define MSM_DGT_BASE (MSM_GPT_BASE + 0x10)
+#define MSM_DGT_SHIFT (5)
+
+#define TIMER_MATCH_VAL         0x0000
+#define TIMER_COUNT_VAL         0x0004
+#define TIMER_ENABLE            0x0008
+#define TIMER_ENABLE_CLR_ON_MATCH_EN    2
+#define TIMER_ENABLE_EN                 1
+#define TIMER_CLEAR             0x000C
+
+#define CSR_PROTECTION          0x0020
+#define CSR_PROTECTION_EN               1
+
+#define GPT_HZ 32768
+#define DGT_HZ 19200000 // 19.2 MHz or 600 KHz after shift
+
+struct msm_clock {
+	struct clock_event_device   clockevent;
+	struct clocksource          clocksource;
+	struct irqaction            irq;
+	uint32_t                    regbase;
+	uint32_t                    freq;
+	uint32_t                    shift;
+};
+
+static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static cycle_t msm_gpt_read(void)
+{
+	return msm_readl(MSM_GPT_BASE + TIMER_COUNT_VAL);
+}
+
+static cycle_t msm_dgt_read(void)
+{
+	return msm_readl(MSM_DGT_BASE + TIMER_COUNT_VAL) >> MSM_DGT_SHIFT;
+}
+
+static int msm_timer_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	struct msm_clock *clock = container_of(evt, struct msm_clock, clockevent);
+	uint32_t now = msm_readl(clock->regbase + TIMER_COUNT_VAL);
+	uint32_t alarm = now + (cycles << clock->shift);
+	int late;
+
+	msm_writel(alarm, clock->regbase + TIMER_MATCH_VAL);
+	now = msm_readl(clock->regbase + TIMER_COUNT_VAL);
+	late = now - alarm;
+	if(late >= (-2 << clock->shift) && late < DGT_HZ*5) {
+		printk(KERN_NOTICE "msm_timer_set_next_event(%lu) clock %s, "
+		       "alarm already expired, now %x, alarm %x, late %d\n",
+		       cycles, clock->clockevent.name, now, alarm, late);
+		return -ETIME;
+	}
+	return 0;
+}
+
+static void msm_timer_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	struct msm_clock *clock = container_of(evt, struct msm_clock, clockevent);
+	switch (mode) {
+	case CLOCK_EVT_MODE_RESUME:
+	case CLOCK_EVT_MODE_PERIODIC:
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		msm_writel(TIMER_ENABLE_EN, clock->regbase + TIMER_ENABLE);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		msm_writel(0, clock->regbase + TIMER_ENABLE);
+		break;
+	}
+}
+
+static struct msm_clock msm_clocks[] = {
+	{
+		.clockevent = {
+			.name           = "gp_timer",
+			.features       = CLOCK_EVT_FEAT_ONESHOT,
+			.shift          = 32,
+			.rating         = 200,
+			.set_next_event = msm_timer_set_next_event,
+			.set_mode       = msm_timer_set_mode,
+		},
+		.clocksource = {
+			.name           = "gp_timer",
+			.rating         = 200,
+			.read           = msm_gpt_read,
+			.mask           = CLOCKSOURCE_MASK(32),
+			.shift          = 24,
+			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+		},
+		.irq = {
+			.name    = "gp_timer",
+			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
+			.handler = msm_timer_interrupt,
+			.dev_id  = &msm_clocks[0].clockevent,
+			.irq     = INT_GP_TIMER_EXP
+		},
+		.regbase = MSM_GPT_BASE,
+		.freq = GPT_HZ
+	},
+	{
+		.clockevent = {
+			.name           = "dg_timer",
+			.features       = CLOCK_EVT_FEAT_ONESHOT,
+			.shift          = 32 + MSM_DGT_SHIFT,
+			.rating         = 300,
+			.set_next_event = msm_timer_set_next_event,
+			.set_mode       = msm_timer_set_mode,
+		},
+		.clocksource = {
+			.name           = "dg_timer",
+			.rating         = 300,
+			.read           = msm_dgt_read,
+			.mask           = CLOCKSOURCE_MASK((32 - MSM_DGT_SHIFT)),
+			.shift          = 24 - MSM_DGT_SHIFT,
+			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+		},
+		.irq = {
+			.name    = "dg_timer",
+			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
+			.handler = msm_timer_interrupt,
+			.dev_id  = &msm_clocks[1].clockevent,
+			.irq     = INT_DEBUG_TIMER_EXP
+		},
+		.regbase = MSM_DGT_BASE,
+		.freq = DGT_HZ >> MSM_DGT_SHIFT,
+		.shift = MSM_DGT_SHIFT
+	}
+};
+
+static void /*__init*/ msm_timer_init(void)
+{
+	int i;
+	int res;
+	printk("msm_timer_init()\n");
+
+	for(i = 0; i < ARRAY_SIZE(msm_clocks); i++) {
+		struct msm_clock *clock = &msm_clocks[i];
+		struct clock_event_device *ce = &clock->clockevent;
+		struct clocksource *cs = &clock->clocksource;
+		msm_writel(0, clock->regbase + TIMER_ENABLE);
+		msm_writel(0, clock->regbase + TIMER_CLEAR);
+		msm_writel(~0, clock->regbase + TIMER_MATCH_VAL);
+
+		ce->mult = div_sc(clock->freq, NSEC_PER_SEC, ce->shift);
+		// allow at least 10 seconds to notice that the timer wrapped
+		ce->max_delta_ns =
+			clockevent_delta2ns(0xf0000000 >> clock->shift, ce);
+		ce->min_delta_ns = clockevent_delta2ns(4, ce); // 4 gets rounded down to 3
+		ce->cpumask = cpumask_of_cpu(0);
+
+		cs->mult = clocksource_hz2mult(clock->freq,cs->shift);
+		res = clocksource_register(cs);
+		if(res)
+			printk(KERN_ERR "msm_timer_init: clocksource_register "
+			       "failed for %s\n", cs->name);
+
+		res = setup_irq(clock->irq.irq, &clock->irq);
+		if(res)
+			printk(KERN_ERR "msm_timer_init: setup_irq "
+			       "failed for %s\n", cs->name);
+
+		clockevents_register_device(ce);
+	}
+}
+
+struct sys_timer msm_timer = {
+	.init = msm_timer_init
+};
-- 
1.5.3.1


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=0mail
Content-Transfer-Encoding: 8bit

>From swetland@google.com Fri Nov  9 05:35:00 2007
Return-Path: <swetland@google.com>
Received: from wpck26.suw.corp.google.com [172.24.219.218]
	by bulgaria with IMAP (fetchmail-6.3.6)
	for <swetland@localhost> (single-drop); Fri, 09 Nov 2007 05:35:00 -0800 (PST)
Received: from wpck26.suw.corp.google.com ([unix socket])
	 by imap4.corp.google.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-1gg2) with LMTPA;
	 Fri, 09 Nov 2007 05:35:04 -0800
X-Sieve: CMU Sieve 2.2
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by wpck26.suw.corp.google.com with ESMTP id lA9DZ4Ou025468
	for <swetland@wpck26.suw.corp.google.com>; Fri, 9 Nov 2007 05:35:04 -0800
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps35.corp.google.com with ESMTP id lA9DYufb029971;
	Fri, 9 Nov 2007 05:34:56 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id 5618E8F45E; Fri,  9 Nov 2007 05:34:46 -0800 (PST)
From: swetland@google.com
To: swetland@google.com
Cc: =?utf-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Brian Swetland <swetland@android.com>
Subject: [PATCH 3/9] msm: timer support using the GPT and DGT timers
Date: Fri,  9 Nov 2007 05:34:46 -0800
Message-Id: <11946152862759-git-send-email-swetland@frotz.net>
X-Mailer: git-send-email 1.5.3.1
Status: RO
Content-Length: 6551

From: Arve Hjønnevåg <arve@android.com>

Signed-off-by: Brian Swetland <swetland@android.com>
---
 arch/arm/mach-msm/timer.c |  205 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/timer.c

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
new file mode 100644
index 0000000..0781a16
--- /dev/null
+++ b/arch/arm/mach-msm/timer.c
@@ -0,0 +1,205 @@
+/* linux/arch/arm/mach-msm/timer.c
+**
+** Copyright (C) 2007 Google, Inc.
+**
+** This software is licensed under the terms of the GNU General Public
+** License version 2, as published by the Free Software Foundation, and
+** may be copied, distributed, and modified under those terms.
+**
+** This program is distributed in the hope that it will be useful,
+** but WITHOUT ANY WARRANTY; without even the implied warranty of
+** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+** GNU General Public License for more details.
+**
+*/
+
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+
+#include <asm/mach/time.h>
+#include <asm/arch/msm_iomap.h>
+
+#include <asm/io.h>
+
+#define MSM_DGT_BASE (MSM_GPT_BASE + 0x10)
+#define MSM_DGT_SHIFT (5)
+
+#define TIMER_MATCH_VAL         0x0000
+#define TIMER_COUNT_VAL         0x0004
+#define TIMER_ENABLE            0x0008
+#define TIMER_ENABLE_CLR_ON_MATCH_EN    2
+#define TIMER_ENABLE_EN                 1
+#define TIMER_CLEAR             0x000C
+
+#define CSR_PROTECTION          0x0020
+#define CSR_PROTECTION_EN               1
+
+#define GPT_HZ 32768
+#define DGT_HZ 19200000 // 19.2 MHz or 600 KHz after shift
+
+struct msm_clock {
+	struct clock_event_device   clockevent;
+	struct clocksource          clocksource;
+	struct irqaction            irq;
+	uint32_t                    regbase;
+	uint32_t                    freq;
+	uint32_t                    shift;
+};
+
+static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static cycle_t msm_gpt_read(void)
+{
+	return msm_readl(MSM_GPT_BASE + TIMER_COUNT_VAL);
+}
+
+static cycle_t msm_dgt_read(void)
+{
+	return msm_readl(MSM_DGT_BASE + TIMER_COUNT_VAL) >> MSM_DGT_SHIFT;
+}
+
+static int msm_timer_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	struct msm_clock *clock = container_of(evt, struct msm_clock, clockevent);
+	uint32_t now = msm_readl(clock->regbase + TIMER_COUNT_VAL);
+	uint32_t alarm = now + (cycles << clock->shift);
+	int late;
+
+	msm_writel(alarm, clock->regbase + TIMER_MATCH_VAL);
+	now = msm_readl(clock->regbase + TIMER_COUNT_VAL);
+	late = now - alarm;
+	if(late >= (-2 << clock->shift) && late < DGT_HZ*5) {
+		printk(KERN_NOTICE "msm_timer_set_next_event(%lu) clock %s, "
+		       "alarm already expired, now %x, alarm %x, late %d\n",
+		       cycles, clock->clockevent.name, now, alarm, late);
+		return -ETIME;
+	}
+	return 0;
+}
+
+static void msm_timer_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	struct msm_clock *clock = container_of(evt, struct msm_clock, clockevent);
+	switch (mode) {
+	case CLOCK_EVT_MODE_RESUME:
+	case CLOCK_EVT_MODE_PERIODIC:
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		msm_writel(TIMER_ENABLE_EN, clock->regbase + TIMER_ENABLE);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		msm_writel(0, clock->regbase + TIMER_ENABLE);
+		break;
+	}
+}
+
+static struct msm_clock msm_clocks[] = {
+	{
+		.clockevent = {
+			.name           = "gp_timer",
+			.features       = CLOCK_EVT_FEAT_ONESHOT,
+			.shift          = 32,
+			.rating         = 200,
+			.set_next_event = msm_timer_set_next_event,
+			.set_mode       = msm_timer_set_mode,
+		},
+		.clocksource = {
+			.name           = "gp_timer",
+			.rating         = 200,
+			.read           = msm_gpt_read,
+			.mask           = CLOCKSOURCE_MASK(32),
+			.shift          = 24,
+			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+		},
+		.irq = {
+			.name    = "gp_timer",
+			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
+			.handler = msm_timer_interrupt,
+			.dev_id  = &msm_clocks[0].clockevent,
+			.irq     = INT_GP_TIMER_EXP
+		},
+		.regbase = MSM_GPT_BASE,
+		.freq = GPT_HZ
+	},
+	{
+		.clockevent = {
+			.name           = "dg_timer",
+			.features       = CLOCK_EVT_FEAT_ONESHOT,
+			.shift          = 32 + MSM_DGT_SHIFT,
+			.rating         = 300,
+			.set_next_event = msm_timer_set_next_event,
+			.set_mode       = msm_timer_set_mode,
+		},
+		.clocksource = {
+			.name           = "dg_timer",
+			.rating         = 300,
+			.read           = msm_dgt_read,
+			.mask           = CLOCKSOURCE_MASK((32 - MSM_DGT_SHIFT)),
+			.shift          = 24 - MSM_DGT_SHIFT,
+			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
+		},
+		.irq = {
+			.name    = "dg_timer",
+			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
+			.handler = msm_timer_interrupt,
+			.dev_id  = &msm_clocks[1].clockevent,
+			.irq     = INT_DEBUG_TIMER_EXP
+		},
+		.regbase = MSM_DGT_BASE,
+		.freq = DGT_HZ >> MSM_DGT_SHIFT,
+		.shift = MSM_DGT_SHIFT
+	}
+};
+
+static void /*__init*/ msm_timer_init(void)
+{
+	int i;
+	int res;
+	printk("msm_timer_init()\n");
+
+	for(i = 0; i < ARRAY_SIZE(msm_clocks); i++) {
+		struct msm_clock *clock = &msm_clocks[i];
+		struct clock_event_device *ce = &clock->clockevent;
+		struct clocksource *cs = &clock->clocksource;
+		msm_writel(0, clock->regbase + TIMER_ENABLE);
+		msm_writel(0, clock->regbase + TIMER_CLEAR);
+		msm_writel(~0, clock->regbase + TIMER_MATCH_VAL);
+
+		ce->mult = div_sc(clock->freq, NSEC_PER_SEC, ce->shift);
+		// allow at least 10 seconds to notice that the timer wrapped
+		ce->max_delta_ns =
+			clockevent_delta2ns(0xf0000000 >> clock->shift, ce);
+		ce->min_delta_ns = clockevent_delta2ns(4, ce); // 4 gets rounded down to 3
+		ce->cpumask = cpumask_of_cpu(0);
+
+		cs->mult = clocksource_hz2mult(clock->freq,cs->shift);
+		res = clocksource_register(cs);
+		if(res)
+			printk(KERN_ERR "msm_timer_init: clocksource_register "
+			       "failed for %s\n", cs->name);
+
+		res = setup_irq(clock->irq.irq, &clock->irq);
+		if(res)
+			printk(KERN_ERR "msm_timer_init: setup_irq "
+			       "failed for %s\n", cs->name);
+
+		clockevents_register_device(ce);
+	}
+}
+
+struct sys_timer msm_timer = {
+	.init = msm_timer_init
+};
-- 
1.5.3.1



--45Z9DzgjV8m4Oswq--
