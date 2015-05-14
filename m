From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Thu, 14 May 2015 00:29:47 -0400
Message-ID: <20150514042947.GB9351@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
 <xmqqzj59aw4c.fsf@gitster.dls.corp.google.com>
 <20150513053706.GA7783@peff.net>
 <b7b8419e6210f7d3eeb748dc31809d86@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 06:29:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YskmT-0001g1-B5
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 06:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbbENE3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 00:29:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:58405 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750713AbbENE3u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 00:29:50 -0400
Received: (qmail 7402 invoked by uid 102); 14 May 2015 04:29:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 23:29:50 -0500
Received: (qmail 19674 invoked by uid 107); 14 May 2015 04:29:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 00:29:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 00:29:47 -0400
Content-Disposition: inline
In-Reply-To: <b7b8419e6210f7d3eeb748dc31809d86@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269023>

On Wed, May 13, 2015 at 09:43:54AM +0200, Johannes Schindelin wrote:

> I would like to believe that I am included in said group, because we
> recently switched to use AsciiDoctor in Git for Windows 2.x. In
> msysGit times, we could not even run AsciiDoc (and neither
> AsciiDoctor), instead we relied on Junio publishing the artifacts in
> the git-htmldocs repository.

Thanks, I didn't know that. I have a vague feeling that AsciiDoctor is
the future of AsciiDoc (certainly the AsciiDoctor folks feel that way),
so the more we can keep compatibility, the better. Knowing that you guys
are actively using it makes me feel even better about spending time on
it.

> By the way, we have two patches in our fork that are needed here to
> use Asciidoctor successfully:
> https://github.com/git-for-windows/git/compare/893292c41%5E...893292c41%5E2
> 
> I would like to put them on top of this patch series. Objections?

The first one looks like straight fixes. The second looks rather nasty,
and makes the AsciiDoc output worse. I don't have a better solution
offhand, though. :(

-Peff
