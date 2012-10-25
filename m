From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: remote tracking branch -> remote-tracking
 branch
Date: Thu, 25 Oct 2012 05:54:27 -0400
Message-ID: <20121025095427.GL8390@sigill.intra.peff.net>
References: <vpqk3uhr5gp.fsf@grenoble-inp.fr>
 <1350992045-11141-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, angelo.borsotti@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:54:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRK9D-0001d5-4n
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662Ab2JYJyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:54:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56057 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964920Ab2JYJya (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:54:30 -0400
Received: (qmail 7213 invoked by uid 107); 25 Oct 2012 09:55:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:55:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:54:27 -0400
Content-Disposition: inline
In-Reply-To: <1350992045-11141-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208379>

On Tue, Oct 23, 2012 at 01:34:05PM +0200, Matthieu Moy wrote:

> This change was already done by 0e615b252f3 (Matthieu Moy, Tue Nov 2
> 2010, Replace "remote tracking" with "remote-tracking"), but new
> instances of remote tracking (without dash) were introduced in the
> meantime.

Thanks. It seems like an obvious step forward.

> I'm not opposed to dropping completely the remote-tracking part in the
> case of merge (i.e. "remote-tracking branches that the current branch
> is configured to use as its upstream" -> "upstream branch") on top of
> that, but if we do this, merge-config.txt should be updated too).

Yeah, I do not care too deeply, but I think it reads just fine without
mentioning remote-tracking at all.

-Peff
