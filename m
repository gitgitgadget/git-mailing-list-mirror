From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git leaves behind .git/COMMIT_EDITMSG non-shared in --shared
 non-bare repo
Date: Sat, 19 Dec 2015 19:24:12 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512191923220.6483@virtualbox>
References: <1450528804-669-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1412484842-1450549454=:6483"
Cc: Yaroslav Halchenko <yoh@onerussian.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Dec 19 19:24:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAMBC-0007nJ-CM
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 19:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbbLSSY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 13:24:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:57969 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754042AbbLSSYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 13:24:25 -0500
Received: from virtualbox ([37.24.143.167]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MfW5D-1ZqvkT0G4Z-00P9ik; Sat, 19 Dec 2015 19:24:14
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1450528804-669-1-git-send-email-szeder@ira.uka.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:+n8YtUGhlmrEEyF+UEyL6x/zSth/ws7r5KxtjoQ/j9/NgQAUo2R
 g+atp476ja/L4GaGTc6VVDDrq6bpH4MY0l+8/6W4JBdMvCa+ywqGPX+4a+5ZZQRoKedyAk4
 bbWNdjRkY47yFuB/DzaIiXlw6gHgKtwMHy2xJYpbcRSx3ACHm8efwkkdAN/uNF7fqQpBWr9
 fEkxS6KU56C/S2mqwhJuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vBkT1k+TtFI=:92nDBZ46+n4F2DcXBIx/Fr
 8LfpGRM5OtkUepTe3UJpDGAD9UBDhS7EveC66DgYziOHSLZqwr4ecBiSyfd5qKJAF5UtAdeUp
 qUnGGpEGZG6jqhZU07aHhDvnmg1xSyA8bO10xXaFDhhBqMDWuqSCAvwpyHXZBZBgFzUELW3ay
 5xu9k3x7TfTz4Pr5ML3VffqaKucg7+l4uNld7TrnM7zjnZWLJ28i79rQLF0ExTs1l9/ywIf9O
 IGJU1OKgSJEghAVDBl9NXBtC6qjaAivwJDSUpSOKvWobl61O3Q0EuAXmN9BLvKfCzTLAUhv5v
 pFP6FhzmRexYK8oCciIoTSnwZgziLoBMvsYCbKZaGefdiSHduqTu2HIvEy4jLwBETKM4Ww9Cg
 IxWHvqMIxYLQ0Xtwo2LDVZBQ5jCEe3PcIJoX7JllA9kmJI2COuMEHnb8n/oDwv+8EQcqyslfP
 WZNSEnk+8543fG4NEOq4NdES04cDrxZUOFPQKcOMni9DRo97/AFExsboAEN5XytlTmomoJj8/
 gaVF4rBRHxIbZgw8QLAmZTM7SFHICm3gE/zhaHVb8vTN+AXCz6Oyudjmg4wAe5/kJiPdW/6Qb
 wZm/LCg6haK096WErhK5GADGeRXrR6824S0vABsC/6F5hgI7MAGq1sgitfds/UqHf1n7EUGVt
 GHqQ6Acr6xdnvA3ywoGigUifn+EcQc2Nn2yEZ8mXw9lsbpMTPxuGVRKceoot4kGVQyG2IJFgG
 +crtpmQwYwXONBXV+zwhxqr6n+dL2WwYNMsF5fR2HXzBMda06rbNQtF2K72f+EcPxVmFfm7t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282751>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1412484842-1450549454=:6483
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Sat, 19 Dec 2015, SZEDER G=C3=A1bor wrote:

> > On Fri, 18 Dec 2015, Yaroslav Halchenko wrote:
> >=20
> > > Not sure for what batch operations that file is actually useful,
> >=20
> > None. This file is written when you commit interactively. It is deleted
> > afterwards, unless aborted in a fatal manner.
>=20
> Is it?  I have a COMMIT_EDITMSG lying around in just about every git
> repository I have and couldn't find any unlink() in builtin/commit.c
> or elsewhere that would remove it.

Oops. My mistake. Patch sent.

Ciao,
Dscho
--8323329-1412484842-1450549454=:6483--
