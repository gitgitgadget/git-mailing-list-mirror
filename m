From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] basic priority queue implementation
Date: Fri, 20 May 2011 09:23:44 -0400
Message-ID: <20110520132344.GA30616@sigill.intra.peff.net>
References: <20110519212349.GA28589@sigill.intra.peff.net>
 <20110519212448.GB29584@sigill.intra.peff.net>
 <BANLkTikLSwWanxUksf3Ezx7uhaTR4mMiWw@mail.gmail.com>
 <20110520073821.GA3663@sigill.intra.peff.net>
 <BANLkTinojbxq=y3f-GPJsL7OH2OAJfW6zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 15:24:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNPgN-0005jq-8o
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 15:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933658Ab1ETNXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 09:23:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40409
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933647Ab1ETNXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 09:23:47 -0400
Received: (qmail 29200 invoked by uid 107); 20 May 2011 13:25:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 May 2011 09:25:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 May 2011 09:23:44 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinojbxq=y3f-GPJsL7OH2OAJfW6zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174060>

On Fri, May 20, 2011 at 10:13:10AM -0300, Thiago Farina wrote:

> > Speaking of naming, though, the real problem is that this data structure
> > should be called "pqueue" or something similar to indicate that it is
> > not a simple FIFO. Unfortunately, the short-and-sweet "pqueue" is taken
> > by openssl, which pollutes all over the global namespace.
> >
> Hum, yeah when I read the commit message I though about the name of
> the structure, but I didn't want to bother you with that. Probably you
> have considered the option of naming it 'priority_queue' too. Haven't
> you chose priority_queue, because you consider the name longer than
> necessary?

Exactly. Though unless somebody can come up with a practical case where
using the priority queue speeds up some operation, I don't think it is
worth applying anyway. So the naming question is somewhat academic. :)

-Peff
