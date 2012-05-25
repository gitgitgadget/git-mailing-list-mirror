From: Jeff King <peff@peff.net>
Subject: Re: credential-helpers + remote-helper, starting   point?
Date: Fri, 25 May 2012 16:35:44 -0400
Message-ID: <20120525203544.GA4297@sigill.intra.peff.net>
References: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
 <20120524182110.GE3161@sigill.intra.peff.net>
 <5edbcd2530e49e719129f799f8c78dd3@telesun.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, matthieu.moy@imag.fr,
	kim-thuat.nguyen@ensimag.fr, pavel.volek@ensimag.fr,
	javier.roucher-iglesias@ensimag.fr
To: roucherj <roucherj@telesun.imag.fr>
X-From: git-owner@vger.kernel.org Fri May 25 22:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY1Em-0003uZ-5m
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 22:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699Ab2EYUfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 16:35:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56116
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757651Ab2EYUfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 16:35:47 -0400
Received: (qmail 12933 invoked by uid 107); 25 May 2012 20:36:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 16:36:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 16:35:44 -0400
Content-Disposition: inline
In-Reply-To: <5edbcd2530e49e719129f799f8c78dd3@telesun.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198523>

On Fri, May 25, 2012 at 03:28:39PM +0200, roucherj wrote:

> Jeff thanks you for helping me with use credentials-helpers with
> git-remote
> I will try to code your proposed solution.
> making something like that:
> 
> +-----+ -----> +----------------------+
> | git |  pipe  | git-remote-mediawiki |
> +-----+ <----- +----------------------+
>                      /\      ||
>                      || pipe ||
>                      ||      \/
>                  +----------------+ ----->  O
>                  | git-credential | <----- -|-
>                  +----------------+        / \
>                      /\      ||            User
>                      || pipe ||
>                      ||      \/
>                  +-------------------------+
>                  | git-credentials-helpers |
>                  +-------------------------+

Exactly. Let me know if you run into any problems.

-Peff
