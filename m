From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 05/21] check-attr: there are only two possible line
 terminations
Date: Fri, 15 Jan 2016 16:23:00 -0500
Message-ID: <20160115212300.GB29698@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-6-git-send-email-gitster@pobox.com>
 <20160115191611.GB11301@sigill.intra.peff.net>
 <20160115193640.GA19291@sigill.intra.peff.net>
 <xmqq60yuh74w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 22:23:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKBps-00008Z-J5
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 22:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbcAOVXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 16:23:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:54713 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752950AbcAOVXC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 16:23:02 -0500
Received: (qmail 13401 invoked by uid 102); 15 Jan 2016 21:23:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 16:23:02 -0500
Received: (qmail 24372 invoked by uid 107); 15 Jan 2016 21:23:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 16:23:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 16:23:00 -0500
Content-Disposition: inline
In-Reply-To: <xmqq60yuh74w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284219>

On Fri, Jan 15, 2016 at 01:20:31PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Apparently we use this pattern in quite a few places (or they all copied
> > from each other). Here's a possible fixup that could go after your
> > series (it could go before, too, but it creates a lot of textual
> > conflicts with your stuff).
> 
> Sounds good, but I'm in favor of leaving this as an unrelated
> clean-up that happens to touch the same area.

Would you prefer me to hold it and send it later, after your series is
merged, or just rebase it on master, have it graduate separately, and
let you deal with the conflicts?

-Peff
