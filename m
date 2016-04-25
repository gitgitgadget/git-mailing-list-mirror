From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 13:07:48 -0400
Message-ID: <20160425170748.GB1551@sigill.intra.peff.net>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
 <20160423033922.GA15994@sigill.intra.peff.net>
 <B674CC4C-5506-4E5C-B638-45E0FAD50842@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujzI-0007Wo-I8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933190AbcDYRHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:07:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:55846 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933111AbcDYRHw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:07:52 -0400
Received: (qmail 28148 invoked by uid 102); 25 Apr 2016 17:07:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 13:07:51 -0400
Received: (qmail 3182 invoked by uid 107); 25 Apr 2016 17:07:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 13:07:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2016 13:07:48 -0400
Content-Disposition: inline
In-Reply-To: <B674CC4C-5506-4E5C-B638-45E0FAD50842@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292526>

On Mon, Apr 25, 2016 at 10:35:24AM +0200, Lars Schneider wrote:

> > This does slow down the normal test results for linux/gcc, though. I
> > don't know very much about Travis, but is it possible to break out the
> > documentation build into its own test, with a separate build status from
> > the other runs?
> 
> Great idea. This is how it looks.
> 
> All jobs of a run:
> https://travis-ci.org/larsxschneider/git/builds/125506781
> 
> The documentation job:
> https://travis-ci.org/larsxschneider/git/jobs/125506786

Very cool. Thanks!

-Peff
