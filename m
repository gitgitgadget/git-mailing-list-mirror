From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Mon, 17 Nov 2014 12:32:30 +0100
Message-ID: <5469DCCE.8040801@alum.mit.edu>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>	<1416122508-30654-2-git-send-email-mhagger@alum.mit.edu> <CAPig+cQ6j-3_Ng8DVT3FYk8T6DippEbYDhQq5v3DTJhGgBhPDQ@mail.gmail.com> <5469BAFA.7070709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 12:32:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqKY8-0003fK-3C
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 12:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbaKQLcs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2014 06:32:48 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45270 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750956AbaKQLcr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2014 06:32:47 -0500
X-AuditID: 1207440c-f798e6d0000057d7-ed-5469dcd2caac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.D9.22487.2DCD9645; Mon, 17 Nov 2014 06:32:34 -0500 (EST)
Received: from [192.168.69.130] (p5DDB383E.dip0.t-ipconnect.de [93.219.56.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAHBWV6L032194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Nov 2014 06:32:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <5469BAFA.7070709@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsUixO6iqHvpTmaIwY3pPBZdV7qZLBp6rzBb
	LPx3lN3i/44FLBb7m5Is1nTvYLI486aR0aKz4yujA4fHzll32T2OHWtl9rh4Sdlj8QMvj8+b
	5DxuP9vG4tE85TxrAHsUt01SYklZcGZ6nr5dAnfG0Yu/mAsmClZsfH2QsYFxOm8XIyeHhICJ
	xJQnp9kgbDGJC/fWA9lcHEIClxklvh46wgjhnGOS+PSwlwmkildAW6Jn9wkWEJtFQFWi714b
	mM0moCuxqKcZrEZUIEji5J7r7BD1ghInZz4BqxERyJNYuGo5M8hQZoFfjBLHGs6BrRYWiJCY
	su0YE8S2O4wS27q7wDo4BdQktu3+xgxiMwuoS/yZdwnKlpdo3jqbeQKjwCwkS2YhKZuFpGwB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJC44NnB+G2dzCFGAQ5GJR7e
	HdmZIUKsiWXFlbmHGCU5mJREefNPA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8MZcBMrxpiRW
	VqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4hW4DNQoWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSD4jW+GBixICkeoL3rQdp5iwsSc4GiEK2nGBWlxHmngCQEQBIZ
	pXlwY2HJ7hWjONCXwrxzQap4gIkSrvsV0GAmoMFzNoANLklESEk1MPZvXLtw1iqphlUqb3Ny
	972WsvDwPM/+sTZ79b0FLyvMZzyTEYiedSLrRkp9kdPfVrW/L+aFxew0vVRWFfOJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2014 10:08 AM, Torsten B=C3=B6gershausen wrote:
> On 11/17/2014 02:40 AM, Eric Sunshine wrote:
>> On Sun, Nov 16, 2014 at 2:21 AM, Michael Haggerty
>> <mhagger@alum.mit.edu> wrote:
>>> [...]
> Sorry for the late reply, I actually had prepared a complete differen=
t
> patch
> for a different problem, but it touches the very same lines of code.
>=20
> (And we may want to add a
> !chmod(path, st1.st_mode & ~S_IXUSR)
> at the end of the operation)
>=20
> There are systems when a file created with 666 have 766, and we
> do not handle this situation yet.
>=20
> Michael, if there is a chance that you integrate my small code change=
s
> in your patch ?

Your change seems like a good idea, but is is logically separate from
mine and I think it would be awkward to yoke them together. Both change=
s
are short enough that conflict resolution shouldn't be a big problem.

It will be easier for you to follow up on your patch if you submit it
separately. The first question you get might be: "Should it be applied
to maint or is it more suitable for master?", which also hints at one o=
f
the reasons that yoking the patches together might be awkward.

Regarding your patch itself:

> [...]
>     b) The user executable bit is always 1
>     c) Is similar to b):
>        When a file is created with mode 0666 the file mode on disc is=
 766
>        and the user executable bit is 1 even if it should be 0 like b=
)
>=20
>        There are smbfs implementations where the file mode can be mai=
ntained
>        locally and chmod -x changes the file mode from 0766 to 0666.
>        When the file system is unmounted and remounted,
>        the file mode is 0766 and executable bit is 1 again.

It seems surprising that there isn't also a case (d) like (c) except
that a file created with mode 0666 initially has the correct mode, and
the executable bits can be maintained locally while the filesystem is
mounted, but where executable bits are lost whenever the filesystem is
unmounted and remounted. Does that case not arise, or is it simply that
it is impossible to test for it in create_default_files()?

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
