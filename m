From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] added a built-in alias for 'stage' to the 'add' command
Date: Mon, 1 Dec 2008 13:25:57 -0500
Message-ID: <20081201182557.GA24443@coredump.intra.peff.net>
References: <20081201172902.GA41963@agadorsparticus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 19:27:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7DUL-0005SK-Rf
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 19:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYLAS0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 13:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbYLAS0A
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 13:26:00 -0500
Received: from peff.net ([208.65.91.99]:1479 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbYLASZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 13:25:59 -0500
Received: (qmail 28507 invoked by uid 111); 1 Dec 2008 18:25:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Dec 2008 13:25:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Dec 2008 13:25:57 -0500
Content-Disposition: inline
In-Reply-To: <20081201172902.GA41963@agadorsparticus>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102075>

On Mon, Dec 01, 2008 at 09:29:02AM -0800, Scott Chacon wrote:

> this comes from conversation at the GitTogether where we thought it would
> be helpful to be able to teach people to 'stage' files because it tends
> to cause confusion when told that they have to keep 'add'ing them.
> 
> This continues the movement to start referring to the index as a
> staging area (eg: the --staged alias to 'git diff'). Also added a
> doc file for 'git stage' that basically points to the docs for
> 'git add'.

FWIW, I think this is a step in the right direction. Or at least if it's
the wrong direction, I don't think we're actually _hurting_ anybody,
since we're not changing existing commands.

Out of curiosity, have you had any experiences referring to this as "git
stage" (maybe just by setting a per-user alias) with new users?

> +SYNOPSIS
> +--------
> +[verse]
> +'git stage' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
> +	  [--all | [--update | -u]] [--intent-to-add | -N]
> +	  [--refresh] [--ignore-errors] [--] <filepattern>...

It seems like this might get stale with respect to git-add(1). Since
we're not hiding the fact that this is really an alias for "add", maybe
it would be better to just have "git stage [options] [--]
<filepattern>" (or maybe even something simpler).

-Peff
