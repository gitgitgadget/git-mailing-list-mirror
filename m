From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Fri, 08 Feb 2013 07:08:14 +0100
Message-ID: <5114964E.9010609@web.de>
References: <201301271557.08994.tboegi@web.de> <5113F1B1.3010102@ramsay1.demon.co.uk> <7vd2wb7w96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?B?VG9yc3RlbiBCw7Zn?= =?UTF-8?B?ZXJzaGF1c2Vu?= 
	<tboegi@web.de>, git@vger.kernel.org, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:08:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3h8f-0007ea-Gq
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 07:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab3BHGIW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2013 01:08:22 -0500
Received: from mout.web.de ([212.227.17.11]:62302 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117Ab3BHGIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 01:08:21 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0LxfGh-1V1s8b3blT-017Bxd; Fri, 08 Feb 2013 07:08:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vd2wb7w96.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:tYtCOyxt3fRQve+pb9WRi+qjaUcpm6ctqkCyK5MieAx
 GJS1dV5goq4jvhEr9BGU0ds3rKHBEGVWUr3P2ZDhRPa8Q/+klD
 yEUd/HL6A5cFRW6d9pjKtDkxy1W+t6jXPVnQE6VRV7aqTm6gz7
 t1JZWMJJfhI3whtICTi8QIhpigPsFqZM05zyD+14BZyWQHTSLq
 qTMjplMj93j/96B5V0tYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215754>

On 07.02.13 20:35, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> Torsten B=C3=B6gershausen wrote:
>>> t0070 and t1301 fail when running the test suite under cygwin.
>>> Skip the failing tests by unsetting POSIXPERM.
>> t1301 does not fail for me. (WIN XP (SP3) on NTFS)
> Others run Cygwin with vfat or some other filesystem, and some of
> them do not cope will with POSIXPERM, perhaps?
>
> Not having POSIXPERM by default for Cygwin may be a saner default
> than having one, if we have to pick one.
>
> It may be debatable to have this default as platform attribute,
> though.
>
Yes, 1301 passes on cygwin 1.5, but not on 1.7.
And it breaks on VFAT, for all kind of OS.

Thanks for comments, I'll put more investigations on my todo stack.
/Torsten
