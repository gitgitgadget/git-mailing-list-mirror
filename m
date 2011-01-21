From: Detlef Vollmann <dv@vollmann.ch>
Subject: Re: cannot fetch arm git tree
Date: Fri, 21 Jan 2011 15:28:14 +0100
Message-ID: <4D3997FE.5030109@vollmann.ch>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
	<4D398C43.1000306@vollmann.ch>
	<20110121134728.GO14956@pengutronix.de>
	<20110121135725.GR13235@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Cc: linux-arm-kernel@lists.infradead.org, Jello huang <ruifeihuang@gmail.com>,
	git@vger.kernel.org,
	=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-From: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org Fri Jan 21 15:29:03 2011
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Envelope-to: linux-arm-kernel@m.gmane.org
Received: from canuck.infradead.org ([134.117.69.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>)
	id 1PgHz4-0007TX-Vv
	for linux-arm-kernel@m.gmane.org; Fri, 21 Jan 2011 15:29:03 +0100
Received: from localhost ([127.0.0.1] helo=canuck.infradead.org)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PgHyb-00082l-AJ; Fri, 21 Jan 2011 14:28:33 +0000
Received: from mailrelay04.sunrise.ch ([194.158.229.47]
	helo=smtp-be-02.be08.sunrise.ch)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PgHyV-00081Y-ED for linux-arm-kernel@lists.infradead.org;
	Fri, 21 Jan 2011 14:28:30 +0000
Received: from [192.168.26.14] (212-98-43-140.static.adslpremium.ch
	[212.98.43.140])
	by smtp-be-02.be08.sunrise.ch (8.13.1/8.12.10) with ESMTP id
	p0LESFEM026391; Fri, 21 Jan 2011 15:28:16 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110121135725.GR13235@n2100.arm.linux.org.uk>
X-CRM114-Version: 20090807-BlameThorstenAndJenny ( TRE 0.7.6 (BSD) )
	MR-646709E3 
X-CRM114-CacheID: sfid-20110121_092827_738285_199AAADA 
X-CRM114-Status: GOOD (  13.69  )
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165371>

On 01/21/11 14:57, Russell King - ARM Linux wrote:
> On Fri, Jan 21, 2011 at 02:47:28PM +0100, Uwe Kleine-K=F6nig wrote:
>> Hi Detlef,
>>
>> On Fri, Jan 21, 2011 at 02:38:11PM +0100, Detlef Vollmann wrote:
>>> On 01/16/11 14:42, Russell King - ARM Linux wrote:
>>>> Let's say you already have a copy of my tree from a month ago, and Lin=
us
>>>> has pulled some work from me into his tree, and repacked his tree into=
 one
>>>> single pack file.  At the moment, the largest pack file from Linus is
>>>> 400MB plus a 50MB index.
>>>>
>>>> You already have most of the contents of that 400MB pack file, but if
>>>> you're missing even _one_ object which is contained within it, git will
>>>> have to download the _entire_ 400MB pack file and index file to retrie=
ve
>>>> it.
>>> I thought this has changed with "smart http" in git 1.6.6.
>>> Am I missing something?
>> Well, not all http repos offer smart http.  E.g. Russell doesn't[1],
>> probably because the serving machine doesn't have the power to nice
>> serve a repo via git:// or smart http://.
>
> What is smart http?  I don't particularly follow git developments.
It seems to be an implementation of the git protocol using
HTTP as transport.
Some info on this is at <http://progit.org/2010/03/04/smart-http.html>.

   Detlef
