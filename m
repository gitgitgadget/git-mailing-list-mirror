From: Jeff King <peff@peff.net>
Subject: Re: sparse checkout file with windows line endings doesn't work
Date: Thu, 19 Sep 2013 23:38:21 -0400
Message-ID: <20130920033821.GD15101@sigill.intra.peff.net>
References: <20130920031705.GA15101@sigill.intra.peff.net>
 <SDZYUVdaTCUzXD8wPVQvMjQwMzM4MTcx@IBMLT4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Gregory <marting@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Fri Sep 20 05:38:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMrYB-0002lN-FL
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 05:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab3ITDic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 23:38:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:41027 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652Ab3ITDib (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 23:38:31 -0400
Received: (qmail 23184 invoked by uid 102); 20 Sep 2013 03:38:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Sep 2013 22:38:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Sep 2013 23:38:21 -0400
Content-Disposition: inline
In-Reply-To: <SDZYUVdaTCUzXD8wPVQvMjQwMzM4MTcx@IBMLT4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235055>

On Fri, Sep 20, 2013 at 12:54:45PM +0930, Martin Gregory wrote:

> >>  I don't think you can do that in the general case of read-tree. You may
> >>  have sparse paths that exist in some commits, but not others. As you
> >>  move around in history, a sparse entry that does not match might do so
> >>  because it is poorly written, or it might do so because you just don't
> >>  happen to have any matching paths in the commit you are moving to. The
> >>  former is a problem, but warning on the latter would be useless noise.
> 
> Even if you only do it as part of a verbose option?
> 
> My thinking was that when you specify verbose, you are saying "I don't
> mind a bit of noise in order to find what I'mlooking for".

I don't mind a special option to turn this on for debugging, but the
normal "-v" for read-tree is not "show me random noise", but rather
"keep me occupied with a progress bar". If it were triggered by two or
more "-v" options (which could also contain other debugging output), I'd
be more sympathetic.

-Peff
