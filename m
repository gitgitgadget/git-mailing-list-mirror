From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH (amend)] cvsserver: Add test cases for config file handling
Date: Sat, 19 May 2007 22:32:12 +0200
Message-ID: <20070519203212.GB4085@planck.djpig.de>
References: <11790154701376-git-send-email-frank@lichtenheld.de> <117901685018-git-send-email-frank@lichtenheld.de> <7vtzugqym8.fsf@assigned-by-dhcp.cox.net> <20070514125915.GB5272@planck.djpig.de> <20070519140521.GA4085@planck.djpig.de> <7v8xbkwpl2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 22:32:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpVbJ-0004m3-De
	for gcvg-git@gmane.org; Sat, 19 May 2007 22:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbXESUcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 16:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759330AbXESUcS
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 16:32:18 -0400
Received: from planck.djpig.de ([85.10.192.180]:3446 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756479AbXESUcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 16:32:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 5A2A588060;
	Sat, 19 May 2007 22:32:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B766v4e04eRM; Sat, 19 May 2007 22:32:13 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 2A4EF88105; Sat, 19 May 2007 22:32:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8xbkwpl2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47773>

On Sat, May 19, 2007 at 01:00:57PM -0700, Junio C Hamano wrote:
> Well, It seems that all of our foreign SCM tests tends to be
> slower than other tests, so I would be happier if a single run

Which only shows that git is so much faster than anything else ;)

> of one test covers everything we would want to cover, when I run
> "make test", rather than having multiple set-up steps that are
> identical in two different tests.  So in that sense, I was not
> talking about code duplication which can be solved by splitting
> the duplicated part into a separate file and sourcing it from
> two scripts -- that is not a solution.

Ok, thanks for the clarification. I will merge the two test files
for now and resubmit.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
