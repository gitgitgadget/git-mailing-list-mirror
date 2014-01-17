From: SH <saajey@yahoo.com>
Subject: Re: file permissions in Git repo
Date: Fri, 17 Jan 2014 12:11:19 -0800 (PST)
Message-ID: <1389989479.82735.YahooMailNeo@web124901.mail.ne1.yahoo.com>
References: <1389916737.92225.YahooMailNeo@web124906.mail.ne1.yahoo.com> <20140117022623.GC12444@sigill.intra.peff.net> <52D971A7.1040104@web.de> <1389986459.3994.YahooMailNeo@web124902.mail.ne1.yahoo.com> <52D98AC7.9030101@web.de>
Reply-To: SH <saajey@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 21:11:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4FlF-0005sc-JI
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 21:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbaAQULW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 15:11:22 -0500
Received: from nm16-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.47]:39743 "EHLO
	nm16-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752066AbaAQULU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 15:11:20 -0500
Received: from [98.138.100.114] by nm16.bullet.mail.ne1.yahoo.com with NNFMP; 17 Jan 2014 20:11:19 -0000
Received: from [98.138.101.165] by tm105.bullet.mail.ne1.yahoo.com with NNFMP; 17 Jan 2014 20:11:19 -0000
Received: from [127.0.0.1] by omp1076.mail.ne1.yahoo.com with NNFMP; 17 Jan 2014 20:11:19 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 493506.45147.bm@omp1076.mail.ne1.yahoo.com
Received: (qmail 98798 invoked by uid 60001); 17 Jan 2014 20:11:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1389989479; bh=nwqrWLlzrAOJjOmjAyFPg71UI4201IGHJ2L13H89uJI=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=rvwkB1xOhLy1nx9UVFlBQYZX3dHkS0b/Zti0Bk5b2QIDhUK4tT6+YdtRzKgiy/Cm0ka97z0OArePe2acXxsvlOg0FOZEJLgDKIOsLVYLCgaOusQ2/HZ3sMIucbtDWksD/U9vsyeMxhQt5lw8p5Ph0CxV/dbhwtavWYpMkbj1OEI=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OJbxjcam+uvq0LLcDBkv0VoxRovErb+b3vHqVdH6+WxUjmLwofqa43iRwlvgO3TWGqqrLkwao+75Kfy3o+Jziz0SAZDmAOTjvCYU70N0g10esiTII2g/TSSsUIamgcimtifTycgFJW2SuQrPLbM/QXlhGSGaX0WH998Rsvjp9qw=;
X-YMail-OSG: SYmMRwoVM1m10.YAa4kfvV7FB.veHkOkDhqe1Bv3cxjDcv_
 4jIUYNJ3bqH5Ngta0TeBOMOEXykj8yRm6VLnxJkuvsPBL6hKUOLXeqAsjWkE
 gVvHGDITw0.vS7x7ct63MnV_JnnYNVuLIUV23iwgAmTBnOQ3e4V_xAdxx3gN
 saApW3ZsD.IHmlbjaMjn96xH4fiCE1G.kf9AY6OC8ALbc0xGtPxb62uqExz8
 ICgVSEIgyPAN.grYD6ZpMcyiv9oM1syZpMw3mWHnJYBbKkXNGDi9br6zKY8N
 BTVHh3xlz.vHn5vqENSK1us6skc6Ju1LRh.C3ksG8Nn_uuUZHlCZVdp1Voh4
 1u5NDhhNKjvRYC7wWj.i.liI6YpXTNNKgVEFNLV_.FI_Cgv5miJZR0FbAAKX
 PDDHx7fGliL29JnGfBN0JpdyiZ2BW4_ajchhCSuDQPRXI20Y2d0I2ZseR2Kx
 D9cZ_PJQzm0RakPkHFrLzU5FxMqgkdVuV2B3hLbYJaDdLWL6ARGZaASaDHNJ
 CJmZko8huQQ2cQGsEc4XBU6fmzcWyJ7eOed9.eNtOwU36aFkEyzP9FlqRGgn
 EFTtO0qgL_iEp9ymV1Ua4k_9.qIeCsb7wCjbytprjaJDIf3yFIul_tvaFiK.
 t1jvp_ZujtA_ncr_Za3Bqg.Kx_f_RCTzwIN..i5ZCGr6UBEC21ektLW.I67e
 _2rtGC4y8IBNAHLiGisFuz302aCmAHC1nxX44QfLsAoq.5tY8pCfoSJUyOLy
 NHg--
