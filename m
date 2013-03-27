From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Tue, 26 Mar 2013 21:04:29 -0400
Message-ID: <20130327010429.GB18405@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-3-git-send-email-gitster@pobox.com>
 <20130326185559.GB26462@sigill.intra.peff.net>
 <20130326203914.GA29167@sigill.intra.peff.net>
 <7v7gktubsp.fsf@alter.siamese.dyndns.org>
 <20130326212948.GA1340@sigill.intra.peff.net>
 <7vd2ulsse3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 02:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKenV-00043e-GU
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 02:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab3C0BEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 21:04:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40923 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab3C0BEd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 21:04:33 -0400
Received: (qmail 10008 invoked by uid 107); 27 Mar 2013 01:06:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 21:06:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 21:04:29 -0400
Content-Disposition: inline
In-Reply-To: <7vd2ulsse3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219230>

On Tue, Mar 26, 2013 at 03:33:40PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I think your series is the right direction, but we would want to
> > factor out the allocation code and use it from match_pathname, as well.
> 
> I am deep into today's integration cycle, so perhaps in the meantime
> you can help with a follow-up patch ;-)?

Your afternoon integration is my dinner-time. :)

I'll try to look at it tomorrow.

-Peff
