From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Mon, 21 Mar 2011 07:16:43 -0400
Message-ID: <20110321111643.GE16334@sigill.intra.peff.net>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
 <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
 <7vpqplv65o.fsf@alter.siamese.dyndns.org>
 <vpqlj09a303.fsf@bauges.imag.fr>
 <7vhbaxuyk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 12:16:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1d6R-0000Zo-PA
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 12:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab1CULQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 07:16:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44460
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649Ab1CULQp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 07:16:45 -0400
Received: (qmail 12229 invoked by uid 107); 21 Mar 2011 11:17:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 07:17:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 07:16:43 -0400
Content-Disposition: inline
In-Reply-To: <7vhbaxuyk7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169583>

On Sun, Mar 20, 2011 at 05:06:32PM -0700, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Unfortunately
> >> we do not have a good way to let people who have already heard
> >> about the transition to squelch it yet.
> >
> > How about an advice.addWithoutPath config variable to disable it?
> 
> I don't think it is worth it; I'd rather see :/ magic implemented earlier.
> 
> Another possibility is to error out on "git add -u" without pathspec in a
> subdirectory as an error in 1.8.0, and then make it full-tree in 1.8.X in
> a distant future, but that wouldn't be as pleasant.

I thought we cared about giving fans of the current behavior a way to
keep it (without having to use additional syntax). Script-writers
already need to use "./" to be portable to old versions of git, so it's
not hurting them (unless you want to count N years into the future, when
we can discount such old versions).

-Peff
