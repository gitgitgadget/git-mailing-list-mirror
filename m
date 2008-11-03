From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Mon, 3 Nov 2008 02:04:30 -0500
Message-ID: <20081103070430.GC10772@coredump.intra.peff.net>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com> <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com> <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081029171122.GA12167@sigill.intra.peff.net> <7vprle1qdl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 08:06:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwtVS-0002f3-3i
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 08:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbYKCHEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 02:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYKCHEc
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 02:04:32 -0500
Received: from peff.net ([208.65.91.99]:1468 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbYKCHEc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 02:04:32 -0500
Received: (qmail 29211 invoked by uid 111); 3 Nov 2008 07:04:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Nov 2008 02:04:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Nov 2008 02:04:30 -0500
Content-Disposition: inline
In-Reply-To: <7vprle1qdl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99908>

On Sun, Nov 02, 2008 at 01:30:46AM -0700, Junio C Hamano wrote:

> A flag "--staged" that means "staged changes and changes in the work tree"
> is no worse than the current "--index".  If we were to shoot for clarity,

Well, there is another flag state to be considered, of course, which is
"no flag".  So I think "--staged" is fine to mean the working tree and
staged, as long as the default (i.e., no option given) is to operate on
the working tree.

I can't think offhand of any commands that violate that assumption.

> how about --staged-only (aka --cached) vs --staged-and-unstaged (aka --index)?
> 
> I am actually actively unhappy about the latter, but I like more
> descriptive --staged-only for the former a lot better.

Agreed. --staged-only is fine to me, but --staged-and-unstaged just
seems too long.

-Peff
