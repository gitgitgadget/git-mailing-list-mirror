From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv5] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 16:02:08 -0500
Message-ID: <20150202210208.GA31675@peff.net>
References: <E05CAD49-755C-4F26-A527-597B1AD412D8@jonathonmah.com>
 <20150202202733.GB28915@peff.net>
 <xmqq7fw0t4x8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <me@jonathonmah.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 22:02:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIO8P-0004kJ-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 22:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933638AbbBBVCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 16:02:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:44271 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933562AbbBBVCL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 16:02:11 -0500
Received: (qmail 19098 invoked by uid 102); 2 Feb 2015 21:02:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 15:02:11 -0600
Received: (qmail 2985 invoked by uid 107); 2 Feb 2015 21:02:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 16:02:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 16:02:08 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7fw0t4x8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263290>

On Mon, Feb 02, 2015 at 12:49:23PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I actually do not see how the situation would come up in practice,
> > and possibly we could drop the iteration of the alternates' loose
> > objects entirely from this code. But certainly that is orthogonal to
> > Jonathon's fix (which is a true regression for the less-exotic case that
> > his test demonstrates).
> 
> Sure.
> 
> This needs to go to both 'maint' and 'master', right?

Yes (on the jk/prune-mtime topic).

-Peff
