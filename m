From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] config.mak.uname: support MSys2
Date: Wed, 13 Jan 2016 17:45:48 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601131745040.2964@virtualbox>
References: <cover.1452691805.git.johannes.schindelin@gmx.de> <e63d391a79396e095d2ebb139bb44c390e50bb62.1452691805.git.johannes.schindelin@gmx.de> <20160113161128.GA11898@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:46:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOYn-0000G8-Ae
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbcAMQqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:46:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:49319 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537AbcAMQqE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:46:04 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LjLwB-1Zl8zo1MPn-00dUXn; Wed, 13 Jan 2016 17:45:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160113161128.GA11898@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7UYYxqm59zikdtrXvTL5RbsLLfPYo9VhZHmAYIzsmXofDfIndH0
 2jgG7qr4TWqHmTR1p2/TvZ13rVvoNLsJNDg15r+tlI7J4RjhImiuPmk5IKLGD4h2BA2lpkS
 2bqsW8dBbIsHBHTB0ZZgstl1i+eqVT9AgvLXEGP5OMwO6eKvo1ZQVe5EgyGgqiqJz43BAiI
 jkjsxBroqAXq9uUTFS3Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/k0DHlabSxM=:1DEaOnIo0OHmKtb9FZXxEV
 2lUqwl3judjjLSkDi4MnB2iKH4rrBV/ypdJuASU37aUYURlRvUtSDoXIGbTnCqoFhs6+Cx4oV
 SBtVQHbDnnllqcguWWAVX+YxV3FKEW9S/pijxOpxK4gh6dATfA5Zn0LOfWMqfTTrNoZS37MXl
 vqKmJvAKK4Dqr1Eowsux2Gt6IO8tyDQphq0ZoUENc//SxE2AEyTamx9WVycfMz3UhbzoAiXwK
 u0p5ECQM5aiQeyFmTqCm9nKuY5J992eLHCvKLtRr8X5D7eeA2jGUj7jAdLF92y2Xr9uNcQ6jk
 kYzwTyzj6L5/0J9IcthLR4cFgEFFt87I+TrgVZXeT20Ym+OF7qxCMXpw41XY7iT/6WClKe3kl
 J53E6bRmguqKmgF67u1YK+QggnmEs1TwtQM4Ej7lKltcanns1E7T4li8VQkpVnc2Jd6nvC1ZD
 TpiC60ncC0wvZhoE3EN77GLDcf81m/DcAHWk0XOy0LvoJEmjwMnf1MUnSaIeTZVUOfY6KNC31
 ZJekTmDeRrD/qDKmq0wHMxPLUT7PEW7xko/FPHGsFmlzBvqoQ3ooPGMglEZ99Efpy3Lh7nW68
 EAbwgRbM5s/TrsiZhtA3dJOT2HvQitjOx9CewL2i/XfJ3SK3XFGtj6OUtfhdAjoaIf23I8jpI
 idEMIrLJ1nincmLqzsUYyAD9rwdio67JIq+4VRA83lRwejyyGvUO1phC8WAcNrqaSP4SH7sE3
 2cw2RVqmSsEkB4GHlMfh9IZ6BLnRBSyf4AaEkytQBPZnblMZQ6C6OZ9orE/E5QfJUL9igjyY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283931>

Hi Peff,

On Wed, 13 Jan 2016, Jeff King wrote:

> On Wed, Jan 13, 2016 at 02:30:53PM +0100, Johannes Schindelin wrote:
> 
> > For a long time, Git for Windows lagged behind Git's 2.x releases because
> > the Git for Windows developers wanted to let that big jump coincide with
> > a well-needed jump away from MSys to MSys2.
> > [...]
> 
> I can't say much about the patch itself, but I think this commit is
> worth it for the message alone. Now I finally know the subtle
> differences between all of those systems!

Thanks! I spent some quality time on reworking this particular commit
message this morning, so I am extra glad about your positive feedback!

Ciao,
Dscho
