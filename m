From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Emphasize options and force ASCIIDOC escaping of "--"
Date: Tue, 12 Nov 2013 03:38:38 -0500
Message-ID: <20131112083838.GB1684@sigill.intra.peff.net>
References: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Tue Nov 12 09:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg9Ui-0005Rr-2p
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 09:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab3KLIil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 03:38:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:37693 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750979Ab3KLIik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 03:38:40 -0500
Received: (qmail 18553 invoked by uid 102); 12 Nov 2013 08:38:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Nov 2013 02:38:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Nov 2013 03:38:38 -0500
Content-Disposition: inline
In-Reply-To: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237705>

On Fri, Nov 08, 2013 at 07:48:51PM -0500, Jason St. John wrote:

>  Using more options generally further limits the output (e.g.
> -`--since=<date1>` limits to commits newer than `<date1>`, and using it
> -with `--grep=<pattern>` further limits to commits whose log message
> +'\--since=<date1>' limits to commits newer than `<date1>`, and using it
> +with '\--grep=<pattern>' further limits to commits whose log message
>  has a line that matches `<pattern>`), unless otherwise noted.

Others pointed out that we generally prefer the `literal` formatting for
such options (with backticks), which I agree with. If your target is
formatting manpages (and not html), you may want to build with
MAN_BOLD_LITERAL set in the Makefile, which will embolden the literals
in the output (since we cannot typeset them in a monospace font on the
terminal, as we would for html).

-Peff
