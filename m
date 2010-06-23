From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Do not decode url protocol.
Date: Wed, 23 Jun 2010 13:38:59 -0400
Message-ID: <20100623173859.GA16938@coredump.intra.peff.net>
References: <4C211A39.2080207@obry.net>
 <7v4ogtfylw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pascal@obry.net, git list <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 19:39:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORTuo-0008Jc-MO
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 19:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab0FWRjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 13:39:04 -0400
Received: from peff.net ([208.65.91.99]:56203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab0FWRjD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 13:39:03 -0400
Received: (qmail 28603 invoked by uid 107); 23 Jun 2010 17:39:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 23 Jun 2010 13:39:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jun 2010 13:38:59 -0400
Content-Disposition: inline
In-Reply-To: <7v4ogtfylw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149523>

On Wed, Jun 23, 2010 at 10:27:39AM -0700, Junio C Hamano wrote:

> > When using the protocol git+ssh:// for example we do not want to
> > decode the '+' as a space. The url decoding must take place only
> > for the server name and parameters.
> >
> > This fixes a regression introduced in 9d2e942.
> 
> Sign-off?
> 
> As the patch was whitespace-broken, I'm proposing to rewrite it like the
> following.
> 
> -- >8 -- 
> url.c: "<scheme>://" part at the beginning should not be URL decoded

I think this is cleaner than Pascal's patch.

Acked-by: Jeff King <peff@peff.net>

Thanks all for fixing my bug. :)

-Peff
