From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 04/14] Add new simplified git-remote-testgit
Date: Fri, 2 Nov 2012 10:00:17 -0400
Message-ID: <20121102140017.GA12040@sigill.intra.peff.net>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
 <1351821738-17526-5-git-send-email-felipe.contreras@gmail.com>
 <5093D0DD.3050801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:00:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUHnZ-0006TY-08
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 15:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933527Ab2KBOAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 10:00:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54491 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab2KBOAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 10:00:20 -0400
Received: (qmail 4773 invoked by uid 107); 2 Nov 2012 14:01:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 10:01:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 10:00:17 -0400
Content-Disposition: inline
In-Reply-To: <5093D0DD.3050801@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208935>

On Fri, Nov 02, 2012 at 02:55:41PM +0100, Stefano Lattarini wrote:

> > --- /dev/null
> > +++ b/git-remote-testgit
> > @@ -0,0 +1,62 @@
> > +#!/bin/bash
> >
> I think git can't assume the existence of bash unconditionally, neither
> in its scripts, nor in its tests (the exception being the tests on
> bash completion, of course).  This script probably need to be re-written
> to be a valid POSIX shell script.

No, we can't assume bash. But this is replacing a script written in
python, which we also can't assume. So if it were optional, and skipped
gracefully when bash was not available, that would be OK. Of course if
it could be done in portable bourne shell, that would be even better (I
haven't looked closely, but your comments all seem reasonable).

-Peff
