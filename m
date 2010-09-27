From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Mon, 27 Sep 2010 09:59:59 +0200
Message-ID: <4CA04EFF.6010805@statsbiblioteket.dk>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>	<AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com>	<AANLkTim8aPoOkzzf4c0JHbBDVa4zJY2xM3v9fXQ-px=V@mail.gmail.com> <AANLkTimNGZom6FfKivg=QNmovz=xf656XHbXCmsjfrxD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Tait <git.git@t41t.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Mon Sep 27 10:00:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P08d6-0007vr-Sz
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 10:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab0I0IAB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 04:00:01 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:51268 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752450Ab0I0IAA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 04:00:00 -0400
Received: from [130.225.25.159] (130.225.25.159) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.436.0; Mon, 27 Sep 2010 10:00:00 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100916)
In-Reply-To: <AANLkTimNGZom6FfKivg=QNmovz=xf656XHbXCmsjfrxD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157318>

Tor Arntsen wrote:
> On Fri, Sep 24, 2010 at 15:32, =C6var Arnfj=F6r=F0 Bjarmason <avarab@=
gmail.com> wrote:
>> On Fri, Sep 24, 2010 at 13:08, Tor Arntsen <tor@spacetec.no> wrote:
>>> On Fri, Sep 24, 2010 at 14:56, =C6var Arnfj=F6r=F0 Bjarmason <avara=
b@gmail.com> wrote:
>>>
>>>> However, I'd like to shift the discussion a bit: Do we want to sup=
port
>>>> the 5.6 line *at all* anymore? I don't think so. As you point out
>>>> yourself you can just compile 5.8 or later on these machines.
>>> 5.8 as minimum is probably for the best. It's not that just you can
>>> compile a newer version (5.8), more importantly, Perl 5.8 is availa=
ble
>>> as a package from those semi-official 3party repositories for most
>>> systems (at least the *nix systems I have access to)
>> Do those repositories also have 5.10 and 5.12?
>=20
> Anything later than 5.8 seems to very unusual except for Linux (and
> presumably *bsd).
>=20
In Linux land atleast the current crop of RHEL dists are on 5.8.x and=20
for RHEL5 this is supported until 2014 (2017 with ELS).

>>> except for those like Irix 6.2 where it's hopeless anyway (perl
>>> 5.0). But I only have access to irix/aix/solaris/tru64 in addition
>>> to Linux.
>> Hrm, 6.2 is old, but 5.12 is known to compile on 6.5 at least. What
>> are the issues with 6.2? Perhaps they could be solved if someone wit=
h
>> such a machine contributed a smoker for the perl core.
>=20
> IRIX 6.2 is simply suffering for being old. Unless you have to
> maintain a legacy system (as I do) you would probably have upgraded t=
o
> IRIX 6.5 anyway.
> (Actually it turns out that I wasn't entirely correct in what I wrote
> earlier - the SGI freeware version of Perl for IRIX 6.5 is still at
> 5.6.1, because they stopped updating that repository. There's another
> 3party semi-official repo for IRIX now, not hosted by SGI, but I'm no=
t
> familiar with it.
>=20
There are currently 2 maintained options for IRIX users:
nekochan (requires IRIX 6.5.21 or better)
tgcware (IRIX 5.3 & 6.2, will also run on 6.3, 6.4, 6.5).

I maintain tgcware and have prebuilt git packages available (1.7.2.3).

Git does not build on IRIX < 6.3 without adding some sort of thirdparty=
=20
(v)snprintf code since those functions are missing in libc. I use the=20
ctrio library for this purpose.

-tgc
