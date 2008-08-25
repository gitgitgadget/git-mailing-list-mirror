From: Jeff King <peff@peff.net>
Subject: Re: Has the git shell revert been done so master should work?
Date: Mon, 25 Aug 2008 01:40:21 -0400
Message-ID: <20080825054021.GA9785@sigill.intra.peff.net>
References: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com> <20080824173804.GA26626@coredump.intra.peff.net> <alpine.LNX.1.10.0808242332580.6062@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 07:41:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXUpo-0001p0-Om
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 07:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbYHYFk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 01:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbYHYFk0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 01:40:26 -0400
Received: from peff.net ([208.65.91.99]:3673 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbYHYFk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 01:40:26 -0400
Received: (qmail 17669 invoked by uid 111); 25 Aug 2008 05:40:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 25 Aug 2008 01:40:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2008 01:40:21 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0808242332580.6062@xenau.zenez.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93598>

On Sun, Aug 24, 2008 at 11:34:19PM -0600, Boyd Lynn Gerber wrote:

> > It's in 'next' but has not yet graduated to 'master'. You can try
> > cherry-picking 4cfc24af into master.
> 
> I have never used cherry-pick before.  I can not seem to get the right 
> incantation to get this into master to test it.  Could someone assist me 
> with how to get this into master for testing?

The usual way would be:

  git checkout master ;# if you are not already there
  git cherry-pick 4cfc24af

However, it looks like Junio has just pushed out a master that has the
commit in question.

-Peff
