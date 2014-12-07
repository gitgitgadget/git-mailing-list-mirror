From: Martin Wendt <martin@wwWendt.de>
Subject: Re: Cannot reset a repo
Date: Sun, 7 Dec 2014 16:34:00 +0100
Message-ID: <05564C98-ADF9-491F-A22B-A2523EDFB381@wwWendt.de>
References: <5482DA16.4080509@wwWendt.de> <5482F32C.40709@web.de> <B811B643-F86B-421E-8E2F-7D0F5235BE03@wwWendt.de> <54842694.9030908@web.de>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 16:34:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxdql-0003vi-3u
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 16:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbaLGPeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 10:34:07 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:22469 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaLGPeG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 10:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1417966442; l=1602;
	s=domk; d=wwWendt.de;
	h=To:References:Content-Transfer-Encoding:Date:In-Reply-To:From:
	Subject:Mime-Version:Content-Type;
	bh=oJZSmr11JuCmJNYKDAPV1L6vQjM=;
	b=iwXx17uO2QReVy5f6rYtRCjGjpcQRI8EloU0sPCCrb3PJLAIAHaZFqUtB7NqAL7BfUo
	Lh56m/IEmlK1XCCgnSDWbvaMz8vAb46tyTMNxSzeBS4wNxm/lQnCaom6i7CW1wRGJzik0
	AXjn9cOLqi9jlWRdeARW8+MtCpcKeulKoFk=
X-RZG-AUTH: :IW0WYUmmW+i9+c0v1PLT3ldgggszV/8YINATMlahVR0UZvl26kAURZJjaWWQM1Rs
X-RZG-CLASS-ID: mo00
Received: from macmartin.fritz.box (e176142021.adsl.alicedsl.de [85.176.142.21])
	by smtp.strato.de (RZmta 36.2 DYNA|AUTH)
	with ESMTPSA id h05fc5qB7FY2zEa
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Sun, 7 Dec 2014 16:34:02 +0100 (CET)
In-Reply-To: <54842694.9030908@web.de>
X-Mailer: Apple Mail (2.1993)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260991>

arghh, sorry that's embarrassing. I was sure that the Mac filesystem wa=
s case sensitive by default, because it's unix based...
Thanks for your  support.

> Am 07.12.2014 um 11:06 schrieb Torsten B=C3=B6gershausen <tboegi@web.=
de>:
>=20
> On 06.12.14 14:39, Martin Wendt wrote:
>>> Am 06.12.2014 um 13:14 schrieb Torsten B=C3=B6gershausen <tboegi@we=
b.de>:
>>>=20
>>> On 2014-12-06 11.27, Martin Wendt wrote:
>>>> Hi,
>>>>=20
>>>> I am facing this problem:
>>>>=20
>>>> - Using git version 1.9.3 (Apple Git-50)
>>>> - cloned a fork from GitHub to my local machine:
>>>> https://github.com/mar10/cdnjs/
>>>> - This repo seems to be broken in some way.
>>>>   At least it is not clean from the beginning and I am not able to=
 reset
>>>>   `git reset --hard` only toggles the modified file from
>>>> ".../sortable" to ".../Sortable" and back
>>>>   (see attached screenshot)
>>>>=20
>>>> Is this a known problem (with case sensitivity)?=20
>>> I think so
>>>> Any suggestions how to  fix it?
>>> Try to rename Sortable into Sortable.u:
>>> git mv Sortable Sortable.upper
>>> (When that does not work)
>>> git mv sortable sortable.lower
>>>=20
>>> If this is not an option, use a USB Stick, format it with HFS+ "cas=
e sensitive"
>>> and clone the repo to the stick
>>>=20
>>=20
>> Thanks for responding.
>> It is a fork of the 6GB cdnjs repository and I don't own the sortabl=
e lib. So renaming is not an option.
> Can you fix it a send a pull request to the author on github ?
>> Also, I am working on a MacBook, which already has a case sensitive =
file system
