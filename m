From: Jeff King <peff@peff.net>
Subject: Re: Bad Man Page URLs
Date: Fri, 6 Apr 2012 03:23:49 -0400
Message-ID: <20120406072349.GA27115@sigill.intra.peff.net>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
 <20120406054637.GA25301@sigill.intra.peff.net>
 <7vzkap1gck.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"David E. Wheeler" <david@justatheory.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 09:24:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG3WZ-00053w-5L
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 09:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab2DFHXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 03:23:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49756
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab2DFHXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 03:23:52 -0400
Received: (qmail 359 invoked by uid 107); 6 Apr 2012 07:23:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 03:23:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 03:23:49 -0400
Content-Disposition: inline
In-Reply-To: <7vzkap1gck.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194855>

On Fri, Apr 06, 2012 at 12:15:07AM -0700, Junio C Hamano wrote:

> > Junio, what do you think of building the git-manpages-* tarballs (and
> > the git-manpages repo) with MAN_BASE_URL set to "http://some-official-place/"?
> > As of now, they mention "file:///home/junio/...".
> 
> I think git-manpages repo already sets the base to the old k.org location
> (see dodoc.sh in the 'todo' branch), but I forgot about that setting when
> I cobbled together the tarball releasing script to be run on my home box
> in a hurry.

Ah, I didn't notice that. The k.org location is dead, of course, but I
hope we will eventually turn it into at least a redirect to the official
location.

Scott, I know you've been working hard on the git-scm.com redesign. Any
word on when that will be ready, or whether it will contain a mirror of
the reference docs?

> I do not know how well things would behave if we set it to "git-htmldocs/"
> as Jonathan suggests, but we will see what happens.

Users will see reference to "git-htmldocs/everyday.html" in their
manpage. Not quite as nice as a real URL, but at least not entirely
misleading.

-Peff
