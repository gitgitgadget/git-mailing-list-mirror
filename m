From: Jeff King <peff@peff.net>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 15:10:32 -0400
Message-ID: <20090831191032.GB4876@sigill.intra.peff.net>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
 <vpqskf8z0rj.fsf@bauges.imag.fr>
 <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
 <20090831164146.GA23245@coredump.intra.peff.net>
 <vpqocpvevzx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiCH4-0006JO-95
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 21:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbZHaTKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753938AbZHaTKb
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 15:10:31 -0400
Received: from peff.net ([208.65.91.99]:53478 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753575AbZHaTKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 15:10:31 -0400
Received: (qmail 26401 invoked by uid 107); 31 Aug 2009 19:10:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Aug 2009 15:10:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 15:10:32 -0400
Content-Disposition: inline
In-Reply-To: <vpqocpvevzx.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127494>

On Mon, Aug 31, 2009 at 07:25:22PM +0200, Matthieu Moy wrote:

> Since the client and server are the same machine:
> 
>     $ git clone ssh://sitaram@localhost/home/sitaram/t/a b
> 
> I'd bet Sitaram has two installations of git, and plain ssh to the
> machine points to the old one (like a $PATH set in ~/.login and not
> ~/.profile or something like that).

Oh, indeed. I didn't notice that his host was @localhost. :)

But yes, that would be my guess, as well. Trying "ssh sitaram@localhost
git version" would be a good clue.

-Peff
