From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ignore: make sure we have an xdg path before using it
Date: Tue, 24 Jul 2012 09:32:27 -0400
Message-ID: <20120724133227.GA14422@sigill.intra.peff.net>
References: <20120724115357.GA7353@sigill.intra.peff.net>
 <1343132811-2296-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:32:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StfE4-0000mi-JY
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 15:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab2GXNcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 09:32:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60237 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897Ab2GXNca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 09:32:30 -0400
Received: (qmail 17113 invoked by uid 107); 24 Jul 2012 13:32:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jul 2012 09:32:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2012 09:32:27 -0400
Content-Disposition: inline
In-Reply-To: <1343132811-2296-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202038>

On Tue, Jul 24, 2012 at 02:26:51PM +0200, Matthieu Moy wrote:

> Commit e3ebc35 (config: fix several access(NULL) calls, 2012-07-12) was
> fixing access(NULL) calls when trying to access $HOME/.config/git/config,
> but missed the ones when trying to access $HOME/.config/git/ignore. Fix
> and test this.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This can be appended to Jeff's serie. I thought if we had 3 bug
> instances and already fixed 2, why not fix the (hopefully last)
> one ;-).

Thanks. Looks obviously correct to me.

-Peff
