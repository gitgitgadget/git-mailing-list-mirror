From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: clean error message for --continue after
 failed exec
Date: Wed, 24 Aug 2011 16:20:27 -0400
Message-ID: <20110824202027.GA28900@sigill.intra.peff.net>
References: <vpqk4a3rkwb.fsf@bauges.imag.fr>
 <1314194508-12067-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v62lmps6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 22:20:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwJwA-0005NL-Qv
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 22:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab1HXUUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 16:20:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55847
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117Ab1HXUU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 16:20:29 -0400
Received: (qmail 5965 invoked by uid 107); 24 Aug 2011 20:21:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Aug 2011 16:21:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2011 16:20:27 -0400
Content-Disposition: inline
In-Reply-To: <7v62lmps6k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180034>

On Wed, Aug 24, 2011 at 11:42:27AM -0700, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> 
> > If after a failed "exec" instruction there are staged changes,...
> 
> I have to wonder why whatever "exec" runs is mucking with the index in the
> first place. Shouldn't we forbid it?

Certainly my only user has ever been "exec make test". But I wonder if
somebody is crazy enough to auto-generate some content and commit it.
OTOH, shouldn't it then be their responsibility to make the commit?
I.e., I can see at least the potential for mucking with the index, but I
really don't see a reason for _leaving_ the index in a mucked state.

-Peff
