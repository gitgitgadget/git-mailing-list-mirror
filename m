From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass under
 Mac OSX
Date: Thu, 08 Mar 2012 13:07:14 +0100
Message-ID: <4F58A0F2.5020400@web.de>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org> <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com> <7v4nu0m5tb.fsf@alter.siamese.dyndns.org> <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com> <7vd38okmp0.fsf@alter.siamese.dyndns.org> <4F5849AE.1070807@web.de> <4F585E70.90302@viscovery.net> <2412B623-E91D-44E6-8E08-97AE8CD9B978@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 13:08:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5c8T-0000vl-VA
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab2CHMH0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 07:07:26 -0500
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:38932 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755038Ab2CHMHZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 07:07:25 -0500
Received: from birne.lan (194.22.188.61) by smtp-out11.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4F3D5B28007B79D0; Thu, 8 Mar 2012 13:07:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <2412B623-E91D-44E6-8E08-97AE8CD9B978@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192580>

On 08.03.12 10:21, Torsten B=F6gershausen wrote:
>=20
> Am 08.03.2012 um 08:23 schrieb Johannes Sixt:
>=20
>> Am 3/8/2012 6:54, schrieb Torsten B=F6gershausen:
>>> On 08.03.12 00:36, Junio C Hamano wrote:
>>>> test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859=
-1 from our UTF-8 *.mo files / Runes' '
>>
>>> ok 4 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files =
/ Runes (missing GETTEXT_ISO_LOCALE)
>>         ^^^^
>> Huh? How can you have tripped over this test in the first place? The
>> prerequisite did not change in Junio's patch. Why was the test not s=
kipped
>> before you started this thread with your own patch?
>>
>> -- Hannes
>>
>=20
> Hm,=20
> things are getting confusing.
>=20
> After re-booting the machine, cloning git ... I get the following on =
a clean 1.7.10-rc0 (without Junios patch):
>=20
> tb@birne:~/projects/git/git_clean/t> ./t0204-gettext-reencode-sanity.=
sh=20
> # lib-gettext: No is_IS UTF-8 locale available
> # lib-gettext: No is_IS ISO-8859-1 locale available
> ok 1 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icela=
ndic (missing GETTEXT_LOCALE)
> ok 2 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes=
 (missing GETTEXT_LOCALE)
> ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / =
Icelandic (missing GETTEXT_ISO_LOCALE)
> ok 4 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / =
Runes (missing GETTEXT_ISO_LOCALE)
> ok 5 # skip gettext: Fetching a UTF-8 msgid -> UTF-8 (missing GETTEXT=
_LOCALE)
> ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing GE=
TTEXT_ISO_LOCALE)
> ok 7 # skip gettext.c: git init UTF-8 -> UTF-8 (missing GETTEXT_LOCAL=
E)
> ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing GETTEXT_=
ISO_LOCALE)
> # passed all 8 test(s)
> 1..8
>=20
> on 5e9637c629702e3d41ad01d95956d1835  the log looks like this:
>=20
>=20
> tb@birne:~/projects/git/git_clean/t> ./t0204-gettext-reencode-sanity.=
sh=20
> # lib-gettext: Found 'is_IS.UTF-8' as an is_IS UTF-8 locale
> # lib-gettext: Found 'is_IS.ISO8859-1' as an is_IS ISO-8859-1 locale
> ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
> ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
> ok 3 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Icela=
ndic
> ok 4 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Runes
> ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
> ok 6 - gettext: Fetching a UTF-8 msgid -> ISO-8859-1
> ok 7 - gettext.c: git init UTF-8 -> UTF-8
> ok 8 - gettext.c: git init UTF-8 -> ISO-8859-1
> # passed all 8 test(s)
> 1..8
> tb@birne:~/projects/git/git_clean/t>=20
>=20
>=20
> At the moment I would like to say sorry for the noise.
> If somebody is interested. I can dig into details later this evening =
(european time)=20
> /Torsten

Here we have the change from t0204-gettext-reencode-sanity.sh beeing pa=
ssed=20
into all tests being skipped under Mac OS X:

42f16113ee87ff667fef3a821e:
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

ad17ea73477012bfe1027a8a999e9e2d9f62145:
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


commit ad17ea734770126bfe1027a8a999e9e2d9f62145
Author: Alex Riesen <raa.lkml@gmail.com>
Date:   Mon Jan 23 14:04:29 2012 -0800

    add a Makefile switch to avoid gettext translation in shell scripts
   =20
    Some systems have gettext.sh (GNU gettext) installed, but it is eit=
her
    broken or misconfigured in such a way so its output is not usable. =
 In
    case the users of these systems are unable or not interested in fix=
ing
    them, setting the new Makefile switch should help:
   =20
        make USE_GETTEXT_SCHEME=3Dfallthrough
   =20
    This will replace the translation routines with fallthrough version=
s,
    that does not use gettext from the platform.
   =20
    Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 9470a1034396a5f3ee36c5d0e6ffc54e21bb3820 a0f2464a9b647fc=
d6b817e9bb86b7f79190acb01 M      Makefile
:100644 100644 6648bd3726f18c95de5737663fae652cadac0003 d5fae993b0c093b=
dd07079101df303c2c74deae3 M      git-sh-i18n.sh
