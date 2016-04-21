From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 0/2] add a add.patch config variable
Date: Thu, 21 Apr 2016 17:39:52 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604211737170.2826@virtualbox>
References: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com> <CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com> <cover.1459946531.git.d.f.fischer@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: XZS <d.f.fischer@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 17:40:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atGi7-0007tY-LF
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 17:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbcDUPkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 11:40:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:53572 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbcDUPkA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 11:40:00 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M6Ana-1bdnr42RUw-00yABf; Thu, 21 Apr 2016 17:39:56
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1459946531.git.d.f.fischer@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:v+SfMKFZ0edBNAdzyDTaN+5jf9vM3H/9k/WPFB4CoGo0SuDHIhX
 HVMizjs8ZuqPc6zJvZNpodO0Tcb4KK06P0qXZXVmTtrcfM/b/z8ku97xJ2mEzMmBaAKWRlj
 r+Yk2DOWir62nIaxgwqdk1CIOEwBj15TvSOajaGvgYlZ+LHgUyddfncQICBQA0qoGbSNzXG
 IiqBxHtstwpnRYGVhowYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g9gkNU17gww=:Uidkyd1usHXCtcVwaq32Ks
 yyNMH72rz3mPNEu0TIzFLMgCTQoh33OKXGoH4qCSfME96/mdPz3ysl8bOac1NSDsRSMFC+W1D
 5hzLEC6IxqWCB36UrwlBrjqxfHbFbZTb4TorKVf9PUNd6HfQ53f3UHgy9rJ8fqM8VpxoR9p2V
 xr2xjAUzy4Rg8U4sMST5AFL9M+DiJ3nUH52Vh6U5Jrrrkdf3ZOqhQkXnIrcqMCgQ9PVLZD394
 OQDA0g/TH4dGos+w4MMBV8bal4R5qBRTEtlXzLLw7VnyBzNqFqmTJs7N7wb/Tbm0usxnzKcZQ
 n9Jby7pShHEe7eszEMb4IMSv64puDMnh/SCU/GOa/yBOxdMqBPgbzksiMaY1aQews68DPKR/p
 QhYI0T9RTeVpf4tuW8yMiyqgjB07OwoByNzfScCEQ/l4khWZ8x/ez7wc6xRyVOdZ97eCkrWln
 33AxF9nye6Se8onflcSTwHfx83jCQ1+c24X/U6Jt/8ptxkknBAAL5ZFWJfpuXxjSCvksFCzoT
 L9MioXtOeYDLcBdJS6ghYJFhpS95sSiv8TLLKX4Zu8Jwz+A974Qm6fjIUgAZcu3OKJCQJAlN9
 19iLrD/JKXuuq3rI2XDeLKo0H5VIVwLQuVnte32liQR4pdpmUs33liSETEok1/YJlyz/a2BQz
 j8E8ev5zvzVO37Wp/e7231Pesyvajjs9Dg+k33+4iszNcvrch1GH5RBHIAbuTRXYfXYxi0KyO
 U/537tkFy/+bjz7SJjgOp1yJ7trifh3vWYOvH3VdaYmhhcPyx4Xo50m5m3SZyWKS1SWlA8YX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292115>

Hi Dominik,

On Thu, 21 Apr 2016, XZS wrote:

> The following patches try to provide an add.patch configuration variable
> while keeping out of the way of other commands. To do so, an environment
> variable counts how often git was recursively invoked. The variable is
> then only considered in the first recursion.

This dives right into the "how". Maybe a good idea would be to start with
a paragraph that explains the "what" and the "why" first, and only then go
into the details how you implemented it, what other options you considered
and why you preferred your solution?

Even after skimming the patch series, I am still a bit puzzled what issue
it solves...

Ciao,
Johannes
