From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push --quiet option does not seem to work
Date: Mon, 16 May 2016 17:04:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605161700360.3303@virtualbox>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com> <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com> <20160515212332.GB31809@sigill.intra.peff.net> <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
 <20160516005824.GA1963@sigill.intra.peff.net> <CADKp0pzOLs5g9Jc6_sA6jr-XOifx0Yn6b7wDW2qcC2UB5Q_WPQ@mail.gmail.com> <alpine.DEB.2.20.1605161526510.3303@virtualbox> <20160516133731.GA6903@sigill.intra.peff.net>
 <CADKp0px3v3K4vqNeNk7NdWZFdSCyqMa+i_Nv0wW80Tkf0C=RUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chris B <chris.blaszczynski@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 17:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2K4t-0006M4-GP
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 17:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbcEPPE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 11:04:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:64323 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853AbcEPPE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 11:04:56 -0400
Received: from virtualbox ([88.128.80.193]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Le5XQ-1bN4yd19hs-00psk3; Mon, 16 May 2016 17:04:43
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CADKp0px3v3K4vqNeNk7NdWZFdSCyqMa+i_Nv0wW80Tkf0C=RUQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:PzA/CxWmOoQjGDE/F5yFn1uEf2g6RawcP/+fm2veW6GDAAnDX9V
 RXPdmXRbJuGIa+BieTPz77rIleH/QHCMGFFemnUADmGHht/xVlP6KpniZXMU4fjz/KXoVpf
 Rl7K0K+DrHNQSF97bJT8BoBK4znQkBJEJ5pp2rQ/W18Z6a2aiakLPohSZvac79pHc0WZGN+
 DT/kwmtWouHbFm87o2Ppw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+Pn4id9RSRI=:4Cwap6fjaBZHV66vCU8rfX
 A8tjFy2DRzcYb73dZ7u7B7pTgvV5T9dR7xxdgRUF//FEhbe1gVZ+i/Ox1rikxzkuzzyjhyMoN
 O4Dthw5KY53EzGYL7DkcU/wPeKiKvvqwyC1oUpYDKNhb7UQ3vFYzKPQ0lYpe8vWx6coVr8Ozw
 HYZP4M7+I8NqTmJBOk3JxHXI2p9KzaVv6PUPeD0Va6xJR0ZVD5sNDAGrVX2JJKKm6HPZtErHC
 1dqEEzkbvoZCpCJXMPOleEw2052m+pFI+hztS96EMnWU1gGUf9zOma9oao4ROJQuYTUEzlf1e
 3lHpXBH+2pQ8SsdsSI07NiXDuKQsiLIyGOVTyvRmwHy9YuENy6SHlNFnkM5vynhYmDHs634tU
 BVUigAmUfAFTJQ3zyDah46xJxWuW+rO79gupBtoSlIg19ryIlrjL4WnKplLCrcI8H8AmDA2LM
 98iPbnbCyiyEkS3YhRiEtk3bAzEjosxF6v0c6MQW0RR1ld7KztljJHpPIhEX16fxXRsiIscid
 JFDLfl9VwYgRdtYu/tIigEnMKopTP3ed7x5qbQySlQZC0R7pvwBR2IXEjPcoHGsPd6KLZyUK1
 oRYplA2PYrphrHFxSfRKL+1J7cmn6QgZZIGJFFCV6x45nHWP8Q5bVoOGgF3p9ceWZwCbZkLr+
 P1BAtIqr0MhFq/TkFh2x2sqOmt+++DdiVMYpBUC4Gm9HYwZH3IKjtGl79Tmu6IvOpyJ26E5sK
 YkdIgBkVI5Vdj+y4kU8s3tlIw+rUm4Pu/fwseiu64PRGRalKw8MEdOMEARXjs7XJ4YXgOpwo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294740>

Hi Chris,

On Mon, 16 May 2016, Chris B wrote:

> Once I included the whole email in my reply, but otherwise I deleted it
> all.

Both are bad practice. If you are considerate with the reader's time, this
consideration is typically reprocicated. So it is a good idea to save the
reader time by giving them the precise context they need.

> Anyway, it is not a Powershell thing. I tested on another repo on
> GitHub and it worked as expected. So I guess indeed the problem lies
> with Microsoft's implementation.

This is *really* unclear.

What "Microsoft's implementation"??? Do you refer to VSTS, or do you refer
to Git for Windows, or PowerShell?

Please. To make it really simple for everybody involved, try to repeat as
closely as possible the same push from PowerShell, Git CMD and Git Bash.
We want to compare oranges to oranges.

FWIW You can repeat the same push by force-pushing the previous state
between re-runs. E.g.

	git push myremote HEAD^:my-branch
	git push myremote my-branch

Ciao,
Johannes
