From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 16:00:45 -0500
Message-ID: <20110131210045.GB14419@sigill.intra.peff.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:00:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk0rn-0005jV-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238Ab1AaVAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 16:00:49 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58094 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab1AaVAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 16:00:49 -0500
Received: (qmail 13538 invoked by uid 111); 31 Jan 2011 21:00:48 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Jan 2011 21:00:48 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jan 2011 16:00:45 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165752>

On Mon, Jan 31, 2011 at 03:28:37PM -0500, Nicolas Pitre wrote:

> We do have subdirectories for documentation, tests, contributions, etc.  
> But a sizeable part of the tree is just a big splat of source files 
> dumped right in the root of the tree.
> 
> So I'd suggest doing the following:
> 
> 1) Create a src/ directory and move *.c, *.h, *.sh, *.perl, *.py and 
>    the builtin directory from the root directory to it.

Wouldn't this just be the same giant splat of source files, but in a
different tree? I don't really see the advantage, and it seems like an
extra annoyance. Besides being just one more directory to go up and
down, it does make history browsing more annoying. As much as I love
git's "don't record renames" philosophy, our handling of renames on the
viewing side is often annoying. I already get annoyed sometimes
following stuff across the s!builtin-!builtin/! change. This would be
like that but more so.

Or maybe it is a good thing for that reason, as we will eat our own
rename dogfood. :)

> 5) Rename t/ to testsuite/ so this doesn't look like some garbage 
>    leftover.

Ugh, more typing. :P

-Peff
