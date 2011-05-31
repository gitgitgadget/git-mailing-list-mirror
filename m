From: Jeff King <peff@peff.net>
Subject: Re: speed of git reset -- file
Date: Tue, 31 May 2011 18:13:32 -0400
Message-ID: <20110531221332.GA15217@sigill.intra.peff.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7vpqmyilj6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:13:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRXBz-0006YM-Pn
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 00:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758465Ab1EaWNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 18:13:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45243
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194Ab1EaWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 18:13:34 -0400
Received: (qmail 1688 invoked by uid 107); 31 May 2011 22:13:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 May 2011 18:13:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2011 18:13:32 -0400
Content-Disposition: inline
In-Reply-To: <7vpqmyilj6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174834>

On Tue, May 31, 2011 at 02:54:05PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Conceptually, no, I don't think so.
> 
> Hmm, don't we have to say like all other reset types which paths are
> dirty, i.e.
> 
>   $ git reset HEAD -- diff.c
>   Unstaged changes after reset:
>   M       diff.c
>   M       diff.h
> 
> which would mean we would need to refresh the index anyway?

True, though if you pass "-q", we could bypass that step.

-Peff
