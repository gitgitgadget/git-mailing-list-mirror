From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] object: make add_object_array_with_mode a static function
Date: Mon, 20 Oct 2014 10:03:15 -0700
Message-ID: <20141020170314.GA20331@peff.net>
References: <5442F56B.8020205@ramsay1.demon.co.uk>
 <20141019020319.GB17908@peff.net>
 <xmqqa94qr9tn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 19:03:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgGMf-0003wV-4A
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 19:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbaJTRDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 13:03:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:60286 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751933AbaJTRDT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 13:03:19 -0400
Received: (qmail 31642 invoked by uid 102); 20 Oct 2014 17:03:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 12:03:18 -0500
Received: (qmail 13177 invoked by uid 107); 20 Oct 2014 17:03:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 13:03:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2014 10:03:15 -0700
Content-Disposition: inline
In-Reply-To: <xmqqa94qr9tn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 20, 2014 at 09:21:24AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think we can take your patch a step further, though, like:
> >
> > -- >8 --
> > Subject: [PATCH] drop add_object_array_with_mode
> > ...
> 
> Thanks.  I think I picked up all incrementals in this thread, but
> please holler if I missed anything.

I just checked it (using Thomas's excellent "tbdiff" tool) and you have
everything. Thanks, and sorry for feeding it so piecemeal. :)

-Peff
