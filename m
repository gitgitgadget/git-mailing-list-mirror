From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Fri, 5 Feb 2016 06:22:40 -0500
Message-ID: <20160205112240.GA18581@sigill.intra.peff.net>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
 <56B483C0.6070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 12:22:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aReTO-0006uj-L4
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 12:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbcBELWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 06:22:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:38074 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750726AbcBELWm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 06:22:42 -0500
Received: (qmail 3821 invoked by uid 102); 5 Feb 2016 11:22:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 06:22:42 -0500
Received: (qmail 13259 invoked by uid 107); 5 Feb 2016 11:22:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 06:22:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2016 06:22:40 -0500
Content-Disposition: inline
In-Reply-To: <56B483C0.6070906@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285569>

On Fri, Feb 05, 2016 at 12:13:04PM +0100, Sebastian Schuberth wrote:

> On 2/5/2016 9:42, larsxschneider@gmail.com wrote:
> 
> >Teach 'git config' the '--sources' option to print the source
> >configuration file for every printed value.
> 
> Yay, not being able to see where a config setting originates from has
> bothered me in the past, too. So thanks for working on this.
> 
> However, the naming of the '--sources' option sounds a bit misleading to me.
> It has nothing to do with source code. So maybe better name it '--origin',
> or even more verbose '--show-origin' or '--show-filename'?

I think he inherited the "--sources" name from me. :) I agree it could
be better. I think "--show-filename" is not right as there are
non-filename cases.  Just "--origin" sounds funny to me, perhaps because
of git's normal use of the word "origin".

I like "--show-origin" the best of the ones suggested.

-Peff
