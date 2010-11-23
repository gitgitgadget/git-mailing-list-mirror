From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 21:38:56 +0100
Message-ID: <m262vn22sf.fsf@igel.home>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
	<AANLkTinFMn4V3c3yV6j72eqj5=v4jW7Uh3fmNDOyYjnT@mail.gmail.com>
	<AANLkTinj3ryChGKV8c6fHSD=aickmz0TMos4k0RYGKvo@mail.gmail.com>
	<AANLkTikxMXRiCYE=ny1tfrS64P0ywAHP_9eLJJzNUG3Q@mail.gmail.com>
	<AANLkTi=FaZ4MhJ2gDFZGiJVHsuY9jtNGgdWxX3Dq4BY6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Tarek =?utf-8?Q?Ziad=C3=A9?= <ziade.tarek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 21:39:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKzds-0008Nz-2T
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 21:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab0KWUjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 15:39:01 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:54744 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab0KWUjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 15:39:00 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id CC5AE180594A;
	Tue, 23 Nov 2010 21:38:56 +0100 (CET)
Received: from igel.home (ppp-88-217-117-240.dynamic.mnet-online.de [88.217.117.240])
	by mail.mnet-online.de (Postfix) with ESMTP id C02931C001F5;
	Tue, 23 Nov 2010 21:38:56 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 885DECA2A0; Tue, 23 Nov 2010 21:38:56 +0100 (CET)
X-Yow: Remember, in 2039, MOUSSE & PASTA will be available
 ONLY by prescription!!
In-Reply-To: <AANLkTi=FaZ4MhJ2gDFZGiJVHsuY9jtNGgdWxX3Dq4BY6@mail.gmail.com>
	("Tarek =?utf-8?Q?Ziad=C3=A9=22's?= message of "Tue, 23 Nov 2010 14:18:59
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162024>

Tarek Ziad=C3=A9 <ziade.tarek@gmail.com> writes:

> On Tue, Nov 23, 2010 at 2:08 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
> ...
>>
>> There's another command that starts with "st": stripspace (it's a
>> lowlevel command by the way). It's going to be a lot more if you typ=
e
>> "git m" and expect all commands starting with 'm'.
>
> Maybe so yeah. That's how Mercurial does.
>
> $  hg s
> hg: command 's' is ambiguous:
>     serve showconfig status strip summary

Mercurial allows unique abbreviations.  Git doesn't.  Thus a git comman=
d
is never ambiguous.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
