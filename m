From: Miles Bader <miles@gnu.org>
Subject: Re: cannot fetch arm git tree
Date: Mon, 24 Jan 2011 14:01:43 +0900
Message-ID: <buok4huzyh4.fsf@dhlpc061.dev.necel.com>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
	<4D398C43.1000306@vollmann.ch> <20110121134728.GO14956@pengutronix.de>
	<20110121135725.GR13235@n2100.arm.linux.org.uk>
	<4D3997FE.5030109@vollmann.ch>
	<20110121145025.GS13235@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jello huang <ruifeihuang@gmail.com>, Detlef Vollmann <dv@vollmann.ch>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-From: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org Mon Jan 24 06:02:53 2011
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Envelope-to: linux-arm-kernel@m.gmane.org
Received: from bombadil.infradead.org ([18.85.46.34])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>)
	id 1PhEZl-0004QF-PP
	for linux-arm-kernel@m.gmane.org; Mon, 24 Jan 2011 06:02:49 +0100
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PhEZE-0001e1-MX; Mon, 24 Jan 2011 05:02:16 +0000
Received: from localhost ([127.0.0.1] helo=canuck.infradead.org)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PhEZC-0003mR-TG; Mon, 24 Jan 2011 05:02:14 +0000
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PhEZ7-0003m7-Ny for linux-arm-kernel@lists.infradead.org;
	Mon, 24 Jan 2011 05:02:11 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p0O51jEv010607; 
	Mon, 24 Jan 2011 14:01:45 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id p0O51jk21164; Mon, 24 Jan 2011 14:01:45 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.46])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id p0O50CZ1021895;
	Mon, 24 Jan 2011 14:01:44 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.40] [10.29.19.40]) by
	relay11.aps.necel.com with ESMTP; Mon, 24 Jan 2011 14:01:44 +0900
Received: from dhlpc061 ([10.114.98.136] [10.114.98.136]) by
	relay11.aps.necel.com with ESMTP; Mon, 24 Jan 2011 14:01:44 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 2650C52E233; Mon, 24 Jan 2011 14:01:44 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20110121145025.GS13235@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 21 Jan 2011 14:50:26 +0000")
X-CRM114-Version: 20090807-BlameThorstenAndJenny ( TRE 0.7.6 (BSD) )
	MR-646709E3 
X-CRM114-CacheID: sfid-20110124_000210_238623_E99F493F 
X-CRM114-Status: GOOD (  11.95  )
X-Spam-Score: 0.0 (/)
X-Spam-Report: SpamAssassin version 3.3.1 on canuck.infradead.org summary:
	Content analysis details:   (0.0 points)
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165435>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> I'm really not interested in working out how to bodge this into working
> along side the existing gitweb setup by adding lots of rewrite rules, so
> as gitweb got there first I think it has priority, that's what we have
> and we'll have to live without the smart http extensions.
...
> It's really not that big a deal if you follow the advice I've given.

Smart http is actually a very big deal -- the old git http protocol is
almost unusable in practice with big repos, at least over somewhat
latency-limited network connections.

If you don't intend to support people pulling over http, then maybe you
don't care.  But if you do care, it's very much worth a second look.

[My personal reason for caring is that I'm behind a corporate firewall
that's latency limited, although it seems to have pretty good bandwidth.
With some public repos, pulling via the old http protocol was a
multi-hour operation; the new http protocol is typically multiple orders
of magnitude faster in these cases.]

-Miles

-- 
Omochiroi!
