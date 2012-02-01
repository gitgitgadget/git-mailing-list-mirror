From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Wed, 1 Feb 2012 22:37:44 +0000
Message-ID: <20120201223743.GC2431@localhost.localdomain>
References: <20120201165952.GA16263@proteus>
 <874nvap9hj.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 01 23:38:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsioR-0007z3-8k
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 23:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab2BAWhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 17:37:54 -0500
Received: from gimli.pitney-fabs.co.uk ([87.106.140.52]:39162 "EHLO
	gimli.pitney-fabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab2BAWhx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 17:37:53 -0500
Received: from host-78-151-87-122.as13285.net ([78.151.87.122] helo=localhost.localdomain)
	by gimli.pitney-fabs.co.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <walrond.andrew@gimli.pitney-fabs.co.uk>)
	id 1RsioJ-0000tx-EQ; Wed, 01 Feb 2012 22:37:52 +0000
Content-Disposition: inline
In-Reply-To: <874nvap9hj.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189550>

On Wed, Feb 01, 2012 at 09:46:48PM +0100, Thomas Rast wrote:
> 
> Do you, by any chance, still have a copy of the upstream repo before you
> trashed the stash?  It would be interesting to know whether there was
> actually some repository corruption going on (that went unnoticed by
> fsck, no less) or if there was a bug in the transmission.

I tried to reproduce the problem but without success :(
Disk corruption is unlikely - raided drives etc etc. More likely stash
related somehow as I was applying patches manually on older versions
checked out in a temp branch, stashing the results then applying the
stash onto master/HEAD.
But why was a remote clone involved with the upstream stash at all I
wonder??

Andrew Walrond
