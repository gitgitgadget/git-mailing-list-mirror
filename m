From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 17 Oct 2007 21:08:23 +0200
Message-ID: <20071017190822.GD9041@planck.djpig.de>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com> <118833cc0710170739i179e7389k1e44f70086ca88be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiEGW-0000tV-5G
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112AbXJQTIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbXJQTIp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:08:45 -0400
Received: from planck.djpig.de ([85.10.192.180]:3344 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933058AbXJQTIo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:08:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id ABE0C88231;
	Wed, 17 Oct 2007 21:08:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZ6NubTFQfb5; Wed, 17 Oct 2007 21:08:34 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id A35DD88235; Wed, 17 Oct 2007 21:08:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <118833cc0710170739i179e7389k1e44f70086ca88be@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61411>

On Wed, Oct 17, 2007 at 10:39:52AM -0400, Morten Welinder wrote:
> >  made it into your repo.  It fixes test failures on my machine that have
> >  been plauging me for months.
> 
> That sounds more like a reason to fix the test.  "die" is the perl
> standard way of
> reporting an error.  It will print the error message on stderr, not on
> stdout like
> your version does.

Please note that git-cvsserver is special in that its output will never
be displayed directly to the user but is always interpreted first by
the client. So print "E something" is acutally in some cases more
correct than print STDERR something.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
