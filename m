From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 18:09:35 -0400
Message-ID: <20160504220935.GA26339@sigill.intra.peff.net>
References: <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
 <xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
 <20160504192516.GD21259@sigill.intra.peff.net>
 <xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
 <20160504200635.GA22787@sigill.intra.peff.net>
 <xmqq8tzpfrt0.fsf@gitster.mtv.corp.google.com>
 <20160504213149.GA22828@sigill.intra.peff.net>
 <xmqq4madfqxs.fsf@gitster.mtv.corp.google.com>
 <20160504214412.GA25237@sigill.intra.peff.net>
 <xmqqk2j9ebj8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 00:09:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4zG-0002C7-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbcEDWJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 18:09:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:34298 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbcEDWJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:09:38 -0400
Received: (qmail 7715 invoked by uid 102); 4 May 2016 22:09:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 18:09:38 -0400
Received: (qmail 14725 invoked by uid 107); 4 May 2016 22:09:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 18:09:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 18:09:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2j9ebj8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293607>

On Wed, May 04, 2016 at 02:52:27PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This dependency feels funny. Wouldn't CI want to invoke this as:
> >
> >   make -C Documentation lint-docs
> 
> I expected CI to do this instead
> 
> 	make check-docs

Ah, sure, that makes even more sense. But I think the point remains,
which is that your perl script is an implementation detail of the
Makefile process. I thought the "ci" directory was supposed to be for
ci-specific scripts that would be driven directly by Travis, etc.

-Peff
