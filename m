From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Wed, 1 Dec 2010 13:03:32 -0500
Message-ID: <20101201180332.GC7774@sigill.intra.peff.net>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
 <201012011557.30849.jnareb@gmail.com>
 <20101201150917.GD6537@picasso.cante.net>
 <201012011737.53652.jnareb@gmail.com>
 <87vd3dv2ow.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 19:04:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNr2l-0007P6-S5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677Ab0LASDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:03:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59179 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755674Ab0LASDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:03:34 -0500
Received: (qmail 5880 invoked by uid 111); 1 Dec 2010 18:03:33 -0000
Received: from 129-79-255-226.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.226)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 01 Dec 2010 18:03:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Dec 2010 13:03:32 -0500
Content-Disposition: inline
In-Reply-To: <87vd3dv2ow.fsf@picasso.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162560>

On Wed, Dec 01, 2010 at 07:10:55PM +0200, Jari Aalto wrote:

> 2010-12-01 18:37 Jakub Narebski <jnareb@gmail.com>:
> > Having related config variables together is IMVHO more important than
> > having config variables sorted alphabetically.
> 
> That's subjective criteria. I doubt there are many related one that
> can't be handled with standard "see also".

Don't we already have a plan and some patches in flight (from Thomas) to
turn the master list into a straight one-line-per-config index (which
probably _should_ be alphabetized), and then put related options into
their respective manpages (which effectively sorts them by
functionality)?

This patch is just going to cause conflicts with Thomas's, and in the
end will be obsoleted by it.

-Peff
