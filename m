From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Fri, 15 Jan 2016 07:51:49 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601150750340.2964@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <20151220074559.GF30662@sigill.intra.peff.net> <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com> <20160115021237.Horde.J6jJsRTdZiG5URajzd8kKsn@webmail.informatik.kit.edu>
 <xmqqegdjk4ud.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-886709608-1452840712=:2964"
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 07:52:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyF8-0006tf-CD
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 07:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbcAOGwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 01:52:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:61758 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbcAOGwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 01:52:14 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MUYiV-1alIIV1dBb-00RLJf; Fri, 15 Jan 2016 07:51:52
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqegdjk4ud.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/gSPvcUq8Kcmv6V5CZ9Zizz0ycpgVym+N+OIbeipZh5bytGwcbQ
 3dHoENsJuQD9kaGUK6f8ksYEa1twoJzYD6QOKux0+1DBCIstVjqhh0zG2CXzNd6RomBfcbi
 bLEPn3wQ5suopx9piFTHhmwcpTwzNUmLWrRwpoNVCsOwP7AdSdqmmdc7yTPPQjoJt/Tu7oD
 2M0cRQcpdR1weeXxwezug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8xa/M/rvJxg=:74wLiEE/CytEhztCQTc+Vj
 x3PVDCrOTxfn2321f2AbpMtN6V5i096cikYapnHyopzER2vL36NriSyTNF+5BYGC57xLGC0XY
 TlzI2PAThpbxQUTwFkfGRoTVKaNcH6v66tf9TFswMog/3d3YjZ4L0Yzi+MQkskP9HZdGTInfv
 CzFk/yRpO2+qpI4CwmRBiKQ1K6Z5PN/Zwpt/DXtVB282TU+nwPLNIKAf9J/IMr1vhl/rr04uw
 EH4l7OzCmGDC8jzU7WsCtGOZpifxhwezwRksX6Wwc1gxqE1cxhED7VsgEzS10bHS/ZXtIuZWl
 F7MnSbiJLwy+BA1GKilux95o1J98iar9lY76BSaT1LCW9i2Ki7t+a7Lv46aGDA8Ik9aY4o2iO
 d9TNPSUVm1W58W2x1sGJmYTG6fqDLeJJ7m4eF0tWHo3jRLPu3Qek/nAC/+cfTtmjJ3ihl0YMd
 SBdVu9dxox7QHfKBajZU+elNdDYoHHZy2qgh/J5pMq4uAONesDo2XuPRmCin7bnpjoKkaeHD2
 4Uj9QtNBR6SLduj/nz5NUvmTMdRBXddY5O2+pVv+DFsILBWHAbr/X89dEQApSp3KB/G8QG/mq
 yQ7zO90CVbq5EQSjrLBwHLeDIY7ly4uFZBklu2h8SAcNZ/nkcQeS6pGDGPvn1RlNkJ7SYNVWa
 LDP0d3g3fcZr+lFmN5nvAUf8JduFMbtrTaUk+EwEm6fHEQMvQLxa2QKCI+VA4BC3/iR9h2jwP
 BzgsRnfSFTQdJBXF8M/36t7R9Lx5QPM2IlYEt+30O0ZJembJYeTmZiooBb/pFhQvRgx0wfvH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284138>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-886709608-1452840712=:2964
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 14 Jan 2016, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>=20
> > Quoting Junio C Hamano <gitster@pobox.com>:
> >
> >> Actually, we do not even _need_ a sharedness for this ephemeral file.
> >> The additional "adjust-shared-perm" is merely a workaround for the
> >> fact the next person cannot write into it when it is left behind, and
> >> because we do not want to remove it when we are done.
> >
> > Do we really want to keep such a file after we are done?
>=20
> There is no strong reason we should want to remove them, either.
>=20
> As long as the lazy garbage collection works, there is no incentive
> to change things.  I do not have strong objection against such a
> change, as long as you do not break people's existing practices,
> either, though.
>=20
> Whoever is designing such a change must carefully define what "after
> we are done" exactly means.  Removing such a file immediately after
> the command read from it is likely to be a bad idea, for example, if
> the command supports hooks that are invoked after the command reads
> and uses the contents of it, as the hooks may be depending on the
> presence of it and the ability to read from it.

=2E.. and do not forget scripts that call `git commit`. They can expect the
presence of that file after a successful operation right now. You will
have to warn any potential user of such a script that you are going to
break their setup.

Ciao,
Dscho
--8323329-886709608-1452840712=:2964--
