From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] commit-queue: LIFO or priority queue of commits
Date: Mon, 10 Jun 2013 14:59:07 -0400
Message-ID: <20130610185907.GD2084@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-3-git-send-email-gitster@pobox.com>
 <20130610052500.GD3621@sigill.intra.peff.net>
 <7vwqq2l9cz.fsf@alter.siamese.dyndns.org>
 <20130610181557.GA2084@sigill.intra.peff.net>
 <7v1u89iyla.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um7JE-0004F4-BJ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab3FJS7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:59:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:47333 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129Ab3FJS7L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:59:11 -0400
Received: (qmail 25841 invoked by uid 102); 10 Jun 2013 19:00:02 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 14:00:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 14:59:07 -0400
Content-Disposition: inline
In-Reply-To: <7v1u89iyla.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227358>

On Mon, Jun 10, 2013 at 11:56:33AM -0700, Junio C Hamano wrote:

> > or similar. I didn't change the name, either. It may be silly to call it
> > "commit_queue" still since it is now more general. I simply called mine
> > "queue" (I wanted "pqueue", but that conflicted with globals defined by
> > OpenSSL; yours is a more general queue anyway, so maybe that is a good
> > name).
> 
> I agree that it makes sense not to call it either commit-queue or
> pqueue.  While at it, the filenames should probably be moved as
> well, no?

Yeah, definitely. I left all of that as an exercise for you, since the
name change will involve a lot of fallout in the other patches.

-Peff
