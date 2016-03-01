From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
Date: Tue, 1 Mar 2016 14:52:36 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603011452090.3152@virtualbox>
References: <56D3E56A.5010608@web.de> <20160229092816.GA23910@sigill.intra.peff.net> <56D415C6.2040203@web.de> <20160229100258.GC2950@sigill.intra.peff.net> <xmqqtwkr9vu6.fsf@gitster.mtv.corp.google.com> <20160229213620.GD25342@sigill.intra.peff.net>
 <56D52D77.1030406@web.de> <20160301055457.GA1359@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1216008406-1456840358=:3152"
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 14:53:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aakjT-000299-Le
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 14:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbcCANwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 08:52:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:50270 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbcCANwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 08:52:54 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0McVGq-1aJDsM3H8a-00HgWg; Tue, 01 Mar 2016 14:52:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160301055457.GA1359@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LWqHDPfDGF73SBhiNrjb1LbwynUS8EzigJ05DGgiOPIQ1AT3/4p
 envSy8FIG1MrMzzhY3oT5mWmAlhJDB4Jnhl+1HPbo4pp0DV1s399GJCkeIjgiuWFS9mn01q
 KaUXu0Bp2nvzMkmyuNnmI+R87Ell3LAZ9bhAUdmSs+K/E9jbdGt+tib3OFX5vf6hvuLnCDD
 JeJlNntxPlppOTXfsJEYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KyUl24/AdOw=:RHxCPMDUV66BcKOYIBITGW
 fwSGdPq9n9jYQ9i2ZoFCmTZrYuRt2U3jZyj4bXrLwxsCkNYxeK4rzpcXvvWk/ZwFOZC8wKOFn
 03Qyzr+D8O1VJPyv1iyTzHatMAMAk/MAZzTvMs5jBsGiuijaIXCKGIfXzNBDv1XXNwwHaWjE3
 GM+I3bOgzMb7mznuyYi8fXkyrr6ws1ALhMe3b952uHGh91kL+l4Xby3/xMAAJ0n4V5kA/1AYq
 7ocKmeOetyCBdk+3FG2B6OkJQj2vwx+jeKpLfStf8dBVCgoRr8cnIr5biUuq1wWR2s7HM7tI+
 Ladt5rbhOwL39TyF2XknWrNg/BUZJZNksfb81qI1xaHfCGgWkzKeHMKByFTlmwwDN4NB+28eT
 1nETaY6xJezXk9U/bnOwKnKdHxMYNCOxcWmR06zzDschrqst7bmGjX/It0Wpo85D959SS5sYy
 6o4CIQ6LZKI/vewe7qUmI+yYREgVa2/hgp/hUlKJy7sBj9uqhyPDXXws2ywypd4eGPpzyvwx8
 E9o9tDMe7evrJyCxgPNvbMlD7fSZxuiVfwY6ahyfg7wmc7pntLkdNzGRfLNfb5jAwEkWgWZEE
 dXS/tWc6+SmKA3A+ccZhBx1KGYi3AC0dBa4F4+mr2k7r1KiIT+spl5lV/mKjMr6dB0YWbU3YS
 UvXVJRe7YYOdyB3Hanjmk+HWJop4z4XrY317U7lzPY94xy6NpX/35JobaR+SVtz3MGHFBrJbV
 mFxhxRy6lvyU7dgx7X2guqwSzGgNexUKGipcBhTQ3s/EieSAXRZp0gqsMnFpsMNExL/ScvKz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288012>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1216008406-1456840358=:3152
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,

On Tue, 1 Mar 2016, Jeff King wrote:

> On Tue, Mar 01, 2016 at 06:49:43AM +0100, Torsten B=C3=B6gershausen wrote=
:
>=20
> > However, suspecting jk/epipe-in-async, I don't know if we can do
> > something against this warning:
> >=20
> >  CC run-command.o run-command.c: In function 'async_exit':
> >  run-command.c:631:1: warning: 'noreturn' function does return } ^
>=20
> The only thing that function does is call pthread_exit(), which should
> also be marked NORETURN. Looks like the one in compat/win32/pthread.h
> isn't?

Correct. Expect a patch momentarily.

Ciao,
Dscho
--8323329-1216008406-1456840358=:3152--
