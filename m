From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pager: drop "wait for output to run less" hack
Date: Tue, 5 Jun 2012 12:45:16 -0400
Message-ID: <20120605164516.GB2694@sigill.intra.peff.net>
References: <20120605085604.GA27298@sigill.intra.peff.net>
 <CABPQNSbhgan+i_Q142R8VvRdJ5T+GyYHqgEJ6KS-BBJguRu-OQ@mail.gmail.com>
 <20120605160157.GA20582@sigill.intra.peff.net>
 <7vlik1pvfv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:45:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbwsl-00005T-FZ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab2FEQpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:45:20 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43957
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463Ab2FEQpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:45:19 -0400
Received: (qmail 21558 invoked by uid 107); 5 Jun 2012 16:45:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 12:45:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 12:45:16 -0400
Content-Disposition: inline
In-Reply-To: <7vlik1pvfv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199262>

On Tue, Jun 05, 2012 at 09:36:36AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Given that the buggy less is apparently still in the wild, and that the
> > patch is a pure cleanup, I guess we should scrap it for now. <sigh>
> 
> Let's keep it on hold for six more months and then re-evaluate the
> situation, perhaps?

Sure. I'll carry it in my local tree for now.

-Peff
