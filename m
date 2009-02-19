From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] Google has renamed the imap folder
Date: Thu, 19 Feb 2009 03:09:31 -0500
Message-ID: <20090219080930.GA7774@coredump.intra.peff.net>
References: <200902190736.11912.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 09:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La3zy-0003zJ-TU
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 09:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbZBSIJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 03:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbZBSIJe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 03:09:34 -0500
Received: from peff.net ([208.65.91.99]:60876 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806AbZBSIJd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 03:09:33 -0500
Received: (qmail 20703 invoked by uid 107); 19 Feb 2009 08:09:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 03:09:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 03:09:31 -0500
Content-Disposition: inline
In-Reply-To: <200902190736.11912.johnflux@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110641>

On Thu, Feb 19, 2009 at 07:36:11AM +0000, John Tapsell wrote:

>  [imap]
> -	folder = "[Gmail]/Drafts"
> +	folder = "[Google Mail]/Drafts"

I thought the consensus from the last patch was that it should stay
Gmail, as that is the name used in most countries?

> +You might need to instead use:  folder = "[Google Mail]/Drafts" if you get an error
> +that the "Folder doesn't exist".

And this hunk certainly implies that's what you were shooting for.

-Peff
