From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Problem in fetch (kernel)
Date: Tue, 24 Aug 2010 00:32:57 -0700 (PDT)
Message-ID: <716248.10984.qm@web31801.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 09:33:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ono0J-0000PW-Tv
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 09:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab0HXHc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 03:32:59 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:47083 "HELO
	web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751862Ab0HXHc6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 03:32:58 -0400
Received: (qmail 11062 invoked by uid 60001); 24 Aug 2010 07:32:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1282635177; bh=+pzb9QwUHhZ0we3d/ktZ1mOJdjo7iX0RZ5GYMd/bcVg=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=3oBvavr+KfBSDcv3nxc9CL5ebjWroi8Ed34MAoQ0Y9d+Vu1CCdX8hOT4+qt9NxnhQthsuQ6ClNBykoYmqP7ApjQ6O+Lvgo+2sW83GKaK/xrFvwNpE1QJIO74jKQEM57TqPh0Q9f5UvTbeVjOrQHmsW+fXBZDBeEP6QJxBx7DOAk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xgLgEGtMUXVhOBH60I3rIBYDXG+LZP1sXEh2J9pZZCS8l2wuclr5lDnT6r/saEShEdc9rUEWfD/rndMaDMflmQq6uBxd3PwN60s6n6YRL//rG4/l5kw/jnNR5cC8DUcJ0XC3DPjTDLpcUj4VgnfaCGi/HRdtUx+eC9bIm8YMGEY=;
X-YMail-OSG: PXhpr.cVM1mb.NUqwYrjZ28kBU1UiIVsrP_7bBBKgtu_Z7J
 gfCJZgAV8Xpgk4McB_407lanhEQXdGNQFotN3c2jGVB6VVTXa52GyuDXJOXr
 nz7_j4kGPUM22yPtL6MM2XD1u8Mp7Et4IAsItAjq16OhF1xL7j.IZPoAHwyk
 GOxWozWktaphW_GMiLeaov6eLNSeGcXWMpWSL4k486LwGjay0KVX3PZyierJ
 VCf_vBWMsC6jQufmq_nt4cs_arnCg8deqEaRPVreORCGuU6ev.falq4gZUb_
 dFywPsoF7nRMtw7k1MKwob7_2ECPwOP9h6h.p6OCvqD.AsSMUnqdZYYwXlVl
 ZFh0XFaKPG1dnfvq00z6HjDTpoms-
Received: from [71.132.202.60] by web31801.mail.mud.yahoo.com via HTTP; Tue, 24 Aug 2010 00:32:57 PDT
X-Mailer: YahooMailClassic/11.3.2 YahooMailWebService/0.8.105.279950
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154305>

Okay, I updated git to latest (1.7.2.2.165.gbc382) and after a "git res=
et" this is what I get:

$git pull -v --verbose linus
walk d1b113bb028999e82a8528e1484be8c23fb5a7d9
walk 9c5ea3675dbe4853eea747542da257c3e6f18de2
walk cca77b7c81876d819a5806f408b3c29b5b61a815
Getting alternates list for http://kernel.org/pub/scm/linux/kernel/git/=
torvalds/linux-2.6.git
Getting pack list for http://kernel.org/pub/scm/linux/kernel/git/torval=
ds/linux-2.6.git
error: Unable to find 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a under ht=
tp://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Cannot obtain needed blob 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a
while processing commit cca77b7c81876d819a5806f408b3c29b5b61a815.
error: Fetch failed.

How do I resolve this?

Thanks,
   Luben

--- On Tue, 8/24/10, Luben Tuikov <ltuikov@yahoo.com> wrote:

> From: Luben Tuikov <ltuikov@yahoo.com>
> Subject: Problem in fetch (kernel)
> To: git@vger.kernel.org
> Date: Tuesday, August 24, 2010, 12:18 AM
> Hi guys,
>=20
> While trying to pull the kernel I get this:
>=20
> git pull -v --progress linus
> error: Unable to find
> 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a under http://kernel.org/pub/=
scm/linux/kernel/git/torvalds/linux-2.6.git
> Cannot obtain needed blob
> 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a
> while processing commit
> cca77b7c81876d819a5806f408b3c29b5b61a815.
> error: Fetch failed.
>=20
> This is with git 1.7.1.
>=20
> How can I resolve this?
>=20
> Thanks,
> =A0=A0=A0Luben
>=20
>=20
