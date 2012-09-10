From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Mon, 10 Sep 2012 16:34:42 -0400
Message-ID: <20120910203442.GA968@sigill.intra.peff.net>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
 <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
 <20120910161325.GB9435@sigill.intra.peff.net>
 <7vvcflmxis.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:34:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAh3-0003ho-MC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401Ab2IJUeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:34:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40038 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152Ab2IJUep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:34:45 -0400
Received: (qmail 664 invoked by uid 107); 10 Sep 2012 20:35:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 16:35:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 16:34:42 -0400
Content-Disposition: inline
In-Reply-To: <7vvcflmxis.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205177>

On Mon, Sep 10, 2012 at 01:30:03PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If the proposal were instead to add a certain type of pathspec that is
> > case-insensitive[2], that would make much more sense to me. It is not
> > violating git's case-sensitivity because it is purely a _query_ issue.
> > And it is a feature you might use whether or not your filesystem is case
> > sensitive.
> > ...
> > [2] I did not keep up with Duy's work on pathspec magic-prefixes (and I
> >     could not find anything relevant in the code or documentation), but
> >     it seems like this would be a logical feature to support there.
> 
> I think it mostly is in setup.c (look for "Magic pathspec").

Thanks, that helped. I got excited when I saw the "icase" in the
comments and thought it might already be implemented. But it looks like
it is still to be done. :)

-Peff
