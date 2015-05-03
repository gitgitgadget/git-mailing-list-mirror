From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Sat, 2 May 2015 22:30:24 -0400
Message-ID: <20150503023024.GA4269@peff.net>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
 <1430519737-6224-1-git-send-email-sbeller@google.com>
 <20150501224334.GB1179@peff.net>
 <xmqqpp6iwgnn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 03 04:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yojfs-00023E-My
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 04:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbbECCa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 22:30:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:53425 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750955AbbECCa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 22:30:28 -0400
Received: (qmail 4428 invoked by uid 102); 3 May 2015 02:30:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 02 May 2015 21:30:27 -0500
Received: (qmail 10489 invoked by uid 107); 3 May 2015 02:30:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 02 May 2015 22:30:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 May 2015 22:30:24 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp6iwgnn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268253>

On Sat, May 02, 2015 at 07:15:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, May 01, 2015 at 03:35:37PM -0700, Stefan Beller wrote:
> >
> >> Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
> >
> > Looks like the patch has expanded beyond checkout-index.c. Maybe:
> >
> >   unconditionally free result of prefix_path
> >
> > would be more descriptive? I usually like the "area:" prefix, but I
> > think here the common thread is not an area, but that they are return
> > values from prefix_path.
> 
> Sure, the prefix could even be "prefix_path(): $message", I would
> think.

I almost suggested that, but it not a change to prefix_path at all, but
rather to its callers. That may be getting nit-picky, though. :)

-Peff
