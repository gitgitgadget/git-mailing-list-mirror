From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] t5800: document some non-functional parts of remote
 helpers
Date: Wed, 8 Jun 2011 20:45:55 -0400
Message-ID: <20110609004555.GD19715@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
 <20110607172030.GC22111@sigill.intra.peff.net>
 <7vk4cv29oe.fsf@alter.siamese.dyndns.org>
 <20110609001150.GA19715@sigill.intra.peff.net>
 <7vzklrzvfb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUTNs-0005pN-6B
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 02:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab1FIAp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 20:45:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54237
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab1FIAp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 20:45:59 -0400
Received: (qmail 6204 invoked by uid 107); 9 Jun 2011 00:46:06 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 20:46:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 20:45:55 -0400
Content-Disposition: inline
In-Reply-To: <7vzklrzvfb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175481>

On Wed, Jun 08, 2011 at 05:43:20PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Jun 08, 2011 at 04:19:29PM -0700, Junio C Hamano wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > The third test demonstrates a bug in git's side of the
> >> > helper code when the upstream has added new refs without us.
> >> 
> >> without us knowing, you mean?
> >
> > I guess it depends what you mean by knowing. The bug is shown when the
> > remote has a ref that we don't; we try to feed the name of that ref to
> > fast-export, which of course doesn't work, because we don't have
> > anything by that name.
> >
> > So in that sense, no, we don't know about the ref. But it is not about
> > us knowing about the remote having the ref; the problem is that we _do_
> > know that the remote has that ref, and assume we have a matching one.
> 
> Ok, I think I understood what the sentence wanted to say ("the upstream
> added new refs. We do not have them yet", right?); it was just I found the
> phrase "... without us" didn't sit well there to my ears.

Fair enough. I think a better wording would be "...the upstream has refs
that we do not have locally", which is more accurate and more clear.

-Peff
