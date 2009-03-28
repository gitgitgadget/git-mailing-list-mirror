From: Jeff King <peff@peff.net>
Subject: Re: First round of UGFWIINI results
Date: Sat, 28 Mar 2009 03:42:05 -0400
Message-ID: <20090328074205.GB9013@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302> <m37i2b2ecu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 08:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnTG7-0002rp-FN
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 08:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbZC1HmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 03:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbZC1HmL
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 03:42:11 -0400
Received: from peff.net ([208.65.91.99]:51605 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbZC1HmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 03:42:10 -0400
Received: (qmail 25227 invoked by uid 107); 28 Mar 2009 07:42:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Mar 2009 03:42:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Mar 2009 03:42:05 -0400
Content-Disposition: inline
In-Reply-To: <m37i2b2ecu.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114940>

On Fri, Mar 27, 2009 at 08:08:04AM -0700, Jakub Narebski wrote:

> Not exactly UGFWIINI yet, but:
> 
>   "Music collaboration via git?"
>   http://www.37signals.com/svn/posts/1655-music-collaboration-via-git
>   (sharing LilyPond source files for music notation).

I do something similar, though I am usually not writing in lilypond but
rather in ABC or human-readable chord charts with accompanying lyrics.
However, my band-mates are not git-literate, so I usually end up pulling
their versions directly from email into the working tree, and then
committing to git myself.

For added UGFWIINI, I also keep multitrack recording projects in the
same repo. Live single tracks are kept as pristine "source", and then
are mixed down (with filters and effects added) into a final product.
It's even driven by make. ;)

However, the source files are annoyingly large to work with in git, so I
keep them outside of the repo as immutable source and refer to them by
unique name. Only the ways in which they are filtered or combined are in
the repo.

-Peff
