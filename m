From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Wed, 6 Jan 2016 09:20:34 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601060916400.2964@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <20151220074559.GF30662@sigill.intra.peff.net> <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com> <20151221065944.GA3550@sigill.intra.peff.net>
 <xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1512301535550.14434@virtualbox> <xmqqfuyjczpv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601011604070.14434@virtualbox> <xmqq60z9p51f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601051342050.14434@virtualbox> <xmqq37ubke8q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:21:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGjL7-0001eY-By
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 09:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbcAFIVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 03:21:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:53538 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbcAFIVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 03:21:00 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MIPhr-1aEF1n0tTj-0049mG; Wed, 06 Jan 2016 09:20:36
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq37ubke8q.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:O7CoZdOwv12xLREauuHDVOiwl29jYnWVvVQNSQxnBEMR6MgS84r
 TF8IxFL/VRfqojMxOfknu9v+ClZ1i0aHBwk4rt79qMdjpx8VRC81xTxMLI22WkiALRG+rXK
 OtvdVC2ZHldNOXjb4x5oGGlEi2AyAjK0QG96xFQ2xQ1RYYhWRPQfPv/U6C4C0wQKd9Ym5l+
 aL3QmYHYHN7xOmM3pvX1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ij5lbeKGLlc=:wuPYAjk+Plubi0bQ9ymCoJ
 5yW2uTI+GEE7TVAqcVTHIBmtMf77XEGP0hXXelAv6HRTUEV+v0FEeHSSrhxCx4JzZacDsB5P5
 YvZS+VHYZ5hatO2NDnfmGneP+aMKnkELTkS1htBF/n6cGcBblgtBl1sgmW+T8rtmAfR1oe2o9
 ViYA2F4s/f6Q/LYAZWU5CHrI6kB0JSLquDKQ2PM1yel9YLWa9pICrOb6Lm30UOWEhr7bdqMLs
 bkBon6Jw9iYLEja2YKxyyWggARbWU4V6QCQiR6raHmGZxaucP8n5b7V7UjDM1tkY1llK9BOIG
 6/805r+9rt4FschiZcbCGws81Vih4Tvj4SEZQn4Uxwb+YuoexSMh+LjXcpE64Cqh1CwR3gzmk
 vdvkuXYCNeLSwC0zz4kHrZFTUoWXisMwWN0tCMWUmGjSKcFxDOQJ41DCSQe3O1k/Gm+Wc4p/g
 vcVTmS5CY9z0osU6Xtn92Txm16kjmTs8FJHNT0dIIqzveaFoNpv4RECHOtwGPVefDqMVCuPsV
 b5QoZtlG7uW7cfbkspsuA9U6Ot7G+ymM67CAY3S6TLuL0SVH0Dt7FOsiVMY6rjBRpZtgtkTb2
 nmP6aS6DHSh3NczrpFKJclNWQenPpgmAR2kN5fgRcVSGYof/Q4Rf5CH4XYAqauES9S3D5MT9l
 tDq35Uti0L/zzanZCdgCtVD0b57+3k+gDM1BrAvBDcztdNPMbjS8eCxkv9TvgQDusZgvxb0Dk
 iBMg0Umpk34v4kDRksI4fDifCuBE05kSCVfEMFxyLzsmMplmAcWZVO+vXJNM3Bjo4DfuaEny 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283421>

Hi Junio,

On Tue, 5 Jan 2016, Junio C Hamano wrote:

> If we want to follow the X_or_Y() pattern, fopen_or_create() may
> describe what it does better.  I do not have strong preference either
> way, but again I am not good at naming things (and I suspect you aren't
> either), so...

Heh... You got that right...

Let's let it simmer for a couple more days, maybe somebody else chimes in
with a brilliant idea... :-)

Ciao,
Dscho
