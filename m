From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] completion: backwards compatibility fix
Date: Fri, 18 May 2012 22:45:03 -0400
Message-ID: <20120519024503.GA2801@sigill.intra.peff.net>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Carsten Mattner <carstenmattner@googlemail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 04:45:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVZfQ-0004Z0-Cb
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 04:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759959Ab2ESCpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 22:45:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49002
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab2ESCpI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 22:45:08 -0400
Received: (qmail 11414 invoked by uid 107); 19 May 2012 02:45:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 22:45:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 22:45:03 -0400
Content-Disposition: inline
In-Reply-To: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198009>

On Sat, May 19, 2012 at 04:41:33AM +0200, Felipe Contreras wrote:

> These two patches are meant to fix the backwards compatibility of _git, and
> _gitk. This also helps my zsh's wrapper.
>
> Felipe Contreras (2):
>   completion: rename _git and _gitk
>   completion: add support for backwards compatibilit

Thanks. This looks like the obviously correct solution. Even if we end
up with a public _GIT_complete or whatever, the backwards-compatibility
is worth it.

-Peff
