From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: import determinism
Date: Sun, 07 Nov 2010 22:01:24 +0100
Message-ID: <m2lj54u9uj.fsf@igel.home>
References: <20101107202535.GA18766@nibiru.local>
	<AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: weigelt@metux.de, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 22:01:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFCMn-000381-Nf
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 22:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab0KGVB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 16:01:27 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33529 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab0KGVB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 16:01:27 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 9E4C21C1596B;
	Sun,  7 Nov 2010 22:01:24 +0100 (CET)
Received: from igel.home (ppp-88-217-124-121.dynamic.mnet-online.de [88.217.124.121])
	by mail.mnet-online.de (Postfix) with ESMTP id 832361C003A5;
	Sun,  7 Nov 2010 22:01:24 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 42AD3CA2A0; Sun,  7 Nov 2010 22:01:24 +0100 (CET)
X-Yow: What a COINCIDENCE!  I'm an authorized ``SNOOTS OF THE STARS'' dealer!!
In-Reply-To: <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 7 Nov
 2010 21:46:57
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160901>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Nov 7, 2010 at 21:25, Enrico Weigelt <weigelt@metux.de> wrote=
:
>> I'm curious on how deterministic the imports (git-cvsimport and
>> git-svn) are. Suppose I close the same cvs repo twice (assuming
>> no write access in between), are the resulting object SHA-1's
>> the same ?
>
> No, because the committer dates will be different.

The committer info in every commit will be the same as the author info,
so the repository conversion is completely deterministic.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
