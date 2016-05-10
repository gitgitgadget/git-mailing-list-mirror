From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Tue, 10 May 2016 08:53:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605100832350.4092@virtualbox>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de> <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de> <20160509080315.GA14383@sigill.intra.peff.net>
 <alpine.DEB.2.20.1605091557050.4092@virtualbox> <20160509142711.GA9552@sigill.intra.peff.net> <alpine.DEB.2.20.1605091710310.4092@virtualbox> <xmqqwpn3w5c7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 08:53:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01Xt-0004fp-9O
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 08:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbcEJGxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 02:53:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:60151 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbcEJGxY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 02:53:24 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MO7ee-1awjkP1xDA-005VOQ; Tue, 10 May 2016 08:53:09
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqwpn3w5c7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:g10HKi1Y+wql37qLhzf0Fc2Ep1Vt3pyx9FT+rSoTyEzu/9+ajdW
 kVRR2fRDbKG/oa3pIky1Lv83JucA4nhs+rUrckId4CCfmo6JAAcOomvKneXTeYcSCebeG4H
 arQS4hq+g7XNGD07BVKfnSGYR9s1tZb/xnXM5b6JjfNSg1LKaYg19ifQreXcONfqK2f+1Sg
 2C+zmHOJ58WKbZ17P6UVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SXVMLkz58yU=:Y0QNDcybx8y6hmyTghOsZE
 qIE/3i2/zP8DCidRkPiEi1Os/YVwQUNQa0GijKnSKJhgL+oDJyzKIEv6mJBJaUnVf7GL8Zqz4
 SMwOm32ewnDoVHL5I4FtMnR5JTcLplgEDPLOlZx93tGKoH47zMSwbCmV7tlCTtKfgHoWhDv8A
 VGs6r+OwnY97hSFctypS/g7xtRSRdnrD5rneECxElX5RPR/aDUR4bgjVoaOjcuvWIqIhhybDV
 XS/jFsRUwFX4vaU+OjNdibEVSHNcPtHIEam8gycBXa4yITqStHwpDh6GxN0LtS5XmVdfuUYnO
 aPQA0juvlnwGMjqIBwsJBNkFciMurnHwYvW93xOVHJmnRrduT+X9mBG5zQPaHQVARxJlfKW4i
 ab2P84xV1IvKCDGevwAeOMf8GiifDjKMYUXJZTSiyRuIEcc834oalMyVr6+yC+9pWqUDoaq2/
 cGYIp/y74Ki9R1YD4QAwqLs7gXBU4U4+LzWhXrmIgLSpv2ZOnyW8JI+gQ1J3+qxwSJXN8XFEX
 UDZ6ROQ8FV0SATn/pf7fQ5Dc82eigi+kodET8aULgtj1F+SP3Hoysl5i8MVxogmZFVyFyuA4C
 JGlsT4dNKsXVb21pc+Dpw/vUIdZDVVhgod+0ojhJXFrFLD+/aRucti6tw9i67gwRHkrBzcm7C
 z+f0hc7tauP3OU/11n9ePmV3rG7jJz5cz1u6Jzl/xNQhehZPfIAGr07HXhdCi1tlpMeaOFYoh
 raUrRNr9BpftUdCQa6znfZUSWnuAG1kDLK5q+4UXfm1TV5OCY1Y5y5rP+z8KZ4vpMZ+JzLeY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294103>

Hi Junio,

On Mon, 9 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay, I already force-pushed my extra-http-header branch and the next
> > iteration will sport this paragraph.
> 
> The new explanation is well written and can and should also replace the
> comment before the implementation in the configuration file to help
> readers.

I picked your commit and force-pushed my branch; it will be part of the
next iteration.

> To be honest, I do not quite understand why you call it "ugly hack"
> at all.

Well, it is convoluted. I would have preferred to say "if this condition
is not met or that condition is not met, fail". Instead I had to say "If`
these two conditions are met, proceed as before. Otherwise, fail."

And of course its ugliness increased in my mind because I had to go
through so many iterations until it finally worked. Not really
straight-forward a solution.

> > Hopefully your patch to remove the -c ... sanitizing makes it to
> > `master` soon, then I can submit my next iteration.
> 
> Or we can just merge that "do not sanitize" branch in, and then queue
> the "next iteration" which I'd assume would only be the test addition?

I'll prepare something.

Ciao,
Dscho
