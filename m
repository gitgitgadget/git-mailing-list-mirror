From: Jeff King <peff@peff.net>
Subject: Re: `man 1 git`: Invalid link to online documentation
Date: Mon, 6 Jun 2016 19:25:37 -0400
Message-ID: <20160606232536.GA23537@sigill.intra.peff.net>
References: <ed8f000f-b8a2-ca92-e0f2-e26ff9928bbe@gentoo.org>
 <20160606231936.GB22756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Campbell <zlg@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 01:26:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA3uI-000750-5A
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 01:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbcFFXZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 19:25:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:50033 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751371AbcFFXZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 19:25:40 -0400
Received: (qmail 959 invoked by uid 102); 6 Jun 2016 23:25:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Jun 2016 19:25:39 -0400
Received: (qmail 23713 invoked by uid 107); 6 Jun 2016 23:25:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Jun 2016 19:25:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2016 19:25:37 -0400
Content-Disposition: inline
In-Reply-To: <20160606231936.GB22756@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296575>

On Mon, Jun 06, 2016 at 07:19:36PM -0400, Jeff King wrote:

>   2. Make git-htmldocs a real site on GitHub. I think this should be as
>      simple as pushing to the `gh-pages` branch of the repository, which
>      would make it available as https://gitster.github.io/git-htmldocs.
>      You can do a bunch of Jekyll magic, but you don't have to; it should
>      serve arbitrary html files (though I think we'd maybe want to add
>      an "index.html"; we may also want to host it under a git/htmldocs
>      project just to make the repo more official looking).

Just to make sure I wasn't spewing nonsense, I tried pushing the tip of
gitster/git-htmldocs to the "gh-pages" branch of git/htmldocs, and
indeed:

  https://git.github.io/htmldocs/git.html

now works. If we like that solution, Junio, you should already have
access to just push there (instead of gitster/git-htmldocs, or in
addition to if you prefer).

If not, I'll delete the repository (I don't plan on doing further
pushes, so leaving it will just confuse people).

I see that we _do_ have an index.html symlink in the built tree, but it
does not seem to actually work via GitHub Pages.

-Peff
