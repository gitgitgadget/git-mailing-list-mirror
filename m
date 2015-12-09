From: Jeff King <peff@peff.net>
Subject: Re: GPG public keys
Date: Wed, 9 Dec 2015 17:43:36 -0500
Message-ID: <20151209224335.GB32104@sigill.intra.peff.net>
References: <9E65FDC7-B4F6-45DC-9B0E-F017B904C868@pixelrebel.com>
 <xmqqtwnsie6h.fsf@gitster.mtv.corp.google.com>
 <3860CB92-AD83-4372-AE7C-BBA8BF2D8F67@pixelrebel.com>
 <20151209220413.GA21751@sigill.intra.peff.net>
 <CAGZ79kYk0RkwNj2aX6iixGjceKVYTy24os_Xb_wY8BWDZwY+Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jamie Evans <jamie@pixelrebel.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:43:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6nSZ-0001FB-HH
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 23:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbbLIWnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 17:43:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:39548 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753470AbbLIWni (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 17:43:38 -0500
Received: (qmail 4081 invoked by uid 102); 9 Dec 2015 22:43:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 16:43:38 -0600
Received: (qmail 14372 invoked by uid 107); 9 Dec 2015 22:43:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 17:43:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Dec 2015 17:43:36 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kYk0RkwNj2aX6iixGjceKVYTy24os_Xb_wY8BWDZwY+Fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282205>

On Wed, Dec 09, 2015 at 02:24:17PM -0800, Stefan Beller wrote:

> On Wed, Dec 9, 2015 at 2:04 PM, Jeff King <peff@peff.net> wrote:
> >
> > Of course you can't just fetch the v1.7.1.4 tag _now_, because the same
> > person impersonating the most recent tag could also be impersonating
> > (and back-dating) the older tags. But you could fetch it now, store it
> > somewhere trusted (e.g., on your laptop), and wait two weeks. If you
> > find no public outcry over hacked git, then it is probably OK to assume
> > that is the real key.
> >
> 
> With all of us pointing out 96AFE6CB being the right hash, you may or may not
> trust the list enough to also trust the key now.

Who's to assume that I actually checked that 96AFE6CB is right? ;)

Actually, I don't typically verify Junio's tag signatures. I fetch and
run "make" daily, far more often than he signs, so I would have been
p0wned long ago.

-Peff
