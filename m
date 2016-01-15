From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Fri, 15 Jan 2016 13:18:47 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601151317360.2964@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <20151220074559.GF30662@sigill.intra.peff.net> <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com> <20160115021237.Horde.J6jJsRTdZiG5URajzd8kKsn@webmail.informatik.kit.edu>
 <xmqqegdjk4ud.fsf@gitster.mtv.corp.google.com> <20160115115100.Horde.QlNwKM_-9TZQXszPUgP2qz3@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1544476400-1452860330=:2964"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 15 13:19:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK3LW-0003zL-Og
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 13:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbcAOMTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 07:19:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:61405 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174AbcAOMTI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 07:19:08 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LqV4f-1Zgbn90WXJ-00e0nT; Fri, 15 Jan 2016 13:18:50
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160115115100.Horde.QlNwKM_-9TZQXszPUgP2qz3@webmail.informatik.kit.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:sLSK9cd40E0Ql5v4KB20PLyP+1tBSkOi67BTBMdd4NI2oDjYKRt
 woL85mfRBZbNGGcPctBzqoZsXfadAE4ofgcSVHcEtMG4TxTXZ+f1J6S1yK7TjQl28zGj3Bz
 ohLdrf9bX1HIeWZ0unulZ8Nn8Jmtd39Hldl6eKwjceTWvIhbNIakC/hG0TQdwNRbnk5NyX4
 Usl4mhnLXYGsyKjefwoMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W/pf1bywhBE=:ReBDL6PtXyxr8lnPFIohyn
 XptguGUWjPuu6lFq4GYktc6ds2BRmeB3EFUJD2tRVExqBVxfJB3RrsK043BsxxRi3+Xy4hJ68
 0gnmJd5z1D8jwLD39/u+EtjeJaUKQfCN4Vo57XqKXkJdLZOk04ouGkTOY+Q5bon81wasznjqB
 VLo10jhWM2tUfNu79xMXOaPsJdpgoUvRqbNTmXRkgxK0bVEamdKlhA3gYjhGienbRf4blPfLA
 S88NLzXkj08gE5O6NfSk8ZZpadWFBholhoKx6M6D1q1b0MGtmEcvvI4Zb5mutq2kknot0dQfN
 6ThA8gxsidSzQSMmkMz1Q6AmbF3oJmz6ad7hDtcdUGZHVV74+vdUotLjRZVBMsJODAotK9JOF
 vcSzZlbALBmELTOntirMk4UQgbmMSU2DBJzjHsBhXLNF+Sl+BGVPyv18izsGwp4OxNdlRs/3B
 VdnQFji2lwO5bwrP0Ubyde/vxp9B4mUfN/VkGQvQNQ662uMuRU/Eh2kYnkmHGYZwTvy4r8QRT
 5MPghZUqlz3Ohu+PqnB7ZDuIMas7wJAElzBVYyXT7Zhr6K+gBWqxEXAo//G82A9CGjqK4+NT5
 fk6MzCezEq+9JtnyPGSNsCOOe5cBtiD6J7pCe9m0I3bu0KcEQZyW/FbDMkWWsBlUjiaoDZSkD
 uiYom42OUvn8wy6ULaH5HtsUBls5b/oW1lb1vprFMfT3mFQYOeRdwqn/MmepXCvunLDEsWRbG
 nmgcQBHFWtwUCg1F2+kAYokHNvFqfuvy4ESupO4rcFfPudlskGNblC5MuX7QPSDRRlY/wD2r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284163>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1544476400-1452860330=:2964
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Fri, 15 Jan 2016, SZEDER G=C3=A1bor wrote:

> Quoting Junio C Hamano <gitster@pobox.com>:
>=20
> >SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
> >
> > >Quoting Junio C Hamano <gitster@pobox.com>:
> > >
> > > >Actually, we do not even _need_ a sharedness for this ephemeral
> > > >file.  The additional "adjust-shared-perm" is merely a workaround
> > > >for the fact the next person cannot write into it when it is left
> > > >behind, and because we do not want to remove it when we are done.
> > >
> > >Do we really want to keep such a file after we are done?
> >
> >There is no strong reason we should want to remove them, either.
> >
> >As long as the lazy garbage collection works, there is no incentive
> >to change things.
>=20
> I'm not sure what you mean by "lazy garbage collection"; I suppose not
> that I sometimes delete a stale COMMIT_EDITMSG or two by hand...

You do not delete a stale COMMIT_EDITMSG *by hand*, but essentially it is
deleted the next time you commit.

Ciao,
Dscho
--8323329-1544476400-1452860330=:2964--
