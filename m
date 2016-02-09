From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Tue, 9 Feb 2016 11:00:43 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602091054430.2964@virtualbox>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net> <20160208135013.GA27054@sigill.intra.peff.net> <CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com> <20160208163700.GA22929@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602082027550.2964@virtualbox> <20160208193509.GA30554@sigill.intra.peff.net> <xmqqlh6v7zu0.fsf@gitster.mtv.corp.google.com> <20160208195630.GB30693@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 11:01:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aT56Y-00085I-EV
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 11:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbcBIKBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 05:01:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:62104 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbcBIKA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 05:00:58 -0500
Received: from virtualbox ([89.204.153.48]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lurin-1a2IzG47n7-010881; Tue, 09 Feb 2016 11:00:48
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160208195630.GB30693@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:z4HkYRYZ64oesmNjkaTrN2z4am+anG/svi3jPDVvNVfOb+5zD3l
 SutETNrnYLnDxXqx5yZLgYdCO6/4tpl3zdbD2PITZ0XyZ6g9I+NB61yFE+kgccWd7axs3jO
 80uYDoZX1cSzNul4zuloluJfaYJ+zIQJNd0j4GESP4ckFWxVffw0uLOMymLfVNcFNJIIsaA
 m+mzTOyqHZv83+wY0x32Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GFvzmQTrpys=:dOAOqtkxyvdMS0gb8mOkNL
 Ft95Bz5vdg7Z6IY+y7sQVSc5U7V+vjRjxTjlsaRM6R7lbJOT9VjgavjF3+Yiu9t4TIX+QF9TF
 NKy/ZwUS6QPRvqQTQjBai87ISK11z3AAMOtRqTlhiLpffEssFCUKcQf4HpwMFUXqyY95XVlZG
 9XeX80oyfTMHxtNFS1PUnfSslHN1hJD9nAi/nCH+RpEgXO63k8prpaTcy1JmnkpqdTBnfC03t
 3t4kwIaLIHbvlBl8IrktdsvKwESTnTWovpPsgBXD1EioVHCbNh7IS0vH09UeP7EDSCw5Vkkz/
 LCfoVxxMG4//76oIbgoTR63w9AW1sEk7vCHNayil6nUE3P8vPUJgXiSc4oZzum6gHqpgdm+m1
 2okZcuSWkH78zB22DX2pbEZB4fvkALxv0y/i5qVj29t2apHHC1HhH1+uzhZlqUjMCrMzZB4Hp
 0CP9jR1WWzURHlB2GWyXHcLViWKdoK1X1k6tNwlBifMR5p0OJnbqO9MzS4gub/GCFDEROU/DL
 uBHeyQf6zif5lmj91w0F2EWDrljh6Wy+1JuTjWn68rd83uUaGEsmmFnJcl3ww6/xKyXExQkIO
 k1t3OvCpdsPKJ3o80ftNUQGONpgmAThogD6QWuV1VqYJLP9Fjps4XKiefh4eDIPGgIf//mIbu
 9691fFb/dz0YfRz3Fnw6o4EsaJt7Y39YGFkDDiCkjd/HzQsEmL2x14CwWHiZzrftNFu94Xq9Q
 yOK3/NSgx9+CBP879K3376+TVrUllcryUBmw3gN3ZBUFvwDf/fexQB8JoSiVb50k6nVZ6cyH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285833>

Hi Peff (and other interested parties),

On Mon, 8 Feb 2016, Jeff King wrote:

> On Mon, Feb 08, 2016 at 11:43:19AM -0800, Junio C Hamano wrote:
> 
> > The version in 'master' that does
> > 
> >                 echo "#!/bin/sh" >exec.sh &&
> >                 chmod +x exec.sh &&
> > 
> > should be equivalent, so dropping that hunk from the patch is the
> > right resolution perhaps?
> 
> Yeah, but I still don't understand why the original did not work on
> Windows, once all the other hunks from bcb11f1 are applied.

And indeed it passes. With MSYS2. Because it simply ignores that chmod +x
cannot flip an executable bit.

The original patch (the one that guarded the chmod behind the MINGW
prereq) originated in the MSys (AKA MSys1) times, where 1) chmod would
fail, and 2) POSIXPERM did not yet exist.

Besides, I am pretty certain that there is a test in t9100 that *does*
test the executable bit, properly requiring POSIXPERM.

So I still would be in favor of using write_script: 1) our *intention* is
to write a script, even if we do not currently execute it, and 2) if
anybody is interested in supporting MSys1 (*cough* Hannes & Sebastian
*cough*), they have a *much* easier time to fix it.

Ciao,
Dscho
