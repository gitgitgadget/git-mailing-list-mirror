From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH (amend)] cvsserver: Add test cases for config file handling
Date: Mon, 14 May 2007 14:59:16 +0200
Message-ID: <20070514125915.GB5272@planck.djpig.de>
References: <11790154701376-git-send-email-frank@lichtenheld.de> <117901685018-git-send-email-frank@lichtenheld.de> <7vtzugqym8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 14:59:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hna9B-0006LL-3P
	for gcvg-git@gmane.org; Mon, 14 May 2007 14:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbXENM7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 08:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbXENM7V
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 08:59:21 -0400
Received: from planck.djpig.de ([85.10.192.180]:1890 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbXENM7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 08:59:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 1BDD8274014;
	Mon, 14 May 2007 14:59:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GzdIO-PD58Ct; Mon, 14 May 2007 14:59:16 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 57FCE274013; Mon, 14 May 2007 14:59:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzugqym8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47236>

On Sun, May 13, 2007 at 01:04:15PM -0700, Junio C Hamano wrote:
> Frank Lichtenheld <frank@lichtenheld.de> writes:
> 
> > Add a few test cases for the config file parsing
> > done by git-cvsserver.
> >
> > Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> > ---
> >  t/t9420-git-cvsserver-config.sh |  109 +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 109 insertions(+), 0 deletions(-)
> >  create mode 100755 t/t9420-git-cvsserver-config.sh
> 
> Do we really need a separate test script that does quite similar setup?

Right now, probably not.

But I certainly don't intend to do all the tests in one big file which
will become rather large over time. If you're concerned with code
duplication, maybe I should move the code to a separate file and source
it from there?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
