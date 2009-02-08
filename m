From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sun, 8 Feb 2009 06:06:28 -0500
Message-ID: <20090208110628.GB14359@coredump.intra.peff.net>
References: <20090205204436.GA6072@diku.dk> <20090206191511.GD19494@coredump.intra.peff.net> <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com> <20090207071056.GB14856@coredump.intra.peff.net> <7vprhuzoxm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902070050490.8086@asgard.lang.hm> <2c6b72b30902080247n31e5c532m31006fcb07ca95da@mail.gmail.com> <2c6b72b30902080255w6ccac5e9vcd961a9ab93dcdf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Feb 08 12:07:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW7W2-0000DB-ED
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 12:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbZBHLGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 06:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbZBHLGc
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 06:06:32 -0500
Received: from peff.net ([208.65.91.99]:35589 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbZBHLGb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 06:06:31 -0500
Received: (qmail 26874 invoked by uid 107); 8 Feb 2009 11:06:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Feb 2009 06:06:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2009 06:06:28 -0500
Content-Disposition: inline
In-Reply-To: <2c6b72b30902080255w6ccac5e9vcd961a9ab93dcdf3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108958>

On Sun, Feb 08, 2009 at 11:55:55AM +0100, Jonas Fonseca wrote:

> On Sun, Feb 8, 2009 at 11:47, Jonas Fonseca <fonseca@diku.dk> wrote:
> > One problem it does not yet handle is the
> > cut'n'paste within the same file where the deleted line ends up in a
> > different hunk.
> 
> Hmm, this is trivially fixed by passing -M to git blame so maybe that
> should just be the default for tig.

Yes, I think that is worth doing. It might also be nice to show the
original filename in the blame output (perhaps optionally if it is
different than the original). However, you might want to look at how
"git gui blame" does it. It actually shows _two_ entries for each line:
the origin of the content, and the commit that moved the content into
place.

I don't know if that is worth doing in tig or not; I think you generally
want to assume a much more constrained screen size (though I have to
admit that I generally maximize my terminal to use "tig blame" anyway --
80x25 just doesn't cut it).

-Peff
