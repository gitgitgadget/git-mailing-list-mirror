From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] update-server-info: create info/* with mode 0666
Date: Tue, 6 Jan 2015 16:47:10 -0500
Message-ID: <20150106214710.GA457@peff.net>
References: <20150106034702.GA11503@peff.net>
 <20150106035048.GB20087@peff.net>
 <xmqqh9w3px0a.fsf@gitster.dls.corp.google.com>
 <20150106193950.GB28440@peff.net>
 <xmqqegr7oa9m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Sokolovsky <paul.sokolovsky@linaro.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 22:47:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8byA-0007eN-HH
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 22:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbbAFVrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 16:47:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:59708 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754201AbbAFVrN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 16:47:13 -0500
Received: (qmail 20466 invoked by uid 102); 6 Jan 2015 21:47:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jan 2015 15:47:12 -0600
Received: (qmail 13931 invoked by uid 107); 6 Jan 2015 21:47:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jan 2015 16:47:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jan 2015 16:47:10 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegr7oa9m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262103>

On Tue, Jan 06, 2015 at 01:43:33PM -0800, Junio C Hamano wrote:

> > That is definitely not what the series means to accomplish. I think
> > naming the test "info/refs respects umask in unshared repo" is probably
> > a better title for the test.
> 
> Thanks for sanity-checking me (I am still somewhat feverish and not
> performing at 100% level).  Here is what I have locally (but haven't
> got around to today's integration cycle yet) on top.

Yeah, that looks fine. Do you think we need an update to the explanation
in the commit message, or does it make sense in light of the
discussion we've had?

-Peff
