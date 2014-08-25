From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Undefine strlcpy if needed.
Date: Mon, 25 Aug 2014 12:16:04 +0100
Message-ID: <53FB1AF4.1000201@ramsay1.demon.co.uk>
References: <1408854741-13956-1-git-send-email-tsunanet@gmail.com> <1408854930-14322-1-git-send-email-tsunanet@gmail.com> <53F9C818.8020607@ramsay1.demon.co.uk> <CAFKYj4dQhGgpS9Vf=5qoku49jEkR0ko7TuBNu4sQAJyiD7y+cg@mail.gmail.com> <53FA1050.2060309@ramsay1.demon.co.uk> <53FA41E2.9060907@web.de> <CAFKYj4eD8CXzafSC5LWpmaen=d6uw7yn0gZXFLG7VGLQwZdUWA@mail.gmail.com> <53FA8438.5070107@ramsay1.demon.co.uk> <CAFKYj4cDJhiVfdmzZ5KnNASBEp9bkj0asxANPv43QcMQP06z9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: tsuna <tsunanet@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 13:16:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLsFz-0001Mk-4U
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 13:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbaHYLQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2014 07:16:09 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:47666 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752690AbaHYLQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 07:16:08 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 522FAA64FDD;
	Mon, 25 Aug 2014 12:16:06 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 09BB6A64FDA;
	Mon, 25 Aug 2014 12:16:06 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Mon, 25 Aug 2014 12:16:05 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAFKYj4cDJhiVfdmzZ5KnNASBEp9bkj0asxANPv43QcMQP06z9A@mail.gmail.com>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255819>

On 25/08/14 02:54, tsuna wrote:
> On Sun, Aug 24, 2014 at 5:32 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> Again, I don't have access to an OS X system, so I don't know
>> which package provides libintl/gettext, but it seems to be missing
>> on your system.
>=20
> Probably yeah, those libraries don=E2=80=99t seem to be provided in s=
tandard
> with OS X or OS X=E2=80=99s development tools, so maybe the Makefile =
should
> also default to having NO_GETTEXT=3DYesPlease when on OS X.
>=20
>> You can avoid the build failure, without running configure, by
>> setting NO_GETTEXT=3DYesPlease in your config.mak file.
>>
>>>
>>>
>>> I need to run configure first:
>>>
>>> $ make configure
>>>     GEN configure
>>> $ ./configure
>>> configure: Setting lib to 'lib' (the default)
>>> [=E2=80=A6]
>>
>> So, presumably, configure has set NO_GETEXT=3DYesPlease in your
>> config.mak.autogen file.
>=20
> Yes it did.
>=20
> I don=E2=80=99t mind running configure, but so far Git has compiled f=
ine
> without doing it.  Should we fix the default values of NO_STRLCPY /
> NO_GETEXT on OS X?
>=20

Is NO_STRLCPY still a problem with a fresh clone (and putting
NO_GETEXT=3DYesPlease in your config.mak)? I still do not understand
why you were getting those warnings; AFAICT it should not be happening!
Also, Torsten could not reproduce.

As far as NO_GETTEXT is concerned, I have to defer to someone who has
experience on that platform (I have _zero_ experience on OS X).

ATB,
Ramsay Jones
