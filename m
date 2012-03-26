From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 26 Mar 2012 16:00:20 -0400
Message-ID: <20120326200020.GA23777@sigill.intra.peff.net>
References: <20120320043133.GA2755@gmail.com>
 <20120323214114.GB18198@sigill.intra.peff.net>
 <20120326192001.GB32387@gmail.com>
 <20120326195150.GA13098@sigill.intra.peff.net>
 <20120326195743.GD32387@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, zbyszek@in.waw.pl,
	Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:00:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCG5c-0004fd-Id
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 22:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab2CZUAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 16:00:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60160
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302Ab2CZUAW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 16:00:22 -0400
Received: (qmail 16739 invoked by uid 107); 26 Mar 2012 20:00:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 16:00:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 16:00:20 -0400
Content-Disposition: inline
In-Reply-To: <20120326195743.GD32387@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193969>

On Mon, Mar 26, 2012 at 03:57:43PM -0400, Christopher Tiwald wrote:

> > My suggestion put them in transport.h, which is included from both
> > places. It compiles fine for me. Am I missing something?
> 
> Ah nope. That was me. Sorry about the noise. This otherwise makes sense
> to me.

OK. Junio, can you throw the patch from the grandparent on top of
ct/advise-push-default?

-Peff
