From: Jeff King <peff@peff.net>
Subject: Re: Topics currently in the Stalled category
Date: Tue, 27 Nov 2012 22:12:38 -0500
Message-ID: <20121128031238.GC27772@sigill.intra.peff.net>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
 <7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
 <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
 <CAMP44s30cbH5+HUxRBByk5sZGq=j_MdqLSnNzREozEk40_zbOw@mail.gmail.com>
 <20121128025928.GA27772@sigill.intra.peff.net>
 <CAMP44s3F4MPm-kLAW67rZG8oZg76CGS32h44LnK05UT11TOnSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:13:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdY52-0003vm-N7
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab2K1DMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:12:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58929 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400Ab2K1DMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:12:40 -0500
Received: (qmail 1710 invoked by uid 107); 28 Nov 2012 03:13:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 22:13:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 22:12:38 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s3F4MPm-kLAW67rZG8oZg76CGS32h44LnK05UT11TOnSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210683>

On Wed, Nov 28, 2012 at 04:10:07AM +0100, Felipe Contreras wrote:

> >> Why generate it? There's nothing to generate. python's source code
> >> needs regeneration, bash's code doesn't.
> >
> > We fix up the #!-lines on all of the existing shell scripts (as well as
> > python and perl). Wouldn't we want to do the same for people who have
> > bash in an alternate location?
> 
> '#!/usr/bin/env bash' should take care of people who have bash in an
> alternate location, no?

If that is where there env is. I do not recall offhand if that is a
problem for anyone. Still, I don't think it is that big a deal to treat
it like we do other scripts, and provide the usual boilerplate (which
also gets us NO_BASH if you have an old or broken bash and want to skip
the tests). I just sent a patch.

-Peff
