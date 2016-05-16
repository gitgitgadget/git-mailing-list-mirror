From: Jeff King <peff@peff.net>
Subject: Re: git push --quiet option does not seem to work
Date: Sun, 15 May 2016 20:58:24 -0400
Message-ID: <20160516005824.GA1963@sigill.intra.peff.net>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
 <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
 <20160515212332.GB31809@sigill.intra.peff.net>
 <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris B <chris.blaszczynski@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 03:00:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b26tq-00075L-8t
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 03:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbcEPA7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 20:59:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:40021 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752153AbcEPA7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 20:59:00 -0400
Received: (qmail 22134 invoked by uid 102); 16 May 2016 00:58:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 May 2016 20:58:27 -0400
Received: (qmail 2517 invoked by uid 107); 16 May 2016 00:58:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 May 2016 20:58:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 May 2016 20:58:24 -0400
Content-Disposition: inline
In-Reply-To: <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294712>

On Sun, May 15, 2016 at 08:51:53PM -0400, Chris B wrote:

> I did not see in your example any commit. But if you say so.

I didn't show the commit step. But you can see that I made two identical
pushes, one quiet and one not, and the non-quiet one actually pushed
commits and showed the progress meter.

That doesn't help with your problem, though...

> I saw git init which would be a new repo.. don't know if it makes a difference.
> 
> It's pushing to HTTPS.

I repeated my test pushing over https, but it still seems to work as
expected with "-q".  So perhaps it is just Windows-specific, or perhaps
there's something else going on.

-Peff
