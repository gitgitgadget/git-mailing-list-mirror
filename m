From: Jeff King <peff@peff.net>
Subject: Re: why the html and man versions of git-diff are different?
Date: Thu, 16 Dec 2010 16:55:06 -0500
Message-ID: <20101216215506.GB10480@sigill.intra.peff.net>
References: <m139px2y26.fsf@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Leo <sdl.web@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 22:55:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTLn9-0003w6-JH
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 22:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab0LPVzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 16:55:09 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50680 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab0LPVzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 16:55:08 -0500
Received: (qmail 2664 invoked by uid 111); 16 Dec 2010 21:55:07 -0000
Received: from 129-79-255-221.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.221)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 16 Dec 2010 21:55:07 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Dec 2010 16:55:06 -0500
Content-Disposition: inline
In-Reply-To: <m139px2y26.fsf@cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163820>

On Thu, Dec 16, 2010 at 09:43:45PM +0000, Leo wrote:

> I compared the html version of git-diff found in
> http://www.kernel.org/pub/software/scm/git/docs/git-diff.html and the
> man version from
> http://kernel.org/pub/software/scm/git/git-manpages-1.7.3.4.tar.bz2
> 
> The man version says gitrevisions(1), which is incorrect since it is in
> man7.

Because it was fixed recently, and the html documention on kernel.org
uses the "master" branch, whereas that commit did not make it into the
maintenance release 1.7.3.4. It will be fixed in the manpages for
git-1.7.4.

-Peff
