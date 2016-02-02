From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] apply, ls-files: simplify "-z" parsing
Date: Tue, 2 Feb 2016 00:29:41 -0500
Message-ID: <20160202052941.GB16983@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
 <20160131113546.GF5116@sigill.intra.peff.net>
 <xmqqzivkt86j.fsf@gitster.mtv.corp.google.com>
 <xmqqio28t55d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 06:30:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQTXu-0005AS-50
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 06:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbcBBF3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 00:29:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:35970 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750763AbcBBF3o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 00:29:44 -0500
Received: (qmail 25159 invoked by uid 102); 2 Feb 2016 05:29:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 00:29:43 -0500
Received: (qmail 9267 invoked by uid 107); 2 Feb 2016 05:29:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 00:29:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Feb 2016 00:29:41 -0500
Content-Disposition: inline
In-Reply-To: <xmqqio28t55d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285238>

On Mon, Feb 01, 2016 at 02:52:30PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Of course, a patch adding a "--nul" can be the one that does the
> > polarity flipping, so in that sense, this simplification is probably
> > OK, as long as there is some comment that warns a time-bomb you just
> > planted here ;-)
> 
> I'll queue it with this tweak for now.
> 
> The idea is to have them run "blame" to find the last paragraph of
> the commit log message.

That looks like a good compromise. Thanks.

-Peff
