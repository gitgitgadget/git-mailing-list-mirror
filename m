From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Post-update hook problems
Date: Fri, 5 Oct 2007 14:08:50 +0200
Message-ID: <20071005120850.GM31659@planck.djpig.de>
References: <930d91430710050427o79395023nffe3bd842a87cddb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoffrey Ferrari <geoffrey.ferrari@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:09:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdlzR-0005kx-Tf
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 14:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbXJEMJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 08:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXJEMJB
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 08:09:01 -0400
Received: from planck.djpig.de ([85.10.192.180]:3340 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbXJEMJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 08:09:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id C229088231;
	Fri,  5 Oct 2007 14:08:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OPgjl05t17Pg; Fri,  5 Oct 2007 14:08:50 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 7F2B888232; Fri,  5 Oct 2007 14:08:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <930d91430710050427o79395023nffe3bd842a87cddb@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60071>

On Fri, Oct 05, 2007 at 12:27:22PM +0100, Geoffrey Ferrari wrote:
> --
> fatal: Not a git repository: '.'
> Failed to find a valid git directory.
> --
> 
> Can anyone explain why this happens? And how can I make the script
> work properly?

I'm no hook expert, but it may have something to do with some
environment variables that are set in hooks, you might need to change
variables like GIT_DIR.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
