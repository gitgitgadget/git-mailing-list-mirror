From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Mon, 9 May 2016 17:11:44 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605091710310.4092@virtualbox>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de> <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de> <20160509080315.GA14383@sigill.intra.peff.net>
 <alpine.DEB.2.20.1605091557050.4092@virtualbox> <20160509142711.GA9552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 17:12:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azmqr-00074l-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 17:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbcEIPMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 11:12:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:59449 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbcEIPMA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 11:12:00 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M4nM5-1bphfz16ib-00yzRR; Mon, 09 May 2016 17:11:46
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160509142711.GA9552@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:QplEMi6iY7GP/hgZT/mvBEklvsPMk5nu01cfZgfUce6prB52qT+
 2N/Z2vWKQBdTEnqEBH5rxTYr36/GC54b1MHHaFUGXppQHBujjZ0V/AbgUcbSINRcc7rSby3
 DTcS+zZXGyYt3wIJ8vQhD2Ro3ub08XGTFJfYaumwUKimjvmR/3rmIUks8UcIuWcVkiIY2F0
 NHykjyg8XdoHAvVd/ZoXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4w/W7TOYSmg=:n7SVBa3CS0MEQyh/FaM31F
 dqsRcFDF3lckRKhNNyNM8+ttDet3nrFiWwMsfouvEZnKsXjZMVgM3ga3WXEGphs4QCMlTyWrj
 wnt/7L6ItnE6Q1cnVRmPFIK/JEqvOby12lQQ2qOymNglHgwXwbyMCzNE53xi93SLFrAZ+dtM4
 leLb0RSM/1C7BTsDPMuQpPlr1c6s0UmI1uOTWLnqYaMY4an8BdqLzsBFrlpXU7AwKPJGjtM/6
 v118xAFXk9W7FeDMJhvGOtJxtms1uJAdmIaTEGA+vsfLVGQh3+m3Qg8RLh8Dkb5efwkwq00vv
 /8bBnO+F1vZ+vZ47nnEXffPMcllTYhPDfITpFAUrqlGg3pdCM9Vpm0qmKYWjlbxPQUGr373Pn
 eOr9Xxh14e18JD+vc8qQ+chitfJGA7DR90vYqyNdTft2vyf4OEZgWOj/ihbA/BAPNcdyKsrRh
 k60ot6vcr9+1/yVb1awVw+J/B/rWq6drVr9rsnPDXWT0qM+fREcabvi7qjS+ShFXcSl6xI/uj
 AcR3sKuFDOd3imQ0/p1Kec4Qv6VTHCoYSmAzh0UCtRHE1ZorFBuw6Ab12x0VpYR94HMsSfvAE
 e/VfILBD8A62L+k/qEF/7nquNpq7525IrfKfuwPY/uz/nEPrO/0CGZ3DB4uBNi7E+Dfg5hx+F
 OSczA5WIFotq2gudLAvpNII+Sjms/VxANtT+3d8pP3CijoPyNsEg8gKdUj/SzQKtwRsyhvpqx
 TnSPivXTyy8uQFrvJK/GWH8pHpvJPXYA5MyN2nLaXMsuCamMX25PQJVdpYWjKOkdqA2WqQ// 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294000>

Hi Peff,

On Mon, 9 May 2016, Jeff King wrote:

> On Mon, May 09, 2016 at 04:03:48PM +0200, Johannes Schindelin wrote:
> 
> > How about this:
> > 
> > 	As RewriteCond does not allow testing for *non*-matches, we simply
> > 	match the desired case first and let it pass by marking the
> > 	RewriteRule as '[L]' ("last rule, do not process any other
> > 	matching RewriteRules after this"), and then have another
> > 	RewriteRule that matches all other cases and lets them fail via
> > 	'[F]' ("fail").
> > 
> > Good enough?
> 
> Yep, I think that explains it. Thanks.

Okay, I already force-pushed my extra-http-header branch and the next
iteration will sport this paragraph.

Hopefully your patch to remove the -c ... sanitizing makes it to `master`
soon, then I can submit my next iteration.

Ciao,
Dscho
