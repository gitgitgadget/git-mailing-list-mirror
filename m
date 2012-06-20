From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 02/11] Makefile: fold MISC_H into LIB_H
Date: Wed, 20 Jun 2012 18:11:25 -0400
Message-ID: <20120620221125.GA3302@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183055.GB30995@sigill.intra.peff.net>
 <20120620210730.GB6142@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 00:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShT7d-0001yT-KG
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 00:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170Ab2FTWL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 18:11:29 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39330
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758100Ab2FTWL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 18:11:29 -0400
Received: (qmail 30886 invoked by uid 107); 20 Jun 2012 22:11:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 18:11:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 18:11:25 -0400
Content-Disposition: inline
In-Reply-To: <20120620210730.GB6142@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200368>

On Wed, Jun 20, 2012 at 04:07:30PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Let's just fold MISC_H into LIB_H and get rid of these
> > manual rules. The worst case is some extra compilation, but
> > even that is unlikely to matter due to the reasons above.
> 
> Should XDIFF_H and VCSSVN_H be folded into STATIC_HEADERS, too?

I stopped short of that, but I'd be tempted to do so. I don't think
those variables have any special meaning beyond the recompilation
dependencies.

-Peff
