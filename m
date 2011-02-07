From: Jeff King <peff@peff.net>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 7 Feb 2011 00:53:14 -0500
Message-ID: <20110207055314.GA5511@sigill.intra.peff.net>
References: <4D4DEDC4.4080708@hartwork.org>
 <20110206051333.GA3458@sigill.intra.peff.net>
 <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 06:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmK2M-00024O-MY
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 06:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab1BGFxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 00:53:18 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60822 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab1BGFxR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 00:53:17 -0500
Received: (qmail 25461 invoked by uid 111); 7 Feb 2011 05:53:16 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 05:53:16 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 00:53:14 -0500
Content-Disposition: inline
In-Reply-To: <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166232>

On Sun, Feb 06, 2011 at 09:50:37PM -0800, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Sebastian Pipping <webmaster@hartwork.org> writes:
> >
> >> I was and I can confirm the different behaviour with 1.7.4 over here: it
> >> does work on the root directory of the repo as you supposed.
> >
> > What do you mean by "it does not work"?
> >
> > "git add -u" adds files under the current directory, and it always
> > did.
> 
> As it takes pathspecs (think "git add -u this-file"), it fundamentally
> shouldn't be tree-wide.  I think the original implementation didn't take
> pathspecs and was mistakenly done as tree-wide operation, but I think it
> was fixed rather quickly.

Is "git add -p" broken, then? It takes pathspecs relative to the current
directory, but "git add -p" without arguments operates from the root,
not from the current subdirectory.

-Peff
