From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Mon, 24 Jun 2013 13:00:57 -0400
Message-ID: <20130624170056.GA24251@sigill.intra.peff.net>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
 <1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
 <vpqsj07vb3m.fsf@anie.imag.fr>
 <7vfvw7bh0u.fsf@alter.siamese.dyndns.org>
 <vpqy59zsb0u.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, benoit.person@ensimag.fr,
	git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:01:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrA8a-00005q-8p
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab3FXRBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 13:01:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:39881 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab3FXRBC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:01:02 -0400
Received: (qmail 28802 invoked by uid 102); 24 Jun 2013 17:02:04 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Jun 2013 12:02:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jun 2013 13:00:57 -0400
Content-Disposition: inline
In-Reply-To: <vpqy59zsb0u.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228874>

On Mon, Jun 24, 2013 at 06:56:17PM +0200, Matthieu Moy wrote:

> > Good eyes.  But if we encourage people to run non-*.perl version,
> > perhaps we should drop the executable bit from the source, no?
> 
> But by default, I'd say consistency is most important so if other *.perl
> are executable, we should do the same (otherwise my "ls" shows different
> colors and it's ugly ;-) ).
> 
> But it may make sense to change the convention, i.e. run a "chmod -x
> *.perl" in Git's tree (in any case, people can still run "perl
> foo.perl").

You'd probably want to also change the shell scripts, too, which are
marked executable in the repo (but the source-able shell "libraries" are
not).

I don't remember the details, but I think there may be some magic with
the --valgrind test option that depends on the executable bit to
distinguish those two.

-Peff
