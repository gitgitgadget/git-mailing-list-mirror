From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH (amend)] cvsserver: Add test cases for config file handling
Date: Sat, 19 May 2007 16:05:21 +0200
Message-ID: <20070519140521.GA4085@planck.djpig.de>
References: <11790154701376-git-send-email-frank@lichtenheld.de> <117901685018-git-send-email-frank@lichtenheld.de> <7vtzugqym8.fsf@assigned-by-dhcp.cox.net> <20070514125915.GB5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 16:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpPZD-0007Si-Fe
	for gcvg-git@gmane.org; Sat, 19 May 2007 16:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945AbXESOF0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 10:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758012AbXESOF0
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 10:05:26 -0400
Received: from planck.djpig.de ([85.10.192.180]:1371 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757945AbXESOF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 10:05:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 901C688060;
	Sat, 19 May 2007 16:05:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qiCHmlmJHwSE; Sat, 19 May 2007 16:05:22 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id E042288105; Sat, 19 May 2007 16:05:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070514125915.GB5272@planck.djpig.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47750>

On Mon, May 14, 2007 at 02:59:16PM +0200, Frank Lichtenheld wrote:
> On Sun, May 13, 2007 at 01:04:15PM -0700, Junio C Hamano wrote:
> > Frank Lichtenheld <frank@lichtenheld.de> writes:
> > 
> > > Add a few test cases for the config file parsing
> > > done by git-cvsserver.
> > >
> > > Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> > > ---
> > >  t/t9420-git-cvsserver-config.sh |  109 +++++++++++++++++++++++++++++++++++++++
> > >  1 files changed, 109 insertions(+), 0 deletions(-)
> > >  create mode 100755 t/t9420-git-cvsserver-config.sh
> > 
> > Do we really need a separate test script that does quite similar setup?
> 
> Right now, probably not.
> 
> But I certainly don't intend to do all the tests in one big file which
> will become rather large over time. If you're concerned with code
> duplication, maybe I should move the code to a separate file and source
> it from there?

Still waiting on a comment here...

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
