From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Tue, 4 Oct 2011 03:00:06 -0400
Message-ID: <20111004070006.GA6824@sigill.intra.peff.net>
References: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:00:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAyzA-0000G7-Qo
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab1JDHAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 03:00:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51946
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367Ab1JDHAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 03:00:09 -0400
Received: (qmail 3617 invoked by uid 107); 4 Oct 2011 07:05:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 03:05:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 03:00:06 -0400
Content-Disposition: inline
In-Reply-To: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182728>

On Mon, Oct 03, 2011 at 02:16:08PM +0200, Erik Faye-Lund wrote:

> I recently needed to prune remote branches in a repo with a lot
> of remotes, and to my surprise "git remote prune" didn't support
> the --all option. So I added it. Perhaps this is useful for other
> people as well?

You could do:

  git remote update --prune

But I thought we were trying to get away from remote doing fetch-like
things in the long term. Isn't the "right" way to do this these days:

  git fetch --all --prune

?

-Peff
