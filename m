From: Detlef Vollmann <dv@vollmann.ch>
Subject: Re: cannot fetch arm git tree
Date: Fri, 21 Jan 2011 14:38:11 +0100
Message-ID: <4D398C43.1000306@vollmann.ch>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>	<20110116092315.GA27542@n2100.arm.linux.org.uk>	<20110116110819.GG6917@pengutronix.de>	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel@lists.infradead.org, Jello huang <ruifeihuang@gmail.com>,
	git@vger.kernel.org, =?ISO-8859-1?Q?Uwe_Kleine-K=F6ni?= =?ISO-8859-1?Q?g?=
	<u.kleine-koenig@pengutronix.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-From: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org Fri Jan 21 14:39:51 2011
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Envelope-to: linux-arm-kernel@m.gmane.org
Received: from canuck.infradead.org ([134.117.69.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>)
	id 1PgHDQ-0004um-Fx
	for linux-arm-kernel@m.gmane.org; Fri, 21 Jan 2011 14:39:49 +0100
Received: from localhost ([127.0.0.1] helo=canuck.infradead.org)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PgHCA-00025c-Ir; Fri, 21 Jan 2011 13:38:30 +0000
Received: from mailrelay3.sunrise.ch ([194.158.229.31]
	helo=smtp-be-01.be08.sunrise.ch)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PgHC7-00025A-Ie for linux-arm-kernel@lists.infradead.org;
	Fri, 21 Jan 2011 13:38:28 +0000
Received: from [192.168.26.14] (212-98-43-140.static.adslpremium.ch
	[212.98.43.140])
	by smtp-be-01.be08.sunrise.ch (8.13.1/8.12.10) with ESMTP id
	p0LDcCXH001838; Fri, 21 Jan 2011 14:38:12 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110116134248.GD27542@n2100.arm.linux.org.uk>
X-CRM114-Version: 20090807-BlameThorstenAndJenny ( TRE 0.7.6 (BSD) )
	MR-646709E3 
X-CRM114-CacheID: sfid-20110121_083827_909652_C1D913F9 
X-CRM114-Status: UNSURE (   9.91  )
X-CRM114-Notice: Please train this message.
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165368>

On 01/16/11 14:42, Russell King - ARM Linux wrote:
> Let's say you already have a copy of my tree from a month ago, and Linus
> has pulled some work from me into his tree, and repacked his tree into one
> single pack file.  At the moment, the largest pack file from Linus is
> 400MB plus a 50MB index.
>
> You already have most of the contents of that 400MB pack file, but if
> you're missing even _one_ object which is contained within it, git will
> have to download the _entire_ 400MB pack file and index file to retrieve
> it.
I thought this has changed with "smart http" in git 1.6.6.
Am I missing something?

   Detlef
