From: Jeff King <peff@peff.net>
Subject: Re: git-latexdiff: Git and Latexdiff working together
Date: Tue, 14 Feb 2012 16:16:29 -0500
Message-ID: <20120214211629.GA23649@sigill.intra.peff.net>
References: <vpq7gzph7mi.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:16:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxPjq-0002D6-DT
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761222Ab2BNVQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 16:16:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35908
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757277Ab2BNVQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:16:33 -0500
Received: (qmail 11605 invoked by uid 107); 14 Feb 2012 21:23:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 16:23:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 16:16:29 -0500
Content-Disposition: inline
In-Reply-To: <vpq7gzph7mi.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190760>

On Tue, Feb 14, 2012 at 02:22:45PM +0100, Matthieu Moy wrote:

> I wrote a little shell-script that allows one to use latexdiff on files
> versionned by Git, with e.g.
> 
>   git latexdiff HEAD^ --main foo.tex --output foo.pdf

My latex usage is all from a past life, so I didn't even try out your
tool.  But I did wonder what your rationale was in making a separate
command as opposed to providing a script that could be plugged in as an
external diff.

-Peff
