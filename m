From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Tue, 26 Apr 2016 12:57:26 -0400
Message-ID: <20160426165726.GA6572@sigill.intra.peff.net>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
 <20160425170326.GA1551@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604261733410.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:57:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av6Io-0000sa-7x
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbcDZQ5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 12:57:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:56615 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752082AbcDZQ53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 12:57:29 -0400
Received: (qmail 3728 invoked by uid 102); 26 Apr 2016 16:57:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 12:57:28 -0400
Received: (qmail 15783 invoked by uid 107); 26 Apr 2016 16:57:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 12:57:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2016 12:57:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604261733410.2896@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292617>

On Tue, Apr 26, 2016 at 05:37:32PM +0200, Johannes Schindelin wrote:

> > I think that's really the only sane way to do it because of curl's
> > interfaces. But maybe it is worth a comment either here, or along with
> > http_get_default_headers(), or both.
> 
> I chose to rename it to http_copy_default_headers(); That should make it
> easier to understand.

Thanks, I think that makes it clearer.

-Peff
