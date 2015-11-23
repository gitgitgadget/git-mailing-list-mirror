From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Mon, 23 Nov 2015 13:57:19 -0500
Message-ID: <20151123185718.GB2597@sigill.intra.peff.net>
References: <20151120140937.GA17079@sigill.intra.peff.net>
 <alpine.DEB.1.00.1511231407380.1686@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:57:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0wIm-0002dt-UZ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 19:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbbKWS5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 13:57:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:32923 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754136AbbKWS5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 13:57:21 -0500
Received: (qmail 18189 invoked by uid 102); 23 Nov 2015 18:57:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Nov 2015 12:57:21 -0600
Received: (qmail 4839 invoked by uid 107); 23 Nov 2015 18:57:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Nov 2015 13:57:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Nov 2015 13:57:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1511231407380.1686@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281590>

On Mon, Nov 23, 2015 at 02:09:42PM +0100, Johannes Schindelin wrote:

> On Fri, 20 Nov 2015, Jeff King wrote:
> 
> > * pt/http-socks-proxy (2015-11-20) 1 commit
> >   (merged to 'next' on 2015-11-20 at dc6ae48)
> >  + remote-http(s): support SOCKS proxies
> > 
> >  Add support for talking http/https over socks proxy.
> > 
> >  Will cook in 'next'.
> 
> With all due respect, I do not thing this needs more cooking, as it
> 
> 1. was tested extensively by yours truly in the Git for Windows context,
>    and it
> 
> 2. cannot possibly break anything because it tests specifically for the
>    "socks:" prefix. It is a pure new feature.

Any time I want to say "cannot possibly" I start to get very worried
that I have missed something. :)

I do think this topic looks OK, but it just made it into next during the
last integration cycle (it was waiting on Pat's signoff, which I
amended). I think it should be OK to cook in next for a few days and
then merge to master (i.e., plenty of time for v2.7).

Thanks (and thank you for extra feedback; especially because of the
maintainer switch I do not have full context on all of the topics).

-Peff
