From: Jeff King <peff@peff.net>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Mon, 26 Jan 2009 16:00:27 -0500
Message-ID: <20090126210027.GG27604@coredump.intra.peff.net>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Perry Smith <pedzsan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 22:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYal-0003M1-OI
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbZAZVAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZAZVAc
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:00:32 -0500
Received: from peff.net ([208.65.91.99]:32886 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbZAZVA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:00:29 -0500
Received: (qmail 6547 invoked by uid 107); 26 Jan 2009 21:00:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 16:00:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 16:00:27 -0500
Content-Disposition: inline
In-Reply-To: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107275>

[cc-ing Mike Ralphson, our local AIX expert]

On Mon, Jan 26, 2009 at 02:02:15PM -0600, Perry Smith wrote:

> I tried building git 1.6.1 on AIX 5.3 as an "out of tree" build and it  
> does not seem to be set up to do out of tree builds.  If that is not  
> true, please let me know.
>
> The install process wants to call install with a -d option.  AIX has two 
> install programs but they are pretty old -- neither takes a -d option.
>
> Is there a GNU install program I can get?  I've not been able to locate 
> one.

It's in GNU coreutils:

  http://www.gnu.org/software/coreutils/

I don't know what Mike uses to install on AIX; you can see his config
setup here:

  http://repo.or.cz/w/git/gitbuild.git?a=tree;f=mr/aix;hb=platform

but I don't see any override of install.

> Last -- just so I know for future reference, is this list a 'text only  
> email' list?

If you mean "no html", then yes, it is absolutely text only.

-Peff
