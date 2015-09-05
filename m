From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
Subject: Re: [L10N] Kickoff of translation for Git 2.6.0 round 1
Date: Sat, 05 Sep 2015 12:02 +0200
Message-ID: <2019620.IQg8023dli@cayenne>
References: <CANYiYbEVU7A2w999jqLQ=V35WM0WTo--RHJHW7Ocw0FfsmqmLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 12:02:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYAIz-00025x-OD
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 12:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbbIEKCV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2015 06:02:21 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:56968 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbIEKCT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2015 06:02:19 -0400
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7215978016F
	for <git@vger.kernel.org>; Sat,  5 Sep 2015 12:02:15 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 384409400B7;
	Sat,  5 Sep 2015 12:02:01 +0200 (CEST)
User-Agent: KMail/4.14.1 (Linux/4.2.0-rc6jna; KDE/4.14.2; x86_64; ; )
In-Reply-To: <CANYiYbEVU7A2w999jqLQ=V35WM0WTo--RHJHW7Ocw0FfsmqmLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277366>

Le samedi 5 septembre 2015, 10:17:54 Jiang Xin a =C3=A9crit :
> Hi,
>=20
> Git v2.6.0-rc0 has been released, and it's time to start new round of=
 git
> l10n. This time there are 123 updated messages need to be translated =
since
> last update:
>=20
>     l10n: git.pot: v2.6.0 round 1 (123 new, 41 removed)
>=20
>     Generate po/git.pot from v2.6.0-rc0-24-gec371ff for git v2.6.0 l1=
0n
>     round 1.
>=20
>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>=20
> You can get it from the usual place:
>=20
>     https://github.com/git-l10n/git-po/
>=20
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in =E2=80=9Cpo/README" fil=
e.
>=20
> --
> Jiang Xin


Some new strings are not consistent with the actual set.

=46or instance, in the "Could not ..." strings were all with capitals, =
and some=20
new ones are not. Last time, I remarked strings which were almost exact=
ly the=20
same (only difference was a final dot, if I remember). Some help string=
s were=20
mixing different styles.

Some strings may be difficult to translate in some languages. We need a=
 first=20
set of commits to correct these errors, before updating the translation=
s. In a=20
longer term, a style/i18n guideline and checker would be very useful.

My two cents.

Jean-Noel
