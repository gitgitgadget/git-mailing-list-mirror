From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Tue, 12 Jun 2012 13:05:36 -0400
Message-ID: <20120612170536.GA12706@sigill.intra.peff.net>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
 <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
 <CABPQNSY=X8HG__vcEncdcgjT4fvqaC1gX_5_QH4n0+bX0tNT6g@mail.gmail.com>
 <7vsje0jyxh.fsf@alter.siamese.dyndns.org>
 <7vhaugjx9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kusmabite@gmail.com, vfr@lyx.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:06:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeUXl-0003Zv-56
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 19:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab2FLRFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 13:05:39 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51163
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab2FLRFj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 13:05:39 -0400
Received: (qmail 22253 invoked by uid 107); 12 Jun 2012 17:05:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 13:05:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 13:05:36 -0400
Content-Disposition: inline
In-Reply-To: <7vhaugjx9h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199813>

On Tue, Jun 12, 2012 at 09:44:10AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Erik Faye-Lund <kusmabite@gmail.com> writes:
> >
> >> Having an MSYS version of Perl in PATH is "broken" in the Windows
> >> world, so it's THIS Perl that people might want to keep out of their
> >> PATH.
> >
> > Fair enough.  After all, that is why we have $PERL_PATH that can be
> > used (and is used) in our Porcelain scripts.
> 
> Let's also apply something like this to t/README.
> [...]
>  t/README | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

Looks good to me.

-Peff
