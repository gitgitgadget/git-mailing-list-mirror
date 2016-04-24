From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: include taggerdate in considering the best
 name
Date: Sun, 24 Apr 2016 08:35:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604240831470.2896@virtualbox>
References: <d58135a6720d6fda4c7bc609e77e2709d161fe25.1461332260.git.johannes.schindelin@gmx.de> <20160422181103.GA5920@sigill.intra.peff.net> <CA+55aFxLoi8RAYOZS8ziaGXkbTOdQ=YFbMA0EO0eFpNVgnugKA@mail.gmail.com>
 <xmqq60v9pduf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 08:41:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auDjI-0006xY-OR
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 08:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbcDXGgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 02:36:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:54208 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbcDXGgT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 02:36:19 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MgszY-1b7Mmh1emO-00M4La; Sun, 24 Apr 2016 08:35:55
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq60v9pduf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ZBsxK9GBkuGhkhbx0OH+qj3qvLxOQ4xqv5yW319pNvUaXQldxJk
 A5pQPLNUavgPocB8YmYw4xideJBGRzviLCpqjfgZCtVbcSWe2vuxV8A99lnX4pZcZl9OuwC
 QvESMNfN/tdoGFC0VfsjYP7bBFYPx3xKPwUFNavGKroJxOHKWAWb/UjU6BoUdsVlrBxSLqy
 E6aMtSjFplFBbPofY+MuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bg70RsGC90g=:bnUMKxf2ndSScF/y7AFdww
 GVte5wp3L3NZawJRHryXnO9ieDwSR57f+J+oYqAThZUL20G53ek+a1E1drcTtXRurVrH8t6bI
 rXheHawpe2Q8z7KHYn3pS8jAxGF7lo0Oc7gSVQCl0zQ5Hm18jF0JTa5Ep1yAcP6ORLDZ8nTHK
 11iocYNTykF0KqhGFgKdZLnxlciymgMvS7miRWURr5VgjZequuHj3hPi0F1nGvZAYp1RwNFMV
 fzA8petq6MV7aMz1fdxIfwvc40B9IBYg/QbbZ7bSVh1vjEErRoeroFuzOUqk1+T5jd028ZWsX
 DW8h9/VbPeSiyvgWrrT4di3AXCeNqsLkTNtL0AY4HFs+pewEQsTv9zhrREOnUmUAbGW691M9T
 CUUVMmdOi6O0/qRh/6r3GvOSiOKUvaV3Nxn0fx+IvDne6NQuoQitqOChtQNc8+ztZxMPAsVXM
 4wz0drWdrQUkB5tR6mTF23BNYvPmm9qIOf1ita9ZrYvJmJWUxoVxQc+kcOO2hJzUlD0jQdaVU
 gy372DklIQEadDF3xL/4pmEcLqcDuykQ/wOswGF/aJNFIZ8AIvQy1hFbJH3y2/s+zFw9kURqp
 6lR3TaXivq7trJ/OjY2VpzoNQfmsgYw0d01AHo1HrGYIHz1MB7hk9rPJjBX8Y46z1FzRJtVEz
 +R7IfPtY8osPHulEAWxsoFSejf8/VGY8Rcl1zxXuDRTmr8lj6+CCVyEDfdMR4WNG/ivmSQwdu
 +rGCtjtEoWrnznCZoigzYSqEkLFb40fq/RGzC1kGv82PsvMogKT8kEkzwCqeV1EPHnS4AS9V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292314>

Hi,

[fixing Uwe's email address, as the address bounces that was recorded in
the commit introducing the flawed behavior, and I failed to check mailmap
earlier.]

On Fri, 22 Apr 2016, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > ... I think this is still the simplest model we can use
> > without trying to really do a topo-sort. And in many ways it's the
> > simplest one to explain to people too: "we try to use the oldest
> > reference we can find as a base for the resulting name" is not a
> > complex or hard concept to explain.
> 
> Yes, the more I look at Dscho's patch, the more like it exactly for
> that reason.  Its behaviour is very simple from the end-user's point
> of view, unlike the historical one.

Well, seeing as I introduced the bug, it's only fair that I fix it, too.

Ciao,
Dscho
