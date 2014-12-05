From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Enhancement Request: "locale" git option
Date: Fri, 05 Dec 2014 16:45:15 +0100
Message-ID: <5481D30B.2020104@web.de>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de> <54801B50.4080500@web.de> <20141204095557.GE27455@peff.net> <CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com> <548087F8.1030103@drmicha.warpmail.net> <CACBZZX6iOtO-Wv_T1Sgtmjqdi8kEziBCHwp1X319x0o1QMOnGA@mail.gmail.com> <20141204205527.GA19953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7Y=?= =?UTF-8?B?Z2Vyc2hhdXNlbg==?= 
	<tboegi@web.de>, Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	Git Mailing List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?B?b24=?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 16:45:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwv4d-0000u8-2e
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 16:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbaLEPpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 10:45:31 -0500
Received: from mout.web.de ([212.227.17.12]:56621 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbaLEPp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 10:45:28 -0500
Received: from [192.168.209.17] ([78.72.72.190]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LkyEb-1XOPf61XKn-00air1; Fri, 05 Dec 2014 16:45:17
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141204205527.GA19953@peff.net>
X-Provags-ID: V03:K0:PhyYH0wS9DSUllE7HpdQ5RAyyGqGjbN4719XRw6oVCa6KEvydWu
 jyQ2BXUzMVZPLYy781wbBCvouhKKcsSvjdkhv68fLZdstKEv0JOYcwsrMg6L4RaRcOHTX9Z
 VDds1hq8TRTqyO5ZoVfLONQuYYG7FkDGLAztVZRASNFsbAHc8MjR2NkAuBPCymAVyhz8GFC
 f+/ilsoQdnR2GgfiDfUNw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260872>

On 12/04/2014 09:55 PM, Jeff King wrote:
> On Thu, Dec 04, 2014 at 06:21:40PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>=20
>>> That is one of the many reasons why I proposed to have a dictionary=
 of
>>> the main technical terms for each language before we even localise =
git
>>> in that language. In an ideal word, we would provide a simple solut=
ion
>>> for looking these terms up both ways. I don't think we're going to =
have
>>> localised man pages any time soon, are we?
>>
>> I think that's a great idea, and one that's only blocked on someone
>> (hint hint) sending patches for it.
>>
>> It would be neat-o to have something to make translating the docs
>> easier, i.e. PO files for sections of the man pages. There's tools t=
o
>> help with that which we could use.
>>
>> But there's no reason for us not to have translated glossaries in th=
e meantime.
>=20
> By the way, there has been fairly significant volunteer effort put in=
to
> translating Pro Git (e.g., <http://git-scm.com/book/de/v1>). I have n=
o
> idea if the terms they use are similar to the terms we use in the
> localized messages. It might make sense to:
>=20
>   1. Coordinate with those translators to make sure that the glossary
>      terms are consistent.
>=20
>   2. Figure out how to harness those translators for manpage work. Wh=
y
>      did Pro Git get so much volunteer translation done, and the
>      manpages didn't? Did they advertise to the right people? Have an
>      interface that made it easier for non-technical people to get
>      involved?
>=20
> -Peff

(Thanks for the pointer, excellent book)

I do not know who was first, and who came later, but=20
<http://git-scm.com/book/de/v1/Git-Grundlagen-%C3%84nderungen-am-Reposi=
tory-nachverfolgen>

uses "versioniert" as "tracked"


LANG=3Dde_DE.UTF-8 git status
gives:
nichts zum Commit vorgemerkt, aber es gibt unbeobachtete Dateien (benut=
zen Sie "git add" zum Beobachten)


Does it make sense to replace "beobachten" with "versionieren" ?
