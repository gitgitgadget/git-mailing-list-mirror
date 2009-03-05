From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http authentication via prompts
Date: Thu, 5 Mar 2009 11:37:40 -0500
Message-ID: <20090305163740.GC4213@coredump.intra.peff.net>
References: <49AF25BF.5060706@gmail.com> <alpine.DEB.1.00.0903051149280.6524@intel-tinevez-2-302> <49AFEC91.10009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:39:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfGbK-0001l7-Vp
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 17:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbZCEQhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 11:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbZCEQhq
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 11:37:46 -0500
Received: from peff.net ([208.65.91.99]:34907 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753766AbZCEQhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 11:37:46 -0500
Received: (qmail 32183 invoked by uid 107); 5 Mar 2009 16:37:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 11:37:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 11:37:40 -0500
Content-Disposition: inline
In-Reply-To: <49AFEC91.10009@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112317>

On Thu, Mar 05, 2009 at 09:15:29AM -0600, Mike Gaffney wrote:

> My thought was that if you had a password you didn't care about you
> could put it in the config.  It does ask you for a password with
> getpass, It compiles under cygwin, I havent tried it under windows.

I think part of the confusion is that your patch does two things, which
means it is probably more sensible as two separate patches:

  1. support http.username and http.password in the git config instead
     of the .netrc

  2. support getpass() if http.password (or .netrc password) is not
     available

-Peff
