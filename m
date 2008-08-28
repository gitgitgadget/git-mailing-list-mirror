From: Jeff King <peff@peff.net>
Subject: Re: Future suggestion's to assist with changes to git.
Date: Thu, 28 Aug 2008 19:30:45 -0400
Message-ID: <20080828233045.GE29609@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0808281646570.18129@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:31:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqy1-0003rP-CR
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbYH1Xas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbYH1Xar
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:30:47 -0400
Received: from peff.net ([208.65.91.99]:2181 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237AbYH1Xar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:30:47 -0400
Received: (qmail 9199 invoked by uid 111); 28 Aug 2008 23:30:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 19:30:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 19:30:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0808281646570.18129@suse104.zenez.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94210>

On Thu, Aug 28, 2008 at 05:10:53PM -0600, Boyd Lynn Gerber wrote:

> Maybe on item could be on the git web site news items could be created to  
> announce backward compatibility changes.  I think most people do visit the 
> main website to look for information.  Having these changes posted there  
> or linked from the main page could be a positive method so something like  
> this will not happen in the future.

Do they? I haven't been to the git web site in quite a long time. Nor
have I been to (for example) the vim web site. The two things I would
personally notice are:

  - a note during upgrade of my system's packages. And this is going to
    be dependent on the packaging system used. 1.6.0 hasn't hit many
    distributions yet, so maybe there is still time for this. Gerrit,
    do you mind putting something into NEWS.Debian about the drop of
    "git-*" so that people with apt-listchanges will see it?

    For people building from source, we have the Release Notes, but
    beyond that, I don't know where to put it (and I don't meant the web
    site is a bad place -- the more places the better, but there is no
    catch-all place).

  - the command complaining that my use of it is deprecated. In
    retrospect, we probably should have done this.

-Peff
