From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Tue, 15 Dec 2015 19:50:45 -0500
Message-ID: <20151216005045.GA31433@sigill.intra.peff.net>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
 <20151215233207.GA30294@sigill.intra.peff.net>
 <xmqqbn9rffo0.fsf@gitster.mtv.corp.google.com>
 <xmqq4mfjff9x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 01:50:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a90Iv-0006nn-GS
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965526AbbLPAut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:50:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:42765 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932608AbbLPAus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:50:48 -0500
Received: (qmail 25345 invoked by uid 102); 16 Dec 2015 00:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 18:50:48 -0600
Received: (qmail 22600 invoked by uid 107); 16 Dec 2015 00:50:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 19:50:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2015 19:50:45 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mfjff9x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282525>

On Tue, Dec 15, 2015 at 03:44:42PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > There already was strbuf_getline_crlf(), and I wanted a new name to
> > be conservative.
> 
> When I re-read the series, I realize that the existing one had
> exactly the same semantics as strbuf_gets(), so I think no risk
> would come from reusing that name.  Let me try redoing the series
> when I find time ;-)

Heh. I just made up that name, not realizing it existed. Looks like it
is fairly recent as part of builtin-am, which explains why I hadn't seen
it yet.

I agree it looks like it does what you want. Upon reading your first
message I thought "eh, did I totally misunderstand the intent of the
series?", but it looks like we are on the same page. :)

-Peff
