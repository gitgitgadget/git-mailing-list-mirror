From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] http-auth-early
Date: Fri, 14 Oct 2011 09:19:32 -0400
Message-ID: <20111014131932.GE7808@sigill.intra.peff.net>
References: <4E9692BF.8040705@drmicha.warpmail.net>
 <cover.1318577792.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 15:19:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REhfu-0006DI-OG
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 15:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541Ab1JNNTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 09:19:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60543
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620Ab1JNNTh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 09:19:37 -0400
Received: (qmail 9049 invoked by uid 107); 14 Oct 2011 13:19:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 09:19:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 09:19:32 -0400
Content-Disposition: inline
In-Reply-To: <cover.1318577792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183573>

On Fri, Oct 14, 2011 at 09:40:34AM +0200, Michael J Gruber wrote:

> Here are the early parts of Jeff's http-auth-keyring series.
> It contains only parts which are not using the credential API (which
> is still under discussion), so that this can go in (and help users)
> and alleviates the pressure on the credential discussion:
> 
> Early bits with cleanups to http.c.
> Cherry-picked bit for improved prompts ("Username for ..." etc.)
> Cherry-pickes bit for using configured pushurls.
> 
> I tried to pick/resolve in a way which should help rebasing Jeff's series
> on top of this.

Thanks for working on this. One of my intended tasks for today is to
rebase my series, so it is nice to wake up to half of the work done. :)

> Jeff King (5):
>   url: decode buffers that are not NUL-terminated
>   improve httpd auth tests
>   remote-curl: don't retry auth failures with dumb protocol
>   http: retry authentication failures for all http requests
>   http_init: accept separate URL parameter
> 
> Michael J Gruber (1):
>   http: use hostname in credential description

Your changes all look right. The naming of git_getpass_one in the
cherry-picked commit is a little odd without the rest of the series as
context. I would maybe have called it "git_getpass_with_description" or
something.

-Peff
