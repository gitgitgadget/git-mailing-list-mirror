From: Martin Wendt <martin@wwWendt.de>
Subject: Re: Cannot reset a repo
Date: Sat, 6 Dec 2014 17:01:22 +0100
Message-ID: <C1046576-F27C-4C93-9C67-239FDAE46D23@wwWendt.de>
References: <5482DA16.4080509@wwWendt.de> <5482F32C.40709@web.de>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Wendt <martin17@wwWendt.de>, git@vger.kernel.org
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Dec 06 17:07:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxHti-0007Wl-KF
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 17:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbaLFQHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 11:07:43 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:28893 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbaLFQHn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 11:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1417882061; l=1190;
	s=domk; d=wwWendt.de;
	h=To:References:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:
	Subject:Mime-Version:Content-Type;
	bh=kPMuM7zNl1npFYApHyQCBNJdZNA=;
	b=GnlIRyNzbKuoseI9b8steTSM+G64oyPsHoa+LaEX29niTkvsYX60tAOcY1hpr/BUXPJ
	RqFg54NTVgYjSIinNRIlwNEtB++2WxSDRWsxOgnV8tRrAU/9zdaVxeG1FgJ8dxB+uNuFM
	BpqQLoehFLFrWZANtvdQ/h5odn0ceIhkKJw=
X-RZG-AUTH: :IW0WYUmmW+i9+c0v1PLT3ldgggszV/8YINATMlahVR0UZvl26kAURZJjaWeQM1QFXA==
X-RZG-CLASS-ID: mo00
Received: from macmartin.fritz.box (e176140214.adsl.alicedsl.de [85.176.140.214])
	by smtp.strato.de (RZmta 36.2 DYNA|AUTH)
	with ESMTPSA id 601255qB6G1Ncly
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Sat, 6 Dec 2014 17:01:23 +0100 (CET)
In-Reply-To: <5482F32C.40709@web.de>
X-Mailer: Apple Mail (2.1993)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260956>


> Am 06.12.2014 um 13:14 schrieb Torsten B=C3=B6gershausen <tboegi@web.=
de>:
>=20
> On 2014-12-06 11.27, Martin Wendt wrote:
>> Hi,
>>=20
>> I am facing this problem:
>>=20
>>  - Using git version 1.9.3 (Apple Git-50)
>>  - cloned a fork from GitHub to my local machine:
>> https://github.com/mar10/cdnjs/
>>  - This repo seems to be broken in some way.
>>    At least it is not clean from the beginning and I am not able to =
reset
>>    `git reset --hard` only toggles the modified file from
>> ".../sortable" to ".../Sortable" and back
>>    (see attached screenshot)
>>=20
>> Is this a known problem (with case sensitivity)?=20
> I think so
>> Any suggestions how to  fix it?
>=20
> Try to rename Sortable into Sortable.u:
> git mv Sortable Sortable.upper
> (When that does not work)
> git mv sortable sortable.lower
>=20
> If this is not an option, use a USB Stick, format it with HFS+ "case =
sensitive"
> and clone the repo to the stick
>=20

Thanks for responding.
It is a fork of the 6GB cdnjs repository and I don't own the sortable l=
ib. So renaming is not an option.
Also, I am working on a MacBook, which already has a case sensitive fil=
e system.
