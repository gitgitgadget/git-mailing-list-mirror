From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] stop putting argv[0] dirname at front of PATH
Date: Wed, 22 Apr 2015 14:36:12 -0400
Message-ID: <20150422183612.GD3535@peff.net>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
 <xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
 <CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
 <20150416061732.GA5612@peff.net>
 <xmqq1tjcf432.fsf@gitster.dls.corp.google.com>
 <20150422181402.GB3535@peff.net>
 <CAPig+cR1aAk053Lptq-vpsKtVP2nt9RF9YJxhNSicshEk7Ps7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David =?utf-8?Q?Rodr=C3=ADguez?= <deivid.rodriguez@gmail.com>,
	Matthew Rothenberg <mroth@khanacademy.org>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 20:36:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkzVT-0003zl-4y
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 20:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbbDVSgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 14:36:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:48706 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751072AbbDVSgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 14:36:14 -0400
Received: (qmail 6376 invoked by uid 102); 22 Apr 2015 18:36:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 13:36:14 -0500
Received: (qmail 12602 invoked by uid 107); 22 Apr 2015 18:36:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:36:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 14:36:12 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cR1aAk053Lptq-vpsKtVP2nt9RF9YJxhNSicshEk7Ps7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267609>

On Wed, Apr 22, 2015 at 02:23:27PM -0400, Eric Sunshine wrote:

> On Wed, Apr 22, 2015 at 2:14 PM, Jeff King <peff@peff.net> wrote:
> > Subject: stop putting argv[0] dirname at front of PATH
> >
> > When the "git" wrapper is invoked, we prepend the baked-in
> > exec-path to our PATH, so that any sub-processes we exec
> > will all find the git-foo commands that match the wrapper
> > version.
> > [...]
> > Given that the main motivation for git pulling the argv[0]
> 
> s/pulling/putting/

Heh. Too much git for me, I think.

-Peff
