From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Mon, 18 Jan 2016 12:06:56 -0500
Message-ID: <20160118170655.GA24184@sigill.intra.peff.net>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
 <569CEA1C.90700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 18:07:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLDGl-0000C3-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 18:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908AbcARRHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 12:07:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:55486 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755618AbcARRHC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 12:07:02 -0500
Received: (qmail 20186 invoked by uid 102); 18 Jan 2016 17:07:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 12:07:01 -0500
Received: (qmail 11646 invoked by uid 107); 18 Jan 2016 17:07:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 12:07:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 12:06:56 -0500
Content-Disposition: inline
In-Reply-To: <569CEA1C.90700@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284300>

On Mon, Jan 18, 2016 at 02:35:24PM +0100, Michael J Gruber wrote:

> Junio C Hamano venit, vidit, dixit 12.01.2016 00:45:
> 
> > 
> > * mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
> >  - t/lib-git-svn: check same httpd module dirs as lib-httpd
> >  - t/lib-httpd: load mod_unixd
> > 
> >  This is the first two commits in a three-patch series $gmane/266962
> > 
> >  Becoming tired of waiting for a reroll.
> >  with updated log message ($gmane/268061).
> >  Will discard.
> 
> Oh, sorry. Work killing me plus I was waiting for help, too.
> 
> I don't care for these tests myself. I just noticed we're not really
> running them (resp. are running them locally only) due to the noted
> problems, i.e. default configs in which we fail to start the server.

FWIW, I took a look at them a few months ago, but I couldn't reproduce
the problems in the first place. I think it has to do with the default
apache setup given by my system (debian unstable) versus others.

-Peff
