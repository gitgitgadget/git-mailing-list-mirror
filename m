From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] minor fixes to some svn tests
Date: Fri, 13 May 2016 16:49:00 -0400
Message-ID: <20160513204900.GA15433@sigill.intra.peff.net>
References: <20160513194716.GA9806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 22:49:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1K1F-0002ZR-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbcEMUtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:49:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:39390 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751201AbcEMUtE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:49:04 -0400
Received: (qmail 16866 invoked by uid 102); 13 May 2016 20:49:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:49:03 -0400
Received: (qmail 21709 invoked by uid 107); 13 May 2016 20:49:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:49:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 16:49:00 -0400
Content-Disposition: inline
In-Reply-To: <20160513194716.GA9806@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294584>

On Fri, May 13, 2016 at 03:47:16PM -0400, Jeff King wrote:

> On Fri, May 13, 2016 at 02:23:25PM -0400, Jeff King wrote:
> 
> > This covers all cases detected by:
> > 
> >   git grep 'test -z [^"]'
> > 
> > (though note that has a few false positives for tests which
> > need an extra layer of quoting to do '\"').
> 
> I looked at those false positives, and they're really gratuitous uses
> of double-quotes that cause the extra layer of quoting.
> 
> So I set off to fix that, but along the way found an actual bug (in the
> final patch here), along with a few minor readability fixups.
> 
>   [1/3]: t/lib-git-svn: drop $remote_git_svn and $git_svn_id
>   [2/3]: t9100: enclose all test code in single-quotes
>   [3/3]: t9107: use "return 1" instead of "exit 1"

Note that I ended up rolling these into the series posted at:

  http://thread.gmane.org/gmane.comp.version-control.git/294539/focus=294577

Or <20160513204654.GA10684@sigill.intra.peff.net>, since I know Eric has
his own list archive. :)

-Peff
