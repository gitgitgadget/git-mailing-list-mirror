From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fetch: add missing documentation
Date: Tue, 24 Sep 2013 01:03:43 -0400
Message-ID: <20130924050343.GF2766@sigill.intra.peff.net>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
 <1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:03:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOKmt-0005fe-6v
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733Ab3IXFDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:03:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:52935 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab3IXFDq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:03:46 -0400
Received: (qmail 31107 invoked by uid 102); 24 Sep 2013 05:03:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 00:03:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 01:03:43 -0400
Content-Disposition: inline
In-Reply-To: <1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235259>

On Sat, Sep 21, 2013 at 09:09:22AM -0500, Felipe Contreras wrote:

> There's no mention of the 'origin' default, or the fact that the
> upstream tracking branch remote is used.

Sounds like a good thing to mention.

> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index e08a028..7e75dc4 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -37,6 +37,9 @@ or from several repositories at once if <group> is given and
>  there is a remotes.<group> entry in the configuration file.
>  (See linkgit:git-config[1]).
>  
> +When no remote is specified, by the default the `origin` remote will be used,

s/the (default the)/\1/

> +unless there's an upstream branch configured for the current branch.

Should this be "upstream remote" rather than "upstream branch"? I don't
think we should be looking at branch.*.merge at all for git-fetch.

-Peff
