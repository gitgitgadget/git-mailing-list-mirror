From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name
 issues
Date: Wed, 23 Mar 2016 11:49:49 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603231148510.4690@virtualbox>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de> <56F18F5E.9090301@web.de> <xmqqbn66gs4k.fsf@gitster.mtv.corp.google.com> <56F1CACA.5040709@web.de>
 <xmqqtwjydsub.fsf@gitster.mtv.corp.google.com> <56F22F85.3010507@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1855825193-1458730192=:4690"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:50:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigMe-0002xS-BX
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbcCWKuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:50:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:60186 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbcCWKuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:50:06 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LjvV7-1aC6dF20dd-00bpsn; Wed, 23 Mar 2016 11:49:52
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56F22F85.3010507@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:BvNwK61wKQHKyaCBA3RCEEXbl7YTpZvX4VS+4w21ETro6TWAVz8
 IfaXfUrNV7r/NO4cN35pcJ3M49prS5wDVp3OkGCCu6v52Tsj+JYIUKePFqjYaTuWu6n+d66
 AdoGid4R+gu06baMwaAsQ9/pJo42tXr4nmEJNbW7eV7upcypAuZzXtRwTAl6W2Tywd8CN9L
 nZYFOqzbzJ1f/Yq/KDT/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EciVxhBLSgw=:XXxc+zok4autdRC4/WBe80
 cIwYiXj3FyERh/TxlBnDNRMNhY01r4sya/pJBmycaSsfZjTRPIA5CfOY4JD11YApTOr1HTGQT
 cMSnx/rq0qJL4hYMzUUX85c2cWfS6P1m1hDUaInOLR1ymtgCYl9BOC28vRTi2cYznW1SRjwIv
 qLLVkuQysTZ+Xdo+3ytumOfNv1aXcAHA9xsuppxPfZwYyEcpJXzFcHcCeYvRkRbV3gRpiQWF6
 PfCjseY3RvxXUa9EhjBMtPJuyYByZ6j6qcRSCGmPEGWbZWn/TNVzkjCtZG+BZweSzQkCyGZHo
 6xuKjoPl1SlzGDssiMHOfdB8UfPoq8+YM4f1B0zF3wNcMcesg7XglCJeITuIqfhNU7dUQROwG
 tHj6ohANjNnxO0qgCToBfkdmOAKNJRI5vCpUg00rgMZR2tZ5stlFCaJshXsio0pLfpAXARDsV
 6IAPBi0vu8ry0sjOzHoCLj3HdJ9WqW2/cQ5g/DmEQa5hlu1djpRo+3HrNaJo0roJ1Eti0O9Ey
 DdmbG3/fcKDFLmF3NZl3kgpvsFBcl6VwADAYV6wHB+VVo4Opb5dRwEwXE5JRT3Ae2VfiYV5ZT
 0YeBNiGQiWDCLDoQttfv8TIs/Yu+aq9LFWgrfD3n6/gLmbwz6uZXlTxcqWcoLWz/xhnxyhNtK
 U2HtsmTXTx0mTD48Cq2EtewjJnMgpIBDt07AmDSWcLJQHwtDeMt96Qnu4+l9zcJiwr0IOzTIR
 GLuKbk+iOCcI9bU+6Pv2xRODNqlnjxZaJsKot8stKlVI3Pg+rFTUn6V7wsElcNK1Ys/Nx2bN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289639>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1855825193-1458730192=:4690
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio & Torsten,

On Wed, 23 Mar 2016, Torsten B=C3=B6gershausen wrote:

> On 2016-03-22 23.57, Junio C Hamano wrote:
> > Dscho, I queued two out of these four, with a proposed fix-up patch
> > for each of them, on 'pu'; but I won't squash them together myself
> > without hearing from you as I do not test mingw or macosx.

The suggested changes will be squashed into v2.

> Beside that, do we want to amend the commit message like this:
>=20
> Author: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date:   Tue Mar 22 18:43:00 2016 +0100
>=20
>     skip some tests in t9115 due to file name issues
>=20
>     These two tests wanted to write file names which work under Linux or
>     CYGWIN, but are incompatible with file naming rules under mingw or HF=
S.
>=20
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>     Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks, I used a slightly different version, as I had crafted it before
reading this mail already.

Ciao,
Dscho
--8323329-1855825193-1458730192=:4690--
