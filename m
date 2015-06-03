From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] read_loose_refs(): treat NULL_SHA1 loose
 references as broken
Date: Wed, 3 Jun 2015 16:15:12 -0400
Message-ID: <20150603201511.GA31157@peff.net>
References: <cover.1433339279.git.mhagger@alum.mit.edu>
 <eb79f7d96ec74445f7adf62757119273280e09c9.1433339279.git.mhagger@alum.mit.edu>
 <20150603140803.GA23901@peff.net>
 <xmqqr3pswrpc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:16:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0F51-0000Gv-Jb
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 22:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbbFCUP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 16:15:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:40739 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756030AbbFCUPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 16:15:15 -0400
Received: (qmail 14805 invoked by uid 102); 3 Jun 2015 20:15:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 15:15:14 -0500
Received: (qmail 24778 invoked by uid 107); 3 Jun 2015 20:15:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 16:15:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 16:15:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3pswrpc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270734>

On Wed, Jun 03, 2015 at 11:51:43AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Jun 03, 2015 at 03:51:59PM +0200, Michael Haggerty wrote:
> >
> >> NULL_SHA1 is used to indicate of "invalid SHA-1" throughout our code
> >
> > s/of/an/ ?
> 
> Also possibly s/invalid SHA-1/invalid ref/?

I thought it was trying to express that we use the null sha1 as a
sentinel value throughout the code, no matter if the value came from a
ref or otherwise.

-Peff
