From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] do not loop around deref_tag()
Date: Tue, 14 Jun 2016 17:21:05 -0400
Message-ID: <20160614212105.GA21445@sigill.intra.peff.net>
References: <xmqqfusf8qh4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:21:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCvlq-0007wf-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbcFNVVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:21:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:54837 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932348AbcFNVVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:21:08 -0400
Received: (qmail 14189 invoked by uid 102); 14 Jun 2016 21:21:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:21:07 -0400
Received: (qmail 354 invoked by uid 107); 14 Jun 2016 21:21:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:21:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 17:21:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfusf8qh4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297331>

On Tue, Jun 14, 2016 at 01:28:39PM -0700, Junio C Hamano wrote:

> These callers appear to expect that deref_tag() is to peel one layer
> of a tag, but the function does not work that way; it has its own
> loop to unwrap tags until an object that is not a tag appears.

Looks obviously correct.

-Peff