Received: from [70.42.18.1] by web124901.mail.ne1.yahoo.com via HTTP; Fri, 17 Jan 2014 12:11:19 PST
X-Rocket-MIMEInfo: 002.001,VGhhbmtzIGFnYWluLgoKCgoKCk9uIEZyaWRheSwgSmFudWFyeSAxNywgMjAxNCAxMTo1NSBBTSwgVG9yc3RlbiBCw7ZnZXJzaGF1c2VuIDx0Ym9lZ2lAd2ViLmRlPiB3cm90ZToKKFBsZWFzZSBubyB0b3AgcG9zdGluZyBuZXh0IHRpbWUpCk9uIDIwMTQtMDEtMTcgMjAuMjAsIFNIIHdyb3RlOgo.IE9uIEZyaWRheSwgSmFudWFyeSAxNywgMjAxNCAxMDowOCBBTSwgVG9yc3RlbiBCw7ZnZXJzaGF1c2VuIDx0Ym9lZ2lAd2ViLmRlPiB3cm90ZToKPiBPbiAwMS8xNy8yMDE0IDAzOjI2IEFNLCBKZWZmIEtpbmcgd3IBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.173.622
In-Reply-To: <52D98AC7.9030101@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240624>

Thanks again.





On Friday, January 17, 2014 11:55 AM, Torsten B=F6gershausen <tboegi@we=
b.de> wrote:
(Please no top posting next time)
On 2014-01-17 20.20, SH wrote:
> On Friday, January 17, 2014 10:08 AM, Torsten B=F6gershausen <tboegi@=
web.de> wrote:
> On 01/17/2014 03:26 AM, Jeff King wrote:
>=20
>> On Thu, Jan 16, 2014 at 03:58:57PM -0800, SH wrote:
>>
>>> We have a repository which holds lots of shell and perl scripts. We=
 add the
>>> files to repository (from windows client) with executable permissio=
ns (using
>>> cygwin) but when we pull that repository on another machine (window=
s or linux),
>>> files dont have executable permission. Can you please provide a sol=
utions for
>>> this?
>>
>> Git does not preserve file permissions _except_ for the executable b=
it.
>> So this should be working.
>>
>> However, I suspect that `core.fileMode` is set to `false` in your
>> repository, which causes git to ignore the executable bit. When a
>> repository is initialized, we check whether the filesystem simply
>> creates everything with the executable bit. If so, we turn off
>> core.fileMode for the repository (since otherwise every file would h=
ave
>> it set).
>>
>> -Peff
> Cygwin has been a little bit special (and mingw still is).
> Until this commit:
> Author: Junio C Hamano <gitster@pobox.com>
> Date:=A0  Wed Jul 24 19:22:49 2013 -0700
>=20
>=A0 =A0  Merge branch 'ml/cygwin-updates'
>=20
>=A0 =A0  The tip one does _not_ revert c869753e (Force core.filemode t=
o
>=A0 =A0  false on Cygwin., 2006-12-30) on purpose, so that people can
>=A0 =A0  still retain the old behaviour if they wanted to.
>=20
>=A0 =A0  * ml/cygwin-updates:
>=A0 =A0 =A0  cygwin: stop forcing core.filemode=3Dfalse
>=A0 =A0 =A0  Cygwin 1.7 supports mmap
>=A0 =A0 =A0  Cygwin 1.7 has thread-safe pread
>=A0 =A0 =A0  Cygwin 1.7 needs compat/regex
> the repositories created by cygwin had always core.filemode=3Dfalse.
>=20
> You can easily check your configuration by running
> git config -l
> on the cygwin machine, as Peff suggested.
>=20
> The next step is to check how the files had been recored in git, usin=
g
> git ls-files -s | less
> on any machine.
>=20
> If I do this on git.git, we find lines like this, where
> 100755 means an executable file,
> 100644 means non-executable file.
>=20
> 100755 9c3f4131b8586408acd81d1e60912b51688575ed 0=20
> Documentation/technical/api-index.sh
> 100644 dd894043ae8b04269b3aa2108f96cb935217181d 0=20
> Documentation/technical/api-lockfile.txt
>=20
>=20
> The 3rd step is to check how file are shown in cygwin, run
> ls -l
> (Do they have the executable bit set ?)
>=20
> Side note:
> And I think the way the auto-probing of the file system works is
> like this:
> When a git repo is initialized, the .git/config file is created.
> After that, we try to toggle the executable bit, and if lstat reports
> it as toggled, we set core.filemode=3Dtrue.
> (See builtin/init-db.c, search for core.filemode)
>=20
> I tested to create a repo on a network share exported by SAMBA.
> The Server was configured so that all new created files had the
> executable bit set by default.
> Git detected that the executable bit could be switched off,
> and configured core.filemode=3Dtrue
> Nice.
>=20
> /Torsten
> Thanks guys.=A0 Sorry but one more question, like I mentioned we have=
 hosted repositories so how do I make some configuration changes are se=
rver based so whether the client have those changes or not, it wouldn't=
 matter. Also I have one client on linux and another one on windows (fo=
r my testing purpose) and I see that .git/config on both machines are l=
ittle different. Is that normal?
>=20
> Thanks Again.
That a config file has small differences could be normal:
the server has typically core.bare true.

About other differences, please don't heasitate to consult
http://git-htmldocs.googlecode.com/git/git-config.html

And if there are still questions, they are there to be answered here.

/Torsten
