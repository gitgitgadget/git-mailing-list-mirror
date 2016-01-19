From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Tue, 19 Jan 2016 10:40:43 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601191034000.2964@virtualbox>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de> <CAPig+cRa9mk0U4iPim5GRWzFN-vHEA=rx8bb40oQyCJVZL7t3A@mail.gmail.com> <alpine.DEB.2.20.1601150734460.2964@virtualbox>
 <xmqq60yukb49.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 10:41:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLSml-0007bY-T9
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 10:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897AbcASJlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 04:41:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:61427 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757895AbcASJlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 04:41:04 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M86PB-1ZzxoS3PEX-00vg1H; Tue, 19 Jan 2016 10:40:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq60yukb49.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:3CHg1MvpZaDqK5k+9Ff56Xm9fJyqJQ7U/3Fk4sM7P45wpEfwhPr
 Fgup19YT/aRc9SOJ+6/YpJcKHqBt13k7yezP79eZgdNFSk4+1oVv7pcDJmdj8xhF9mpQNk9
 JWhCGXUMnz83/iHCvH625nmgrVn+vIKAeMIf61MNtyVtueC1bpnavbi2p7vR9T4kQWcyl2o
 gylGZR4MiJD7c7CTOvVDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xhidNUBT8LI=:3XIoLzANHR9ALdM/4butmY
 FqLr/vkEnBCmxTjebScMdaG0/1vVs6ibrgWM8uwNKuHH4EDB3qQOc6cvdvAaHZeEi0JVn5jqw
 eCV3za7fr4kHZUsn4K3KX+ne+PM/X81oPXCihOvPjDuniDZiSN3JkO9lDYWQu+bLtMfsqHQRB
 MG8Ix4Sy1D/g2DI2ROM9DXc8qxDhY1ZOpwJbNViw8308FiwBuQB8NiY13FB7sY1VfyjO6bTYW
 SDG5dvxULwZrgVGHmoDZhsz2d5cfwiCARG/xkHi2eYqikbpgNCBVC+VCveh1MrOsIogFyLHSa
 buUv9kcx4ZvorrmUVmwSkhx/hOrrXBQda7iJzyXxRzr37gLzH6M0MLOvbjlUrH9pIoC/iR/J9
 bAxSKjSDbyqoAxC3sSpLEFENE/2geJBXVP7m9j5crRiYuM1hlcCQa1te3RMfIWDeVK96An/t7
 5TBrqErOGU+6RBc+qo2g/YaiHBTtymThbPvE/WqyD/UyBRM78YGtNfLZwp8ctV07TEDN4bCqh
 In8OoZranl9O8p9zs+aUFmp4+QL/Qzk8nfUyCVT+F6Hhrqdf66WShVWCDgfYlgIwYBWfSgDwx
 +zpAbva77cBWMn5eyCZzIKZzo4AOyHKH9tDd+nZ7uMqqcbNxFeV8rrDOJav8XPQemhD+jGX6R
 Oi3ONr9IbFg0PAChutT4S0V3/H9iyyS5cytcdB5ywNF6DdZ754G1yPOMACDay0im9C7cqXiYs
 WHlWXZqfGljugvuew5ECUcg8gpN37KLRJU+3aC2xsx0o5Zn757t5YC0v0dIm5NTbHsUDKMK1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284353>

Hi Junio,

On Fri, 15 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > This is not limited to the "//" vs "/" case, of course, other inputs are
> >> > also allowed to produce multiple outpus by the POSIX specs.
> >> 
> >> s/outpus/outputs/
> >
> > Whoops.
> >
> > Junio, would you terribly mind adjusting the commit message on your end?
> 
> No problem.  Is this the only tweak that is necessary before it can
> go to 'next' and then to 'master'?

Sorry to respond so late... Yes, this is the only tweak.

Ciao,
Dscho
