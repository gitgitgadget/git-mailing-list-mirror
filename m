From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9902: protect test from stray build artifacts
Date: Fri, 25 Jan 2013 17:06:41 -0500
Message-ID: <20130125220641.GB23626@sigill.intra.peff.net>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
 <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
 <20130125011349.GB27657@sigill.intra.peff.net>
 <7vvcal7vhg.fsf@alter.siamese.dyndns.org>
 <7vr4l97v3h.fsf@alter.siamese.dyndns.org>
 <20130125042326.GA31281@sigill.intra.peff.net>
 <7v1ud95cxb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:07:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyrQP-0006sG-L2
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 23:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab3AYWGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 17:06:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51087 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116Ab3AYWGn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 17:06:43 -0500
Received: (qmail 17034 invoked by uid 107); 25 Jan 2013 22:08:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Jan 2013 17:08:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Jan 2013 17:06:41 -0500
Content-Disposition: inline
In-Reply-To: <7v1ud95cxb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214590>

On Fri, Jan 25, 2013 at 10:34:56AM -0800, Junio C Hamano wrote:

> >> Not so quick, though.  The lower level "read from help -a" is only
> >> run once and its output kept in a two-level cache hierarchy; we need
> >> to reset both.
> >
> > Ugh, I didn't even think about that.
> >
> > I wonder if it would be simpler if the completion tests actually ran a
> > new bash for each test. That would be slower, but it somehow seems
> > cleaner.
> 
> I agree 100% with that.  Let's leave this fix as-is, at least as a
> tentative fix while "git check-ignore" graduates into the upcoming
> release, and let somebody who is interested work on an update to
> this test script to do so as an independent topic.

Sounds good to me. Thanks.

-Peff
