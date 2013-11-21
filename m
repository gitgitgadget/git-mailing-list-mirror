From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] Revamp git-cherry(1)
Date: Thu, 21 Nov 2013 06:54:23 -0500
Message-ID: <20131121115423.GC7171@sigill.intra.peff.net>
References: <3af3069696e3a59d513f1fef0ca797d103f6d882.1385033403.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, a.huemer@commend.com,
	"Michael S. Tsirkin" <mst@kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 21 12:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjSq7-0003F6-AX
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 12:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab3KULy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 06:54:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:43186 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753340Ab3KULyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 06:54:25 -0500
Received: (qmail 12700 invoked by uid 102); 21 Nov 2013 11:54:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Nov 2013 05:54:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Nov 2013 06:54:23 -0500
Content-Disposition: inline
In-Reply-To: <3af3069696e3a59d513f1fef0ca797d103f6d882.1385033403.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238120>

On Thu, Nov 21, 2013 at 12:30:56PM +0100, Thomas Rast wrote:

> git-cherry(1)'s "description" section has never really managed to
> explain to me what the command does.  It contains too much explanation
> of the algorithm instead of simply saying what goals it achieves, and
> too much terminology that we otherwise do not use (fork-point instead
> of merge-base).
> 
> Try a much more concise approach: state what it finds out, why this is
> neat, and how the output is formatted, in a few short paragraphs.  In
> return, provide a longer example of how it fits into a format-patch/am
> based workflow.

FWIW, I find your concise explanation much friendlier.

> +Later, you can whether your changes have been applied by saying (still
> +on `topic`):

s/can/& see/ ?

> +------------
> +git fetch  # update your notion of origin/master
> +git cherry -v
> +------------
> ++
> +Note that this uses , and assumes that
> +`core.autosetupmerge` is enabled (the default).

I couldn't quite parse this. Is there a word missing before the comma,
or is it "uses and assumes that..."?

Given that it is the default, I wonder if it is worth mentioning at all.
Even I, who knows what autosetupmerge does, took a minute to figure out
why it is relevant here. I suspect it may just confuse most readers.

-Peff
