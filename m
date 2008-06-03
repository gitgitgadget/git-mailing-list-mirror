From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add an optional <mode> argument to commit/status
	-u|--untracked-files option
Date: Tue, 3 Jun 2008 16:14:22 -0400
Message-ID: <20080603201421.GB17260@sigill.intra.peff.net>
References: <7viqwvk04y.fsf@gitster.siamese.dyndns.org> <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3cvE-0004WF-71
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbYFCUO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbYFCUO0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:14:26 -0400
Received: from peff.net ([208.65.91.99]:2534 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756618AbYFCUOX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:14:23 -0400
Received: (qmail 25488 invoked by uid 111); 3 Jun 2008 20:14:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 03 Jun 2008 16:14:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jun 2008 16:14:22 -0400
Content-Disposition: inline
In-Reply-To: <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83698>

On Tue, Jun 03, 2008 at 03:09:10PM +0200, Marius Storm-Olsen wrote:

> +-u[<mode>]|--untracked-files[=<mode>]::
> +	Show all untracked files.
> +	The mode parameter is optional, and is used to specify
> +	the handling of untracked files. The possible options are:
> +		none   - Show no untracked files
> +		normal - Shows untracked files and directories
> +		all    - Also shows individual files in untracked directories.
> +	If the mode parameter is not specified, the defaults is
> +	'all'.

Hmm. Doesn't this change bundling semantics of "git commit -us"? Do we
care?

-Peff
