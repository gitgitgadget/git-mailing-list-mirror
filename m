From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 4 Feb 2016 14:13:47 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602041411520.2964@virtualbox>
References: <cover.1454587284.git.johannes.schindelin@gmx.de> <20160204121437.GF29880@serenity.lan> <alpine.DEB.2.20.1602041334450.2964@virtualbox> <20160204130111.GG29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elia Pinto <gitter.spiros@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Feb 04 14:14:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRJja-0004D4-TX
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 14:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965904AbcBDNOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 08:14:02 -0500
Received: from mout.gmx.net ([212.227.17.20]:58645 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965900AbcBDNOA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 08:14:00 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LnUna-1Zqbnm0liw-00hbGF; Thu, 04 Feb 2016 14:13:48
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160204130111.GG29880@serenity.lan>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:2yrN1mESv1NOlz/zCBvlwYdxWZqPSfMeXnmRGGh42rB/3zm36Nh
 E8q3fvjB4pDrmY3AKY5NbJfdN2RxvjTiqk0uOb7XpSj4oVpG7RJqU4YvNP3A+j7/e0AEW5Y
 um3a+6hglFe1MUPd+5wQ8NJlEUUqvdK+cl55c6NgEgRfi87IrxnPEOJuiMO6X4I/qp7jqZY
 40+IE2U5fTW0Wz5al/baQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Nau+gwj5lpg=:ckHSMsU40hJOBaIfBueB5p
 sPUbI/LYyNgZsZdvylUBqZrAZqc0xldwypX4sr0O1kFzGu3lN3tSw9JFdnDAwBroqGsSmE9SN
 3fRAxhF38tMz58uCCGYXnWdXFtfdu5vqt7cd1Xo4pH6fqbRDaiTku4ZgXfjGJ9DA+XGbpY15T
 +EMUx29slVUYqt2Eh+PVFMXKkiyMuCq8u3Ttd2gtPgcQ2gYdfAH7ThP5/WKcv16Z8gO0+niy5
 mrfkc8G79y1QTg9DFTbjqSsP+ZHorrqlj89cywuE7G+7x26oCFnFJUzq90yT65h5N/uJKiUmr
 1da2+LNW+C1Wue512eRxH+nIDNaN5if9ujS1Xx/e+dJrPZLRZIz8v3K25IEu1D8OvW3IoL9X+
 vrPBQ51kd/PLjKG/wfAgunq7jFb1H/bbsZTGyAh2mp98HOHRYJbtync0vW+1Gkj98sZTf8tdO
 IT5NRP7vGcCyAeRUqzkRVrYa7lLNvhEN8spAhy8CpDJjrkUvTBpREZ3mY5i0bz8eSRxU1IfdM
 dwIjiYiiWPAPYXKUrYmRmVZiFnIyil3lk2ELs/SJFQCtSTlXolLPYrCTT4zsFY4YzA4F3jgiX
 ZziR0DAQMJKe0b110a0xLBGhgpUu02JpEizgJXCbHGBhpMoGevK7KUsOKeQFRkse3+tMKRqV0
 bFy5OvyVH+u+Tgqb+FbubLlS+xKxFVJFFK8JHPF0OHl8vZupBqkpuaa2/pPOPU6Rth9ogew1n
 gL+Glc5fDivHxFrRVojwaFoOjXsPLpRXCjwd8QLAhPoESuQzupjvqLeY+xkTTPk1slGs9CeF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285462>

Hi John,

On Thu, 4 Feb 2016, John Keeping wrote:

> Although I don't think the historic context is useful in deciding which
> direction to go in the future.

Being a maintainer, I find that argument particularly hard to defend.

But sure, you go ahead and prepare a patch series that turns everything
around, adding spaces around those operators.

Whatever the outcome, the inconsistency must be fixed. I just submitted my
proposed solution.

Ciao,
Johannes
