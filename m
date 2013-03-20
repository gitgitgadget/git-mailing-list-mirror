From: Jeff King <peff@peff.net>
Subject: Re: USE_NSEC bug?
Date: Wed, 20 Mar 2013 15:00:53 -0400
Message-ID: <20130320190053.GC30165@sigill.intra.peff.net>
References: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
 <20130320075344.GA8159@sigill.intra.peff.net>
 <7vppyuf1f5.fsf@alter.siamese.dyndns.org>
 <20130320170957.GA21350@sigill.intra.peff.net>
 <7v620mf05l.fsf@alter.siamese.dyndns.org>
 <CABFQKmONh2dQ+dkt3MsSXtFyKh5mnfK1fQVyw6Ez6aWajo=BDg@mail.gmail.com>
 <20130320183049.GB29609@sigill.intra.peff.net>
 <7vobedewer.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Rodland <andrew@cleverdomain.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:01:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOGN-0005f0-TF
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab3CTTBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:01:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60408 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab3CTTA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:00:59 -0400
Received: (qmail 11505 invoked by uid 107); 20 Mar 2013 19:02:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 15:02:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 15:00:53 -0400
Content-Disposition: inline
In-Reply-To: <7vobedewer.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218657>

On Wed, Mar 20, 2013 at 11:52:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I think your real complaint is "configure does not set NO_NSEC
> > properly", which is something worth fixing.
> 
> Yes.
> 
> I think our "Meh" was about "do we want to unify USE_NSEC and
> NO_NSEC?" and nothing else.

Exactly. Now I am hoping Andrew will volunteer to fix configure.ac, as I
will be happy to go to my grave never having had to figure out autoconf
m4 syntax ever again. :)

-Peff
