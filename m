From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-rerere observations and feature suggestions
Date: Wed, 18 Jun 2008 13:29:31 +0200
Message-ID: <20080618112931.GY29404@genesis.frugalware.org>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ezq4Vu1d99+73doN"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jun 18 13:30:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8vry-0001Hx-5N
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 13:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYFRL3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 07:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYFRL3e
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 07:29:34 -0400
Received: from virgo.iok.hu ([193.202.89.103]:59892 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbYFRL3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 07:29:33 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A36A91B24FF;
	Wed, 18 Jun 2008 13:29:31 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 851AE4469A;
	Wed, 18 Jun 2008 13:08:03 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1629F1778015; Wed, 18 Jun 2008 13:29:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080618105731.GA9242@elte.hu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85375>


--ezq4Vu1d99+73doN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2008 at 12:57:31PM +0200, Ingo Molnar <mingo@elte.hu> wrote:
> just to demonstrate it, i tried today to do an octopus merge of 87 topic=
=20
> branches:
>=20
> git-merge build checkme core/checkme core/debugobjects core/futex-64bit=
=20
> core/iter-div core/kill-the-BKL core/locking core/misc core/percpu=20
> core/printk core/rcu core/rodata core/softirq core/softlockup=20
> core/stacktrace core/topology core/urgent cpus4096 genirq kmemcheck=20
> kmemcheck2 mm/xen out-of-tree pci-for-jesse safe-poison-pointers sched=20
> sched-devel scratch stackprotector timers/clockevents timers/hpet=20
> timers/hrtimers timers/nohz timers/posixtimers tip tracing/ftrace=20
> tracing/ftrace-mergefixups tracing/immediates tracing/markers=20
> tracing/mmiotrace tracing/mmiotrace-mergefixups tracing/nmisafe=20
> tracing/sched_markers tracing/stopmachine-allcpus tracing/sysprof=20
> tracing/textedit x86/apic x86/apm x86/bitops x86/build x86/checkme=20
> x86/cleanups x86/cpa x86/cpu x86/defconfig x86/delay x86/gart x86/i8259=
=20
> x86/idle x86/intel x86/irq x86/irqstats x86/kconfig x86/ldt x86/mce=20
> x86/memtest x86/mmio x86/mpparse x86/nmi x86/numa x86/numa-fixes x86/pat=
=20
> x86/pebs x86/ptemask x86/resumetrace x86/scratch x86/setup x86/smpboot=20
> x86/threadinfo x86/timers x86/urgent x86/urgent-undo-ioapic x86/uv=20
> x86/vdso x86/xen x86/xsave
>=20
> it failed miserably:
>=20
>  warning: ignoring 066519068ad2fbe98c7f45552b1f592903a9c8c8; cannot=20
>  handle more than 25 refs

The upcoming builtin-merge won't have this problem. I have added a
testcase for this in my working branch:

http://repo.or.cz/w/git/vmiklos.git?a=3Dcommit;h=3D7eef40b3cd772692c6eb7520=
686300533f35f10c

--ezq4Vu1d99+73doN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhY8ZoACgkQe81tAgORUJYdFACbBK0eJPSntQJVjD0OeND6m8xR
VmkAoIetyAk6b/p7huovoH0w0LVKeBfn
=6+jL
-----END PGP SIGNATURE-----

--ezq4Vu1d99+73doN--
