From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum member
Date: Mon, 07 Nov 2011 14:12:28 +0100
Message-ID: <m3pqh4krer.fsf@hase.home>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
	<1320581184-4557-4-git-send-email-avarab@gmail.com>
	<m2pqh5nvic.fsf@igel.home>
	<CACBZZX6CRm1W5i43=LeXPJFdcWFgVTkD8cGntHoKsPoWGx_hNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 14:12:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNP0B-0003fX-8l
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 14:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab1KGNMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 08:12:36 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:50980 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab1KGNMf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 08:12:35 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id E5A77188B5AF;
	Mon,  7 Nov 2011 14:14:02 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 34C7C1C00072;
	Mon,  7 Nov 2011 14:12:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id icgDmaPS2VLK; Mon,  7 Nov 2011 14:12:29 +0100 (CET)
Received: from hase.home (ppp-93-104-152-211.dynamic.mnet-online.de [93.104.152.211])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon,  7 Nov 2011 14:12:28 +0100 (CET)
X-Yow: I am covered with pure vegetable oil and I am writing a best seller!
In-Reply-To: <CACBZZX6CRm1W5i43=LeXPJFdcWFgVTkD8cGntHoKsPoWGx_hNg@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 7 Nov
 2011 13:42:39
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184982>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I.e. we'll always have GREP_HEADER_AUTHOR =3D 0 and
> GREP_HEADER_COMMITTER =3D 1, we'll never have GREP_HEADER_AUTHOR =3D =
and
> GREP_HEADER_COMMITTER =3D <some int>.

That is irrelevant.  You can always assign -1 to an object of enumerate=
d
type and the implicit conversion to the underlying type is fully
defined, no matter what type the compiler choses.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
