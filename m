From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk : fix missing lines when displaying diff.
Date: Wed, 8 Mar 2006 09:17:09 +1100
Message-ID: <17422.1637.975579.478563@cargo.ozlabs.ibm.com>
References: <440DE262.7020007@gmail.com>
	<20060307204648.GA13620@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jacob Kroon <jacob.kroon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 23:17:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGkUb-0006sq-8S
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 23:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWCGWRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 17:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWCGWRR
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 17:17:17 -0500
Received: from ozlabs.org ([203.10.76.45]:31635 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964784AbWCGWRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 17:17:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id D0565679EB; Wed,  8 Mar 2006 09:17:15 +1100 (EST)
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <20060307204648.GA13620@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17352>

Robert Fitzsimons writes:

> Lines which are added (removed) and begin with +++ (---) are not shown
> correctly when displaying in the diff panel.
> 
> The +++ and --- lines are part of the diff header, with the +++
> indicating the end of the header.

Thanks for pointing out the easy fix.  I had been going to do
something much more complicated. :)

However, your patch didn't apply due to the whitespace being munged.
I committed an equivalent fix, but I took the opportunity to change
the [regexp] to a couple of [string compare]s as well.

Paul.
