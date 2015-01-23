From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: what does "git log --indexed-objects"
 even mean?
Date: Fri, 23 Jan 2015 14:52:53 -0500
Message-ID: <20150123195253.GA6935@peff.net>
References: <xmqqd265qnv2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 20:53:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkHs-0002Eh-J9
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 20:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526AbbAWTw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 14:52:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:38040 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752294AbbAWTw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 14:52:56 -0500
Received: (qmail 26240 invoked by uid 102); 23 Jan 2015 19:52:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 13:52:56 -0600
Received: (qmail 23449 invoked by uid 107); 23 Jan 2015 19:53:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 14:53:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2015 14:52:53 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd265qnv2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262952>

On Fri, Jan 23, 2015 at 11:49:05AM -0800, Junio C Hamano wrote:

> 4fe10219 (rev-list: add --indexed-objects option, 2014-10-16) adds
> "--indexed-objects" option to "rev-list", and it is only useful in
> the context of "git rev-list" and not "git log".  There are other
> object traversal options that do not make sense for "git log" that
> are shown in the manual page.
> 
> Move the description of "--indexed-objects" to the object traversal
> section so that it sits together with its friends "--objects",
> "--objects-edge", etc. and then show them only in "git rev-list"
> documentation.

Yeah, that makes sense to me.

Acked-by: Jeff King <peff@peff.net>

-Peff
