From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Compiler warning under cygwin/mingw
Date: Mon, 29 Feb 2016 12:32:33 +0000
Message-ID: <56D43A61.3090503@ramsayjones.plus.com>
References: <56D3E56A.5010608@web.de>
 <20160229092816.GA23910@sigill.intra.peff.net> <56D415C6.2040203@web.de>
 <20160229100258.GC2950@sigill.intra.peff.net> <56D4203B.1030708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 13:32:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaN0D-00030Q-MI
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 13:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbcB2Mch convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 07:32:37 -0500
Received: from avasout01.plus.net ([84.93.230.227]:34502 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbcB2Mch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 07:32:37 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout01 with smtp
	id QCYZ1s0044mu3xa01CYaTa; Mon, 29 Feb 2016 12:32:35 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=N3sh0_2eW6l_0QQvmi0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <56D4203B.1030708@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287831>



On 29/02/16 10:40, Torsten B=C3=B6gershausen wrote:
> That compiles OK, thanks.
>=20
>=20
> Sorry for high-jacking this thread, but while compiling under CYGWIN,
> found one warning:
>=20
>    LINK git-credential-store.exe
>     CC daemon.o
> daemon.c: In function =E2=80=98drop_privileges=E2=80=99:
> daemon.c:1136:15: warning: implicit declaration of function =E2=80=98=
initgroups=E2=80=99 [-Wimplicit-function-declaration]
>   if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||

Yeah, this has been there for a while - except it depends on which vers=
ion
of the header files you have. (Some may not see the warning).

I have 'fixed' this twice before, then updated my installation and
a change to the system headers broke it again! (The headers are
currently 'broken'). So, I got tired of fixing it up and have left
it a while - you never know a new update may fix it! ;-)

[I personally don't use the git daemon on cygwin, so I don't know
if this a problem in practice.]

ATB,
Ramsay Jones
