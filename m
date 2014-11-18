From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: hack around CGI's list-context param() handling
Date: Tue, 18 Nov 2014 13:01:35 -0500
Message-ID: <20141118180135.GA12461@peff.net>
References: <20141118171022.GA18799@peff.net>
 <xmqqfvdgwful.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:01:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqn5z-0007Ky-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbaKRSBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 13:01:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:41805 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753627AbaKRSBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:01:37 -0500
Received: (qmail 22567 invoked by uid 102); 18 Nov 2014 18:01:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 12:01:37 -0600
Received: (qmail 18528 invoked by uid 107); 18 Nov 2014 18:01:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 13:01:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 13:01:35 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfvdgwful.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 09:58:26AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As of CGI.pm's 4.08 release, the behavior to call
> > CGI::param() in a list context is deprecated (because it can
> > be potentially unsafe if called inside a hash constructor).
> > This cause gitweb to issue a warning for some of our code,

Oops, s/cause/causes/ of course.

-Peff
