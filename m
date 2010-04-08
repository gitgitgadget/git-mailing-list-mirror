From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Thu, 8 Apr 2010 02:47:28 -0400
Message-ID: <20100408064728.GA12941@coredump.intra.peff.net>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
 <20100408044552.GA30473@coredump.intra.peff.net>
 <l2xbe6fef0d1004072307ma8dff5c2ic5dce170b28e5957@mail.gmail.com>
 <20100408063422.GD30473@coredump.intra.peff.net>
 <7vsk7678av.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:47:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlWr-0008GY-B1
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758278Ab0DHGrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:47:49 -0400
Received: from peff.net ([208.65.91.99]:56626 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756299Ab0DHGrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:47:48 -0400
Received: (qmail 16858 invoked by uid 107); 8 Apr 2010 06:47:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 02:47:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 02:47:28 -0400
Content-Disposition: inline
In-Reply-To: <7vsk7678av.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144329>

On Wed, Apr 07, 2010 at 11:44:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Fetch's message is equally hard to trigger, I think, which is perhaps
> > why nobody has complained about it yet.
> 
> See http://thread.gmane.org/gmane.comp.version-control.git/143229/focus=143404
> 
> ;-)

Fair enough. :)

If people are seeing it (both the new one and the old one), perhaps we
should lose the easter egg and just change it to "no default remote
defined" or somesuch. Boring, I know, but probably more helpful.

-Peff
