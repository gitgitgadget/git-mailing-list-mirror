From: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass under Mac OSX
Date: Thu, 8 Mar 2012 10:21:43 +0100
Message-ID: <2412B623-E91D-44E6-8E08-97AE8CD9B978@web.de>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org> <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com> <7v4nu0m5tb.fsf@alter.siamese.dyndns.org> <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com> <7vd38okmp0.fsf@alter.siamese.dyndns.org> <4F5849AE.1070807@web.de> <4F585E70.90302@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 10:21:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ZXl-0004r9-Sf
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 10:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab2CHJVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 04:21:49 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:54046 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab2CHJVq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 04:21:46 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate04.web.de (Postfix) with ESMTP id E88607355BC6
	for <git@vger.kernel.org>; Thu,  8 Mar 2012 10:21:44 +0100 (CET)
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MBTTa-1SFzOL3H42-00AdOg; Thu, 08 Mar 2012 10:21:44 +0100
In-Reply-To: <4F585E70.90302@viscovery.net>
X-Mailer: Apple Mail (2.1084)
X-Provags-ID: V02:K0:gf0KkZNFWLea1NtJMrjoBMnhpdKmL8v6y8HpsXTWEaV
 ypqd1rLPhSboMQ/hLK0zX2Mo3/887ySxVn1VWWVFykJk0AiUG+
 3IRQ52SMwM+pzhyuAHOW4d+l8YfgJ/nis3nO2HYx6PRHuZ/rfD
 AbpalCCC16mEO0wHMj97XeZWcEvi+wOOyh+Oxnusa5X24wSHGw
 JAO1t9BuXhmp5SiujXVfg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192546>


Am 08.03.2012 um 08:23 schrieb Johannes Sixt:

> Am 3/8/2012 6:54, schrieb Torsten B=F6gershausen:
>> On 08.03.12 00:36, Junio C Hamano wrote:
>>> test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-=
1 from our UTF-8 *.mo files / Runes' '
>=20
>> ok 4 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files /=
 Runes (missing GETTEXT_ISO_LOCALE)
>         ^^^^
> Huh? How can you have tripped over this test in the first place? The
> prerequisite did not change in Junio's patch. Why was the test not sk=
ipped
> before you started this thread with your own patch?
>=20
> -- Hannes
>=20

Hm,=20
things are getting confusing.

After re-booting the machine, cloning git ... I get the following on a =
clean 1.7.10-rc0 (without Junios patch):

tb@birne:~/projects/git/git_clean/t> ./t0204-gettext-reencode-sanity.sh=
=20
# lib-gettext: No is_IS UTF-8 locale available
# lib-gettext: No is_IS ISO-8859-1 locale available
ok 1 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files / Iceland=
ic (missing GETTEXT_LOCALE)
ok 2 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes (=
missing GETTEXT_LOCALE)
ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Ic=
elandic (missing GETTEXT_ISO_LOCALE)
ok 4 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Ru=
nes (missing GETTEXT_ISO_LOCALE)
ok 5 # skip gettext: Fetching a UTF-8 msgid -> UTF-8 (missing GETTEXT_L=
OCALE)
ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing GETT=
EXT_ISO_LOCALE)
ok 7 # skip gettext.c: git init UTF-8 -> UTF-8 (missing GETTEXT_LOCALE)
ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing GETTEXT_IS=
O_LOCALE)
# passed all 8 test(s)
1..8

on 5e9637c629702e3d41ad01d95956d1835  the log looks like this:


tb@birne:~/projects/git/git_clean/t> ./t0204-gettext-reencode-sanity.sh=
=20
# lib-gettext: Found 'is_IS.UTF-8' as an is_IS UTF-8 locale
# lib-gettext: Found 'is_IS.ISO8859-1' as an is_IS ISO-8859-1 locale
ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
ok 3 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Iceland=
ic
ok 4 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Runes
ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
ok 6 - gettext: Fetching a UTF-8 msgid -> ISO-8859-1
ok 7 - gettext.c: git init UTF-8 -> UTF-8
ok 8 - gettext.c: git init UTF-8 -> ISO-8859-1
# passed all 8 test(s)
1..8
tb@birne:~/projects/git/git_clean/t>=20


At the moment I would like to say sorry for the noise.
If somebody is interested. I can dig into details later this evening (e=
uropean time)=20
/Torsten
